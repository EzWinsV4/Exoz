if not game:IsLoaded() then
    game.Loaded:Wait()
end

pcall(function() if getgenv().ExozSpeedConnection then getgenv().ExozSpeedConnection:Disconnect() getgenv().ExozSpeedConnection = nil end end)
pcall(function() if getgenv().ExozJumpPowerConnection then getgenv().ExozJumpPowerConnection:Disconnect() getgenv().ExozJumpPowerConnection = nil end end)
pcall(function() if getgenv().ExozNoclipConnection then getgenv().ExozNoclipConnection:Disconnect() getgenv().ExozNoclipConnection = nil end end)
pcall(function() if getgenv().ExozGravityConnection then getgenv().ExozGravityConnection:Disconnect() getgenv().ExozGravityConnection = nil end end)
pcall(function() if getgenv().ExozInfJumpConnection then getgenv().ExozInfJumpConnection:Disconnect() getgenv().ExozInfJumpConnection = nil end end)
pcall(function() if getgenv().ExozFlyConnection then getgenv().ExozFlyConnection:Disconnect() getgenv().ExozFlyConnection = nil end end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local exoz = {
    LuckyBlockBattlegrounds = {
        Locations = {
            {name = "Base", position = CFrame.new(-1039.5282, -128.299408, 85.450943)},
            {name = "Middle", position = CFrame.new(-1041.23193, 190.831711, 90.9453735)},
            {name = "Pink Bridge", position = CFrame.new(-868.601929, 194.367462, 211.650894)},
            {name = "Purple Bridge", position = CFrame.new(-933.63385, 194.367462, 263.423431)},
            {name = "Red Bridge", position = CFrame.new(-1161.80469, 194.367447, 263.3815)},
            {name = "Blue Bridge", position = CFrame.new(-1215.68848, 194.367355, 198.300949)},
            {name = "Cyan Bridge", position = CFrame.new(-1215.79639, 194.367447, -30.0486374)},
            {name = "Green Bridge", position = CFrame.new(-1148.33435, 194.367462, -83.3314285)},
            {name = "Yellow Bridge", position = CFrame.new(-920.233826, 194.367462, -83.3137131)},
            {name = "Orange Bridge", position = CFrame.new(-868.59314, 194.367462, -16.6490135)},
        },
        Blocks = {
            {Name = "Lucky Block", Event = game:GetService("ReplicatedStorage").SpawnLuckyBlock},
            {Name = "Super Block", Event = game:GetService("ReplicatedStorage").SpawnSuperBlock},
            {Name = "Diamond Block", Event = game:GetService("ReplicatedStorage").SpawnDiamondBlock},
            {Name = "Rainbow Block", Event = game:GetService("ReplicatedStorage").SpawnRainbowBlock},
            {Name = "Galaxy Block", Event = game:GetService("ReplicatedStorage").SpawnGalaxyBlock},
        }
    },
    Speed = {
        Enabled = false,
        Value = 16
    },
    JumpPower = {
        Enabled = false,
        Value = 50.145
    },
    Noclip = {
        Enabled = false
    },
    Gravity = {
        Enabled = false,
        Value = 196.2
    },
    InfiniteJump = {
        Enabled = false
    },
    Fly = {
        Enabled = false,
        Speed = 40
    },
    Esp = {
        Enabled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Healthbar = false,
        Connections = {},
        Drawings = {}
    },
    Highlight = {
        Enabled = false,
        SeeThroughWalls = true,
        Fill = {
            Color = Color3.fromRGB(255, 255, 255),
            Transparency = 0.5
        },
        Outline = {
            Color = Color3.fromRGB(0, 0, 0),
            Transparency = 0
        },
        Objects = {},
        Connection = nil
    }
}

local gameName = "Lucky Block Battlegrounds"
local discord = "https://discord.com/invite/7DVEpdpsyf"
local theme = "Rose"
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")
local backpack = player:WaitForChild("Backpack")
local mouse = player:GetMouse()

local Window = Fluent:CreateWindow({
    Title = "Exoz",
    SubTitle = gameName,
    TabWidth = 140,
    Size = UDim2.fromOffset(780, 460),
    Acrylic = false,
    Theme = theme,
    MinimizeKey = Enum.KeyCode.RightControl
})

local function Notify(title, desc, time)
    Fluent:Notify({Title = title, Content = desc, Duration = time or 5})
end

local function teleportTo(location)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = location
    end
end

local locationNames = {}
for _, location in ipairs(exoz.LuckyBlockBattlegrounds.Locations) do
    table.insert(locationNames, location.name)
end

local Tabs = {
    Main = Window:AddTab({Title = "Main", Icon = "skull"}),
    Visuals = Window:AddTab({Title = "Visuals", Icon = "eye"}),
    Utility = Window:AddTab({Title = "Utility", Icon = "wrench"}),
    Credits = Window:AddTab({Title = "Credits", Icon = "code"}),
    Settings = Window:AddTab({Title = "Settings", Icon = "settings"})
}

Tabs.Credits:AddParagraph({Title = "Credits:", Content = ".vnpr"})
Tabs.Credits:AddParagraph({Title = "Join The Discord", Content = discord})
Tabs.Credits:AddButton({
    Title = "Copy Link",
    Description = "Click here to copy Discord invite link.",
    Callback = function()
        if setclipboard then
            setclipboard(discord)
            Notify("Exoz", "Discord link copied to clipboard.")
        else
            Notify("Exoz", "Clipboard function not supported.")
        end
    end
})

local SpeedSection = Tabs.Main:AddSection("Speed")

SpeedSection:AddToggle("SpeedToggle", {
    Title = "Speed",
    Default = false,
    Callback = function(Value)
        exoz.Speed.Enabled = Value
        Notify("Exoz", "Speed toggled " .. (Value and "on" or "off"), 2)
    end
})

SpeedSection:AddSlider("SpeedSlider", {
    Title = "Speed Slider",
    Min = 16,
    Max = 500,
    Default = 16,
    Rounding = 1,
    Callback = function(Value)
        exoz.Speed.Value = Value
    end
})

getgenv().ExozSpeedConnection = RunService.Heartbeat:Connect(function()
    if humanoid then 
        humanoid.WalkSpeed = exoz.Speed.Enabled and exoz.Speed.Value or 16 
    end
end)

local JumpPowerSection = Tabs.Main:AddSection("Jump Power")

JumpPowerSection:AddToggle("JumpPowerToggle", {
    Title = "Jump Power",
    Default = false,
    Callback = function(Value)
        exoz.JumpPower.Enabled = Value
        Notify("Exoz", "Jump power toggled " .. (Value and "on" or "off"), 2)
    end
})

JumpPowerSection:AddSlider("JumpPowerSlider", {
    Title = "Jump Power Slider",
    Min = 50.145,
    Max = 1000,
    Default = 50.145,
    Rounding = 1,
    Callback = function(Value)
        exoz.JumpPower.Value = Value
    end
})

getgenv().ExozJumpPowerConnection = RunService.Heartbeat:Connect(function()
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if exoz.JumpPower.Enabled then
            if humanoid.UseJumpPower then 
                humanoid.JumpPower = exoz.JumpPower.Value 
            else 
                humanoid.JumpHeight = exoz.JumpPower.Value / 7 
            end
        else
            if humanoid.UseJumpPower then 
                humanoid.JumpPower = 50.145 
            else 
                humanoid.JumpHeight = 7.2 
            end
        end
    end
end)

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    task.wait(1)
    if exoz.JumpPower.Enabled then
        if char.Humanoid.UseJumpPower then 
            char.Humanoid.JumpPower = exoz.JumpPower.Value 
        else 
            char.Humanoid.JumpHeight = exoz.JumpPower.Value / 7 
        end
    end
end)

