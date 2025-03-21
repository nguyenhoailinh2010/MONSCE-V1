-- Blox Fruits Auto Farm Script
-- Created by Cody

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local AutoFarmEnabled = false
local AntiAFKEnabled = true
local BypassMobsEnabled = false
local AttackSpeed = 1 -- Default attack speed multiplier

-- UI Library (using Orion Library)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Create Main Window
local Window = OrionLib:MakeWindow({
    Name = "Blox Fruits Auto Farm",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BloxFruitsConfig",
    IntroEnabled = true,
    IntroText = "Blox Fruits Auto Farm",
    IntroIcon = "rbxassetid://7733658504", -- Blox Fruits logo
    Icon = "rbxassetid://7733658504"
})

-- Tabs
local FarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://7743875962", -- Sword icon
    PremiumOnly = false
})

local StatsTab = Window:MakeTab({
    Name = "Auto Stats",
    Icon = "rbxassetid://7734053495", -- Stats icon
    PremiumOnly = false
})

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://7734039270", -- Settings icon
    PremiumOnly = false
})

-- Functions
local function GetCurrentSea()
    -- Check which sea the player is in based on game place ID or other indicators
    local placeId = game.PlaceId
    
    if placeId == 2753915549 then
        return 1 -- Sea 1
    elseif placeId == 4442272183 then
        return 2 -- Sea 2
    elseif placeId == 7449423635 then
        return 3 -- Sea 3
    else
        return 1 -- Default to Sea 1 if unknown
    end
end

local function GetPlayerLevel()
    return Player.Data.Level.Value
end

local function TeleportToIsland(islandName)
    -- Find the island CFrame
    local islands = {
        ["Starter Island"] = CFrame.new(1000, 10, 1000), -- Example coordinates
        ["Middle Island"] = CFrame.new(2000, 10, 2000), -- Example coordinates
        ["Jungle Island"] = CFrame.new(3000, 10, 3000), -- Example coordinates
        -- Add more islands with their coordinates
    }
    
    if islands[islandName] then
        local targetCFrame = islands[islandName]
        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        return true
    end
    return false
end

local function GetBestQuestForLevel(level, sea)
    -- Return the best quest for the player's level and sea
    if sea == 1 then
        if level < 10 then
            return "Bandit", "Starter Island"
        elseif level < 25 then
            return "Monkey", "Jungle Island"
        end
        -- Add more quests for Sea 1
    elseif sea == 2 then
        if level < 700 then
            return "Desert Bandit", "Desert Island"
        elseif level < 800 then
            return "Snow Bandit", "Snow Island"
        end
        -- Add more quests for Sea 2
    elseif sea == 3 then
        if level < 1500 then
            return "Pirate Millionaire", "Port Island"
        elseif level < 1600 then
            return "Dragon Crew Warrior", "Dragon Island"
        end
        -- Add more quests for Sea 3
    end
    
    return "Unknown", "Unknown Island"
end

local function AcceptQuest(questName)
    -- Simulate accepting a quest
    print("Accepting quest: " .. questName)
    -- Add code to interact with quest NPC
end

local function AttackNearestMob()
    local nearestMob = nil
    local shortestDistance = math.huge
    
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
            local distance = (HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestMob = mob
            end
        end
    end
    
    if nearestMob and shortestDistance < 100 then
        -- Move to mob
        local tweenInfo = TweenInfo.new(1 / AttackSpeed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = nearestMob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)})
        tween:Play()
        
        -- Attack mob
        local args = {
            [1] = nearestMob.HumanoidRootPart.Position
        }
        
        -- Simulate different attack methods
        local attackMethods = {
            ReplicatedStorage.Remotes.Combat,
            ReplicatedStorage.Remotes.Sword,
            ReplicatedStorage.Remotes.Gun,
            ReplicatedStorage.Remotes.BloxFruit
        }
        
        for _, method in ipairs(attackMethods) do
            if method then
                method:FireServer(unpack(args))
            end
        end
        
        return true
    end
    
    return false
end

