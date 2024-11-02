
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local blacklist = {
    [27191917191] = true,
    [8765432109] = true,
    [7654321098] = true,
}

local whitelist = {
    [4411316582] = true,
    [3449894283] = true,
    [4981545740] = true,
    [7158753496] = true,
    [7245850025] = true,
    [7158723626] = true,
    [7489641169] = true,
    [4042007999] = true,
    [7890123456] = true,
    [8901234567] = true,
    [9012345678] = true,
    [1011121314] = true,
    [1213141516] = true,
    [1314151617] = true,
    [1415161718] = true,
    [1516171819] = true,
    [1617181920] = true,
    [1718192021] = true,
    [1819202122] = true,
    [1920212223] = true,
    [2021222324] = true,
    [2122232425] = true,
    [2223242526] = true,
    [2324252627] = true,
    [2425262728] = true,
    [2526272829] = true,
    [2627282930] = true,
    [2728293031] = true,
    [2829303132] = true,
    [2930313233] = true,
    [3031323334] = true,
    [3132333435] = true,
    [3233343536] = true,
    [3334353637] = true,
    [3435363738] = true,
    [3536373839] = true,
    [3637383940] = true,
}

local function isPlayerBlacklisted(player)
    return blacklist[player.UserId] or false
end

local function isPlayerWhitelisted(player)
    return whitelist[player.UserId] or false
end

if isPlayerBlacklisted(LocalPlayer) then
    pcall(function()
        LocalPlayer:Kick("You are blacklisted!")
    end)
    return
end

if not isPlayerWhitelisted(LocalPlayer) then
    pcall(function()
        LocalPlayer:Kick("You are not whitelisted!")
    end)
    return
end

getgenv().venus = {
    ["Enabled"] = true,
    ["AimPart"] = "Head",
    ["Prediction"] = 0.12588,
    ["Smoothness"] = 0.7,
    ["ShakeValue"] = 1,
    ["AutoPred"] = true,
    ["Loaded"] = false,
    ["TTKO"] = false,
    ["AntiAimViewer"] = true,
    ["cframe"] = {
        ["enabled"] = false,
        ["speed"] = 2
    },
    ["TargetStrafe"] = {
        ["Enabled"] = false,
        ["StrafeSpeed"] = 10,
        ["StrafeRadius"] = 7,
        ["StrafeHeight"] = 3,
        ["RandomizerMode"] = false
    },
    ["targetaim"] = {
        ["Toggled"] = false,
        ["AutoShoot"] = false,
        ["enabled"] = true,
        ["targetPart"] = "UpperTorso",
        ["prediction"] = 0.12588
    },
    ["Triggerbot"] = {
        ["ClosestPart"] = {
            ["HitParts"] = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "RightFoot", "LeftFoot"}
        },
        ["FOV"] = {
            ["Enabled"] = true,
            ["Size"] = 13,
            ["Centered"] = false,
            ["Visible"] = true,
            ["Filled"] = false,
            ["Color"] = Color3.fromRGB(255, 0, 0)
        },
        ["Settings"] = {
            ["Prediction"] = 0.111,
            ["ClickDelay"] = 0.1,
            ["ActivationDelay"] = 2,
            ["IgnoreFriends"] = false,
            ["AutomaticallyFire"] = false
        },
        ["Resolver"] = {
            ["Enabled"] = true,
            ["Method"] = "RecalculateVelocity",
            ["Prediction Settings"] = {
                ["HitPart"] = "Head"
            },
            ["desync"] = {
                ["sky"] = false,
                ["invis"] = true,
                ["jump"] = false,
                ["network"] = false
            },
            ["Misc"] = {
                ["LowGfx"] = false
            },
            ["FPSunlocker"] = {
                ["Enabled"] = true,
                ["FPSCap"] = 999
            }
        }
    }
}

local Notification = Instance.new("ScreenGui")
local Holder = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

Notification.Name = "Notification"
Notification.Parent = game.CoreGui
Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Holder.Name = "Holder"
Holder.Parent = Notification
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.BackgroundTransparency = 1.000
Holder.Position = UDim2.new(0, 10, 0, 10)  -- Starting position on the left with slight padding
Holder.AnchorPoint = Vector2.new(0, 0)
Holder.Size = UDim2.new(0, 243, 0, 240)

UIListLayout.Parent = Holder
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

function jam_notify(text, time)
    local Template = Instance.new("Frame")
    local ColorBar = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")

    Template.Name = text
    Template.Parent = Holder
    Template.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Set frame to black
    Template.BorderSizePixel = 0  -- Remove the border
    Template.Size = UDim2.new(0, 0, 0, 22)  -- Start with width 0
    Template.Position = UDim2.new(0, 0, 0, 0)  -- Start position at the holder
    Template.Transparency = 1

    ColorBar.Name = "ColorBar"
    ColorBar.Parent = Template
    ColorBar.BackgroundColor3 = Color3.fromRGB(0, 85, 255)  -- Set color bar to Blue
    ColorBar.BorderSizePixel = 0
    ColorBar.Size = UDim2.new(0, 2, 0, 21)
    ColorBar.Position = UDim2.new(0, 0, 0, 0)  -- Positioning the color bar
    ColorBar.Transparency = 1  -- Start as fully transparent

    TextLabel.Parent = Template
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderSizePixel = 0  -- Remove the border
    TextLabel.Position = UDim2.new(0, 8, 0, 1)
    TextLabel.Size = UDim2.new(1, -16, 0, 20)  -- Adjust text size to fit better
    TextLabel.Font = Enum.Font.Code
    TextLabel.Text = text .. " [" .. time .. "s]"  -- Add countdown timer
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Set text to white
    TextLabel.TextSize = 12.000  -- Smaller text size
    TextLabel.TextStrokeTransparency = 0.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Transparency = 1  -- Start as fully transparent

    -- Update size based on text
    local textSize = TextLabel.TextBounds.X + 18 -- Adjust for padding
    Template.Size = UDim2.new(0, textSize, 0, 22) -- Update template size based on text

    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  -- Set duration to 0.3 seconds
    local fadeInGoal = {Transparency = 0}
    
    -- Play fade in and expand animations
    TweenService:Create(Template, tweenInfo, fadeInGoal):Play()
    TweenService:Create(ColorBar, tweenInfo, {Transparency = 0}):Play()  -- Fade in color bar
    TweenService:Create(TextLabel, tweenInfo, fadeInGoal):Play()  -- Fade in text

    -- Animate position from left to right
    Template.Position = UDim2.new(0, 10, 0, 0)  -- Final position

    local elapsed = 0
    local updateConnection

    updateConnection = RunService.RenderStepped:Connect(function(dt)
        elapsed = elapsed + dt
        local remainingTime = math.max(0, time - elapsed)
        TextLabel.Text = text .. " [" .. string.format("%.1f", remainingTime) .. "s]"
        
        -- Update notification size to fit the text every update
        local newTextSize = TextLabel.TextBounds.X + 18 -- Adjust for padding
        Template.Size = UDim2.new(0, newTextSize, 0, 22) -- Update template size based on new text

        if remainingTime <= 0 then
            updateConnection:Disconnect()
            local fadeOutGoal = {Transparency = 1}
            TweenService:Create(Template, tweenInfo, fadeOutGoal):Play()
            TweenService:Create(ColorBar, tweenInfo, fadeOutGoal):Play()
            TweenService:Create(TextLabel, tweenInfo, fadeOutGoal):Play()
            delay(0.51, function()
                Template:Destroy()
            end)
        end
    end)