local NoclipSection = Tabs.Main:AddSection("Noclip")

NoclipSection:AddToggle("NoClip", {
    Title = "NoClip",
    Default = false,
    Callback = function(Value)
        exoz.Noclip.Enabled = Value
        Notify("Exoz", "Noclip toggled " .. (Value and "on" or "off"), 2)
    end
})

getgenv().ExozNoclipConnection = RunService.Stepped:Connect(function()
    if exoz.Noclip.Enabled and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            end
        end
    end
end)

local GravitySection = Tabs.Main:AddSection("Gravity")

GravitySection:AddToggle("GravityToggle", {
    Title = "Gravity",
    Default = false,
    Callback = function(Value)
        exoz.Gravity.Enabled = Value
        Notify("Exoz", "Gravity toggled " .. (Value and "on" or "off"), 2)
        if not Value then 
            workspace.Gravity = 196.2 
        end
    end
})

GravitySection:AddSlider("GravitySlider", {
    Title = "Gravity Value",
    Min = 0,
    Max = 196.2,
    Default = workspace.Gravity,
    Rounding = 0.1,
    Callback = function(Value)
        exoz.Gravity.Value = Value
    end
})

getgenv().ExozGravityConnection = RunService.Heartbeat:Connect(function()
    if exoz.Gravity.Enabled then 
        workspace.Gravity = exoz.Gravity.Value 
    end
end)

