-- Blox Fruits Auto Farm Script with Enhanced UI
-- Created for educational purposes only

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- GUI Creation with Enhanced Visuals
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local UIGradient_Main = Instance.new("UIGradient")
local TopBar = Instance.new("Frame")
local UICorner_TopBar = Instance.new("UICorner")
local UIGradient_TopBar = Instance.new("UIGradient")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("ImageButton")
local MinimizeButton = Instance.new("ImageButton")
local Shadow = Instance.new("ImageLabel")
local ButtonsHolder = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local StatusFrame = Instance.new("Frame")
local UICorner_Status = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")
local StatusIcon = Instance.new("ImageLabel")

-- GUI Properties with Enhanced Visuals
ScreenGui.Name = "BloxFruitsEnhancedGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, 10)
UICorner_Main.Parent = MainFrame

UIGradient_Main.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
}
UIGradient_Main.Rotation = 45
UIGradient_Main.Parent = MainFrame

Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = -1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)

UICorner_TopBar.CornerRadius = UDim.new(0, 10)
UICorner_TopBar.Parent = TopBar

UIGradient_TopBar.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 80))
}
UIGradient_TopBar.Rotation = 90
UIGradient_TopBar.Parent = TopBar

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Blox Fruits Auto Farm"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18.000
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0.5, -10)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Image = "rbxassetid://6031094678"
CloseButton.ImageColor3 = Color3.fromRGB(255, 80, 80)

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(1, -65, 0.5, -10)
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Image = "rbxassetid://6031090990"
MinimizeButton.ImageColor3 = Color3.fromRGB(80, 180, 255)

ButtonsHolder.Name = "ButtonsHolder"
ButtonsHolder.Parent = MainFrame
ButtonsHolder.BackgroundTransparency = 1
ButtonsHolder.Position = UDim2.new(0, 0, 0, 50)
ButtonsHolder.Size = UDim2.new(1, 0, 1, -100)

UIListLayout.Parent = ButtonsHolder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

UIPadding.Parent = ButtonsHolder
UIPadding.PaddingTop = UDim.new(0, 10)

StatusFrame.Name = "StatusFrame"
StatusFrame.Parent = MainFrame
StatusFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
StatusFrame.BorderSizePixel = 0
StatusFrame.Position = UDim2.new(0, 10, 1, -40)
StatusFrame.Size = UDim2.new(1, -20, 0, 30)

UICorner_Status.CornerRadius = UDim.new(0, 6)
UICorner_Status.Parent = StatusFrame

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = StatusFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 30, 0, 0)
StatusLabel.Size = UDim2.new(1, -30, 1, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14.000
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

StatusIcon.Name = "StatusIcon"
StatusIcon.Parent = StatusFrame
StatusIcon.BackgroundTransparency = 1
StatusIcon.Position = UDim2.new(0, 5, 0.5, -8)
StatusIcon.Size = UDim2.new(0, 16, 0, 16)
StatusIcon.Image = "rbxassetid://6031075931"
StatusIcon.ImageColor3 = Color3.fromRGB(80, 200, 120)

-- Function to create stylish buttons
local function createStylishButton(name, text, parent, positionY, order)
    local Button = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local ButtonLabel = Instance.new("TextLabel")
    local ButtonIcon = Instance.new("ImageLabel")
    local ToggleStatus = Instance.new("Frame")
    local UICorner_Toggle = Instance.new("UICorner")
    local ToggleInner = Instance.new("Frame")
    local UICorner_Inner = Instance.new("UICorner")
    local Detector = Instance.new("TextButton")
    
    Button.Name = name
    Button.Parent = parent
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0.9, 0, 0, 45)
    Button.LayoutOrder = order
    
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Button
    
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 90)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 75))
    }
    UIGradient.Rotation = 90
    UIGradient.Parent = Button
    
    ButtonLabel.Name = "ButtonLabel"
    ButtonLabel.Parent = Button
    ButtonLabel.BackgroundTransparency = 1
    ButtonLabel.Position = UDim2.new(0, 45, 0, 0)
    ButtonLabel.Size = UDim2.new(1, -100, 1, 0)
    ButtonLabel.Font = Enum.Font.GothamSemibold
    ButtonLabel.Text = text
    ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonLabel.TextSize = 16.000
    ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    ButtonIcon.Name = "ButtonIcon"
    ButtonIcon.Parent = Button
    ButtonIcon.BackgroundTransparency = 1
    ButtonIcon.Position = UDim2.new(0, 10, 0.5, -12)
    ButtonIcon.Size = UDim2.new(0, 24, 0, 24)
    ButtonIcon.Image = "rbxassetid://6026568198"
    ButtonIcon.ImageColor3 = Color3.fromRGB(200, 200, 255)
    
    ToggleStatus.Name = "ToggleStatus"
    ToggleStatus.Parent = Button
    ToggleStatus.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    ToggleStatus.BorderSizePixel = 0
    ToggleStatus.Position = UDim2.new(1, -60, 0.5, -10)
    ToggleStatus.Size = UDim2.new(0, 50, 0, 20)
    
    UICorner_Toggle.CornerRadius = UDim.new(1, 0)
    UICorner_Toggle.Parent = ToggleStatus
    
    ToggleInner.Name = "ToggleInner"
    ToggleInner.Parent = ToggleStatus
    ToggleInner.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleInner.BorderSizePixel = 0
    ToggleInner.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleInner.Size = UDim2.new(0, 16, 0, 16)
    
    UICorner_Inner.CornerRadius = UDim.new(1, 0)
    UICorner_Inner.Parent = ToggleInner
    
    Detector.Name = "Detector"
    Detector.Parent = Button
    Detector.BackgroundTransparency = 1
    Detector.Size = UDim2.new(1, 0, 1, 0)
    Detector.Font = Enum.Font.SourceSans
    Detector.Text = ""
    Detector.TextColor3 = Color3.fromRGB(0, 0, 0)
    Detector.TextSize = 14.000
    
    -- Button hover effect
    Detector.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
    end)
    
    Detector.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
    end)
    
    return Button, Detector, ToggleInner, ToggleStatus, ButtonIcon