end

-- Example of usage
jam_notify("Whitelisted user!✅", 5)

local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextButton = Instance.new("TextButton")
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0
    Frame.Position = UDim2.new(1, -120, 0, 0)
    Frame.Size = UDim2.new(0, 100, 0, 50)

    TextButton.Parent = Frame

    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BackgroundTransparency = 0.0001
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    TextButton.Font = Enum.Font.SourceSansLight
    TextButton.Text = "Toggle Ui"
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextScaled = true
    TextButton.TextSize = 6
    TextButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextStrokeTransparency = 0.000
    TextButton.TextWrapped = true
    TextButton.MouseButton1Down:Connect(
        function()
            Library:Toggle()
        end
    )

    UITextSizeConstraint.Parent = TextButton
    UITextSizeConstraint.MaxTextSize = 30

    local player = game.Players.LocalPlayer

   
    local function onCharacterAdded(character)
        ScreenGui.Parent = player.PlayerGui
    end

    local function connectCharacterAdded()
        player.CharacterAdded:Connect(onCharacterAdded)
    end

   
    connectCharacterAdded()

   
    player.CharacterRemoving:Connect(
        function()
            ScreenGui.Parent = nil
        end
    )

-- Load the library from the script (if not already loaded)
local Library = loadstring(game:HttpGet('https://pastebin.com/raw/7Tk5QM6R'))()

-- Set up the watermark connection
local FrameTimer = tick()
local FrameCounter = 0
local FPS = 240

