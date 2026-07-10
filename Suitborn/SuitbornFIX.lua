local notif = loadstring(game:HttpGet("https://raw.githubusercontent.com/DozeIsOkLol/UILibarys/refs/heads/main/Notifications/Modern/Source.lua"))()
local TeleportService = game:GetService("TeleportService")

--[[
    ***READ ME!!!***
    For Team Escape to work, you need to wait for godzilla to wake up (or move out of the exit hallway)

    OneManEscape bypasses that however leaves your teammates to fend for themselves.

    **TO NOTE**: OneManEscape will automatically send you to the main menu so think carefully.

    Fully open source for yall <3
    Made with love by Purps <3
    (First Script lol)

    If you are a suitborn dev contact me on discord: KirturneedPurp
]]

notif:Notification("Made by Purps","Check the config variables!","GothamSemibold","Gotham",2)

local Config = {
    TeamEscape = false, -- True by default. Allows yo lads to escape GOJIRA MUST BE AWAKE
    OneManEscape = true, -- False by default. Bypasses the need for Gojira to be awake
    AutoRejoin = false -- False by default, (NEEDS TO BE IN NIGHT 1) you just need to execute the script when you join the new server.
}

local function EscapeEarly()
    local ExitDoorOpen = game:GetService("ReplicatedStorage"):WaitForChild("ExitDoorOpen")

    ExitDoorOpen:FireServer() -- Opens up the door for yo lads
end

local function OneManEscapah()
    local Players = game:GetService("Players")
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

end


if Config.TeamEscape == true and Config.OneManEscape == true then -- TeamEscape + OneManEscape set to true
    --loadstring(game:HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/EscapeEarly.lua"))()
    EscapeEarly()
    notif:Notification("TeamEscape","Gojira must be awake first, else your teammates will have to wait for him to awaken to escape.","GothamSemibold","Gotham",2)


    task.wait(1)

    --loadstring(game:HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Gojira.lua"))()
    OneManEscapah()
elseif Config.OneManEscape == true and Config.TeamEscape == false then -- OneManEscape set to true and TeamEscape set to false
    notif:Notification("One man Escape","Will automatically send you to the lobby!","GothamSemibold","Gotham",2)

    --loadstring(game:HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Gojira.lua"))()
    OneManEscapah()

    loadstring(game:HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/PurpsUtility/PurpsUtility.lua"))() -- Opens up purps utils just incase if anything fails or needs a rejoin.
elseif Config.TeamEscape == true and Config.OneManEscape == false then -- Team Escape set to true and One Man Escape set to be false
    notif:Notification("TeamEscape","Gojira must be awake first, else your teammates will have to wait for him to awaken to escape.","GothamSemibold","Gotham",5)

    --loadstring(game:HttpGet("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/EscapeEarly.lua"))()
    EscapeEarly()
end

task.wait(0.1)

if Config.AutoRejoin == true then
    TeleportService:Teleport(game.PlaceId, Player)
end