end

-- Create buttons with the new style
local AutoFarmButton, AutoFarmDetector, AutoFarmToggle, AutoFarmToggleStatus = createStylishButton("AutoFarmButton", "Auto Farm", ButtonsHolder, 0.15, 1)
local AutoQuestButton, AutoQuestDetector, AutoQuestToggle, AutoQuestToggleStatus = createStylishButton("AutoQuestButton", "Auto Quest", ButtonsHolder, 0.25, 2)
local AutoRaidButton, AutoRaidDetector, AutoRaidToggle, AutoRaidToggleStatus = createStylishButton("AutoRaidButton", "Auto Raid", ButtonsHolder, 0.35, 3)
local AutoSkillButton, AutoSkillDetector, AutoSkillToggle, AutoSkillToggleStatus = createStylishButton("AutoSkillButton", "Auto Skill", ButtonsHolder, 0.45, 4)
local AutoCollectButton, AutoCollectDetector, AutoCollectToggle, AutoCollectToggleStatus = createStylishButton("AutoCollectButton", "Auto Collect", ButtonsHolder, 0.55, 5)
local SelectMobButton, SelectMobDetector = createStylishButton("SelectMobButton", "Select Mob", ButtonsHolder, 0.65, 6)
local TeleportButton, TeleportDetector = createStylishButton("TeleportButton", "Teleport Menu", ButtonsHolder, 0.75, 7)
-- Set specific icons for each button
AutoFarmButton.ButtonIcon.Image = "rbxassetid://6034287594" -- Sword icon
AutoQuestButton.ButtonIcon.Image = "rbxassetid://6031075930" -- Quest icon
AutoRaidButton.ButtonIcon.Image = "rbxassetid://6031086173" -- Target icon
AutoSkillButton.ButtonIcon.Image = "rbxassetid://6026568215" -- Lightning icon
AutoCollectButton.ButtonIcon.Image = "rbxassetid://6031097225" -- Collect icon
SelectMobButton.ButtonIcon.Image = "rbxassetid://6031086176" -- Search icon
TeleportButton.ButtonIcon.Image = "rbxassetid://6034754445" -- Location icon

-- Remove toggle elements from non-toggle buttons
SelectMobButton.ToggleStatus:Destroy()
TeleportButton.ToggleStatus:Destroy()

-- Variables
local AutoFarm = false
local AutoQuest = false
local AutoRaid = false
local AutoSkill = false
local AutoCollect = false
local SelectedMob = "Bandit"
local CurrentQuest = nil
local QuestLevel = 0
local Minimized = false