-- Create the watermark that shows FPS and Ping
local WatermarkConnection = game:GetService("RunService").RenderStepped:Connect(function()
    FrameCounter += 1

    -- Update FPS every second
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end

    -- Set the watermark text with the same format
    Library:SetWatermark(('Venus.tech | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

for _, con in next, getconnections(workspace.CurrentCamera.Changed) do
  task.wait()
    con:Disable()
end
for _, con in next, getconnections(workspace.CurrentCamera:GetPropertyChangedSignal("CFrame")) do
   task.wait()
    con:Disable()
end

local repo = 'https://raw.githubusercontent.com/LionTheGreatRealFrFr/MobileLinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()



local Window = Library:CreateWindow({
    Title = "Venus.tech",
    Center = true,
    AutoShow = true,
    Size = UDim2.new(0, 550, 0, 400)
})

   

local Tabs = {
        Main = Window:AddTab("Legit"),
        Rage = Window:AddTab("HvH"),
        ["UI Settings"] = Window:AddTab("UI Settings")
    }

local Cam = Tabs.Main:AddLeftGroupbox("Main")

local Res = Tabs.Main:AddLeftGroupbox("CamLock")

local Tool = Tabs.Main:AddLeftGroupbox("")

local Tar = Tabs.Main:AddRightGroupbox("Settings")

local Tri = Tabs.Main:AddRightGroupbox("Trigger Bot")

local cframe = Tabs.Rage: AddLeftGroupbox("Cframe")

local esp = Tabs.Rage: AddRightGroupbox("ESP")

local visuals = Tabs.Rage: AddLeftGroupbox("Visuals")

local fov = Tabs.Rage: AddRightGroupbox("Fov")

Cam:AddToggle(
        "Enable Camlock",
        {
            Text = "Enable CamLock",
            Default = true,
            Tooltip = "Enable",
            Callback = function(state)
             venus.Enabled = state
            end 
        }
    )

Res:AddToggle(
        "Enable AutoPrediction",
        {
            Text = "Enable AutoPrediction",
            Default = false,
            Tooltip = "Enable",
            Callback = function(state)
               venus.AutoPred = state
            end
        }
    ) 

    

Res:AddInput(
        "Smoothness",
        {
            Default = "Smoothness",
            Numeric = false,
            Finished = false,
            Text = "smoothness",
            Tooltip = "Change smoothing For Target",
            Placeholder = "0.9",
            Callback = function(value)
                venus.Smoothness = value
            end
        }
    )

Tar:AddDropdown(
    "Hitpart",
    {
        Values = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "RightFoot", "RightUpperLeg"},
        Default = 1,
        Multi = false,
        Text = "Hitpart",
        Tooltip = "Choose the hit part",
        Callback = function(value)
            venus.AimPart = value  -- Update the AimPart for targeting
            camlock.AimPart = value -- Ensure camlock uses the same AimPart
        end
    }
)

Cam:AddToggle(
        "Enable TargetAim",
        {
            Text = "Enable TargetAim",
            Default = true,
            Tooltip = "Enable",
            Callback = function(state)
               targetaim.enabled = state
            end
        }
    )

Cam:AddToggle(
    "Enable Look At",
    {
        Text = "Enable Look At",
        Default = false,
        Tooltip = "Enable to make your character look at the target",
        Callback = function(state)
            venus.LookAtEnabled = state
        end
    }
)

Tar:AddInput(
    "HorizontalPrediction",
    {
        Default = "Horizontal Prediction",
        Numeric = true,
        Finished = false,
        Text = "Horizontal Prediction",
        Tooltip = "Change Horizontal Prediction For Target and Camlock",
        Placeholder = "1",
        Callback = function(value)
            venus.HorizontalPrediction = tonumber(value) or 1
        end
    }
)

Tar:AddInput(
    "VerticalPrediction",
    {
        Default = "Vertical Prediction",
        Numeric = true,
        Finished = false,
        Text = "Vertical Prediction",
        Tooltip = "Change Vertical Prediction For Target and Camlock",
        Placeholder = "1",
        Callback = function(value)
            venus.VerticalPrediction = tonumber(value) or 1
        end
    }
)

Tar:AddInput(
    "JumpOffset",
    {
        Default = "Jump Offset",
        Numeric = false,
        Finished = false,
        Text = "Jump Offset",
        Tooltip = "Change Jump Offset For Target",
        Placeholder = "1",
        Callback = function(value)
            venus.JumpOffset = tonumber(value) or 1
        end
    }
)

Tar:AddToggle(
        "Enable AutoPrediction",
        {
            Text = "Enable AutoPrediction",
            Default = false,
            Tooltip = "Enable",
            Callback = function(state)
               targetaim.AutoPred = state
            end
        }
    ) 





Tri:AddToggle(
        "Enable TriggerBot",
        {
            Text = "Enable Trigger Bot",
            Default = false,
            Tooltip = "Enable",
            Callback = function(state)
               venus.Triggerbot.Settings["Automatically Fire"] = state
            end
        }
    )

Tri:AddInput(
        "Click delay",
        {
            Default = "Delay",
            Numeric = false,
            Finished = false,
            Text = "Click delay",
            Tooltip = "Change delay For Clicks",
            Placeholder = "0.1",
            Callback = function(value)
                venus.Triggerbot.Settings["Click Delay"] = value
            end
        }
    )

cframe:AddToggle(
        "Enable cframe",
        {
            Text = "Enable cframe",
            Default = false,
            Tooltip = "Enable",
            Callback = function(state)
               venus.cframe.enabled = state
            end
        }
    )

cframe:AddSlider(
    "cframe speed",
    {
        Text = "How fast you run around ",
        Default = 0,
        Min = 0,
        Max = 50,
        Rounding = 1,
        Compact = false,
        Callback = function(Value)
            venus.cframe.Speed = Value
        end
    }
)

local resolverEnabled = false  -- State variable to track if the resolver is enabled

-- Toggle button for the resolver
Cam:AddToggle(
    "Enable Resolver",
    {
        Text = "Enable Resolver",
        Default = false,
        Tooltip = "Toggle to enable or disable the resolver",
        Callback = function(state)
            resolverEnabled = state
            
            if resolverEnabled then
                -- Start the resolver loop in a coroutine
                coroutine.wrap(function()
                    while resolverEnabled do
                        heartbeat:Wait()
                        if target == true then
                            local character = game.Players[targetplr].Character.HumanoidRootPart
                            local lastPosition = character.Position
                            task.wait()
                            local currentPosition = character.Position
                            local velocity = (currentPosition - lastPosition) * 0  -- This always sets velocity to 0
                            character.AssemblyLinearVelocity = velocity
                            character.Velocity = velocity
                        end
                    end
                end)()  -- Start the coroutine immediately
            end
        end
    }
)

local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

local healthBarEnabled = false -- Use true or false to toggle health bars

-- Toggle Button for Venus (which also controls health bars)
esp:AddToggle(
    "Boxes & Health Bars",
    {
        Text = "Boxes & Health Bars",
        Default = false,
        Tooltip = "Enable or Disable Boxes and Health Bars",
        Callback = function(state)
            healthBarEnabled = state
        end
    }
)

local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0, 3, 0)

local function createJamkleBox(v)
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false -- Keep this invisible
    BoxOutline.Color = Color3.new(0, 0, 0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false -- This will be set to true when the player is visible
    Box.Color = Color3.new(1, 1, 1) -- White box
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local HealthBarOutline = Drawing.new("Line")
    HealthBarOutline.Thickness = 1.5 -- Stroke thickness
    HealthBarOutline.Color = Color3.new(0, 0, 0) -- Black stroke color
    HealthBarOutline.Visible = false

    local HealthBar = Drawing.new("Line")
    HealthBar.Thickness = 1.5 -- Line thickness for health bar
    HealthBar.Visible = false

    local function boxesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                local RootPart = v.Character.HumanoidRootPart
                local Head = v.Character.Head
                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

                if onScreen and healthBarEnabled then
                    -- Remove the BoxOutline drawing
                    -- BoxOutline.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    -- BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                    -- BoxOutline.Visible = true -- Keep BoxOutline invisible

                    Box.Size = Vector2.new(1000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                    Box.Visible = true -- Only the white box is visible

                    -- Health bar
                    HealthBarOutline.From = Vector2.new(Box.Position.X - 6, Box.Position.Y)
                    HealthBarOutline.To = Vector2.new(Box.Position.X - 6, Box.Position.Y + (HeadPosition.Y - LegPosition.Y))
                    HealthBarOutline.Visible = true

                    local healthRatio = v.Character.Humanoid.Health / v.Character.Humanoid.MaxHealth
                    HealthBar.From = Vector2.new(Box.Position.X - 6, Box.Position.Y)
                    HealthBar.To = Vector2.new(Box.Position.X - 6, Box.Position.Y + (HeadPosition.Y - LegPosition.Y) * healthRatio)
                    HealthBar.Color = Color3.fromRGB(255 * (1 - healthRatio), 255 * healthRatio, 0) -- Health color
                    HealthBar.Visible = true
                else
                    Box.Visible = false -- Hide the white box if conditions aren't met
                    HealthBarOutline.Visible = false
                    HealthBar.Visible = false
                end
            else
                Box.Visible = false -- Hide the white box if the character isn't valid
                HealthBarOutline.Visible = false
                HealthBar.Visible = false
            end
        end)
    end
    coroutine.wrap(boxesp)()
end

for _, v in pairs(game.Players:GetChildren()) do
    createJamkleBox(v)
end

game.Players.PlayerAdded:Connect(function(v)
    createJamkleBox(v)
end)

local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

_G.TeamCheck = false -- Default team check is off
local tracersEnabled = false -- Default tracers are off

-- Add Toggle for Tracers
esp:AddToggle(
    "Tracers",
    {
        Text = "Tracers",
        Default = false,
        Tooltip = "Enable or disable Tracers",
        Callback = function(state)
            tracersEnabled = state
        end
    }
)

for i,v in pairs(game.Players:GetChildren()) do
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1, 1, 1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1

    function lineesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if tracersEnabled and v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                if OnScreen then
                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)

                    if _G.TeamCheck and v.TeamColor == lplr.TeamColor then
                        -- Teammates
                        Tracer.Visible = false
                    else
                        -- Enemies
                        Tracer.Visible = true
                    end
                else
                    Tracer.Visible = false
                end
            else
                Tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineesp)()
