local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Laundered by Purps",
   Icon = 0, 
   LoadingTitle = "Hekmatyar (Dirty Money)",
   LoadingSubtitle = "by purps",
   ShowText = "urps", 
   Theme = "Default", 

   ToggleUIKeybind = Enum.KeyCode.K, 

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, 

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PurpsHub", 
      FileName = "PURPS"
   },

   Discord = {
      Enabled = false, 
      Invite = "noinvitelink", 
      RememberJoins = true 
   },

   KeySystem = false, 
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", 
      FileName = "Key", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Hello"} 
   }
})

local TeleportsX = Window:CreateTab("Main", 18273149527) 
local Teleports

local Button1 = TeleportsX:CreateButton({
   Name = "Tp quest guy (OLD)",
   Callback = function()
      local player = game:GetService("Players").LocalPlayer
      if player.Character then
         player.Character:PivotTo(CFrame.new(-993.2938, -24.2524, 244.5152))
      end
   end,
})

local Button2 = TeleportsX:CreateButton({
   Name = "Smuggling Quest",
   Callback = function()
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer
      local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
      
      local QuestsFolder = workspace:FindFirstChild("Quests")

      if QuestsFolder then
          local targetNPC = nil
          
          for _, child in pairs(QuestsFolder:GetChildren()) do
              if child.Name == "CourierNPC" then
                  targetNPC = child
                  break
              end
          end
          
          if targetNPC then
              local targetPart = targetNPC:IsA("Model") and (targetNPC.PrimaryPart or targetNPC:FindFirstChildWhichIsA("BasePart")) or targetNPC
              
              if targetPart then
                  Character:PivotTo(targetPart.CFrame)
              else
                  warn("CourierNPC found, but it has no valid parts to teleport to!")
              end
          else
              warn("CourierNPC could not be found inside workspace.Quests!")
          end
      else
          warn("workspace.Quests folder/model does not exist!")
      end
   end,
})

local Button3 = TeleportsX:CreateButton({
   Name = "Wires quest",
   Callback = function()
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer
      local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
      local Camera = workspace.CurrentCamera 

      local marker = Camera:FindFirstChild("FuseboxMarker")

      if marker then
          local targetCFrame = marker:IsA("Model") and (marker.PrimaryPart and marker.PrimaryPart.CFrame or marker:FindFirstChildWhichIsA("BasePart").CFrame) or (marker:IsA("BasePart") and marker.CFrame)
          
          if targetCFrame then
              Character:PivotTo(targetCFrame)
          else
              warn("FuseboxMarker found in Camera, but it does not contain a physical part/CFrame!")
          end
      else
          warn("FuseboxMarker was not found inside workspace.Camera!")
      end
   end,
})

local Dropdown = TeleportsX:CreateDropdown({
   Name = "Select Mission Dealer",
   Options = {"MissionDealer1", "MissionDealer2", "MissionDealer3", "MissionDealer4", "MissionDealer5"},
   CurrentOption = {"MissionDealer1"},
   MultipleOptions = false,
   Callback = function(SelectedOption)
      local choice = SelectedOption[1]
      local npcFolder = workspace:FindFirstChild("Scenic NPCs")
      
      if npcFolder then
         local dealer = npcFolder:FindFirstChild(choice)
         if dealer then
            local player = game:GetService("Players").LocalPlayer
            if player.Character then
               player.Character:PivotTo(dealer:GetPivot())
            end
         else
            warn(choice .. " was not found inside Scenic NPCs folder!")
         end
      else
         warn("Scenic NPCs folder was not found in workspace!")
      end
   end,
})

local ButtonHeist = TeleportsX:CreateButton({
   Name = "Rnd Heist Objective TP (Parts Only)",
   Callback = function()
      local function somePathCheck(...)
         local current = workspace
         for _, name in ipairs({...}) do
            current = current and current:FindFirstChild(name)
         end
         return current
      end

      local paths = {
         somePathCheck("Heists", "DataCenter", "Interactables"),
         somePathCheck("Heists", "Bank", "Interactables"),
         somePathCheck("Heists", "PentHouse", "Interactables")
      }
      
      local possibleTargets = {}

      for _, folder in pairs(paths) do
         if folder then
            for _, object in pairs(folder:GetDescendants()) do
               -- Strictly targeted toward BaseParts rather than structural Models
               if object:IsA("BasePart") then
                  local parentModel = object:FindFirstAncestorWhichIsA("Model")
                  local parentName = parentModel and parentModel.Name or ""
                  
                  -- Filters out blacklisted items/parents
                  if object.Name ~= "CrownSpawner" and object.Name ~= "JewelryCabinet" and 
                     parentName ~= "CrownSpawner" and parentName ~= "JewelryCabinet" then
                     
                     table.insert(possibleTargets, object)
                  end
               end
            end
         end
      end

      if #possibleTargets > 0 then
         local randomChoice = possibleTargets[math.random(1, #possibleTargets)]
         local player = game:GetService("Players").LocalPlayer
         
         if player.Character then
            player.Character:PivotTo(randomChoice.CFrame)
         end
      else
         warn("No valid, unfiltered BaseParts found across target heist paths!")
      end
   end,
})