-- Functions
local function getNearestMob()
    local nearestMob = nil
    local shortestDistance = math.huge
    
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            if v.Name:find(SelectedMob) then
                local distance = (HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestMob = v
                end
            end
        end
    end
    
    return nearestMob
end

local function getQuest()
    if not AutoQuest then return end
    
    -- This is a simplified example. You would need to adjust this based on actual quest NPCs in the game
    local questNPCs = {
        ["Bandit"] = {NPC = "QuestGiver1", Level = 1},
        ["Monkey"] = {NPC = "QuestGiver2", Level = 10},
        -- Add more quest givers as needed
    }
    
    local questInfo = questNPCs[SelectedMob]
    if questInfo and LocalPlayer.Data.Level.Value >= questInfo.Level then
        -- Simulate clicking on quest NPC and accepting quest
        -- This would need to be adjusted based on how quests work in the game
        updateStatus("Getting quest from " .. questInfo.NPC)
        
        -- Example of how you might interact with a quest NPC
        -- game:GetService("ReplicatedStorage").Remotes.TakeQuest:FireServer(questInfo.NPC, SelectedMob)
        
        CurrentQuest = SelectedMob
        QuestLevel = questInfo.Level
    end
end

local function teleportTo(position)
    local tweenInfo = TweenInfo.new(
        (HumanoidRootPart.Position - position).Magnitude / 200, -- Time based on distance
        Enum.EasingStyle.Linear
    )
    
    local tween = TweenService:Create(HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(position)})
    tween:Play()
    tween.Completed:Wait()
end

local function attackMob(mob)
    if mob and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
        -- Teleport near the mob
        teleportTo(mob.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
        
        -- Attack the mob
        -- This would need to be adjusted based on how combat works in the game
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(0, 0))
        
        -- Use skills if enabled
        if AutoSkill then
            useSkills()
        end
    end
end

local function startAutoFarm()
    while AutoFarm do
        if AutoQuest and not CurrentQuest then
            getQuest()
        end
        
        local mob = getNearestMob()
        if mob then
            updateStatus("Attacking " .. mob.Name)
            attackMob(mob)
        else
            updateStatus("Searching for mobs...")
            -- You might want to teleport to known spawn locations here
        end
        
        wait(0.1)
    end
end

local function startAutoRaid()
    while AutoRaid do
        updateStatus("Auto Raid running")
        -- Implement raid logic here
        -- This would involve joining raids, attacking raid bosses, etc.
        wait(1)
    end
end

local function useSkills()
    -- Example of how to use skills in Blox Fruits
    -- This would need to be adjusted based on the actual skill system
    local skills = {"Z", "X", "C", "V", "F"}
    
    for _, skill in ipairs(skills) do
        game:GetService("VirtualInputManager"):SendKeyEvent(true, skill, false, game)
        wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, skill, false, game)
        wait(0.5)
    end
end

local function collectDrops()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
            wait(0.5)
        end
    end
end

local function updateStatus(text)
    StatusLabel.Text = "Status: " .. text
    -- Add a small animation to the status icon
    local tween = TweenService:Create(StatusIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = StatusIcon.Rotation + 30})
    tween:Play()
end