local InfJumpSection = Tabs.Main:AddSection("Infinite Jump")

InfJumpSection:AddToggle("InfJumpToggle", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        exoz.InfiniteJump.Enabled = Value
        Notify("Exoz", "Infinite Jump toggled " .. (Value and "on" or "off"), 2)
    end
})

getgenv().ExozInfJumpConnection = UserInputService.JumpRequest:Connect(function()
    if exoz.InfiniteJump.Enabled then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local FlySection = Tabs.Main:AddSection("Fly")

FlySection:AddToggle("FlyToggle", {
    Title = "Fly",
    Default = false,
    Callback = function(Value)
        local plr = Players.LocalPlayer
        local char = plr.Character or plr.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        exoz.Fly.Enabled = Value

        if Value then
            Notify("Exoz", "Fly enabled", 2)
            
            local control = {F=0,B=0,L=0,R=0,Q=0,E=0}

            local bodyGyro = Instance.new('BodyGyro')
            bodyGyro.P = 9e4
            bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
            bodyGyro.CFrame = root.CFrame
            bodyGyro.Parent = root

            local bodyVelocity = Instance.new('BodyVelocity')
            bodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.Parent = root

            getgenv().ExozFlyKeyDown = UserInputService.InputBegan:Connect(function(input, gp)
                if gp then return end
                if input.KeyCode == Enum.KeyCode.W then control.F = -1 end
                if input.KeyCode == Enum.KeyCode.S then control.B = 1 end
                if input.KeyCode == Enum.KeyCode.A then control.L = -1 end
                if input.KeyCode == Enum.KeyCode.D then control.R = 1 end
                if input.KeyCode == Enum.KeyCode.Q then control.E = -1 end
                if input.KeyCode == Enum.KeyCode.E then control.Q = 1 end
            end)

            getgenv().ExozFlyKeyUp = UserInputService.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W then control.F = 0 end
                if input.KeyCode == Enum.KeyCode.S then control.B = 0 end
                if input.KeyCode == Enum.KeyCode.A then control.L = 0 end
                if input.KeyCode == Enum.KeyCode.D then control.R = 0 end
                if input.KeyCode == Enum.KeyCode.Q then control.E = 0 end
                if input.KeyCode == Enum.KeyCode.E then control.Q = 0 end
            end)

            getgenv().ExozFlyConnection = RunService.Heartbeat:Connect(function()
                if not exoz.Fly.Enabled then return end
                local cam = workspace.CurrentCamera

                local moveVec = Vector3.new(control.R + control.L, control.Q + control.E, control.F + control.B)

                if moveVec.Magnitude > 0 then
                    moveVec = moveVec.Unit * exoz.Fly.Speed
                    bodyVelocity.Velocity = cam.CFrame:VectorToWorldSpace(moveVec)
                else
                    bodyVelocity.Velocity = Vector3.zero
                end

                bodyGyro.CFrame = cam.CFrame
            end)
        else
            Notify("Exoz", "Fly disabled", 2)
            if getgenv().ExozFlyKeyDown then getgenv().ExozFlyKeyDown:Disconnect() getgenv().ExozFlyKeyDown = nil end
            if getgenv().ExozFlyKeyUp then getgenv().ExozFlyKeyUp:Disconnect() getgenv().ExozFlyKeyUp = nil end
            if getgenv().ExozFlyConnection then getgenv().ExozFlyConnection:Disconnect() getgenv().ExozFlyConnection = nil end
            if root:FindFirstChildOfClass("BodyGyro") then root.BodyGyro:Destroy() end
            if root:FindFirstChildOfClass("BodyVelocity") then root.BodyVelocity:Destroy() end
            if humanoid then humanoid.PlatformStand = false end
        end
    end
})