end

game.Players.PlayerAdded:Connect(function(v)
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1, 1, 1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1

    function lineesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if tracersEnabled and v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)

                if OnScreen then
                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)

                    if _G.TeamCheck and v.TeamColor == lplr.TeamColor then
                        -- Teammates
                        Tracer.Visible = false
                    else
                        -- Enemies
                        Tracer.Visible = true
                    end
                else
                    Tracer.Visible = false
                end
            else
                Tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineesp)()
end)

-- Separate functionality loop
game:GetService("RunService").Heartbeat:Connect(function()
    if getgenv().FeatureEnabled then
        -- Place your functionality code here
        -- This code will only execute if FeatureEnabled is true
    end
end)

-- Dropdown list for Crosshair Toggle
local CrosshairEnabled = false

visuals:AddToggle(
    "Crosshair",
    {
        Text = "Crosshair",
        Default = false,
        Tooltip = "Enable or disable Crosshair",
        Callback = function(state)
            CrosshairEnabled = state
        end
    }
)

-- Crosshair settings
getgenv().crosshair = {
    enabled = true,
    refreshrate = 0.015,
    mode = 'center',
    position = Vector2.new(0, 0),
    width = 2.5,
    length = 10,
    radius = 11,
    color = Color3.fromRGB(66, 84, 245),  -- Color for the crosshair lines
    spin = true,
    spin_speed = 150,
    spin_max = 340,
    spin_style = Enum.EasingStyle.Circular,
    resize = true,
    resize_speed = 150,
    resize_min = 5,
    resize_max = 22,
}

local old; old = hookfunction(Drawing.new, function(class, properties)
    local drawing = old(class)
    for i, v in next, properties or {} do
        drawing[i] = v
    end
    return drawing
end)

local runservice = game:GetService('RunService')
local inputservice = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')
local camera = workspace.CurrentCamera

local last_render = 0

local drawings = {
    crosshair = {},
    text = {
        Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = 'Venus', Color = Color3.new(1, 1, 1)}),
        Drawing.new('Text', {Size = 13, Font = 2, Outline = true, Text = '.Tech', Color = Color3.fromRGB(66, 84, 245)}),
    }
}

for idx = 1, 4 do
    drawings.crosshair[idx] = Drawing.new('Line')
    drawings.crosshair[idx + 4] = Drawing.new('Line')
end

function solve(angle, radius)
    return Vector2.new(
        math.sin(math.rad(angle)) * radius,
        math.cos(math.rad(angle)) * radius
    )
end

runservice.PostSimulation:Connect(function()
    local _tick = tick()

    if _tick - last_render > crosshair.refreshrate then
        last_render = _tick

        local position = camera.ViewportSize / 2

        local text_1 = drawings.text[1]
        local text_2 = drawings.text[2]

        text_1.Visible = CrosshairEnabled
        text_2.Visible = CrosshairEnabled

        if CrosshairEnabled then
            local text_x = text_1.TextBounds.X + text_2.TextBounds.X

            text_1.Position = position + Vector2.new(-text_x / 2, crosshair.radius + (crosshair.resize and crosshair.resize_max or crosshair.length) + 5)
            text_2.Position = text_1.Position + Vector2.new(text_1.TextBounds.X, 0)
            text_2.Color = Color3.fromRGB(66, 84, 245)

            for idx = 1, 4 do
                local outline = drawings.crosshair[idx]
                local inline = drawings.crosshair[idx + 4]

                local angle = (idx - 1) * 90
                local length = crosshair.length

                if crosshair.spin then
                    local spin_angle = -_tick * crosshair.spin_speed % crosshair.spin_max
                    angle = angle + tweenservice:GetValue(spin_angle / 360, crosshair.spin_style, Enum.EasingDirection.InOut) * 360
                end

                if crosshair.resize then
                    local resize_length = tick() * crosshair.resize_speed % 180
                    length = crosshair.resize_min + math.sin(math.rad(resize_length)) * crosshair.resize_max
                end

                inline.Visible = true
                inline.Color = Color3.fromRGB(66, 84, 245)  -- Set color for all inline lines
                inline.From = position + solve(angle, crosshair.radius)
                inline.To = position + solve(angle, crosshair.radius + length)
                inline.Thickness = crosshair.width

                outline.Visible = true
                outline.From = position + solve(angle, crosshair.radius - 1)
                outline.To = position + solve(angle, crosshair.radius + length + 1)
                outline.Thickness = crosshair.width + 1.5    
            end
        else
            for idx = 1, 4 do
                drawings.crosshair[idx].Visible = false
                drawings.crosshair[idx + 4].Visible = false
            end
        end
    end
end)

local circle  -- Declare the circle variable outside the function

-- Function to create or get the circle
local function getCircle()
    if not circle then
        circle = Drawing.new("Circle")
        circle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)  -- Centered on the screen
        circle.Radius = 120  -- Default radius
        circle.Color = Color3.fromRGB(255, 255, 255)  -- Default color (white)
        circle.Thickness = 1
        circle.Filled = false  -- Default filled state
    end
    return circle
end

-- State variable to track circle visibility
local circleEnabled = false

-- State variable to track circle fill
local circleFilled = false