local function toggleButton(button, toggle, status)
    if status then
        -- ON state
        TweenService:Create(toggle, TweenInfo.new(0.3), {Position = UDim2.new(0, 32, 0.5, -8), BackgroundColor3 = Color3.fromRGB(80, 200, 120)}):Play()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 80, 100)}):Play()
    else
        -- OFF state
        TweenService:Create(toggle, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
    end
end

-- Create Teleport Menu with enhanced visuals
local function createTeleportMenu()
    local TeleportMenu = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local TeleportTitle = Instance.new("TextLabel")
    local LocationsHolder = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")
    local CloseButton = Instance.new("ImageButton")
    
    TeleportMenu.Name = "TeleportMenu"
    TeleportMenu.Parent = MainFrame
    TeleportMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    TeleportMenu.BorderSizePixel = 0
    TeleportMenu.Position = UDim2.new(1.05, 0, 0, 0)
    TeleportMenu.Size = UDim2.new(0, 250, 1, 0)
    TeleportMenu.ClipsDescendants = true
    
    -- Animate the menu sliding in
    TweenService:Create(TeleportMenu, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, 10, 0, 0)}):Play()
    
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = TeleportMenu
    
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 50))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = TeleportMenu
    
    TeleportTitle.Name = "TeleportTitle"
    TeleportTitle.Parent = TeleportMenu
    TeleportTitle.BackgroundTransparency = 1
    TeleportTitle.Position = UDim2.new(0, 10, 0, 10)
    TeleportTitle.Size = UDim2.new(1, -50, 0, 30)
    TeleportTitle.Font = Enum.Font.GothamBold
    TeleportTitle.Text = "Teleport Locations"
    TeleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportTitle.TextSize = 16.000
    TeleportTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    LocationsHolder.Name = "LocationsHolder"
    LocationsHolder.Parent = TeleportMenu
    LocationsHolder.BackgroundTransparency = 1
    LocationsHolder.Position = UDim2.new(0, 10, 0, 50)
    LocationsHolder.Size = UDim2.new(1, -20, 1, -70)
    LocationsHolder.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated based on content
    LocationsHolder.ScrollBarThickness = 4
    LocationsHolder.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
    
    UIListLayout.Parent = LocationsHolder
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    
    UIPadding.Parent = LocationsHolder
    UIPadding.PaddingTop = UDim.new(0, 5)
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TeleportMenu
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Image = "rbxassetid://6031094678"
    CloseButton.ImageColor3 = Color3.fromRGB(255, 100, 100)
    
    -- Add teleport locations (these would need to be adjusted for actual game locations)
    local locations = {
        "Starter Island",
        "Middle Island",
        "Jungle Island",
        "Pirate Island",
        "Desert Island",
        "Frozen Island",
        "Marine Fortress",
        "Prison",
        "Colosseum",
        "Sky Island"
    }
    
    for i, location in ipairs(locations) do
        local LocationButton = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local LocationLabel = Instance.new("TextLabel")
        local LocationIcon = Instance.new("ImageLabel")
        local Detector = Instance.new("TextButton")
        
        LocationButton.Name = location
        LocationButton.Parent = LocationsHolder
        LocationButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        LocationButton.BorderSizePixel = 0
        LocationButton.Size = UDim2.new(0.95, 0, 0, 40)
        
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = LocationButton
        
        LocationLabel.Name = "LocationLabel"
        LocationLabel.Parent = LocationButton
        LocationLabel.BackgroundTransparency = 1
        LocationLabel.Position = UDim2.new(0, 40, 0, 0)
        LocationLabel.Size = UDim2.new(1, -50, 1, 0)
        LocationLabel.Font = Enum.Font.GothamSemibold
        LocationLabel.Text = location
        LocationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        LocationLabel.TextSize = 14.000
        LocationLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        LocationIcon.Name = "LocationIcon"
        LocationIcon.Parent = LocationButton
        LocationIcon.BackgroundTransparency = 1
        LocationIcon.Position = UDim2.new(0, 8, 0.5, -10)
        LocationIcon.Size = UDim2.new(0, 20, 0, 20)
        LocationIcon.Image = "rbxassetid://6034754445"
        LocationIcon.ImageColor3 = Color3.fromRGB(200, 200, 255)
        
        Detector.Name = "Detector"
        Detector.Parent = LocationButton
        Detector.BackgroundTransparency = 1
        Detector.Size = UDim2.new(1, 0, 1, 0)
        Detector.Font = Enum.Font.SourceSans
        Detector.Text = ""
        Detector.TextColor3 = Color3.fromRGB(0, 0, 0)
        Detector.TextSize = 14.000
        
        -- Button hover effect
        Detector.MouseEnter:Connect(function()
            TweenService:Create(LocationButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
        end)
        
        Detector.MouseLeave:Connect(function()
            TweenService:Create(LocationButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
        end)
        
        Detector.MouseButton1Click:Connect(function()
            updateStatus("Teleporting to " .. location)
            -- This would need to be adjusted with actual coordinates for each location
            -- teleportTo(Vector3.new(x, y, z))

-- Add a nice effect when clicking
            TweenService:Create(LocationButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 100, 150)}):Play()
            wait(0.1)
            TweenService:Create(LocationButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
        end)
    end
    
    -- Update canvas size based on content
    LocationsHolder.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        -- Animate the menu sliding out
        TweenService:Create(TeleportMenu, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1.05, 0, 0, 0)}):Play()
        wait(0.5)
        TeleportMenu:Destroy()
    end)
