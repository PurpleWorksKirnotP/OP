local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI = GUI:CreateWindow("Waterbath made with love by Purps <3","v1")

local Home = UI:addPage("Main", 1, true, 6)
local NewFeatures = UI:addPage("More", 2, false, 6)

Home:addButton("Teleport to Queues (IN LOBBY)", function()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        rootPart.CFrame = CFrame.new(-402.1268310546875, 21.81222152709961, -59.4254035949707)
    end
end)

Home:addButton("Teleport to computer (Starts bloodbath)", function()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        rootPart.CFrame = CFrame.new(2184.958984375, -22.720096588134766, -1951.0340576171875)
    end
end)

local farming = false
Home:addToggle("Auto-Farm Souls (IN BLOODBATH)", function(value)
    farming = value
    if farming then
        task.spawn(function()
            local soulsFolder = workspace.Map.Souls
            local player = game:GetService("Players").LocalPlayer
            
            while farming do
                local children = soulsFolder:GetChildren()
                if #children == 0 then
                    task.wait(1)
                end
                
                for _, soul in next, children do
                    if not farming then break end 
                    if soul:IsA("BasePart") then
                        local character = player.Character
                        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = soul.CFrame * CFrame.new(0, 2, 0)
                        end
                        task.wait(0.1) 
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

Home:addButton("Inf lives script (NOT MINE, Creds to owner)", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/SUITBORN-BLOODBATH-cracked-script-removed-key-system-94055"))()
end)

NewFeatures:addButton("ESCAPE!!!", function()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local escapeDoor = workspace.Map:FindFirstChild("EscapeDoor")
    if rootPart and escapeDoor then
        if escapeDoor:IsA("BasePart") then
            rootPart.CFrame = escapeDoor.CFrame
        elseif escapeDoor:FindFirstChildWhichIsA("BasePart") then
            rootPart.CFrame = escapeDoor:FindFirstChildWhichIsA("BasePart").CFrame
        end
    end
end)

local farmingKatanas = false
NewFeatures:addButton("Auto-Farm Katanas", function(value)
    farmingKatanas = value
    if farmingKatanas then
        task.spawn(function()
            local katanasFolder = workspace.Map:FindFirstChild("Katanas")
            local player = game:GetService("Players").LocalPlayer
            
            while farmingKatanas and katanasFolder do
                local children = katanasFolder:GetChildren()
                if #children == 0 then
                    task.wait(1)
                end
                
                for _, katana in next, children do
                    if not farmingKatanas then break end
                    if katana:IsA("BasePart") then
                        local character = player.Character
                        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = katana.CFrame * CFrame.new(0, 2, 0)
                        end
                        task.wait(0.5)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

NewFeatures:addButton("Straight To Cutscene", function()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        rootPart.CFrame = CFrame.new(-141.8729705810547, -450.12408447265625, 2104.786865234375)
    end
end)

NewFeatures:addButton("Straight to Cutscene2", function()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        rootPart.CFrame = CFrame.new(-299.00067138671875, -9.345233917236328, 2203.372314453125)
    end
end)

NewFeatures:addButton("Destroy kit", function()
    local kit = workspace:FindFirstChild("kit")
    if kit then
        kit:Destroy()
    end
end)
