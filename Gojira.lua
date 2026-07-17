print("DEPRECATED CODE!!! Copied New Script To Clipboard.")

setclipboard("loadstring(HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Suitborn/SuitbornFIX.lua"))()")setclipboard("loadstring(HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Suitborn/SuitbornFIX.lua"))()")

--[[local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function executionSequence()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    character:PivotTo(CFrame.new(-20.394798278808594, -9.102655410766602, -239.45388793945312))
end

local function TeleportToTeleporter()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    if character then
        character:PivotTo(CFrame.new(-70.45172119140625, 5.692732334136963, -17.807708740234375))
    end
end

if game.PlaceId == 98274370174426 then -- Menu
    task.spawn(TeleportToTeleporter)
elseif game.PlaceId == 90784884733059 then -- Game
    task.spawn(executionSequence)
end
]]