end

-- Create Mob Selection Menu with enhanced visuals
local function createMobSelectionMenu()
    local MobMenu = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local MobTitle = Instance.new("TextLabel")
    local MobsHolder = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")
    local CloseButton = Instance.new("ImageButton")
    
    MobMenu.Name = "MobMenu"
    MobMenu.Parent = MainFrame
    MobMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    MobMenu.BorderSizePixel = 0
    MobMenu.Position = UDim2.new(1.05, 0, 0, 0)
    MobMenu.Size = UDim2.new(0, 250, 1, 0)
    MobMenu.ClipsDescendants = true
    
    -- Animate the menu sliding in
    TweenService:Create(MobMenu, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, 10, 0, 0)}):Play()
    
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MobMenu
    
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 50))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = MobMenu
    
    MobTitle.Name = "MobTitle"
    MobTitle.Parent = MobMenu
    MobTitle.BackgroundTransparency = 1
    MobTitle.Position = UDim2.new(0, 10, 0, 10)
    MobTitle.Size = UDim2.new(1, -50, 0, 30)
    MobTitle.Font = Enum.Font.GothamBold
    MobTitle.Text = "Select Mob to Farm"
    MobTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MobTitle.TextSize = 16.000
    MobTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    MobsHolder.Name = "MobsHolder"
    MobsHolder.Parent = MobMenu
    MobsHolder.BackgroundTransparency = 1
    MobsHolder.Position = UDim2.new(0, 10, 0, 50)
    MobsHolder.Size = UDim2.new(1, -20, 1, -70)
    MobsHolder.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated based on content
    MobsHolder.ScrollBarThickness = 4
    MobsHolder.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
    
    UIListLayout.Parent = MobsHolder
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    
    UIPadding.Parent = MobsHolder
    UIPadding.PaddingTop = UDim.new(0, 5)
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MobMenu
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Image = "rbxassetid://6031094678"
    CloseButton.ImageColor3 = Color3.fromRGB(255, 100, 100)
    
    -- Add mob options (these would need to be adjusted for actual game mobs)
    local mobs = {
        "Bandit",
        "Monkey",
        "Gorilla",
        "Pirate",
        "Desert Bandit",
        "Snow Bandit",
        "Marine",
        "Prison Guard",
        "Colosseum Fighter",
        "Sky Bandit"
    }
    
    for i, mob in ipairs(mobs) do
        local MobButton = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local MobLabel = Instance.new("TextLabel")
        local MobIcon = Instance.new("ImageLabel")
        local Detector = Instance.new("TextButton")
        
        MobButton.Name = mob
        MobButton.Parent = MobsHolder
        MobButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        MobButton.BorderSizePixel = 0
        MobButton.Size = UDim2.new(0.95, 0, 0, 40)
        
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = MobButton
        
        MobLabel.Name = "MobLabel"
        MobLabel.Parent = MobButton
        MobLabel.BackgroundTransparency = 1
        MobLabel.Position = UDim2.new(0, 40, 0, 0)
        MobLabel.Size = UDim2.new(1, -50, 1, 0)
        MobLabel.Font = Enum.Font.GothamSemibold
        MobLabel.Text = mob
        MobLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        MobLabel.TextSize = 14.000
        MobLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        MobIcon.Name = "MobIcon"
        MobIcon.Parent = MobButton
        MobIcon.BackgroundTransparency = 1
        MobIcon.Position = UDim2.new(0, 8, 0.5, -10)
        MobIcon.Size = UDim2.new(0, 20, 0, 20)
        MobIcon.Image = "rbxassetid://6034287594" -- Sword icon
        MobIcon.ImageColor3 = Color3.fromRGB(200, 200, 255)
        
        Detector.Name = "Detector"
        Detector.Parent = MobButton
        Detector.BackgroundTransparency = 1
        Detector.Size = UDim2.new(1, 0, 1, 0)
        Detector.Font = Enum.Font.SourceSans
        Detector.Text = ""
        Detector.TextColor3 = Color3.fromRGB(0, 0, 0)
        Detector.TextSize = 14.000
        
        -- Button hover effect
        Detector.MouseEnter:Connect(function()
            TweenService:Create(MobButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
        end)
        
        Detector.MouseLeave:Connect(function()
            TweenService:Create(MobButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
        end)
        
        Detector.MouseButton1Click:Connect(function()
            SelectedMob = mob
            updateStatus("Selected " .. mob)
            
            -- Add a nice effect when clicking
            TweenService:Create(MobButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 100, 150)}):Play()
            wait(0.1)
            TweenService:Create(MobButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
            
            -- Reset current quest when changing mob
            CurrentQuest = nil
            
            -- Animate the menu sliding out
            TweenService:Create(MobMenu, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1.05, 0, 0, 0)}):Play()
            wait(0.5)
            MobMenu:Destroy()
        end)
    end
    
    -- Update canvas size based on content
    MobsHolder.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        -- Animate the menu sliding out
        TweenService:Create(MobMenu, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1.05, 0, 0, 0)}):Play()
        wait(0.5)
        MobMenu:Destroy()
    end)