FlySection:AddSlider("FlySpeedSlider", {
    Title = "Fly Speed",
    Min = 1,
    Max = 100,
    Default = 10,
    Rounding = 1,
    Callback = function(Value)
        exoz.Fly.Speed = Value * 4
    end
})

local ESPSection = Tabs.Visuals:AddSection("ESP")

ESPSection:AddToggle("ESPToggle", {
    Title = "ESP",
    Default = false,
    Callback = function(Value)
        if not getgenv().ExozESPConnections then getgenv().ExozESPConnections = {} end
        if not getgenv().ExozESPDrawings then getgenv().ExozESPDrawings = {} end

        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera

        local function DisableESP()
            for _, connection in ipairs(getgenv().ExozESPConnections) do
                if connection.Disconnect then connection:Disconnect() end
            end
            for _, drawing in ipairs(getgenv().ExozESPDrawings) do
                if drawing.Remove then drawing:Remove() end
            end
            table.clear(getgenv().ExozESPConnections)
            table.clear(getgenv().ExozESPDrawings)
        end

        if not Value then
            DisableESP()
            return
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local Box = Drawing.new("Square")
                Box.Thickness = 1
                Box.Color = exoz.Esp.Color
                Box.Transparency = 1
                Box.Filled = false
                table.insert(getgenv().ExozESPDrawings, Box)

                local HealthBar = Drawing.new("Square")
                HealthBar.Thickness = 0
                HealthBar.Filled = true
                table.insert(getgenv().ExozESPDrawings, HealthBar)

                local connection = RunService.RenderStepped:Connect(function()
                    if not Value then return end
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                        local Humanoid = player.Character.Humanoid
                        local RootPart = player.Character.HumanoidRootPart
                        local Vector, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)

                        if OnScreen and Humanoid.Health > 0 then
                            local Distance = (Camera.CFrame.Position - RootPart.Position).Magnitude
                            local Scale = math.clamp(1 / (Distance * 0.05), 0.5, 3)
                            local BoxHeight = 100 * Scale
                            local BoxWidth = 60 * Scale
                            local TopLeft = Vector2.new(Vector.X - BoxWidth / 2, Vector.Y - BoxHeight / 2)

                            Box.Color = exoz.Esp.Color
                            Box.Size = Vector2.new(BoxWidth, BoxHeight)
                            Box.Position = TopLeft
                            Box.Visible = true

                            if exoz.Esp.Healthbar then
                                local HealthPercent = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
                                local BarHeight = BoxHeight * HealthPercent
                                local BarX = TopLeft.X + BoxWidth + 5
                                local BarY = TopLeft.Y + BoxHeight - BarHeight

                                HealthBar.Size = Vector2.new(4, BarHeight)
                                HealthBar.Position = Vector2.new(BarX, BarY)
                                HealthBar.Visible = true

                                local HealthColor
                                if HealthPercent > 0.5 then
                                    HealthColor = Color3.fromRGB(0, 255, 0)
                                elseif HealthPercent > 0.25 then
                                    HealthColor = Color3.fromRGB(255, 165, 0)
                                else
                                    HealthColor = Color3.fromRGB(255, 0, 0)
                                end
                                HealthBar.Color = HealthColor
                            else
                                HealthBar.Visible = false
                            end
                        else
                            Box.Visible = false
                            HealthBar.Visible = false
                        end
                    else
                        Box.Visible = false
                        HealthBar.Visible = false
                    end
                end)
                table.insert(getgenv().ExozESPConnections, connection)
            end
        end

        Players.PlayerAdded:Connect(function(player)
            if Value and player ~= LocalPlayer then
                local Box = Drawing.new("Square")
                Box.Thickness = 1
                Box.Color = exoz.Esp.Color
                Box.Transparency = 1
                Box.Filled = false
                table.insert(getgenv().ExozESPDrawings, Box)

                local HealthBar = Drawing.new("Square")
                HealthBar.Thickness = 0
                HealthBar.Filled = true
                table.insert(getgenv().ExozESPDrawings, HealthBar)

                local connection = RunService.RenderStepped:Connect(function()
                    if not Value then return end
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                        local Humanoid = player.Character.Humanoid
                        local RootPart = player.Character.HumanoidRootPart
                        local Vector, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)
                        if OnScreen and Humanoid.Health > 0 then
                            local Distance = (Camera.CFrame.Position - RootPart.Position).Magnitude
                            local Scale = math.clamp(1 / (Distance * 0.05), 0.5, 3)
                            local BoxHeight = 100 * Scale
                            local BoxWidth = 60 * Scale
                            local TopLeft = Vector2.new(Vector.X - BoxWidth / 2, Vector.Y - BoxHeight / 2)

                            Box.Color = exoz.Esp.Color
                            Box.Size = Vector2.new(BoxWidth, BoxHeight)
                            Box.Position = TopLeft
                            Box.Visible = true

                            if exoz.Esp.Healthbar then
                                local HealthPercent = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
                                local BarHeight = BoxHeight * HealthPercent
                                local BarX = TopLeft.X + BoxWidth + 5
                                local BarY = TopLeft.Y + BoxHeight - BarHeight

                                HealthBar.Size = Vector2.new(4, BarHeight)
                                HealthBar.Position = Vector2.new(BarX, BarY)
                                HealthBar.Visible = true

                                local HealthColor
                                if HealthPercent > 0.5 then
                                    HealthColor = Color3.fromRGB(0, 255, 0)
                                elseif HealthPercent > 0.25 then
                                    HealthColor = Color3.fromRGB(255, 165, 0)
                                else
                                    HealthColor = Color3.fromRGB(255, 0, 0)
                                end
                                HealthBar.Color = HealthColor
                            else
                                HealthBar.Visible = false
                            end
                        else
                            Box.Visible = false
                            HealthBar.Visible = false
                        end
                    else
                        Box.Visible = false
                        HealthBar.Visible = false
                    end
                end)
                table.insert(getgenv().ExozESPConnections, connection)
            end
        end)
    end
})