-- Toggle button for circle visibility
fov:AddToggle(
    "Enable Circle",
    {
        Text = "Enable Circle",
        Default = false,
        Tooltip = "Toggle to enable or disable the circle",
        Callback = function(state)
            circleEnabled = state
            local circleInstance = getCircle()
            circleInstance.Visible = circleEnabled
        end
    }
)

-- Toggle button for filling the circle
fov:AddToggle(
    "Filled",
    {
        Text = "Filled",
        Default = false,
        Tooltip = "Toggle to fill the circle",
        Callback = function(state)
            circleFilled = state
            local circleInstance = getCircle()  -- Get the circle instance
            circleInstance.Filled = circleFilled  -- Update filled state
        end
    }
)

-- Slider for circle size adjustment
fov:AddSlider(
    "Circle Size",
    {
        Min = 20,  -- Minimum size
        Max = 300,  -- Maximum size
        Default = 120,  -- Default size (initial radius)
        Rounding = 0,  -- Add rounding value
        Text = "Circle Size",
        Tooltip = "Adjust the size of the circle",
        Callback = function(size)
            local circleInstance = getCircle()  -- Get the circle instance
            if circleInstance then  -- Ensure circleInstance is valid
                circleInstance.Radius = size  -- Set the new radius
            end
        end
    }
)

-- Dropdown for circle color selection, with additional color options
fov:AddDropdown(
    "Circle Color",
    {
        Values = {"Red", "Green", "Blue", "Yellow", "Orange", "Purple", "White", "Cyan", "Magenta"},  -- Added more colors
        Default = 7,  -- Set the default selection to "White" (7 = "White")
        Multi = false,
        Text = "Circle Color",
        Tooltip = "Select a color for the circle",
        Callback = function(value)
            local circleInstance = getCircle()  -- Get the circle instance
            if circleInstance then  -- Ensure circleInstance is valid
                -- Map selected value to Color3
                if value == "Red" then
                    circleInstance.Color = Color3.fromRGB(255, 0, 0)
                elseif value == "Green" then
                    circleInstance.Color = Color3.fromRGB(0, 255, 0)
                elseif value == "Blue" then
                    circleInstance.Color = Color3.fromRGB(0, 0, 255)
                elseif value == "Yellow" then
                    circleInstance.Color = Color3.fromRGB(255, 255, 0)
                elseif value == "Orange" then
                    circleInstance.Color = Color3.fromRGB(255, 165, 0)
                elseif value == "Purple" then
                    circleInstance.Color = Color3.fromRGB(128, 0, 128)
                elseif value == "White" then
                    circleInstance.Color = Color3.fromRGB(255, 255, 255)  -- White
                elseif value == "Cyan" then
                    circleInstance.Color = Color3.fromRGB(0, 255, 255)  -- Cyan
                elseif value == "Magenta" then
                    circleInstance.Color = Color3.fromRGB(255, 0, 255)  -- Magenta
                end
            end
        end
    }
)

-- Initial drawing of the circle based on the default state
local circleInstance = getCircle()
circleInstance.Visible = circleEnabled

local effectEnabled = false -- Variable to control the toggle state

-- Toggle Button for Effect
visuals:AddToggle(
    "VisualsToggle",
    {
        Text = "ForceField",
        Default = false,
        Tooltip = "Enable or disable the effect on MeshParts",
        Callback = function(state)
            effectEnabled = state
        end
    }
)

-- Apply effect if enabled
spawn(function()
    while wait() do
        for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if part:IsA("MeshPart") then
                if effectEnabled then
                    part.Material = "ForceField"
                    part.Color = Color3.new(0, 0, 1)
                else
                    -- Revert to original properties
                    part.Material = Enum.Material.SmoothPlastic -- Change this to the original material you want
                    part.Color = Color3.new(1, 1, 1) -- Change this to the original color you want
                end
            end
        end
    end
end)








Tool:AddButton(
    "Create Tool",
    function()
       spawnTool()
    end
)

Tool:AddButton(
    "Create Button",
    function()
       spawnButton()
    end
)

Tool:AddButton(
    "Controller Dpad Up",
    function()
       setupController()
    end
)


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('rexlua')
SaveManager:SetFolder('rex/configs')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()









local player = game.Players.LocalPlayer

local userInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local GS = game:GetService("GuiService")


local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = WS.CurrentCamera
local GetGuiInset = GS.GetGuiInset

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera


getgenv().venus = {
    ["Enabled"] = true,
    ["AimPart"] = "Head",
    ["Prediction"] = 0.12588,
    ["Smoothness"] = 1,
    ["ShakeValue"] = 0,
    ["AutoPred"] = true,
    ["Loaded"] = false,
    ["TTKO"] = false,
    ["Mode"] = "Controller",
    ["cframe"] = {
        ["enabled"] = false,
        ["speed"] = 2,
        ["TargetStrafe"] = {
            ["Enabled"] = false,
            ["StrafeSpeed"] = 10,
            ["StrafeRadius"] = 7,
            ["StrafeHeight"] = 3,
            ["RandomizerMode"] = true
        }
    }
}

getgenv().Fov = {
    ["FOVSize"] = 90,
    ["FOVColor"] = Color3.fromRGB(255, 0, 0),
    ["FOVVisible"] = true,
    ["FOVShape"] = "Circle"
}

getgenv().targetaim= {
    ["enabled"] = true,
    ["targetPart"] = "UpperTorso",
    ["prediction"] = 0.12588
}

getgenv().desync = {
    ["sky"] = false,
    ["invis"] = true,
    ["jump"] = false,
    ["network"] = false
}

getgenv().Misc = {
    ["LowGfx"] = false,
}

getgenv().FPSunlocker = {
    ["Enabled"] = true,
    ["FPSCap"] = 999
}

getgenv().Triggerbot = {
    ["ClosestPart"] = {
        ["HitParts"] = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "RightFoot", "LeftFoot"}
    },
    ["FOV"] = {
        ["Enabled"] = true,
        ["Size"] = 13,
        ["Centered FOV"] = true,
        ["Visible"] = false,
        ["Filled"] = false,
        ["Color"] = Color3.fromRGB(255, 0, 0)
    },
    ["Settings"] = {
        ["Prediction"] = 0.111,
        ["Click Delay"] = 0.1,
        ["Activation Delay"] = 2,
        ["IgnoreFriends"] = false,
        ["Automatically Fire"] = false,
    }
}