end

-- Button Callbacks
AutoFarmDetector.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    toggleButton(AutoFarmButton, AutoFarmToggle, AutoFarm)
    
    if AutoFarm then
        updateStatus("Auto Farm started")
        coroutine.wrap(startAutoFarm)()
    else
        updateStatus("Auto Farm stopped")
    end
end)

AutoQuestDetector.MouseButton1Click:Connect(function()
    AutoQuest = not AutoQuest
    toggleButton(AutoQuestButton, AutoQuestToggle, AutoQuest)
    
    if AutoQuest then
        updateStatus("Auto Quest enabled")
    else
        updateStatus("Auto Quest disabled")
    end
end)

AutoRaidDetector.MouseButton1Click:Connect(function()
    AutoRaid = not AutoRaid
    toggleButton(AutoRaidButton, AutoRaidToggle, AutoRaid)
    
    if AutoRaid then
        updateStatus("Auto Raid started")
        coroutine.wrap(startAutoRaid)()
    else
        updateStatus("Auto Raid stopped")
    end
end)

AutoSkillDetector.MouseButton1Click:Connect(function()
    AutoSkill = not AutoSkill
    toggleButton(AutoSkillButton, AutoSkillToggle, AutoSkill)
    
    if AutoSkill then
        updateStatus("Auto Skill enabled")
    else
        updateStatus("Auto Skill disabled")
    end
end)

AutoCollectDetector.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    toggleButton(AutoCollectButton, AutoCollectToggle, AutoCollect)
    
    if AutoCollect then
        updateStatus("Auto Collect started")
        coroutine.wrap(function()
            while AutoCollect do
                collectDrops()
                wait(5)
            end
        end)()
    else
        updateStatus("Auto Collect stopped")
    end
end)

SelectMobDetector.MouseButton1Click:Connect(function()
    createMobSelectionMenu()
end)

TeleportDetector.MouseButton1Click:Connect(function()
    createTeleportMenu()
end)

-- Close and Minimize Button Functionality
CloseButton.MouseButton1Click:Connect(function()
    -- Add a fade out animation
    local fadeOut = TweenService:Create(ScreenGui, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    
    if Minimized then
        -- Minimize animation
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 350, 0, 40)}):Play()
        ButtonsHolder.Visible = false
        StatusFrame.Visible = false
    else
        -- Restore animation
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 350, 0, 400)}):Play()
        ButtonsHolder.Visible = true
        StatusFrame.Visible = true
    end
end)

-- Anti-AFK
local vu = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    updateStatus("Anti-AFK triggered")
    wait(2)
    updateStatus(AutoFarm and "Auto Farming" or "Idle")
end)

-- Character respawn handling
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    updateStatus("Character respawned")
    wait(2)
    
    if AutoFarm then
        updateStatus("Resuming Auto Farm")
    else
        updateStatus("Idle")
    end
