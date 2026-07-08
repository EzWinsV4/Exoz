local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

pcall(function() if getgenv().ExozSpeedConnection then getgenv().ExozSpeedConnection:Disconnect() getgenv().ExozSpeedConnection = nil end end)
pcall(function() if getgenv().ExozJumpPowerConnection then getgenv().ExozJumpPowerConnection:Disconnect() getgenv().ExozJumpPowerConnection = nil end end)
pcall(function() if getgenv().ExozNoclipConnection then getgenv().ExozNoclipConnection:Disconnect() getgenv().ExozNoclipConnection = nil end end)
pcall(function() if getgenv().ExozGravityConnection then getgenv().ExozGravityConnection:Disconnect() getgenv().ExozGravityConnection = nil end end)
pcall(function() if getgenv().ExozInfJumpConnection then getgenv().ExozInfJumpConnection:Disconnect() getgenv().ExozInfJumpConnection = nil end end)
pcall(function() if getgenv().ExozFlyConnection then getgenv().ExozFlyConnection:Disconnect() getgenv().ExozFlyConnection = nil end end)

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
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

local Window = MacLib:Window({
    Title = "Exoz",
    Subtitle = gameName,
    Size = UDim2.fromOffset(780, 570),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = true,
    Keybind = Enum.KeyCode.RightControl,
    AcrylicBlur = true,
})

local globalSettings = {
    UIBlur = Window:GlobalSetting({
        Name = "UI Blur",
        Default = Window:GetAcrylicBlurState(),
        Callback = function(bool)
            Window:SetAcrylicBlurState(bool)
        end
    }),
    Notifications = Window:GlobalSetting({
        Name = "Notifications",
        Default = Window:GetNotificationsState(),
        Callback = function(bool)
            Window:SetNotificationsState(bool)
        end
    }),
    ShowUserInfo = Window:GlobalSetting({
        Name = "Show User Info",
        Default = Window:GetUserInfoState(),
        Callback = function(bool)
            Window:SetUserInfoState(bool)
        end
    })
}

local function Notify(title, desc, time)
    Window:Notify({
        Title = title,
        Description = desc,
        Lifetime = time or 5
    })
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

local tabGroups = {
    TabGroup1 = Window:TabGroup(),
    TabGroup2 = Window:TabGroup()
}

local tabs = {
    Main = tabGroups.TabGroup1:Tab({ Name = "Main", Image = "rbxassetid://101060850237115" }),
    Visuals = tabGroups.TabGroup1:Tab({ Name = "Visuals", Image = "rbxassetid://127234874352422" }),
    Utility = tabGroups.TabGroup1:Tab({ Name = "Utility", Image = "rbxassetid://85345725497834" }),
    Credits = tabGroups.TabGroup2:Tab({ Name = "Credits", Image = "rbxassetid://75851496262862" }),
    Settings = tabGroups.TabGroup2:Tab({ Name = "Settings", Image = "rbxassetid://10734950309" })
}

local sections = {
    Speed = tabs.Main:Section({ Side = "Left" }),
    JumpPower = tabs.Main:Section({ Side = "Right" }),
    Noclip = tabs.Main:Section({ Side = "Left" }),
    Gravity = tabs.Main:Section({ Side = "Right" }),
    InfiniteJump = tabs.Main:Section({ Side = "Left" }),
    Fly = tabs.Main:Section({ Side = "Right" }),
    ESP = tabs.Visuals:Section({ Side = "Left" }),
    Highlights = tabs.Visuals:Section({ Side = "Right" }),
    Teleports = tabs.Utility:Section({ Side = "Left" }),
    Blocks = tabs.Utility:Section({ Side = "Right" }),
    Credits = tabs.Credits:Section({ Side = "Left" }),
    Discord = tabs.Credits:Section({ Side = "Right" })
}

sections.Credits:Header({ Name = "Credits" })
sections.Credits:Paragraph({ Header = "Developers", Body = ".vnpr\nflamesiscoolz" })
sections.Discord:Paragraph({ Header = "Join The Discord", Body = discord })
sections.Discord:Button({
    Name = "Copy Link",
    Callback = function()
        if setclipboard then
            setclipboard(discord)
            Notify("Exoz", "Discord link copied to clipboard.")
        else
            Notify("Exoz", "Clipboard function not supported.")
        end
    end
})

sections.Speed:Header({ Name = "Speed" })

sections.Speed:Toggle({
    Name = "Speed",
    Default = false,
    Callback = function(Value)
        exoz.Speed.Enabled = Value
        Notify("Exoz", "Speed toggled " .. (Value and "on" or "off"), 2)
    end
}, "SpeedToggle")

sections.Speed:Slider({
    Name = "Speed Slider",
    Default = 16,
    Minimum = 16,
    Maximum = 500,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(Value)
        exoz.Speed.Value = Value
    end
}, "SpeedSlider")

getgenv().ExozSpeedConnection = RunService.Heartbeat:Connect(function()
    if humanoid then 
        humanoid.WalkSpeed = exoz.Speed.Enabled and exoz.Speed.Value or 16 
    end
end)

sections.JumpPower:Header({ Name = "Jump Power" })

sections.JumpPower:Toggle({
    Name = "Jump Power",
    Default = false,
    Callback = function(Value)
        exoz.JumpPower.Enabled = Value
        Notify("Exoz", "Jump power toggled " .. (Value and "on" or "off"), 2)
    end
}, "JumpPowerToggle")

sections.JumpPower:Slider({
    Name = "Jump Power Slider",
    Default = 50.145,
    Minimum = 50.145,
    Maximum = 1000,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(Value)
        exoz.JumpPower.Value = Value
    end
}, "JumpPowerSlider")

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

