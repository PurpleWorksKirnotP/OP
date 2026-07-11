local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Load UI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/imagoodpersond/puppyware/main/lib"))()

-- Configuration
local TixSettings = {
    Sticky = false,
    InstantAim = false, 
    Smoothness = 0.35,
    HeadOnly = false, -- New toggle choice
    WallCheck = true,
    TeamCheck = false,
    ESP = false,
    Tracers = false,
    RainbowStyle = false,
    NPCs = false,
    FOV = 150,
    CircleVis = false,
    ToggleKey = Enum.KeyCode.RightAlt
}

-- THEME COLORS (Purple)
local PrimaryPurple = Color3.fromRGB(150, 50, 250)

local currentTargetStructure = nil
local selectedBoneName = "Head"
local lastBoneSwitchTime = 0
local BoneSwitchInterval = 0.25 
local visualCache = {}
local connections = {}

local function getRainbow()
    return Color3.fromHSV(tick() % 5 / 5, 0.7, 1)
end

-- Drawings
local Circle = Drawing.new("Circle")
Circle.Visible = false
Circle.Thickness = 2
Circle.NumSides = 64
Circle.Radius = TixSettings.FOV
Circle.Filled = false

-- UI Initialization
local Window = library:new({name = "Aimlock Refined", accent = PrimaryPurple, textsize = 13})
local MainTab = Window:page({name = "Main"})
local AimSection = MainTab:section({name = "Aimlock Settings", side = "left", size = 310})
local VisualSection = MainTab:section({name = "Visual Settings", side = "right", size = 230})

local ExtrasTab = Window:page({name = "ExtrasTab", acceent = PrimaryPurple, textsize = 13})
local ScriptsSection = ExtrasTab:section({name = "Scripts", side = "left", size = 310})

-- Bind UI Controls to Settings

ScriptsSection:button({name = "PurpsUtils", callback = function()
    loadstring(HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/PurpsUtility/PurpsUtility.lua"))()
end})

AimSection:toggle({name = "Sticky Aimlock", def = TixSettings.Sticky, callback = function(Boolean)
    TixSettings.Sticky = Boolean
end})

AimSection:toggle({name = "Instant Aim", def = TixSettings.InstantAim, callback = function(Boolean)
    TixSettings.InstantAim = Boolean
end})

AimSection:toggle({name = "Head Only Aiming", def = TixSettings.HeadOnly, callback = function(Boolean)
    TixSettings.HeadOnly = Boolean
end})

-- Smoothness Slider Configuration
AimSection:slider({
    name = "Smoothness", 
    min = 5,
    max = 100, 
    def = TixSettings.Smoothness * 100, 
    callback = function(Value)
        TixSettings.Smoothness = Value / 100
    end
})

AimSection:toggle({name = "Wall Check", def = TixSettings.WallCheck, callback = function(Boolean)
    TixSettings.WallCheck = Boolean
end})

AimSection:toggle({name = "Team Check", def = TixSettings.TeamCheck, callback = function(Boolean)
    TixSettings.TeamCheck = Boolean
end})

AimSection:toggle({name = "Include Bots / NPCs", def = TixSettings.NPCs, callback = function(Boolean)
    TixSettings.NPCs = Boolean
end})

VisualSection:toggle({name = "Visual ESP", def = TixSettings.ESP, callback = function(Boolean)
    TixSettings.ESP = Boolean
end})

VisualSection:toggle({name = "Tracers", def = TixSettings.Tracers, callback = function(Boolean)
    TixSettings.Tracers = Boolean
end})

VisualSection:toggle({name = "Rainbow Mode", def = TixSettings.RainbowStyle, callback = function(Boolean)
    TixSettings.RainbowStyle = Boolean
end})

VisualSection:toggle({name = "Show FOV", def = TixSettings.CircleVis, callback = function(Boolean)
    TixSettings.CircleVis = Boolean
    Circle.Visible = Boolean
end})

-- FOV Size Slider Configuration
VisualSection:slider({
    name = "FOV Size",
    min = 10,
    max = 1200,
    def = TixSettings.FOV,
    callback = function(Value)
        TixSettings.FOV = Value
        Circle.Radius = Value
    end
})

-- Keybind Trigger Setup
table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end 
    if input.KeyCode == TixSettings.ToggleKey then
        TixSettings.Sticky = not TixSettings.Sticky
    end
end))

-- Wall Check
local function isVisible(targetPart)
    if not TixSettings.WallCheck then return true end
    local ignoreList = {LocalPlayer.Character, Camera}
    local ray = Ray.new(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position).Unit * 1000)
    local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    
    if hit and hit:IsDescendantOf(targetPart.Parent) then
        return true
    end
    return false
end

