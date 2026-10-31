local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local CONFIG = {
	ScanInterval = 10, -- seconds between full safety-net scans
	AutoListen = true, -- also catch objects the instant they are added

	MaxHighlights = 31, -- engine hard cap for the whole client; do not raise
	RespectForeignHighlights = true, -- subtract highlights the game already uses
	ForeignRefreshInterval = 10, -- seconds between recounts of the game's highlights
	MaxSelections = 60, -- cap for the SelectionBox fallback

	-- NPC ESP only shows while you are inside this distance band (studs).
	-- 0 / math.huge mean "no limit" on either end, so a plain radius is
	-- Min = 0, Max = 500 and a plain "farther than" is Min = 100, Max = math.huge.
	NpcMinDistance = 0,
	NpcMaxDistance = 250,

	ReorderDistance = 2, -- studs the camera must move before re-prioritising
	BudgetUpdateRate = 0.3, -- seconds between priority / budget updates
	ModeRefreshInterval = 5, -- re-check "is this model all transparent?" every N s
	MarkTransparentParts = true, -- SelectionBox fallback for invisible loot

	FillTransparency = 0.55,
	OutlineTransparency = 0,
	DepthMode = Enum.HighlightDepthMode.AlwaysOnTop, -- see things through walls
	SelectionLineThickness = 0.06,

	Debug = false,
}

-- Resolved at runtime: 31 minus whatever the game itself is using.
CONFIG.GlobalVisualCap = CONFIG.MaxHighlights

-- One entry per category.
--   priority 0 = characters (NPC / Guard / Police): they claim the 31 render
--                slots first, so they never get pushed out by a pile of loot.
--   priority 1 = fillers (loot): they only get whatever slots are left over.
-- Inside the same priority band, the nearest to the camera wins.
local GROUP_CONFIGS = {
	{
		key = "loot",
		label = "Loot ESP",
		short = "Loot",
		folderName = "Loot",
		color = Color3.fromRGB(255, 170, 0),
		maxVisuals = 31,
		priority = 1, -- 0 = takes slots first (characters), 1 = fills what is left
		enabled = true,
	},
	{
		key = "npc",
		label = "NPC ESP",
		short = "NPCs",
		folderName = "Npcs",
		color = Color3.fromRGB(80, 200, 255),
		maxVisuals = 10,
		priority = 0,
		enabled = true,
		minDistance = CONFIG.NpcMinDistance, -- only show NPCs farther than this
		maxDistance = CONFIG.NpcMaxDistance, -- and closer than this
	},
	{
		key = "guard",
		label = "Guard ESP",
		short = "Guards",
		folderName = "Guards",
		color = Color3.fromRGB(90, 230, 120),
		maxVisuals = 10,
		priority = 0,
		enabled = true,
	},
	{
		key = "police",
		label = "Police ESP",
		short = "Police",
		folderName = "Police",
		color = Color3.fromRGB(70, 120, 255),
		maxVisuals = 10,
		priority = 0,
		enabled = true,
	},
}

type Record = {
	adornee: Instance,
	group: any,
	highlight: Highlight?,
	selection: SelectionBox?,
	mode: string, -- "highlight" | "selection"
	dirty: boolean,
	modeTime: number,
	connections: { RBXScriptConnection },
}

type Group = {
	key: string,
	label: string,
	short: string,
	folderName: string,
	color: Color3,
	maxVisuals: number,
	priority: number, -- 0 = first claim on the 31 render slots
	enabled: boolean,
	rangeKey: string?, -- CONFIG key prefix so the range can be live-edited
	minDistance: number,
	maxDistance: number,
	folder: Instance?,
	records: { [Instance]: Record },
	visuals: number,
	selections: number,
	count: number,
	vfx: Instance,
	connections: { RBXScriptConnection },
}

local GROUPS: { Group } = {}
local groupsByKey: { [string]: Group } = {}

-- One private folder per category: the Clean up button can then wipe a
-- category's visuals (including duplicates) without ever touching ours.
local vfxRoot = Instance.new("Folder")
vfxRoot.Name = "LootHighlighter_VFX"
vfxRoot.Parent = Workspace

local function isOurVisual(instance: Instance): boolean
	return instance:IsA("Highlight") or instance:IsA("SelectionBox")
