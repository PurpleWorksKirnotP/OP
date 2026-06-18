local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function executionSequence()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    -- 1. Teleport to the first set of coordinates
    character:PivotTo(CFrame.new(-20.394798278808594, -9.102655410766602, -239.45388793945312))
    
    -- 2. Wait exactly 1 second
    task.wait(1)
    
    -- 3. Teleport to the second set of coordinates
    character:PivotTo(CFrame.new(-166.05490112304688, -450.0935363769531, -193.98046875))
end

local function TeleportToTeleporter()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    if character then
        character:PivotTo(CFrame.new(-70.45172119140625, 5.692732334136963, -17.807708740234375))
    end
end

-- Run the sequence safely on a background task thread

if game.PlaceId == 98274370174426 then -- Menu
    task.spawn(TeleportToTeleporter)
elseif game.PlaceId == 90784884733059 then -- Game
    task.spawn(executionSequence)
end