-- Targeting Radar Scan Engine
local function getClosest()
    local targetModel, shortestFOV = nil, TixSettings.FOV
    local potentials = {}
    
    for _,v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            if TixSettings.TeamCheck and v.Team == LocalPlayer.Team then continue end
            table.insert(potentials, v.Character)
        end
    end
    
    if TixSettings.NPCs then
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                if not Players:GetPlayerFromCharacter(v) and v ~= LocalPlayer.Character then 
                    table.insert(potentials, v) 
                end
            end
        end
    end

    for _, model in pairs(potentials) do
        local referencePart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head")
        if referencePart then
            local pos, vis = Camera:WorldToViewportPoint(referencePart.Position)
            if vis and isVisible(referencePart) then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < shortestFOV then 
                    targetModel = model 
                    shortestFOV = mag 
                end
            end
        end
    end
    return targetModel
end

-- Instant Caching Framework for Elements
local function createVisuals(char)
    if visualCache[char] then return visualCache[char] end
    
    local line = Drawing.new("Line")
    line.Visible = false
    
    local highlight = Instance.new("Highlight")
    highlight.Parent = game:GetService("CoreGui")
    highlight.Enabled = false
    
    visualCache[char] = {Line = line, High = highlight}
    return visualCache[char]
end

local function removeVisuals(char)
    if visualCache[char] then
        visualCache[char].Line:Remove()
        if visualCache[char].High then visualCache[char].High:Destroy() end
        visualCache[char] = nil
    end
end

local function monitorCharacter(char)
    if char == LocalPlayer.Character then return end
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        createVisuals(char)
        table.insert(connections, hum.Died:Connect(function() removeVisuals(char) end))
    end
end

-- Initialization Listeners
for _, p in pairs(Players:GetPlayers()) do
    if p.Character then task.spawn(monitorCharacter, p.Character) end
    table.insert(connections, p.CharacterAdded:Connect(monitorCharacter))
end
table.insert(connections, Players.PlayerAdded:Connect(function(p)
    table.insert(connections, p.CharacterAdded:Connect(monitorCharacter))
end))

if TixSettings.NPCs then
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            task.spawn(monitorCharacter, v)
        end
    end
end

table.insert(connections, workspace.DescendantAdded:Connect(function(v)
    if TixSettings.NPCs and v:IsA("Model") then
        task.spawn(function()
            RunService.Heartbeat:Wait()
            if v:FindFirstChild("Humanoid") then monitorCharacter(v) end
        end)
    end
end))

-- Core Control Engine Loop
local runtimeLoop = RunService.RenderStepped:Connect(function(deltaTime)
    local accent = TixSettings.RainbowStyle and getRainbow() or PrimaryPurple
    
    Circle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    Circle.Color = accent

    -- Aimlock Engine Tracking
    if TixSettings.Sticky then
        local targetModel = getClosest()
        if targetModel then 
            currentTargetStructure = targetModel
            
            -- Humanized part shifting vs Fixed Head logic
            if TixSettings.HeadOnly then
                selectedBoneName = "Head"
            else
                if tick() - lastBoneSwitchTime > BoneSwitchInterval then
                    lastBoneSwitchTime = tick()
                    selectedBoneName = (math.random(1, 2) == 1) and "Head" or "HumanoidRootPart"
                end
            end

            local lockPart = targetModel:FindFirstChild(selectedBoneName) or targetModel:FindFirstChild("HumanoidRootPart") or targetModel:FindFirstChild("Head")
            if lockPart then
                local targetCFrame = CFrame.new(Camera.CFrame.Position, lockPart.Position)
                
                if TixSettings.InstantAim then
                    Camera.CFrame = targetCFrame
                else
                    local interpolationFactor = math.clamp(TixSettings.Smoothness * (deltaTime * 60), 0.01, 1)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, interpolationFactor) 
                end
            end
        else
            currentTargetStructure = nil
        end
    else
        currentTargetStructure = nil
    end

    -- Process Rendering Maps (Synced Viewport Cleanups for Tracers & ESP Highlights)
    for char, visual in pairs(visualCache) do
        if not char or not char.Parent then
            removeVisuals(char)
            continue
        end

        local head = char:FindFirstChild("Head")
        local hum = char:FindFirstChild("Humanoid")
        
        if head and hum and hum.Health > 0 then
            local pos, vis = Camera:WorldToViewportPoint(head.Position)
            
            -- Tracer handling
            if TixSettings.Tracers and vis then
                visual.Line.Visible = true
                visual.Line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                visual.Line.To = Vector2.new(pos.X, pos.Y)
                visual.Line.Color = accent
                visual.Line.Thickness = 1.5
            else
                visual.Line.Visible = false
            end

            -- Highlight handling
            if TixSettings.ESP and vis then
                if TixSettings.TeamCheck and Players:GetPlayerFromCharacter(char) and Players:GetPlayerFromCharacter(char).Team == LocalPlayer.Team then
                    visual.High.Enabled = false
                else
                    visual.High.Enabled = true
                    visual.High.Adornee = char
                    visual.High.FillColor = accent
                    visual.High.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            else
                visual.High.Enabled = false
            end
        else
            visual.Line.Visible = false
            visual.High.Enabled = false
        end
    end
end)
table.insert(connections, runtimeLoop)

-- Open initial tab
MainTab:openpage()