local function createFOVCircle()
    local circle = Drawing.new("Circle")
    circle.Radius = Triggerbot.FOV.Size
    circle.Thickness = 1
    circle.Filled = Triggerbot.FOV.Filled
    circle.Color = Triggerbot.FOV.Color
    circle.Visible = Triggerbot.FOV.Visible
    return circle
end

local FOVCircle = createFOVCircle()

local function updateFOVCircle()
    if Triggerbot.FOV.Enabled and FOVCircle then
        if Triggerbot.FOV["Centered FOV"] then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            local mousePos = UserInputService:GetMouseLocation()
            FOVCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        end
    end
end

local function isTargetValid(player)
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        if humanoid.Health > 0 then
            return true
        end
    end
    return false
end

local function getMouseTarget()
    local mousePos =
        Triggerbot.FOV["Centered FOV"] and Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) or
        UserInputService:GetMouseLocation()
    local closestPlayer = nil
    local closestDistance = Triggerbot.FOV.Size

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and isTargetValid(player) then
            for _, hitPartName in ipairs(Triggerbot.ClosestPart.HitParts) do
                local hitPart = player.Character and player.Character:FindFirstChild(hitPartName)
                if hitPart then
                    local partPos = Camera:WorldToViewportPoint(hitPart.Position)
                    local distance = (Vector2.new(partPos.X, partPos.Y) - mousePos).Magnitude

                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function fireAtTarget(target)
    if target and Triggerbot.Settings["Automatically Fire"] then
        for _, hitPartName in ipairs(Triggerbot.ClosestPart.HitParts) do
            local hitPart = target.Character and target.Character:FindFirstChild(hitPartName)
            if hitPart then
                local Tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if Tool and Tool:FindFirstChild("Handle") then
                    Tool:Activate()
                    wait(Triggerbot.Settings["Click Delay"])
                    Tool:Deactivate()
                end
            end
        end
    end
end

local activationDelay = Triggerbot.Settings["Activation Delay"]

RunService.RenderStepped:Connect(
    function()
        updateFOVCircle()

        if activationDelay > 0 then
            activationDelay = activationDelay - RunService.RenderStepped:Wait()
            return
        end

        if Triggerbot.FOV["Centered FOV"] then
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        else
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end

        local target = getMouseTarget()
        if target then
            fireAtTarget(target)
        end
    end
)



local userInputService = game:GetService("UserInputService")

local AimlockState = true
local Locked = false
local Victim
local target

if venus.Loaded then
    notify("Venus.lol is Already Loaded!")
    return
end