ESPSection:AddToggle("HealthbarToggle", {
    Title = "Health Bars",
    Default = false,
    Callback = function(Value)
        exoz.Esp.Healthbar = Value
    end
})

ESPSection:AddColorpicker("ESPCustomisationPicker", {
    Title = "ESP Color",
    Default = exoz.Esp.Color,
    Callback = function(Value)
        exoz.Esp.Color = Value
    end
})

local HighlightsSection = Tabs.Visuals:AddSection("Highlights")

HighlightsSection:AddToggle("HighlightToggle", {
    Title = "Highlight ESP",
    Default = false,
    Callback = function(Value)
        exoz.Highlight.Enabled = Value
        if not Value then
            for _, h in pairs(exoz.Highlight.Objects) do if h and h.Parent then h:Destroy() end end
            table.clear(exoz.Highlight.Objects)
            return
        end
        local function CreateHighlight(player)
            if player == Players.LocalPlayer then return end
            if not player.Character then return end
            if exoz.Highlight.Objects[player] then return end
            local h = Instance.new("Highlight")
            h.FillTransparency = exoz.Highlight.Fill.Transparency
            h.OutlineTransparency = exoz.Highlight.Outline.Transparency
            h.FillColor = exoz.Highlight.Fill.Color
            h.OutlineColor = exoz.Highlight.Outline.Color
            h.DepthMode = exoz.Highlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
            h.Adornee = player.Character
            h.Parent = game.CoreGui
            exoz.Highlight.Objects[player] = h
        end
        for _, p in ipairs(Players:GetPlayers()) do CreateHighlight(p) end
        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function() if exoz.Highlight.Enabled then CreateHighlight(p) end end)
        end)
        task.spawn(function()
            while exoz.Highlight.Enabled do
                for p, h in pairs(exoz.Highlight.Objects) do
                    if p.Character and h then
                        h.FillColor = exoz.Highlight.Fill.Color
                        h.OutlineColor = exoz.Highlight.Outline.Color
                        h.Adornee = p.Character
                    else
                        if h then h:Destroy() exoz.Highlight.Objects[p] = nil end
                    end
                end
                task.wait(0.25)
            end
        end)
    end
})

