local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI = GUI:CreateWindow("Purps Utility","v1")

local Home = UI:addPage("Main", 1, true, 6)

Home:addButton("Rejoin", function()
    local TeleportService = game:GetService("TeleportService")
    local player = game:GetService("Players").LocalPlayer
    TeleportService:Teleport(game.PlaceId, player)
end)

Home:addButton("Dex ++", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Dex-PlusPlus-Decompiler-Fix-206651"))()
end)

Home:addButton("Inf Yield", function()  
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)