end

-- Build the group table once, up front, from GROUP_CONFIGS.
for _, config in ipairs(GROUP_CONFIGS) do
	local group: Group = {
		key = config.key,
		label = config.label,
		short = config.short,
		folderName = config.folderName,
		color = config.color,
		maxVisuals = config.maxVisuals or CONFIG.MaxHighlights,
		priority = config.priority or 1,
		enabled = config.enabled ~= false,
		rangeKey = config.rangeKey,
		minDistance = config.minDistance or 0,
		maxDistance = config.maxDistance or math.huge,
		folder = nil,
		records = {},
		visuals = 0,
		selections = 0,
		count = 0,
		vfx = (function()
			local folder = Instance.new("Folder")
			folder.Name = "LootHighlighter_" .. config.key
			folder.Parent = vfxRoot
			return folder
		end)(),
		connections = {},
	}
	table.insert(GROUPS, group)
	groupsByKey[group.key] = group
end

local highlightPool: { Highlight } = {}

local activeHighlights = 0
local activeSelections = 0
local dirtyFlag = true
local lastCameraPosition: Vector3? = nil
local nextModeSweep = 0

local function log(...: any)
	if CONFIG.Debug then
		print("[LootHighlighter]", ...)
	end
end

-- Anything that can be an Adornee for us: a Model or any BasePart
-- (Part, MeshPart, UnionOperation, WedgePart, TrussPart, ...).
local function isTarget(instance: Instance): boolean
	return instance:IsA("Model") or instance:IsA("BasePart")
end

local function pivotOf(instance: Instance): Vector3
	if instance:IsA("BasePart") then
		return instance.Position
	end
	local ok, pivot = pcall(function()
		return (instance :: Model):GetPivot().Position
	end)
	if ok and typeof(pivot) == "Vector3" then
		return pivot
	end
	return Vector3.zero
end