venus.Loaded = true

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestScore = math.huge
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local maxAngle = 30 -- Maximum angle limit in degrees (adjust this for wider or narrower locking range)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild(venus.AimPart) and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            local part = plr.Character[venus.AimPart]
            local relativePos = part.Position - Camera.CFrame.Position
            local playerDistance = relativePos.Magnitude
            local screenPosition, onScreen = Camera:WorldToViewportPoint(part.Position)

            if onScreen then
                local angle = math.deg(math.acos(Camera.CFrame.LookVector:Dot(relativePos.Unit)))
                
                -- Only consider players within a specific angle range (in front of you)
                if angle <= maxAngle then
                    local mouseDistance = (Vector2.new(screenPosition.X, screenPosition.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

                    -- Adjust score to prioritize players more in front and reduce side locks
                    local score = mouseDistance * 0.02 + angle * 0.03 -- Increase angle weight to penalize wider angles
                    
                    if angle < 5 then
                        score = score * 0.001 -- Further reduce score for players directly in front
                    end

                    local ray = Ray.new(Camera.CFrame.Position, relativePos.Unit * playerDistance)
                    local hitPart = WS:FindPartOnRayWithIgnoreList(ray, {player.Character})

                    if (not hitPart or hitPart:IsDescendantOf(plr.Character)) and score < shortestScore then
                        closestPlayer = plr
                        shortestScore = score
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function ToggleLock()
    if AimlockState then
        Locked = not Locked
        if Locked then
            Victim = GetClosestPlayer()
            target = Victim
            if Victim then
                if venus.Enabled then
                    jam_notify("Camlock: Locked onto " .. tostring(Victim.Name), 5)
                end
                if targetaim.enabled then
                    jam_notify("Target Lock: Locked onto " .. tostring(target.Name), 5)
                end
            else
                if venus.Enabled then
                    jam_notify("Camlock: No target found", 5)
                end
                if targetaim.enabled then
                    jam_notify("Target Lock: No target found", 5)
                end
            end
        else
            Victim = nil
            target = nil
            if venus.Enabled then
                jam_notify("Camlock: Unlocked!", 5)
            end
            if targetaim.enabled then
                jam_notify("Target Lock: Unlocked!", 5)
            end
        end
    else
        if not venus.Enabled then
            jam_notify("Camlock not enabled", 5)
        end
    end
end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local userInputService = game:GetService("UserInputService")

-- Function for the "Tool" mode
function spawnTool()
    local Tool = Instance.new("Tool")
    Tool.RequiresHandle = false
    Tool.Name = "VenusTool"
    Tool.Parent = player.Backpack

    local function onCharacterAdded()
        Tool.Parent = player.Backpack
    end

    player.CharacterAdded:Connect(onCharacterAdded)

    player.CharacterRemoving:Connect(function()
        Tool.Parent = player.Backpack
    end)

    Tool.Activated:Connect(function()
        ToggleLock()
    end)
end

-- Function for the "Button" mode
function spawnButton()
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui") -- Ensure playerGui is defined
    local function setupGui()
        local screenGui = playerGui:FindFirstChild("LockScreenGui")

        if not screenGui then
            screenGui = Instance.new("ScreenGui")
            screenGui.Name = "LockScreenGui"
            screenGui.Parent = playerGui
        end

        local button = screenGui:FindFirstChild("LockButton")

        if not button then
            button = Instance.new("ImageButton") -- Changed to ImageButton
            button.Name = "LockButton"
            button.Size = UDim2.new(0, 70, 0, 70)
            button.Position = UDim2.new(0.5, -250, 0.8, -225) -- Center the button better for the size
            button.Image = "rbxassetid://78342062013795" -- Set the image
            button.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Change this to your desired color
            button.BackgroundTransparency = 0.350 -- Set transparency to 0 to show the color
            button.Parent = screenGui
            button.Active = true
            button.Draggable = true

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = button

            button.MouseButton1Click:Connect(function()
                ToggleLock() -- Ensure ToggleLock function is defined elsewhere
            end)
        end
    end

    setupGui()

    -- Re-setup the GUI when the character respawns
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        setupGui()
    end)
end

-- Function for the "Controller" mode
function setupController()
    userInputService.InputBegan:Connect(function(input, processed)
        if not processed then
            if input.KeyCode == Enum.KeyCode.DPadUp then
                ToggleLock()
            end
        end
    end)
end


RS.RenderStepped:Connect(function()
    if AimlockState and Victim and Victim.Character and Victim.Character:FindFirstChild(venus.AimPart) then
        local aimPart = Victim.Character[venus.AimPart]
        
        -- Use shared horizontal, vertical prediction, and JumpOffset
        local predictedPosition = aimPart.Position 
            + Vector3.new(aimPart.Velocity.X * venus.HorizontalPrediction, aimPart.Velocity.Y * venus.VerticalPrediction, aimPart.Velocity.Z * venus.HorizontalPrediction)
            + Vector3.new(0, venus.JumpOffset, 0)

        -- Look at the target smoothly only if LookAt is enabled and target aim is active
        if venus.LookAtEnabled and targetaim.enabled then
            local lookPosition = CFrame.new(Camera.CFrame.p, predictedPosition)
            Camera.CFrame = Camera.CFrame:Lerp(lookPosition, venus.Smoothness)

            local playerHRP = player.Character.HumanoidRootPart

            -- Maintain original Y orientation while looking at the target
            playerHRP.CFrame = CFrame.new(playerHRP.Position, Vector3.new(predictedPosition.X, playerHRP.Position.Y, predictedPosition.Z))

            -- Optionally add a distance threshold if desired
            local lookAtDistanceThreshold = 15  -- Set this to the distance threshold you prefer
            if (playerHRP.Position - predictedPosition).Magnitude < lookAtDistanceThreshold then
                -- If close, maintain a normal jump orientation without changing Y
                playerHRP.CFrame = CFrame.new(playerHRP.Position, playerHRP.Position + playerHRP.CFrame.LookVector)
            end
        end

        -- Camlock functionality
        if AimlockState then
            local playerHRP = player.Character.HumanoidRootPart
            local camlockPosition = CFrame.new(Camera.CFrame.p, predictedPosition)  -- Set the camlock CFrame to look at the target
            Camera.CFrame = Camera.CFrame:Lerp(camlockPosition, venus.Smoothness)

            -- Target strafe functionality
            if venus.cframe.TargetStrafe.Enabled then
                local lp = player.Character
                local targpos = Victim.Character.HumanoidRootPart.Position
                local strafeOffset
                
                if venus.cframe.TargetStrafe.RandomizerMode then
                    strafeOffset = Vector3.new(
                        math.random(-venus.cframe.TargetStrafe.StrafeRadius, venus.cframe.TargetStrafe.StrafeRadius),
                        math.random(0, venus.cframe.TargetStrafe.StrafeHeight),
                        math.random(-venus.cframe.TargetStrafe.StrafeRadius, venus.cframe.TargetStrafe.StrafeRadius)
                    )
                else
                    strafeOffset = Vector3.new(
                        math.cos(tick() * venus.cframe.TargetStrafe.StrafeSpeed) * venus.cframe.TargetStrafe.StrafeRadius,
                        venus.cframe.TargetStrafe.StrafeHeight,
                        math.sin(tick() * venus.cframe.TargetStrafe.StrafeSpeed) * venus.cframe.TargetStrafe.StrafeRadius
                    )
                end

                local strafePosition = targpos + strafeOffset
                strafePosition = Vector3.new(strafePosition.X, math.max(strafePosition.Y, targpos.Y), strafePosition.Z)
                
                lp:SetPrimaryPartCFrame(CFrame.new(strafePosition))
                playerHRP.CFrame = CFrame.new(
                    playerHRP.CFrame.Position,
                    Vector3.new(targpos.X, playerHRP.CFrame.Position.Y, targpos.Z)
                )
            end
        end
    end
end)

spawn(function()
    RS.Heartbeat:Connect(function()
        if venus.Enabled and venus.cframe.enabled then
            player.Character.HumanoidRootPart.CFrame =
                player.Character.HumanoidRootPart.CFrame + player.Character.Humanoid.MoveDirection * venus.cframe.speed
        end
    end)
end)

for _, con in pairs(getconnections(Camera.Changed)) do
    con:Disable()
end
for _, con in pairs(getconnections(Camera:GetPropertyChangedSignal("CFrame"))) do
    con:Disable()
end

local mt = getrawmetatable(game)
local oldNameCall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(Self, ...)
    local args = {...}
    local methodName = getnamecallmethod()
    if not checkcaller() and methodName == "FireServer" and targetaim.enabled then
        for i, Argument in ipairs(args) do
            if typeof(Argument) == "Vector3" and target and target.Character then
                local targetPart = target.Character[targetaim.targetPart]
                if targetPart then
                    args[i] = targetPart.Position 
                        + Vector3.new(targetPart.Velocity.X * venus.HorizontalPrediction, targetPart.Velocity.Y * venus.VerticalPrediction, targetPart.Velocity.Z * venus.HorizontalPrediction) 
                        + Vector3.new(0, venus.JumpOffset, 0)
                    return oldNameCall(Self, unpack(args))
                end
            end
        end
    end
    return oldNameCall(Self, ...)
end)

setreadonly(mt, true)

