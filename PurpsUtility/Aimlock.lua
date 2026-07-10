local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Configuration
local TixSettings = {
    Sticky = false,
    InstantAim = false, 
    Smoothness = 0.35,  
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
local OrchidAccent = Color3.fromRGB(200, 100, 255)
local DarkGreyBlack = Color3.fromRGB(15, 15, 17)
local OffText = Color3.fromRGB(160, 160, 160)
local DarkBtn = Color3.fromRGB(25, 25, 27)

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

-- UI Setup
local TixUI = Instance.new("ScreenGui")
TixUI.Name = "Aimlock, refined by purps"
TixUI.Parent = gethui and gethui() or game:GetService("CoreGui")
TixUI.ResetOnSpawn = false

-- Toggle Icon (Explicitly Draggable)
local TogglePanel = Instance.new("Frame", TixUI)
TogglePanel.Size = UDim2.new(0, 45, 0, 45)
TogglePanel.Position = UDim2.new(0, 20, 0, 20)
TogglePanel.BackgroundColor3 = DarkGreyBlack
TogglePanel.Active = true
TogglePanel.Draggable = true
Instance.new("UICorner", TogglePanel)
local ToggleStroke = Instance.new("UIStroke", TogglePanel)
ToggleStroke.Thickness = 2
ToggleStroke.Color = PrimaryPurple

local ToggleBtn = Instance.new("TextButton", TogglePanel)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = "P"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextColor3 = PrimaryPurple
ToggleBtn.TextSize = 18

-- MAIN FRAME
local Main = Instance.new("Frame", TixUI)
local VisiblePos = UDim2.new(0.5, -180, 0.5, -140)
local HiddenPos = UDim2.new(0.5, -180, 1.2, 0)
Main.Size = UDim2.new(0, 360, 0, 280) 
Main.Position = HiddenPos
Main.BackgroundColor3 = DarkGreyBlack
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2
MainStroke.Color = PrimaryPurple

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "Aimlock refined by purps XD"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.BackgroundTransparency = 1
Title.TextColor3 = PrimaryPurple

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = PrimaryPurple
CloseBtn.TextSize = 25

-- OPEN/CLOSE LOGIC
ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    TogglePanel.Visible = false
    Main:TweenPosition(VisiblePos, "Out", "Quart", 0.5, true)
end)

CloseBtn.MouseButton1Click:Connect(function()
    Main:TweenPosition(HiddenPos, "In", "Quart", 0.4, true, function()
        Main.Visible = false
        TogglePanel.Visible = true
    end)
end)

-- SCROLL AREA
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -20, 1, -70)
Scroll.Position = UDim2.new(0, 10, 0, 60)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 2.4, 0) 
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = PrimaryPurple

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 6)

local function AddToggle(text, settingKey)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, -5, 0, 42)
    btn.BackgroundColor3 = DarkBtn
    btn.Text = ""
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn)
    
    local BStroke = Instance.new("UIStroke", btn)
    BStroke.Thickness = 1
    BStroke.Color = PrimaryPurple
    BStroke.Transparency = 0.8

    local Label = Instance.new("TextLabel", btn)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = PrimaryPurple
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Status = Instance.new("TextLabel", btn)
    Status.Size = UDim2.new(0, 40, 1, 0)
    Status.Position = UDim2.new(1, -55, 0, 0)
    Status.BackgroundTransparency = 1
    Status.Text = TixSettings[settingKey] and "ON" or "OFF"
    Status.Font = Enum.Font.GothamBold
    Status.TextColor3 = TixSettings[settingKey] and OrchidAccent or OffText
    Status.TextSize = 13
    Status.TextXAlignment = Enum.TextXAlignment.Right

    local function updateVisualState()
        local s = TixSettings[settingKey]
        local targetColor = s and Color3.fromRGB(35, 15, 45) or DarkBtn
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play()
        Status.Text = s and "ON" or "OFF"
        Status.TextColor3 = s and OrchidAccent or OffText
        if settingKey == "CircleVis" then Circle.Visible = s end
    end

    btn.MouseButton1Click:Connect(function()
        TixSettings[settingKey] = not TixSettings[settingKey]
        updateVisualState()
    end)
    
    return {Update = updateVisualState}
end

local indicators = {
    Sticky = AddToggle("Sticky Aimlock", "Sticky"),
    Instant = AddToggle("Instant Aim", "InstantAim"), 
    Walls = AddToggle("Wall Check", "WallCheck"),
    Teams = AddToggle("Team Check", "TeamCheck"),
    ESP = AddToggle("Visual ESP", "ESP"),
    Tracers = AddToggle("Tracers", "Tracers"),
    NPCs = AddToggle("Include Bots / NPCs", "NPCs"),
    Rain = AddToggle("Rainbow Mode", "RainbowStyle"),
    FOV = AddToggle("Show FOV", "CircleVis")
}

-- Keybind Trigger Setup
table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end 
    if input.KeyCode == TixSettings.ToggleKey then
        TixSettings.Sticky = not TixSettings.Sticky
        indicators.Sticky.Update() 
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
    highlight.Parent = TixUI
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
    MainStroke.Color = accent
    ToggleStroke.Color = accent
    Title.TextColor3 = accent

    -- Aimlock Engine Tracking
    if TixSettings.Sticky then
        local targetModel = getClosest()
        if targetModel then 
            currentTargetStructure = targetModel
            
            -- Active humanized mid-lock part shifting
            if tick() - lastBoneSwitchTime > BoneSwitchInterval then
                lastBoneSwitchTime = tick()
                selectedBoneName = (math.random(1, 2) == 1) and "Head" or "HumanoidRootPart"
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

            -- Highlight handling (Matches strict boundaries cleanup properties)
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