HighlightsSection:AddColorpicker("HighlightFillColorPicker", {
    Title = "Highlight Fill Color",
    Default = exoz.Highlight.Fill.Color,
    Callback = function(Value)
        exoz.Highlight.Fill.Color = Value
        for _, h in pairs(exoz.Highlight.Objects) do if h then h.FillColor = exoz.Highlight.Fill.Color end end
    end
})

HighlightsSection:AddColorpicker("HighlightOutlineColorPicker", {
    Title = "Highlight Outline Color",
    Default = exoz.Highlight.Outline.Color,
    Callback = function(Value)
        exoz.Highlight.Outline.Color = Value
        for _, h in pairs(exoz.Highlight.Objects) do if h then h.OutlineColor = exoz.Highlight.Outline.Color end end
    end
})

local TeleportsSection = Tabs.Utility:AddSection("Teleports")

local TeleportDropdown = Tabs.Utility:AddDropdown("TeleportDropdown", {
    Title = "Teleport",
    Values = locationNames,
    Multi = false,
    Default = 1,
})
TeleportDropdown:SetValue(locationNames[1])
TeleportDropdown:OnChanged(function(Value)
    for _, location in ipairs(exoz.LuckyBlockBattlegrounds.Locations) do
        if location.name == Value then
            teleportTo(location.position)
            break
        end
    end
end)

local BlocksSection = Tabs.Utility:AddSection("Blocks")

for _, block in ipairs(exoz.LuckyBlockBattlegrounds.Blocks) do
    BlocksSection:AddButton({
        Title = "Spawn " .. block.Name,
        Callback = function()
            if block.Event then
                block.Event:FireServer()
            else
                Notify("Error", "Cant find.", 6)
            end
        end
    })
end

BlocksSection:AddParagraph({
    Title = "Note",
    Content = "Lucky blocks with higher value than Galaxy cannot be spawned. I am trying to figure out how to spawn them."
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Exoz")
SaveManager:SetFolder("Exoz/".. gameName)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
Notify("Exoz", "Loaded".. gameName .. " script successfully.")
SaveManager:LoadAutoloadConfig()