-- Load the library from the script (if not already loaded)
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Luarmorscripts/library/refs/heads/main/main'))()

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
    Library:SetWatermark(('Exile.CC | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

local repo = 'https://raw.githubusercontent.com/Luarmorscripts/library/main/'

local Library = loadstring(game:HttpGet(repo .. 'main'))()
-- local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
-- local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = "Exile.CC",
    Center = true,
    AutoShow = true,
    Size = UDim2.new(0, 550, 0, 400)
})



local Tabs = {
        Main = Window:AddTab("Main"),
        Rage = Window:AddTab("Visuals"),
        ["UI Settings"] = Window:AddTab("Configuration")
    }

local main = Tabs.Main:AddLeftGroupbox("Main")

local cam = Tabs.Main:AddLeftGroupbox("CamLock")

local air = Tabs.Main:AddLeftGroupbox("Air Settings")

local set = Tabs.Main:AddRightGroupbox("Settings")

local fov = Tabs.Main:AddRightGroupbox("Fov")

local cframe = Tabs.Rage: AddLeftGroupbox("Cframe")

local visuals = Tabs.Rage: AddLeftGroupbox("Visuals")

local esp = Tabs.Rage: AddRightGroupbox("ESP")

local fly = Tabs.Rage: AddRightGroupbox("Fly")

cam:AddToggle(
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

cam:AddInput(
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

set:AddDropdown(
    "Hitpart",
    {
       Values = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm"},
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

main:AddToggle(
        "Enable TargetAim",
        {
            Text = "Enable TargetAim",
            Default = false,
            Tooltip = "Enable",
            Callback = function(state)
               targetaim.enabled = state
            end
        }
    )

set:AddToggle(
    "Enable AutoPrediction",
    {
        Text = "Enable AutoPrediction",
        Default = false,
        Tooltip = "Enable or disable auto prediction for camlock and target aim.",
        Callback = function(state)
            venus.AutoPred = state  -- This variable should control your prediction state
        end
    }
)

set:AddInput(
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

set:AddInput(
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

air:AddInput(
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
    "Cframe speed",
    {
        Text = "Cframe Speed",
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

-- Set up initial variables for fly speed and control
local flySpeed = 100  -- Default speed
local flying = false  -- Set to false initially

-- Get the player and character
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")
local userInputService = game:GetService("UserInputService")

-- Function to start flying
local function startFlying()
    if not flying then
        flying = true
        humanoid.PlatformStand = true
        
        local bodyGyro = Instance.new("BodyGyro", character.PrimaryPart)
        local bodyVelocity = Instance.new("BodyVelocity", character.PrimaryPart)
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

        -- Update fly direction and speed based on camera orientation
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if flying then
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                
                local moveDirection = Vector3.new(0, 0, 0)
                if humanoid.MoveDirection.Magnitude > 0 then
                    moveDirection = workspace.CurrentCamera.CFrame.LookVector * humanoid.MoveDirection.Magnitude
                end
                
                local verticalVelocity = 0
                if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                    verticalVelocity = flySpeed -- Ascend
                elseif userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    verticalVelocity = -flySpeed -- Descend
                end
                
                bodyVelocity.Velocity = moveDirection * flySpeed + Vector3.new(0, verticalVelocity, 0)
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            else
                bodyVelocity.Velocity = Vector3.new(0, 0, 0) -- Stop movement when not flying
                connection:Disconnect() -- Disconnect the RenderStepped connection
            end
        end)
    end
end

-- Function to stop flying
local function stopFlying()
    if flying then
        flying = false
        humanoid.PlatformStand = false
        for _, v in pairs(character.PrimaryPart:GetChildren()) do
            if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
                v:Destroy()
            end
        end
    end
end

-- Toggle button setup
fly:AddToggle(
    "Enable Fly",
    {
        Text = "Enable Fly",
        Default = false,
        Tooltip = "Enable or disable flying",
        Callback = function(state)
            if state then
                startFlying()
            else
                stopFlying()
            end
        end
    }
)

-- Slider for adjusting fly speed
fly:AddSlider(
    "Fly Speed",
    {
        Text = "Adjust Fly Speed",
        Default = 50,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Compact = false,
        Callback = function(value)
            flySpeed = value  -- Update the fly speed with the slider value
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

local function createExileBox(v)
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
    createExileBox(v)
end

game.Players.PlayerAdded:Connect(function(v)
    createExileBox(v)
end)

local lplr = game.Players.LocalPlayer
local esp = {}  -- Placeholder for your ESP object

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