while task.wait() do
    if venus.TTKO and Victim and Victim.Character and Victim.Character:FindFirstChild("Humanoid") then
        if Victim.Character.Humanoid.Health <= 2 then
            local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
            if chatEvents and chatEvents:FindFirstChild("SayMessageRequest") then
                local sayMessageRequest = chatEvents.SayMessageRequest
                if sayMessageRequest and sayMessageRequest:IsA("RemoteEvent") then
                    sayMessageRequest:FireServer("get tapped by Venus😂", "All")
                    wait(0.6)
                    sayMessageRequest:FireServer("ur so bad", "All")
                elseif sayMessageRequest and sayMessageRequest:IsA("RemoteFunction") then
                    sayMessageRequest:InvokeServer("up you’re sets", "All")
                    wait(0.6)
                    sayMessageRequest:InvokeServer("ur a trash and a larp", "All")
                end
            end
        end
    end
end

while task.wait() do
    if venus.Enabled and venus.AutoPred then
        local pingValue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local ping = tonumber((pingValue:match("%d+")))

        if ping then
            if ping > 225 then
                venus.Prediction = 0.166547
            elseif ping > 215 then
                venus.Prediction = 0.15692
            elseif ping > 205 then
                venus.Prediction = 0.165732
            elseif ping > 190 then
                venus.Prediction = 0.1690
            elseif ping > 185 then
                venus.Prediction = 0.1235666
            elseif ping > 180 then
                venus.Prediction = 0.16779123
            elseif ping > 175 then
                venus.Prediction = 0.165455312399999
            elseif ping > 170 then
                venus.Prediction = 0.16
            elseif ping > 165 then
                venus.Prediction = 0.15
            elseif ping > 160 then
                venus.Prediction = 0.1223333
            elseif ping > 155 then
                venus.Prediction = 0.125333
            elseif ping > 150 then
                venus.Prediction = 0.1652131
            elseif ping > 145 then
                venus.Prediction = 0.129934
            elseif ping > 140 then
                venus.Prediction = 0.1659921
            elseif ping > 135 then
                venus.Prediction = 0.1659921
            elseif ping > 130 then
                venus.Prediction = 0.12399
            elseif ping > 125 then
                venus.Prediction = 0.15465
            elseif ping > 110 then
                venus.Prediction = 0.142199
            elseif ping > 105 then
                venus.Prediction = 0.141199
            elseif ping > 100 then
                venus.Prediction = 0.134143
            elseif ping > 90 then
                venus.Prediction = 0.1433333333392
            elseif ping > 80 then
                venus.Prediction = 0.143214443
            elseif ping > 70 then
                venus.Prediction = 0.14899911
            elseif ping > 60 then
                venus.Prediction = 0.148325
            elseif ping > 50 then
                venus.Prediction = 0.128643
            elseif ping > 40 then
                venus.Prediction = 0.12766
            elseif ping > 30 then
                venus.Prediction = 0.124123
            elseif ping > 20 then
                venus.Prediction = 0.12435
            elseif ping > 10 then
                venus.Prediction = 0.1234555
            elseif ping < 10 then
                venus.Prediction = 0.1332
            else
                venus.Prediction = 0.1342
            end
        end
    end
end

  
        




if desync.sky == true then
    getgenv().VenusSky = true 
    getgenv().SkyAmount = 90

    game:GetService("RunService").Heartbeat:Connect(function()
        if getgenv().VenusSky then 
            local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, getgenv().SkyAmount, 0) 
            game:GetService("RunService").RenderStepped:Wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
        end
    end)
end

if desync.jump == true then
    getgenv().jumpanti = true
    
    game:GetService("RunService").Heartbeat:Connect(function()
        if getgenv().jumpanti then    
            local CurrentVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1000, 1000, 1000)
            game:GetService("RunService").RenderStepped:Wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = CurrentVelocity
        end
    end)
end

if desync.jump == true then

-- Maximum Roblox velocity (128^2 or 16384)
local velMax = (128 ^ 2)

local timeRelease, timeChoke = 0.015, 0.105

local Property, Wait = sethiddenproperty, task.wait
local Radian, Random, Ceil = math.rad, math.random, math.ceil
local Angle = CFrame.Angles
local Vector = Vector3.new
local Service = game.GetService

local Run = Service(game, 'RunService')
local Stats = Service(game, 'Stats')
local Players = Service(game, 'Players')
local LocalPlayer = Players.LocalPlayer
local statPing = Stats.PerformanceStats.Ping
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Mouse = LocalPlayer:GetMouse()

local runRen, runBeat = Run.RenderStepped, Run.Heartbeat
local runRenWait, runRenCon = runRen.Wait, runRen.Connect
local runBeatCon = runBeat.Connect

local function Ping()
    return statPing:GetValue()
end

local function Sleep()
    Property(Root, 'NetworkIsSleeping', true)
end

local function FireGun()
    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Shoot") then
        local ShootEvent = tool.Shoot
        ShootEvent:FireServer(Mouse.Hit.Position)
    end
end

local function Init()
    if not Root then return end

    local rootVel = Root.Velocity
    local rootCFrame = Root.CFrame

   
    local rootAng = Random(-180, 180)
    local rootOffset do
        local X = Random(-velMax, velMax)
        local Y = Random(0, velMax)
        local Z = Random(-velMax, velMax)
        rootOffset = Vector(X, -Y, Z)
    end

    Root.CFrame = Angle(0, Radian(rootAng), 0)
    Root.Velocity = rootOffset

   
    FireGun()


    runRenWait(runRen)
    Root.CFrame = rootCFrame
    Root.Velocity = rootVel
end

runBeatCon(runBeat, Init)

-- Main loop for choking replication
while Wait(timeRelease) do
    -- Stable replication packets
    local chokeClient, chokeServer = runBeatCon(runBeat, Sleep), runRenCon(runRen, Sleep)

    Wait(Ceil(Ping()) / 1000)

    chokeClient:Disconnect()
    chokeServer:Disconnect()

end
end

if desync.network == true then
local RunService = game:GetService("RunService")

local function onHeartbeat()
    setfflag("S2PhysicsSenderRate", 1)
end

RunService.Heartbeat:Connect(onHeartbeat)
end

if Misc.LowGfx == true then
game:GetService("CorePackages").Packages:Destroy()
end

if FPSunlocker.Enabled then
    setfpscap(FPSunlocker.FPSCap)
end