local function StartAutoFarm()
    if AutoFarmEnabled then
        local currentSea = GetCurrentSea()
        local playerLevel = GetPlayerLevel()
        
        print("Current Sea: " .. currentSea)
        print("Player Level: " .. playerLevel)
        
        local questMob, questIsland = GetBestQuestForLevel(playerLevel, currentSea)
        
        if questMob ~= "Unknown" then
            -- Teleport to quest island
            if TeleportToIsland(questIsland) then
                wait(1)
                -- Accept quest
                AcceptQuest(questMob)
                
                -- Start attacking mobs
                while AutoFarmEnabled and wait(0.1) do
                    if not AttackNearestMob() then
                        -- No mobs found, look for more
                        print("Looking for more mobs...")
                    end
                end
            else
                print("Failed to teleport to island: " .. questIsland)
            end
        else
            print("No suitable quest found for level " .. playerLevel .. " in Sea " .. currentSea)
        end
    end
end

local function ToggleUI(showFull)
    for _, tab in pairs(Window.Tabs) do
        for _, element in pairs(tab.Elements) do
            element.Visible = showFull
        end
    end
    
    -- Always show the logo/toggle button
    Window.Frame.TopBar.Visible = true
end

-- Anti AFK
local function EnableAntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    Player.Idled:Connect(function()
        if AntiAFKEnabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            print("Anti-AFK triggered")
        end
    end)
end

-- UI Elements
-- Auto Farm Section
FarmTab:AddToggle({
    Name = "Enable Auto Farm",
    Default = false,
    Callback = function(Value)
        AutoFarmEnabled = Value
        if AutoFarmEnabled then
            StartAutoFarm()
        end
    end
})

FarmTab:AddButton({
    Name = "Teleport to Best Island",
    Callback = function()
        local currentSea = GetCurrentSea()
        local playerLevel = GetPlayerLevel()
        local _, bestIsland = GetBestQuestForLevel(playerLevel, currentSea)
        
        if bestIsland ~= "Unknown Island" then
            TeleportToIsland(bestIsland)
        else
            OrionLib:MakeNotification({
                Name = "Error",
                Content = "No suitable island found",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

-- Stats Section
StatsTab:AddToggle({
    Name = "Auto Upgrade Melee",
    Default = false,
    Callback = function(Value)
        -- Code to auto upgrade melee stats
        print("Auto Melee: " .. tostring(Value))
    end
})

StatsTab:AddToggle({
    Name = "Auto Upgrade Defense",
    Default = false,
    Callback = function(Value)
        -- Code to auto upgrade defense stats
        print("Auto Defense: " .. tostring(Value))
    end
})

StatsTab:AddToggle({
    Name = "Auto Upgrade Sword",
    Default = false,
    Callback = function(Value)
        -- Code to auto upgrade sword stats
        print("Auto Sword: " .. tostring(Value))
    end
})

StatsTab:AddToggle({
    Name = "Auto Upgrade Gun",
    Default = false,
    Callback = function(Value)
        -- Code to auto upgrade gun stats
        print("Auto Gun: " .. tostring(Value))
    end
})

StatsTab:AddToggle({
    Name = "Auto Upgrade Devil Fruit",
    Default = false,
    Callback = function(Value)
        -- Code to auto upgrade devil fruit stats
        print("Auto Devil Fruit: " .. tostring(Value))
    end
})

-- Settings Section
SettingsTab:AddSlider({
    Name = "Attack Speed",
    Min = 0.5,
    Max = 3,
    Default = 1,
    Color = Color3.fromRGB(255, 185, 0),
    Increment = 0.1,
    ValueName = "x",
    Callback = function(Value)
        AttackSpeed = Value
    end    
})

SettingsTab:AddToggle({
    Name = "Anti AFK",
    Default = true,
    Callback = function(Value)
        AntiAFKEnabled = Value
    end
})

SettingsTab:AddToggle({
    Name = "Bypass Mobs",
    Default = false,
    Callback = function(Value)
        BypassMobsEnabled = Value
    end
})

-- Minimize/Maximize Button
local minimized = false
Window.Frame.TopBar.LeftIcon.MouseButton1Click:Connect(function()
    minimized = not minimized
    ToggleUI(not minimized)
    
    -- Change icon based on state
    if minimized then
        Window.Frame.TopBar.LeftIcon.Image = "rbxassetid://7733658504" -- Logo
    else
        Window.Frame.TopBar.LeftIcon.Image = "rbxassetid://4034483344" -- Minus icon
    end
})

-- Initialize
EnableAntiAFK()
OrionLib:Init()

-- Notification on load
OrionLib:MakeNotification({
    Name = "Script Loaded",
    Content = "Auto Farm is ready to use!",
    Image = "rbxassetid://7733658504",
    Time = 5
})

print("Blox Fruits Auto Farm Script loaded successfully!")