end)
-- Add a welcome notification
local function createNotification(text, duration)
    local Notification = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local NotifIcon = Instance.new("ImageLabel")
    local NotifText = Instance.new("TextLabel")
    
    Notification.Name = "Notification"
    Notification.Parent = ScreenGui
    Notification.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Notification.BorderSizePixel = 0
    Notification.Position = UDim2.new(0, -300, 0.8, 0)
    Notification.Size = UDim2.new(0, 280, 0, 80)
    Notification.ZIndex = 100
    
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Notification
    
    NotifIcon.Name = "NotifIcon"
    NotifIcon.Parent = Notification
    NotifIcon.BackgroundTransparency = 1
    NotifIcon.Position = UDim2.new(0, 15, 0.5, -20)
    NotifIcon.Size = UDim2.new(0, 40, 0, 40)
    NotifIcon.Image = "rbxassetid://6026568198"
    NotifIcon.ImageColor3 = Color3.fromRGB(100, 200, 255)
    
    NotifText.Name = "NotifText"
    NotifText.Parent = Notification
    NotifText.BackgroundTransparency = 1
    NotifText.Position = UDim2.new(0, 70, 0, 0)
    NotifText.Size = UDim2.new(1, -80, 1, 0)
    NotifText.Font = Enum.Font.GothamSemibold
    NotifText.Text = text
    NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifText.TextSize = 14.000
    NotifText.TextWrapped = true
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Animate notification sliding in
    TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 20, 0.8, 0)}):Play()
    
    -- Schedule notification removal
    spawn(function()
        wait(duration)
        TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0, -300, 0.8, 0)}):Play()
        wait(0.5)
        Notification:Destroy()
    end)
end

-- Add a pulsing effect to the main frame
spawn(function()
    while wait(2) do
        if not Minimized then
            local pulse = TweenService:Create(Shadow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency = 0.4})
            pulse:Play()
            wait(1)
            local pulse2 = TweenService:Create(Shadow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency = 0.6})
            pulse2:Play()
        end
    end
end)

-- Add a rainbow effect to the title
spawn(function()
    local hue = 0
    while wait(0.1) do
        hue = (hue + 0.01) % 1
        Title.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
    end
end)

-- Initialize with welcome notification
createNotification("Welcome to Blox Fruits Auto Farm! Select a mob and enable features to begin farming.", 5)
updateStatus("Script loaded successfully")

-- Add version info at the bottom
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Name = "VersionLabel"
VersionLabel.Parent = MainFrame
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(0, 5, 1, -15)
VersionLabel.Size = UDim2.new(0, 100, 0, 15)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "v1.0.0"
VersionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
VersionLabel.TextSize = 12.000
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Add a credit label
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Name = "CreditLabel"
CreditLabel.Parent = MainFrame
CreditLabel.BackgroundTransparency = 1
CreditLabel.Position = UDim2.new(1, -105, 1, -15)
CreditLabel.Size = UDim2.new(0, 100, 0, 15)
CreditLabel.Font = Enum.Font.Gotham
CreditLabel.Text = "Made with ❤️"
CreditLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
CreditLabel.TextSize = 12.000
CreditLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Add a loading animation at startup
local LoadingFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local LoadingBar = Instance.new("Frame")
local UICorner_Bar = Instance.new("UICorner")
local LoadingText = Instance.new("TextLabel")

LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -40)
LoadingFrame.Size = UDim2.new(0, 300, 0, 80)
LoadingFrame.ZIndex = 1000

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = LoadingFrame

LoadingBar.Name = "LoadingBar"
LoadingBar.Parent = LoadingFrame
LoadingBar.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
LoadingBar.BorderSizePixel = 0
LoadingBar.Position = UDim2.new(0, 10, 0.7, 0)
LoadingBar.Size = UDim2.new(0, 0, 0, 15)
LoadingBar.ZIndex = 1001

UICorner_Bar.CornerRadius = UDim.new(0, 5)
UICorner_Bar.Parent = LoadingBar

LoadingText.Name = "LoadingText"
LoadingText.Parent = LoadingFrame
LoadingText.BackgroundTransparency = 1
LoadingText.Position = UDim2.new(0, 0, 0.2, 0)
LoadingText.Size = UDim2.new(1, 0, 0, 20)
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Text = "Loading Script..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 16.000
LoadingText.ZIndex = 1001

-- Animate loading bar
TweenService:Create(LoadingBar, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 280, 0, 15)}):Play()

-- Hide main UI until loading is complete
MainFrame.Visible = false

-- Complete loading and show UI
spawn(function()
    wait(1.5)
    LoadingText.Text = "Initializing Features..."
    wait(1)
    LoadingText.Text = "Ready!"
    wait(0.5)
    TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingBar, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    wait(0.5)
    LoadingFrame:Destroy()
    MainFrame.Visible = true
    
    -- Add entrance animation for main frame
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -400)
    TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -175, 0.5, -200)}):Play()
end)