-- Highlight does not render on parts with Transparency > 0.01 (and on models
-- made only of such parts), unless the model has a Humanoid. Decide per object
-- whether we use a Highlight or the SelectionBox fallback.
local function computeVisualMode(adornee: Instance): string
	if not CONFIG.MarkTransparentParts then
		return "highlight"
	end

	if adornee:IsA("BasePart") then
		if adornee.Transparency > 0.01 then
			return "selection"
		end
		return "highlight"
	end

	if adornee:FindFirstChildOfClass("Humanoid") then
		return "highlight" -- characters render their highlight fine
	end
	for _, descendant in ipairs(adornee:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Transparency <= 0.01 then
			return "highlight"
		end
	end
	return "selection" -- nothing opaque in there: Highlight would be invisible
end

local function applyHighlightStyle(highlight: Highlight, group: Group)
	highlight.FillColor = group.color
	highlight.FillTransparency = CONFIG.FillTransparency
	highlight.OutlineColor = group.color:Lerp(Color3.new(1, 1, 1), 0.6)
	highlight.OutlineTransparency = CONFIG.OutlineTransparency
	highlight.DepthMode = CONFIG.DepthMode
end

-- IMPORTANT: a pooled Highlight is unparented, not just disabled. A disabled
-- Highlight still eats one of the 31 render slots; an unparented one does not.
local function acquireHighlight(group: Group): Highlight
	local highlight = table.remove(highlightPool)
	if not highlight then
		highlight = Instance.new("Highlight")
	end
	applyHighlightStyle(highlight, group)
	highlight.Parent = group.vfx
	return highlight
end

local function releaseHighlight(highlight: Highlight, discard: boolean?)
	highlight.Adornee = nil
	highlight.Parent = nil -- out of the DataModel => frees its render slot
	if not discard and #highlightPool < CONFIG.MaxHighlights then
		table.insert(highlightPool, highlight)
	else
		highlight:Destroy()
	end
end

local untrack: (Group, Instance) -> ()
local giveVisual: (Group, Record) -> boolean
local dropVisual: (Group, Record, boolean?) -> ()

local function newRecord(group: Group, adornee: Instance): Record
	return {
		adornee = adornee,
		group = group,
		highlight = nil,
		selection = nil,
		mode = "highlight",
		dirty = true,
		modeTime = 0,
		connections = {},
	}
end

-- A registered Model "covers" its own parts: we do not track them separately,
-- because the model's highlight already outlines them.
local function coveredByTrackedModel(group: Group, instance: Instance): boolean
	local parent = instance.Parent
	while parent and parent ~= group.folder and parent ~= Workspace do
		if parent:IsA("Model") and group.records[parent] then
			return true
		end
		parent = parent.Parent
	end
	return false
end

local function watchRecord(group: Group, record: Record)
	local adornee = record.adornee

	-- The classic gotcha: a Highlight whose Adornee is a Model does NOT grow to
	-- include parts added to that model later (accessories spawning on an NPC,
	-- a car being assembled, ...). Rebuild the highlight when that happens
	-- (debounced by the budget pass).
	if adornee:IsA("Model") then
		table.insert(
			record.connections,
			(adornee :: Model).DescendantAdded:Connect(function()
				record.dirty = true
				dirtyFlag = true
			end)
		)
		table.insert(
			record.connections,
			(adornee :: Model).DescendantRemoving:Connect(function()
				record.dirty = true
				dirtyFlag = true
			end)
		)
	end

	table.insert(
		record.connections,
		adornee.Destroying:Connect(function()
			untrack(group, adornee)
		end)
	)
end

untrack = function(group: Group, instance: Instance)
	local record = group.records[instance]
	if not record then
		return
	end
	group.records[instance] = nil
	group.count = math.max(0, group.count - 1)
	dropVisual(group, record, true)
	for _, connection in ipairs(record.connections) do
		connection:Disconnect()
	end
	table.clear(record.connections)
	dirtyFlag = true
	log("untracked", instance:GetFullName())
end

local function track(group: Group, instance: Instance)
	if not instance or group.records[instance] then
		return
	end
	if not isTarget(instance) then
		return
	end
	if coveredByTrackedModel(group, instance) then
		return -- already outlined by its parent model
	end

	local record = newRecord(group, instance)
	group.records[instance] = record
	group.count += 1
	watchRecord(group, record)
	dirtyFlag = true
end

-- Walk a container (the category folder / sub-folders) and register everything.
local function walk(group: Group, container: Instance)
	for _, child in ipairs(container:GetChildren()) do
		if isTarget(child) then
			track(group, child) -- do not descend into it: its own highlight covers it
		else
			walk(group, child) -- Folder, Configuration, ... keep going
		end
	end
end

local function trackSubtree(group: Group, instance: Instance)
	if isTarget(instance) then
		track(group, instance)
	else
		walk(group, instance)
	end
end

-- Drop records whose object left / was destroyed.
local function pruneStale(group: Group)
	local folder = group.folder
	for instance in pairs(group.records) do
		local alive = instance.Parent ~= nil
		if alive and folder then
			alive = (instance == folder) or instance:IsDescendantOf(folder)
		elseif alive and not folder then
			alive = false -- the folder is gone, so is our claim on anything
		end
		if not alive then
			untrack(group, instance)
		end
	end
end

-- The heartbeat: register anything we somehow do not know about yet.
local function fullScan(group: Group)
	local folder = group.folder
	if not folder then
		return
	end
	if isTarget(folder) then
		track(group, folder) -- the folder itself could be a Model/Part
	end
	walk(group, folder)
	pruneStale(group)
	if CONFIG.Debug then
		log("full scan", group.key, "->", group.count, "tracked")
	end
end

local function fullScanAll()
	for _, group in ipairs(GROUPS) do
		fullScan(group)
	end
end

giveVisual = function(group: Group, record: Record): boolean
	if record.highlight or record.selection then
		return false
	end

	if record.mode == "selection" then
		if activeSelections >= CONFIG.MaxSelections then
			return false
		end
		local selection = Instance.new("SelectionBox")
		selection.Name = "LootSelection"
		selection.Color3 = group.color
		selection.SurfaceTransparency = 1
		selection.LineThickness = CONFIG.SelectionLineThickness
		selection.Adornee = record.adornee
		selection.Parent = group.vfx
		record.selection = selection
		activeSelections += 1
		group.selections += 1
		return true
	end

	if activeHighlights >= CONFIG.GlobalVisualCap then
		return false
	end
	if group.visuals >= group.maxVisuals then
		return false
	end

	local highlight = acquireHighlight(group)
	highlight.Adornee = record.adornee
	record.highlight = highlight
	activeHighlights += 1
	group.visuals += 1
	return true
end

dropVisual = function(group: Group, record: Record, discard: boolean?)
	if record.highlight then
		releaseHighlight(record.highlight, discard)
		record.highlight = nil
		activeHighlights = math.max(0, activeHighlights - 1)
		group.visuals = math.max(0, group.visuals - 1)
	end
	if record.selection then
		record.selection:Destroy()
		record.selection = nil
		activeSelections = math.max(0, activeSelections - 1)
		group.selections = math.max(0, group.selections - 1)
	end
end

-- Recompute every counter from the live state (cheap, and it self-heals if the
-- game did something rude to our instances).
local function refreshCounts()
	activeHighlights = 0
	activeSelections = 0
	for _, group in ipairs(GROUPS) do
		group.visuals = 0
		group.selections = 0
		group.count = 0
		for _ in pairs(group.records) do
			group.count += 1
		end
		for _, record in pairs(group.records) do
			if record.highlight then
				activeHighlights += 1
				group.visuals += 1
			end
			if record.selection then
				activeSelections += 1
				group.selections += 1
			end
		end
	end
end

-- If a game script destroyed our highlight / selection, forget it and rebuild.
local function validateVisuals()
	-- Safety net: if something blew our VFX folders away, put them back so
	-- new highlights have somewhere to live.
	if vfxRoot.Parent == nil then
		vfxRoot.Parent = Workspace
	end
	for _, group in ipairs(GROUPS) do
		if group.vfx.Parent == nil then
			group.vfx.Parent = vfxRoot
		end
	end

	for _, group in ipairs(GROUPS) do
		for _, record in pairs(group.records) do
			local highlight = record.highlight
			if highlight and (highlight.Parent == nil or highlight.Adornee ~= record.adornee) then
				-- Do not pool a tainted instance: something else touched it.
				record.highlight = nil
				if highlight.Parent == nil then
					highlight:Destroy()
				else
					releaseHighlight(highlight, true)
				end
				dirtyFlag = true
			end
			local selection = record.selection
			if selection and selection.Parent == nil then
				record.selection = nil
				dirtyFlag = true
			end
		end
	end
end

-- Distance gate: is this object inside its category's show range?
local function inRange(group: Group, distance: number): boolean
	if distance < group.minDistance then
		return false
	end
	if distance > group.maxDistance then
		return false
	end
	return true
end

local function updateBudget()
	validateVisuals()
	refreshCounts()

	local camera = Workspace.CurrentCamera
	local cameraPosition = if camera then camera.CFrame.Position else Vector3.zero
	local now = os.clock()
	local moved = lastCameraPosition == nil
		or (lastCameraPosition - cameraPosition).Magnitude > CONFIG.ReorderDistance

	if not moved and not dirtyFlag and now < nextModeSweep then
		return
	end
	nextModeSweep = now + CONFIG.ModeRefreshInterval
	lastCameraPosition = cameraPosition
	dirtyFlag = false

	-- 1. Work out what every enabled record should look like, and rebuild the
	--    ones whose target changed (new parts in a model, transparency flipped,
	--    ...). A rebuilt Highlight picks up the new parts.
	local entries: { { group: Group, record: Record, distance: number } } = {}
	for _, group in ipairs(GROUPS) do
		for instance, record in pairs(group.records) do
			if not group.enabled then
				dropVisual(group, record) -- toggled off: silent, still tracked
				continue
			end

			local rebuild = record.dirty
			local recheckMode = rebuild
				or instance:IsA("BasePart")
				or (now - record.modeTime) >= CONFIG.ModeRefreshInterval

			if recheckMode then
				record.modeTime = now
				local mode = computeVisualMode(instance)
				if mode ~= record.mode then
					record.mode = mode
					rebuild = true
				end
			end
			if rebuild then
				-- Throw the instance away instead of pooling it: Roblox does not
				-- refresh a Highlight whose Adornee is a model when parts are
				-- added later, so a brand-new instance is the only reliable rebuild.
				dropVisual(group, record, true)
			end
			record.dirty = false

			local distance = (pivotOf(instance) - cameraPosition).Magnitude

			-- Outside the category's band (e.g. an NPC 600 studs away) it is
			-- still tracked, but it does not compete for a render slot.
			if not inRange(group, distance) then
				dropVisual(group, record) -- no visual, but the record stays tracked
				continue
			end

			table.insert(entries, {
				group = group,
				record = record,
				distance = distance,
			})
		end
	end

	if #entries == 0 then
		return
	end

	-- Characters always outrank loot: every NPC / Guard / Police entry is
	-- queued ahead of every loot entry, then each block is sorted by distance.
	-- So with 31 slots, the enabled character folders get theirs first and
	-- loot only fills whatever is left over.
	table.sort(entries, function(a, b)
		if a.group.priority ~= b.group.priority then
			return a.group.priority < b.group.priority
		end
		return a.distance < b.distance
	end)

	-- 2. Release the visuals of everything that fell outside the global slot
	--    window, so the nearest / highest priority objects can take those slots
	--    in this same pass.
	for index = CONFIG.GlobalVisualCap + 1, #entries do
		local entry = entries[index]
		dropVisual(entry.group, entry.record)
	end
	refreshCounts()

	-- 3. Enforce each category's own cap, dropping that category's FARTHEST
	--    visuals first so a crowded folder cannot starve its near objects.
	for _, group in ipairs(GROUPS) do
		if group.visuals > group.maxVisuals then
			for index = #entries, 1, -1 do
				if group.visuals <= group.maxVisuals then
					break
				end
				local entry = entries[index]
				if entry.group == group then
					dropVisual(group, entry.record)
				end
			end
		end
	end

	-- 4. Hand out the free slots in priority order: characters first, nearest
	--    first inside each priority band, loot last.
	local limit = math.min(#entries, CONFIG.GlobalVisualCap)
	for index = 1, limit do
		local entry = entries[index]
		local group, record = entry.group, entry.record
		if group.enabled and not (record.highlight or record.selection) then
			giveVisual(group, record)
		end
	end
end

local function unbind(group: Group)
	for _, connection in ipairs(group.connections) do
		connection:Disconnect()
	end
	table.clear(group.connections)
	group.folder = nil
	pruneStale(group) -- nothing is inside the (now gone) folder -> clears everything
end

local function bind(group: Group, folder: Instance)
	unbind(group)
	group.folder = folder
	log("bound", group.key, "to", folder:GetFullName())

	if CONFIG.AutoListen then
		-- Instant pickup: no waiting for the next sweep.
		table.insert(
			group.connections,
			folder.ChildAdded:Connect(function(child)
				trackSubtree(group, child) -- an object, or a container to look inside
				dirtyFlag = true
			end)
		)

		table.insert(
			group.connections,
			folder.DescendantAdded:Connect(function(descendant)
				-- Catches things dropped deep inside sub-folders the same frame
				-- they appear (NPC accessories, spawned guards, ...).
				if isTarget(descendant) and not coveredByTrackedModel(group, descendant) then
					track(group, descendant)
					dirtyFlag = true
				end
			end)
		)
	end

	table.insert(
		group.connections,
		folder.AncestryChanged:Connect(function()
			if folder.Parent == nil then
				unbind(group)
			end
		end)
	)

	table.insert(
		group.connections,
		folder.Destroying:Connect(function()
			unbind(group)
		end)
	)

	fullScan(group)
	dirtyFlag = true
end

-- Nukes every visual this script owns: active highlights, active selection
-- boxes, the unparented instance pool, and anything stray that ended up in our
-- VFX folder (duplicates, leftovers from an older version of the script).
-- Then it re-scans and rebuilds, so categories that are switched ON come
-- straight back - the button is a hard reset, not an off switch.
local function cleanUpHighlights(): number
	local removed = 0

	-- 1. Drop every record's visual (counted here, once).
	for _, group in ipairs(GROUPS) do
		for _, record in pairs(group.records) do
			if record.highlight or record.selection then
				removed += 1
			end
			dropVisual(group, record, true)
		end
	end

	-- 2. Sweep the VFX folders for anything left behind: duplicates, orphans
	--    from an older run, or visuals whose record vanished. Only ever inside
	--    our own folder, so the game's highlights are untouched.
	for _, group in ipairs(GROUPS) do
		for _, child in ipairs(group.vfx:GetChildren()) do
			if isOurVisual(child) then
				child:Destroy()
				removed += 1
			end
		end
	end

	-- Throw the pool away as well, so nothing stale is ever reused.
	for _, highlight in ipairs(highlightPool) do
		highlight:Destroy()
	end
	table.clear(highlightPool)

	refreshCounts()
	dirtyFlag = true
	nextModeSweep = 0

	fullScanAll()
	updateBudget()

	log("cleaned up", removed, "visuals")
	return removed
end

-- Same as cleanUpHighlights, but it also throws away every tracking record and
-- re-binds every folder, so the second half of the stagger starts from zero.
-- Use this if highlights ever get truly stuck.
local function hardReset()
	local removed = cleanUpHighlights()

	for _, group in ipairs(GROUPS) do
		for instance in pairs(group.records) do
			local record = group.records[instance]
			if record then
				for _, connection in ipairs(record.connections) do
					connection:Disconnect()
				end
				table.clear(record.connections)
			end
			group.records[instance] = nil
		end
		group.count = 0
	end

	refreshCounts()

	for _, group in ipairs(GROUPS) do
		local target = Workspace:FindFirstChild(group.folderName)
		if target then
			bind(group, target)
		else
			unbind(group)
		end
	end

	dirtyFlag = true
	nextModeSweep = 0
	fullScanAll()
	updateBudget()
	log("hard reset, removed", removed, "visuals")
	return removed
end

-- Re-apply colour / depth settings to highlights that are already on screen
-- (used when a setting changes from the Settings tab).
local function restyleActiveHighlights()
	for _, group in ipairs(GROUPS) do
		for _, record in pairs(group.records) do
			if record.highlight then
				applyHighlightStyle(record.highlight, group)
			end
			if record.selection then
				record.selection.Color3 = group.color
			end
		end
	end
end

local function refreshForeignBudget()
	if not CONFIG.RespectForeignHighlights then
		CONFIG.GlobalVisualCap = CONFIG.MaxHighlights
		return
	end

	local foreign = 0
	for _, descendant in ipairs(game:GetDescendants()) do
		if descendant:IsA("Highlight") and not descendant:IsDescendantOf(vfxRoot) then
			foreign += 1
		end
	end

	CONFIG.GlobalVisualCap = math.max(1, math.min(CONFIG.MaxHighlights, CONFIG.MaxHighlights - foreign))
	dirtyFlag = true
	log("foreign highlights:", foreign, "-> our budget:", CONFIG.GlobalVisualCap)
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Rain-Design/Unnamed/main/Library.lua"))()
Library.Theme = "Dark"

local Window = Library:Window({ Text = "Crimple | Developed by Kirturneedpurp on discord" })

local HighlightsTab = Window:Tab({ Text = "Main" })
local SettingsTab = Window:Tab({ Text = "Settings" })

local FoldersSection = HighlightsTab:Section({ Text = "Folders", Opened = true })
local ToolsSection = HighlightsTab:Section({ Text = "Tools", Opened = true })
local RenderSection = SettingsTab:Section({ Text = "Rendering", Opened = true })
local BudgetSection = SettingsTab:Section({ Text = "Budget", Opened = true })

-- status summary used by the Status button and the notification
local function statusLine(): string
	local tracked = 0
	for _, group in ipairs(GROUPS) do
		tracked += group.count
	end
	local parts = {}
	for _, group in ipairs(GROUPS) do
		table.insert(parts, string.format("%s %s", group.short, if group.enabled then "on" else "off"))
	end
	local npcGroup = groupsByKey.npc
	local npcRange = if npcGroup
		then string.format(
			"NPC range %s-%s",
			if npcGroup.minDistance > 0 then tostring(math.floor(npcGroup.minDistance)) else "0",
			if npcGroup.maxDistance < math.huge then tostring(math.floor(npcGroup.maxDistance)) else "inf"
		)
		else ""

	return string.format(
		"%d tracked | %d/%d highlight slots | %d outlines | %s | %s",
		tracked,
		activeHighlights,
		CONFIG.GlobalVisualCap,
		activeSelections,
		table.concat(parts, ", "),
		npcRange
	)
end

-- The library does not hand back its ScreenGui, so diff the containers around
-- Window creation to find the one it made (the one holding "Main").
local function uiContainers(): { Instance }
	local list = {}
	local okHui, hidden = pcall(function()
		return gethui and gethui() or (get_hidden_gui and get_hidden_gui()) or nil
	end)
	if okHui and typeof(hidden) == "Instance" then
		table.insert(list, hidden)
	end
	local okCore, coreGui = pcall(function()
		return game:GetService("CoreGui")
	end)
	if okCore and typeof(coreGui) == "Instance" then
		table.insert(list, coreGui)
	end
	return list
end

local before: { [Instance]: boolean } = {}
for _, container in ipairs(uiContainers()) do
	pcall(function()
		for _, child in ipairs(container:GetChildren()) do
			before[child] = true
		end
	end)
end

local function findWindowGui(): Instance?
	for _, container in ipairs(uiContainers()) do
		local ok, children = pcall(function()
			return container:GetChildren()
		end)
		if ok then
			for _, child in ipairs(children) do
				if not before[child] and child:FindFirstChild("Main") then
					return child
				end
			end
		end
	end
	return nil
end

-- ---- Folders ---------------------------------------------------------
-- Turning a category back ON rebuilds all of its highlights at once. Going from
-- 3 categories to 4 in a single frame asks for more than 31 Highlights, and
-- Roblox starts ignoring them (that is the "stuck until I toggle twice" bug).
-- So the rebuild is staggered across a few frames - each pass only fills the
-- slots that are actually free.
local TOGGLE_STAGGER_PASSES = 6
local TOGGLE_STAGGER_INTERVAL = 0.15

local function rebuildStaggered(group: Group)
	dirtyFlag = true
	nextModeSweep = 0

	task.spawn(function()
		for _ = 1, TOGGLE_STAGGER_PASSES do
			if not group.enabled then
				return
			end
			updateBudget()
			task.wait(TOGGLE_STAGGER_INTERVAL)
		end
	end)
end

for _, group in ipairs(GROUPS) do
	FoldersSection:Toggle({
		Text = group.label,
		Default = group.enabled,
		Callback = function(state)
			group.enabled = state

			if state then
				fullScan(group) -- pick up anything that appeared while it was off
				rebuildStaggered(group)
			else
				-- Drop this category's visuals right now; tracking is kept, so
				-- flipping it back on is instant.
				for _, record in pairs(group.records) do
					dropVisual(group, record)
				end
				dirtyFlag = true
			end

			log("toggled", group.key, "->", state)
		end,
	})
end

-- ---- Tools -----------------------------------------------------------
ToolsSection:Button({
	Text = "Clean up highlights",
	Callback = function()
		local removed = cleanUpHighlights()
		Library:Notification({
			Title = "Clean up",
			Description = string.format("Removed %d visual(s) and rebuilt.", removed),
			Timeout = 4,
		})
	end,
})

ToolsSection:Button({
	Text = "Rescan now",
	Callback = function()
		fullScanAll()
		refreshForeignBudget()
		dirtyFlag = true
		updateBudget()
		Library:Notification({ Title = "Rescan", Description = "Re-scanned every folder.", Timeout = 4 })
	end,
})

ToolsSection:Button({
	Text = "Hard reset (stuck highlights)",
	Callback = function()
		local removed = hardReset()
		Library:Notification({
			Title = "Hard reset",
			Description = string.format("Rebuilt from scratch (%d visual(s) cleared).", removed),
			Timeout = 4,
		})
	end,
})

ToolsSection:Button({
	Text = "Status",
	Callback = function()
		Library:Notification({ Title = "Status", Description = statusLine(), Timeout = 6 })
	end,
})

-- ---- Rendering -------------------------------------------------------
RenderSection:Toggle({
	Text = "See through walls",
	Default = CONFIG.DepthMode == Enum.HighlightDepthMode.AlwaysOnTop,
	Callback = function(state)
		CONFIG.DepthMode = if state
			then Enum.HighlightDepthMode.AlwaysOnTop
			else Enum.HighlightDepthMode.Occluded
		restyleActiveHighlights()
	end,
})

RenderSection:Toggle({
	Text = "Outline invisible loot",
	Default = CONFIG.MarkTransparentParts,
	Callback = function(state)
		CONFIG.MarkTransparentParts = state
		dirtyFlag = true -- modes get recomputed on the next pass
		nextModeSweep = 0
	end,
})

RenderSection:Toggle({
	Text = "Soft fill",
	Default = CONFIG.FillTransparency >= 0.5,
	Callback = function(state)
		CONFIG.FillTransparency = if state then 0.55 else 0.25
		restyleActiveHighlights()
	end,
})

-- ---- Budget ----------------------------------------------------------
BudgetSection:Toggle({
	Text = "Share slots with the game",
	Default = CONFIG.RespectForeignHighlights,
	Callback = function(state)
		CONFIG.RespectForeignHighlights = state
		refreshForeignBudget()
		dirtyFlag = true
	end,
})

BudgetSection:Slider({
	Text = "Slots per folder",
	Default = 10,
	Minimum = 1,
	Maximum = 31,
	Callback = function(value)
		local cap = math.floor(value)
		for _, group in ipairs(GROUPS) do
			-- Loot keeps the whole 31-slot budget, the character folders get the slider.
			if group.key ~= "loot" then
				group.maxVisuals = cap
			end
		end
		dirtyFlag = true
	end,
})

-- ---- NPC range -------------------------------------------------------
BudgetSection:Slider({
	Text = "NPC ESP max distance",
	Default = CONFIG.NpcMaxDistance == math.huge and 500 or CONFIG.NpcMaxDistance,
	Minimum = 0,
	Maximum = 2000,
	Callback = function(value)
		local npcGroup = groupsByKey.npc
		if not npcGroup then
			return
		end
		local maxDistance = math.floor(value)
		npcGroup.maxDistance = if maxDistance <= 0 then math.huge else maxDistance
		CONFIG.NpcMaxDistance = npcGroup.maxDistance
		dirtyFlag = true
		updateBudget() -- apply it right away, no waiting for the next pass
	end,
})

BudgetSection:Slider({
	Text = "NPC ESP min distance",
	Default = CONFIG.NpcMinDistance,
	Minimum = 0,
	Maximum = 500,
	Callback = function(value)
		local npcGroup = groupsByKey.npc
		if not npcGroup then
			return
		end
		npcGroup.minDistance = math.floor(value)
		CONFIG.NpcMinDistance = npcGroup.minDistance
		dirtyFlag = true
		updateBudget()
	end,
})

local WindowGui = findWindowGui()
if WindowGui then
	BudgetSection:Keybind({
		Text = "Toggle this panel",
		Default = Enum.KeyCode.RightShift,
		Callback = function()
			WindowGui.Enabled = not WindowGui.Enabled
		end,
	})
end

Library:Notification({
	Title = "Loot Highlighter",
	Description = "Loaded - 4 folders watched.",
	Timeout = 4,
})

HighlightsTab:Select()

task.spawn(function()
	-- Subtract the highlights the game itself is using from the 31-slot budget,
	-- and keep that number honest as the game spawns / removes its own.
	while true do
		refreshForeignBudget()
		task.wait(CONFIG.ForeignRefreshInterval)
	end
end)

task.spawn(function()
	-- Pick up a category folder immediately if it appears / is re-created.
	Workspace.ChildAdded:Connect(function(child)
		for _, group in ipairs(GROUPS) do
			if group.folder == nil and child.Name == group.folderName then
				bind(group, child)
			end
		end
	end)
end)

task.spawn(function()
	-- Main loop: full re-scan every CONFIG.ScanInterval seconds, forever.
	while true do
		for _, group in ipairs(GROUPS) do
			local folder = Workspace:FindFirstChild(group.folderName)
			if folder ~= group.folder then
				if folder then
					bind(group, folder)
				elseif group.folder then
					unbind(group)
				end
			elseif folder then
				fullScan(group)
			end
		end
		task.wait(CONFIG.ScanInterval)
	end
end)

task.spawn(function()
	-- Cheap per-frame-ish pass that spends the render slots on the nearest
	-- objects across every enabled category.
	local accumulator = 0
	RunService.Heartbeat:Connect(function(deltaTime)
		accumulator += deltaTime
		if accumulator < CONFIG.BudgetUpdateRate then
			return
		end
		accumulator = 0
		updateBudget()
	end)
end)