sections.Noclip:Header({ Name = "Noclip" })

sections.Noclip:Toggle({
    Name = "NoClip",
    Default = false,
    Callback = function(Value)
        exoz.Noclip.Enabled = Value
        Notify("Exoz", "Noclip toggled " .. (Value and "on" or "off"), 2)
    end
}, "NoClip")

getgenv().ExozNoclipConnection = RunService.Stepped:Connect(function()
    if exoz.Noclip.Enabled and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then 
                part.CanCollide = false 
            end
        end
    end
end)

sections.Gravity:Header({ Name = "Gravity" })

sections.Gravity:Toggle({
    Name = "Gravity",
    Default = false,
    Callback = function(Value)
        exoz.Gravity.Enabled = Value
        Notify("Exoz", "Gravity toggled " .. (Value and "on" or "off"), 2)
        if not Value then 
            workspace.Gravity = 196.2 
        end
    end
}, "GravityToggle")

sections.Gravity:Slider({
    Name = "Gravity Value",
    Default = workspace.Gravity,
    Minimum = 0,
    Maximum = 196.2,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(Value)
        exoz.Gravity.Value = Value
    end
}, "GravitySlider")

getgenv().ExozGravityConnection = RunService.Heartbeat:Connect(function()
    if exoz.Gravity.Enabled then 
        workspace.Gravity = exoz.Gravity.Value 
    end
end)

sections.InfiniteJump:Header({ Name = "Infinite Jump" })

sections.InfiniteJump:Toggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        exoz.InfiniteJump.Enabled = Value
        Notify("Exoz", "Infinite Jump toggled " .. (Value and "on" or "off"), 2)
    end
}, "InfJumpToggle")

getgenv().ExozInfJumpConnection = UserInputService.JumpRequest:Connect(function()
    if exoz.InfiniteJump.Enabled then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

sections.Fly:Header({ Name = "Fly" })

sections.Fly:Toggle({
    Name = "Fly",
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
}, "FlyToggle")

sections.Fly:Slider({
    Name = "Fly Speed",
    Default = 10,
    Minimum = 1,
    Maximum = 100,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(Value)
        exoz.Fly.Speed = Value * 4
    end
}, "FlySpeedSlider")

sections.ESP:Header({ Name = "ESP" })

sections.ESP:Toggle({
    Name = "ESP",
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
}, "ESPToggle")

sections.ESP:Toggle({
    Name = "Health Bars",
    Default = false,
    Callback = function(Value)
        exoz.Esp.Healthbar = Value
    end
}, "HealthbarToggle")

sections.ESP:Colorpicker({
    Name = "ESP Color",
    Default = exoz.Esp.Color,
    Callback = function(Value)
        exoz.Esp.Color = Value
    end
}, "ESPCustomisationPicker")

sections.Highlights:Header({ Name = "Highlights" })

sections.Highlights:Toggle({
    Name = "Highlight ESP",
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
}, "HighlightToggle")

sections.Highlights:Colorpicker({
    Name = "Highlight Fill Color",
    Default = exoz.Highlight.Fill.Color,
    Callback = function(Value)
        exoz.Highlight.Fill.Color = Value
        for _, h in pairs(exoz.Highlight.Objects) do if h then h.FillColor = exoz.Highlight.Fill.Color end end
    end
}, "HighlightFillColorPicker")

sections.Highlights:Colorpicker({
    Name = "Highlight Outline Color",
    Default = exoz.Highlight.Outline.Color,
    Callback = function(Value)
        exoz.Highlight.Outline.Color = Value
        for _, h in pairs(exoz.Highlight.Objects) do if h then h.OutlineColor = exoz.Highlight.Outline.Color end end
    end
}, "HighlightOutlineColorPicker")

sections.Teleports:Header({ Name = "Teleports" })

local TeleportDropdown = sections.Teleports:Dropdown({
    Name = "Teleport",
    Multi = false,
    Required = true,
    Options = locationNames,
    Default = 1,
    Callback = function(Value)
        for _, location in ipairs(exoz.LuckyBlockBattlegrounds.Locations) do
            if location.name == Value then
                teleportTo(location.position)
                break
            end
        end
    end
}, "TeleportDropdown")

sections.Blocks:Header({ Name = "Blocks" })

for _, block in ipairs(exoz.LuckyBlockBattlegrounds.Blocks) do
    sections.Blocks:Button({
        Name = "Spawn " .. block.Name,
        Callback = function()
            if block.Event then
                block.Event:FireServer()
            else
                Notify("Error", "Cant find.", 6)
            end
        end
    })
end

sections.Blocks:Paragraph({
    Header = "Note",
    Body = "Lucky blocks with higher value than Galaxy cannot be spawned. I am trying to figure out how to spawn them."
})

tabs.Settings:InsertConfigSection("Left")

Window.onUnloaded(function()
    pcall(function() if getgenv().ExozSpeedConnection then getgenv().ExozSpeedConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozJumpPowerConnection then getgenv().ExozJumpPowerConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozNoclipConnection then getgenv().ExozNoclipConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozGravityConnection then getgenv().ExozGravityConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozInfJumpConnection then getgenv().ExozInfJumpConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozFlyConnection then getgenv().ExozFlyConnection:Disconnect() end end)
end)

tabs.Main:Select()
MacLib:SetFolder("Exoz/" .. gameName)
MacLib:LoadAutoLoadConfig()

Notify("Exoz", "Loaded ".. gameName .. " script successfully.")
