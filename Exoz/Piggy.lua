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
pcall(function() if getgenv().ExozFlyKeyDown then getgenv().ExozFlyKeyDown:Disconnect() getgenv().ExozFlyKeyDown = nil end end)
pcall(function() if getgenv().ExozFlyKeyUp then getgenv().ExozFlyKeyUp:Disconnect() getgenv().ExozFlyKeyUp = nil end end)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local exoz = {
    Piggy = {
        Lightings = {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            FogEnd = Lighting.FogEnd,
            GlobalShadows = Lighting.GlobalShadows,
            OutdoorAmbient = Lighting.OutdoorAmbient
        },
        Maps = {
            House = "House",
            Station = "Station",
            Gallery = "Gallery",
            Forest = "Forest",
            School = "School",
            Hospital = "Hospital",
            Metro = "Metro",
            Carnival = "Carnival",
            City = "City",
            Mall = "Mall",
            Outpost = "Outpost",
            Plant = "Plant"
        },
        Modes = {
            Bot = "Bot",
            Player = "Player",
            PlayerAndBot = "PlayerBot",
            Swarm = "Swarm",
            Traitor = "Traitor",
            Tag = "Tag"
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
    FullBright = {
        Enabled = false
    },
    Esp = {
        PlayerHighlight = {
            Enabled = false,
            SeeThroughWalls = true,
            Fill = {
                Color = Color3.fromRGB(0, 255, 0),
                Transparency = 0.5
            },
            Outline = {
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0
            },
            Objects = {},
            Connection = nil
        },
        PiggyHighlight = {
            Enabled = false,
            SeeThroughWalls = true,
            Fill = {
                Color = Color3.fromRGB(255, 100, 100),
                Transparency = 0.5
            },
            Outline = {
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0
            },
            Objects = {},
            Connection = nil
        },
        TraitorHighlight = {
            Enabled = false,
            SeeThroughWalls = true,
            Fill = {
                Color = Color3.fromRGB(255, 165, 0),
                Transparency = 0.5
            },
            Outline = {
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0
            },
            Objects = {},
            Connection = nil
        },
        BotHighlight = {
            Enabled = false,
            SeeThroughWalls = true,
            Fill = {
                Color = Color3.fromRGB(139, 0, 0),
                Transparency = 0.5
            },
            Outline = {
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0
            },
            Objects = {},
            Connection = nil
        },
        ItemHighlight = {
            Enabled = false,
            SeeThroughWalls = true,
            Fill = {
                Color = Color3.fromRGB(255, 255, 0),
                Transparency = 0.5
            },
            Outline = {
                Color = Color3.fromRGB(0, 0, 0),
                Transparency = 0
            },
            Objects = {},
            Connection = nil
        }
    },
    VoidBots = {
        Enabled = false,
        Connection = nil
    },
    BreakBots = {
        Enabled = false,
        Connection = nil,
        Forces = {},
        FrozenParts = {}
    },
    AntiTrap = {
        Enabled = false,
        Connection = nil,
        DisabledTraps = {}
    },
    Win = {
        Enabled = false,
        Connection = nil,
        KilledPlayers = {}
    }
}

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")
local gameName = "Piggy ~ Book 1"
local discord = "https://discord.com/invite/7DVEpdpsyf"

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

local function IsPiggy(target)
    if target:IsA("Player") then
        local character = target.Character
        if character then
            local enemyValue = character:FindFirstChild("Enemy")
            if enemyValue and enemyValue:IsA("BoolValue") and enemyValue.Value == true then
                return true, character
            end
        end
    end
    return false, nil
end

local function IsTraitor(target)
    if target:IsA("Player") then
        local character = target.Character
        if character then
            local traitorValue = character:FindFirstChild("Traitor")
            if traitorValue and traitorValue:IsA("BoolValue") and traitorValue.Value == true then
                return true, character
            end
        end
    end
    return false, nil
end

local function CreatePiggyHighlight(target)
    local isPiggy, character = IsPiggy(target)
    if not isPiggy then return nil end
    
    if exoz.Esp.PiggyHighlight.Objects[character] then return exoz.Esp.PiggyHighlight.Objects[character] end
    if not character or not character.Parent then return nil end
    
    local highlightInstance = Instance.new("Highlight")
    highlightInstance.FillTransparency = exoz.Esp.PiggyHighlight.Fill.Transparency
    highlightInstance.OutlineTransparency = exoz.Esp.PiggyHighlight.Outline.Transparency
    highlightInstance.FillColor = exoz.Esp.PiggyHighlight.Fill.Color
    highlightInstance.OutlineColor = exoz.Esp.PiggyHighlight.Outline.Color
    highlightInstance.DepthMode = exoz.Esp.PiggyHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    highlightInstance.Adornee = character
    highlightInstance.Parent = game.CoreGui
    
    exoz.Esp.PiggyHighlight.Objects[character] = highlightInstance
    return highlightInstance
end

local function CreateTraitorHighlight(target)
    local isTraitor, character = IsTraitor(target)
    if not isTraitor then return nil end
    
    if exoz.Esp.TraitorHighlight.Objects[character] then return exoz.Esp.TraitorHighlight.Objects[character] end
    if not character or not character.Parent then return nil end
    
    local highlightInstance = Instance.new("Highlight")
    highlightInstance.FillTransparency = exoz.Esp.TraitorHighlight.Fill.Transparency
    highlightInstance.OutlineTransparency = exoz.Esp.TraitorHighlight.Outline.Transparency
    highlightInstance.FillColor = exoz.Esp.TraitorHighlight.Fill.Color
    highlightInstance.OutlineColor = exoz.Esp.TraitorHighlight.Outline.Color
    highlightInstance.DepthMode = exoz.Esp.TraitorHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    highlightInstance.Adornee = character
    highlightInstance.Parent = game.CoreGui
    
    exoz.Esp.TraitorHighlight.Objects[character] = highlightInstance
    return highlightInstance
end

local function CreateBotHighlight(target)
    if exoz.Esp.BotHighlight.Objects[target] then return exoz.Esp.BotHighlight.Objects[target] end
    if not target or not target.Parent then return nil end
    
    local highlightInstance = Instance.new("Highlight")
    highlightInstance.FillTransparency = exoz.Esp.BotHighlight.Fill.Transparency
    highlightInstance.OutlineTransparency = exoz.Esp.BotHighlight.Outline.Transparency
    highlightInstance.FillColor = exoz.Esp.BotHighlight.Fill.Color
    highlightInstance.OutlineColor = exoz.Esp.BotHighlight.Outline.Color
    highlightInstance.DepthMode = exoz.Esp.BotHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    highlightInstance.Adornee = target
    highlightInstance.Parent = game.CoreGui
    
    exoz.Esp.BotHighlight.Objects[target] = highlightInstance
    return highlightInstance
end

local function CleanupPiggyHighlights()
    for target, highlightInstance in pairs(exoz.Esp.PiggyHighlight.Objects) do
        if highlightInstance and highlightInstance.Parent then
            highlightInstance:Destroy()
        end
    end
    exoz.Esp.PiggyHighlight.Objects = {}
    if exoz.Esp.PiggyHighlight.Connection then
        exoz.Esp.PiggyHighlight.Connection:Disconnect()
        exoz.Esp.PiggyHighlight.Connection = nil
    end
end

local function CleanupTraitorHighlights()
    for target, highlightInstance in pairs(exoz.Esp.TraitorHighlight.Objects) do
        if highlightInstance and highlightInstance.Parent then
            highlightInstance:Destroy()
        end
    end
    exoz.Esp.TraitorHighlight.Objects = {}
    if exoz.Esp.TraitorHighlight.Connection then
        exoz.Esp.TraitorHighlight.Connection:Disconnect()
        exoz.Esp.TraitorHighlight.Connection = nil
    end
end

local function CleanupBotHighlights()
    for target, highlightInstance in pairs(exoz.Esp.BotHighlight.Objects) do
        if highlightInstance and highlightInstance.Parent then
            highlightInstance:Destroy()
        end
    end
    exoz.Esp.BotHighlight.Objects = {}
    if exoz.Esp.BotHighlight.Connection then
        exoz.Esp.BotHighlight.Connection:Disconnect()
        exoz.Esp.BotHighlight.Connection = nil
    end
end

local function UpdateAllPiggyHighlights()
    for target, highlightInstance in pairs(exoz.Esp.PiggyHighlight.Objects) do
        if highlightInstance then
            highlightInstance.FillColor = exoz.Esp.PiggyHighlight.Fill.Color
            highlightInstance.OutlineColor = exoz.Esp.PiggyHighlight.Outline.Color
            highlightInstance.DepthMode = exoz.Esp.PiggyHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
            highlightInstance.FillTransparency = exoz.Esp.PiggyHighlight.Fill.Transparency
            highlightInstance.OutlineTransparency = exoz.Esp.PiggyHighlight.Outline.Transparency
        end
    end
end

local function UpdateAllTraitorHighlights()
    for target, highlightInstance in pairs(exoz.Esp.TraitorHighlight.Objects) do
        if highlightInstance then
            highlightInstance.FillColor = exoz.Esp.TraitorHighlight.Fill.Color
            highlightInstance.OutlineColor = exoz.Esp.TraitorHighlight.Outline.Color
            highlightInstance.DepthMode = exoz.Esp.TraitorHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
            highlightInstance.FillTransparency = exoz.Esp.TraitorHighlight.Fill.Transparency
            highlightInstance.OutlineTransparency = exoz.Esp.TraitorHighlight.Outline.Transparency
        end
    end
end

local function UpdateAllBotHighlights()
    for target, highlightInstance in pairs(exoz.Esp.BotHighlight.Objects) do
        if highlightInstance then
            highlightInstance.FillColor = exoz.Esp.BotHighlight.Fill.Color
            highlightInstance.OutlineColor = exoz.Esp.BotHighlight.Outline.Color
            highlightInstance.DepthMode = exoz.Esp.BotHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
            highlightInstance.FillTransparency = exoz.Esp.BotHighlight.Fill.Transparency
            highlightInstance.OutlineTransparency = exoz.Esp.BotHighlight.Outline.Transparency
        end
    end
end

local function ScanForPiggies()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            CreatePiggyHighlight(player)
        end
    end
end

local function ScanForTraitors()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            CreateTraitorHighlight(player)
        end
    end
end

local function ScanForBots()
    local piggyNPCFolder = Workspace:FindFirstChild("PiggyNPC")
    if piggyNPCFolder then
        for _, bot in ipairs(piggyNPCFolder:GetChildren()) do
            if bot:IsA("Model") and bot:FindFirstChildOfClass("Humanoid") then
                CreateBotHighlight(bot)
            end
        end
    end
end

local function InitializePiggyHighlightSystem()
    if not exoz.Esp.PiggyHighlight.Enabled then return end
    
    CleanupPiggyHighlights()
    ScanForPiggies()
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if exoz.Esp.PiggyHighlight.Enabled then
                task.wait(0.5)
                CreatePiggyHighlight(player)
            end
        end)
    end)
    
    exoz.Esp.PiggyHighlight.Connection = RunService.Heartbeat:Connect(function()
        if not exoz.Esp.PiggyHighlight.Enabled then
            CleanupPiggyHighlights()
            return
        end
    end)
end

local function InitializeTraitorHighlightSystem()
    if not exoz.Esp.TraitorHighlight.Enabled then return end
    
    CleanupTraitorHighlights()
    ScanForTraitors()
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if exoz.Esp.TraitorHighlight.Enabled then
                task.wait(0.5)
                CreateTraitorHighlight(player)
            end
        end)
    end)
    
    exoz.Esp.TraitorHighlight.Connection = RunService.Heartbeat:Connect(function()
        if not exoz.Esp.TraitorHighlight.Enabled then
            CleanupTraitorHighlights()
            return
        end
    end)
end

local function InitializeBotHighlightSystem()
    if not exoz.Esp.BotHighlight.Enabled then return end
    
    CleanupBotHighlights()
    ScanForBots()
    
    local piggyNPCFolder = Workspace:FindFirstChild("PiggyNPC")
    if piggyNPCFolder then
        piggyNPCFolder.ChildAdded:Connect(function(bot)
            if exoz.Esp.BotHighlight.Enabled and bot:IsA("Model") and bot:FindFirstChildOfClass("Humanoid") then
                task.wait(0.5)
                CreateBotHighlight(bot)
            end
        end)
    end
    
    exoz.Esp.BotHighlight.Connection = RunService.Heartbeat:Connect(function()
        if not exoz.Esp.BotHighlight.Enabled then
            CleanupBotHighlights()
            return
        end
    end)
end

local function IsRegularPlayer(target)
    if target:IsA("Player") and target ~= Players.LocalPlayer then
        local character = target.Character
        if character then
            local enemyValue = character:FindFirstChild("Enemy")
            local traitorValue = character:FindFirstChild("Traitor")
            if (not enemyValue or not enemyValue.Value) and (not traitorValue or not traitorValue.Value) then
                return true, character
            end
        end
    end
    return false, nil
end

local function CreatePlayerHighlight(target)
    local isPlayer, character = IsRegularPlayer(target)
    if not isPlayer then return nil end
    
    if exoz.Esp.PlayerHighlight.Objects[character] then return exoz.Esp.PlayerHighlight.Objects[character] end
    if not character or not character.Parent then return nil end
    
    local highlightInstance = Instance.new("Highlight")
    highlightInstance.FillTransparency = exoz.Esp.PlayerHighlight.Fill.Transparency
    highlightInstance.OutlineTransparency = exoz.Esp.PlayerHighlight.Outline.Transparency
    highlightInstance.FillColor = exoz.Esp.PlayerHighlight.Fill.Color
    highlightInstance.OutlineColor = exoz.Esp.PlayerHighlight.Outline.Color
    highlightInstance.DepthMode = exoz.Esp.PlayerHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    highlightInstance.Adornee = character
    highlightInstance.Parent = game.CoreGui
    
    exoz.Esp.PlayerHighlight.Objects[character] = highlightInstance
    return highlightInstance
end

local function CleanupPlayerHighlights()
    for target, highlightInstance in pairs(exoz.Esp.PlayerHighlight.Objects) do
        if highlightInstance and highlightInstance.Parent then
            highlightInstance:Destroy()
        end
    end
    exoz.Esp.PlayerHighlight.Objects = {}
    if exoz.Esp.PlayerHighlight.Connection then
        exoz.Esp.PlayerHighlight.Connection:Disconnect()
        exoz.Esp.PlayerHighlight.Connection = nil
    end
end

local function UpdateAllPlayerHighlights()
    for target, highlightInstance in pairs(exoz.Esp.PlayerHighlight.Objects) do
        if highlightInstance then
            highlightInstance.FillColor = exoz.Esp.PlayerHighlight.Fill.Color
            highlightInstance.OutlineColor = exoz.Esp.PlayerHighlight.Outline.Color
            highlightInstance.DepthMode = exoz.Esp.PlayerHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
            highlightInstance.FillTransparency = exoz.Esp.PlayerHighlight.Fill.Transparency
            highlightInstance.OutlineTransparency = exoz.Esp.PlayerHighlight.Outline.Transparency
        end
    end
end

local function ScanForPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            CreatePlayerHighlight(player)
        end
    end
end

local function InitializePlayerHighlightSystem()
    if not exoz.Esp.PlayerHighlight.Enabled then return end
    
    CleanupPlayerHighlights()
    ScanForPlayers()
    
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if exoz.Esp.PlayerHighlight.Enabled then
                task.wait(0.5)
                CreatePlayerHighlight(player)
            end
        end)
    end)
    
    exoz.Esp.PlayerHighlight.Connection = RunService.Heartbeat:Connect(function()
        if not exoz.Esp.PlayerHighlight.Enabled then
            CleanupPlayerHighlights()
            return
        end
    end)
end

local function IsItem(target)
    if target:IsA("Part") or target:IsA("MeshPart") or target:IsA("UnionOperation") then
        local clickDetector = target:FindFirstChildOfClass("ClickDetector")
        if clickDetector then
            local parent = target.Parent
            if parent and parent:IsA("Folder") then
                return true
            end
        end
    end
    return false
end

local function CreateItemHighlight(target)
    if not IsItem(target) then return nil end
    if exoz.Esp.ItemHighlight.Objects[target] then return exoz.Esp.ItemHighlight.Objects[target] end
    if not target or not target.Parent then return nil end
    
    local highlightInstance = Instance.new("Highlight")
    highlightInstance.FillTransparency = exoz.Esp.ItemHighlight.Fill.Transparency
    highlightInstance.OutlineTransparency = exoz.Esp.ItemHighlight.Outline.Transparency
    highlightInstance.FillColor = exoz.Esp.ItemHighlight.Fill.Color
    highlightInstance.OutlineColor = exoz.Esp.ItemHighlight.Outline.Color
    highlightInstance.DepthMode = exoz.Esp.ItemHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    highlightInstance.Adornee = target
    highlightInstance.Parent = game.CoreGui
    
    exoz.Esp.ItemHighlight.Objects[target] = highlightInstance
    return highlightInstance
end

local function CleanupItemHighlights()
    for target, highlightInstance in pairs(exoz.Esp.ItemHighlight.Objects) do
        if highlightInstance and highlightInstance.Parent then
            highlightInstance:Destroy()
        end
    end
    exoz.Esp.ItemHighlight.Objects = {}
    if exoz.Esp.ItemHighlight.Connection then
        exoz.Esp.ItemHighlight.Connection:Disconnect()
        exoz.Esp.ItemHighlight.Connection = nil
    end
end

local function UpdateAllItemHighlights()
    for target, highlightInstance in pairs(exoz.Esp.ItemHighlight.Objects) do
        if highlightInstance then
            highlightInstance.FillColor = exoz.Esp.ItemHighlight.Fill.Color
            highlightInstance.OutlineColor = exoz.Esp.ItemHighlight.Outline.Color
            highlightInstance.DepthMode = exoz.Esp.ItemHighlight.SeeThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
            highlightInstance.FillTransparency = exoz.Esp.ItemHighlight.Fill.Transparency
            highlightInstance.OutlineTransparency = exoz.Esp.ItemHighlight.Outline.Transparency
        end
    end
end

local function ScanForItems()
    for _, item in ipairs(Workspace:GetDescendants()) do
        CreateItemHighlight(item)
    end
end

local function InitializeItemHighlightSystem()
    if not exoz.Esp.ItemHighlight.Enabled then return end
    
    CleanupItemHighlights()
    ScanForItems()
    
    Workspace.DescendantAdded:Connect(function(item)
        if exoz.Esp.ItemHighlight.Enabled then
            task.wait(0.1)
            CreateItemHighlight(item)
        end
    end)
    
    exoz.Esp.ItemHighlight.Connection = RunService.Heartbeat:Connect(function()
        if not exoz.Esp.ItemHighlight.Enabled then
            CleanupItemHighlights()
            return
        end
    end)
end

local function VoidBots()
    if not exoz.VoidBots.Enabled then return end
    
    local piggyNPCFolder = Workspace:FindFirstChild("PiggyNPC")
    if piggyNPCFolder then
        for _, bot in ipairs(piggyNPCFolder:GetChildren()) do
            if bot:IsA("Model") then
                bot.Parent = Lighting
            end
        end
    end
end

local function RestoreBots()
    local piggyNPCFolder = Workspace:FindFirstChild("PiggyNPC")
    if piggyNPCFolder then
        for _, bot in ipairs(Lighting:GetChildren()) do
            if bot:IsA("Model") and bot:FindFirstChild("Humanoid") then
                bot.Parent = piggyNPCFolder
            end
        end
    end
end

local function BreakBots()
    local piggyNPCFolder = Workspace:FindFirstChild("PiggyNPC")
    if piggyNPCFolder then
        for _, bot in ipairs(piggyNPCFolder:GetChildren()) do
            if bot:IsA("Model") then
                local root = bot:FindFirstChild("HumanoidRootPart") or bot:FindFirstChild("Torso") or bot:FindFirstChild("UpperTorso")
                if root and not table.find(exoz.BreakBots.FrozenParts, root) then
                    local ForceInstance = Instance.new("BodyPosition")
                    ForceInstance.Parent = root
                    ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    ForceInstance.Position = root.Position
                    table.insert(exoz.BreakBots.Forces, ForceInstance)
                    table.insert(exoz.BreakBots.FrozenParts, root)
                end
            end
        end
    end
end

local function CleanupBreakBots()
    for _, force in ipairs(exoz.BreakBots.Forces) do
        if force and force.Parent then
            force:Destroy()
        end
    end
    exoz.BreakBots.Forces = {}
    exoz.BreakBots.FrozenParts = {}
end

local function DisableTraps()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local trapSound = obj:FindFirstChild("TrapSound")
        if trapSound and not exoz.AntiTrap.DisabledTraps[obj] then
            obj.CanTouch = false
            obj.CanCollide = false
            for _, part in ipairs(obj:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanTouch = false
                    part.CanCollide = false
                    part.Transparency = 0.8
                end
            end
            exoz.AntiTrap.DisabledTraps[obj] = true
        end
    end
end

local function EnableTraps()
    for obj, _ in pairs(exoz.AntiTrap.DisabledTraps) do
        if obj and obj.Parent then
            obj.CanTouch = true
            obj.CanCollide = true
            for _, part in ipairs(obj:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanTouch = true
                    part.CanCollide = true
                    part.Transparency = 0
                end
            end
        end
    end
    exoz.AntiTrap.DisabledTraps = {}
end

local function AntiTrap()
    DisableTraps()
    
    Workspace.DescendantAdded:Connect(function(obj)
        if exoz.AntiTrap.Enabled then
            local trapSound = obj:FindFirstChild("TrapSound")
            if trapSound then
                obj.CanTouch = false
                obj.CanCollide = false
                for _, part in ipairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanTouch = false
                        part.CanCollide = false
                        part.Transparency = 0.8
                    end
                end
                exoz.AntiTrap.DisabledTraps[obj] = true
            end
        end
    end)
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
    World = tabs.Visuals:Section({ Side = "Left" }),
    Piggy = tabs.Visuals:Section({ Side = "Left" }),
    Traitor = tabs.Visuals:Section({ Side = "Right" }),
    Bots = tabs.Visuals:Section({ Side = "Left" }),
    Players = tabs.Visuals:Section({ Side = "Right" }),
    Items = tabs.Visuals:Section({ Side = "Right" }),
    BotsUtility = tabs.Utility:Section({ Side = "Left" }),
    AntiTrapUtil = tabs.Utility:Section({ Side = "Right" }),
    WinUtil = tabs.Utility:Section({ Side = "Left" }),
    Credits = tabs.Credits:Section({ Side = "Left" }),
    Discord = tabs.Credits:Section({ Side = "Right" })
}

sections.Credits:Header({ Name = "Credits" })
sections.Credits:Paragraph({ Header = "Developers", Body = ".vnpr\nflamesizcoolz" })
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

sections.World:Header({ Name = "World" })

sections.World:Toggle({
    Name = "Full Bright",
    Default = false,
    Callback = function(Value)
        exoz.FullBright.Enabled = Value

        if Value then
            local function bright()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            end

            bright()
            
            while exoz.FullBright.Enabled do
                bright()
                task.wait(0.5)
            end
        else
            Lighting.Brightness = exoz.Piggy.Lightings.Brightness
            Lighting.ClockTime = exoz.Piggy.Lightings.ClockTime
            Lighting.FogEnd = exoz.Piggy.Lightings.FogEnd
            Lighting.GlobalShadows = exoz.Piggy.Lightings.GlobalShadows
            Lighting.OutdoorAmbient = exoz.Piggy.Lightings.OutdoorAmbient
        end
    end
}, "FullBrightToggle")

sections.Piggy:Header({ Name = "Piggy" })

sections.Piggy:Toggle({
    Name = "Highlight",
    Default = false,
    Callback = function(Value)
        exoz.Esp.PiggyHighlight.Enabled = Value
        if Value then
            InitializePiggyHighlightSystem()
            Notify("Exoz", "Piggy Highlight enabled", 2)
        else
            CleanupPiggyHighlights()
            Notify("Exoz", "Piggy Highlight disabled", 2)
        end
    end
}, "PiggyHighlightToggle")

sections.Piggy:Toggle({
    Name = "See Through Walls",
    Default = true,
    Callback = function(Value)
        exoz.Esp.PiggyHighlight.SeeThroughWalls = Value
        UpdateAllPiggyHighlights()
    end
}, "PiggySeeThroughWallsToggle")

sections.Piggy:Colorpicker({
    Name = "Fill Color",
    Default = exoz.Esp.PiggyHighlight.Fill.Color,
    Callback = function(Value)
        exoz.Esp.PiggyHighlight.Fill.Color = Value
        UpdateAllPiggyHighlights()
    end
}, "PiggyFillColorPicker")

sections.Piggy:Colorpicker({
    Name = "Outline Color",
    Default = exoz.Esp.PiggyHighlight.Outline.Color,
    Callback = function(Value)
        exoz.Esp.PiggyHighlight.Outline.Color = Value
        UpdateAllPiggyHighlights()
    end
}, "PiggyOutlineColorPicker")

sections.Bots:Header({ Name = "Bots" })

sections.Bots:Toggle({
    Name = "Highlight",
    Default = false,
    Callback = function(Value)
        exoz.Esp.BotHighlight.Enabled = Value
        if Value then
            InitializeBotHighlightSystem()
            Notify("Exoz", "Bot Highlight enabled", 2)
        else
            CleanupBotHighlights()
            Notify("Exoz", "Bot Highlight disabled", 2)
        end
    end
}, "BotHighlightToggle")

sections.Bots:Toggle({
    Name = "See Through Walls",
    Default = true,
    Callback = function(Value)
        exoz.Esp.BotHighlight.SeeThroughWalls = Value
        UpdateAllBotHighlights()
    end
}, "BotSeeThroughWallsToggle")

sections.Bots:Colorpicker({
    Name = "Fill Color",
    Default = exoz.Esp.BotHighlight.Fill.Color,
    Callback = function(Value)
        exoz.Esp.BotHighlight.Fill.Color = Value
        UpdateAllBotHighlights()
    end
}, "BotFillColorPicker")

sections.Bots:Colorpicker({
    Name = "Outline Color",
    Default = exoz.Esp.BotHighlight.Outline.Color,
    Callback = function(Value)
        exoz.Esp.BotHighlight.Outline.Color = Value
        UpdateAllBotHighlights()
    end
}, "BotOutlineColorPicker")

sections.Traitor:Header({ Name = "Traitor" })

sections.Traitor:Toggle({
    Name = "Highlight",
    Default = false,
    Callback = function(Value)
        exoz.Esp.TraitorHighlight.Enabled = Value
        if Value then
            InitializeTraitorHighlightSystem()
            Notify("Exoz", "Traitor Highlight enabled", 2)
        else
            CleanupTraitorHighlights()
            Notify("Exoz", "Traitor Highlight disabled", 2)
        end
    end
}, "TraitorHighlightToggle")

sections.Traitor:Toggle({
    Name = "See Through Walls",
    Default = true,
    Callback = function(Value)
        exoz.Esp.TraitorHighlight.SeeThroughWalls = Value
        UpdateAllTraitorHighlights()
    end
}, "TraitorSeeThroughWallsToggle")

sections.Traitor:Colorpicker({
    Name = "Fill Color",
    Default = exoz.Esp.TraitorHighlight.Fill.Color,
    Callback = function(Value)
        exoz.Esp.TraitorHighlight.Fill.Color = Value
        UpdateAllTraitorHighlights()
    end
}, "TraitorFillColorPicker")

sections.Traitor:Colorpicker({
    Name = "Outline Color",
    Default = exoz.Esp.TraitorHighlight.Outline.Color,
    Callback = function(Value)
        exoz.Esp.TraitorHighlight.Outline.Color = Value
        UpdateAllTraitorHighlights()
    end
}, "TraitorOutlineColorPicker")

sections.Players:Header({ Name = "Players" })

sections.Players:Toggle({
    Name = "Highlight",
    Default = false,
    Callback = function(Value)
        exoz.Esp.PlayerHighlight.Enabled = Value
        if Value then
            InitializePlayerHighlightSystem()
            Notify("Exoz", "Player Highlight enabled", 2)
        else
            CleanupPlayerHighlights()
            Notify("Exoz", "Player Highlight disabled", 2)
        end
    end
}, "PlayerHighlightToggle")

sections.Players:Toggle({
    Name = "See Through Walls",
    Default = true,
    Callback = function(Value)
        exoz.Esp.PlayerHighlight.SeeThroughWalls = Value
        UpdateAllPlayerHighlights()
    end
}, "PlayerSeeThroughWallsToggle")

sections.Players:Colorpicker({
    Name = "Fill Color",
    Default = exoz.Esp.PlayerHighlight.Fill.Color,
    Callback = function(Value)
        exoz.Esp.PlayerHighlight.Fill.Color = Value
        UpdateAllPlayerHighlights()
    end
}, "PlayerFillColorPicker")

sections.Players:Colorpicker({
    Name = "Outline Color",
    Default = exoz.Esp.PlayerHighlight.Outline.Color,
    Callback = function(Value)
        exoz.Esp.PlayerHighlight.Outline.Color = Value
        UpdateAllPlayerHighlights()
    end
}, "PlayerOutlineColorPicker")

sections.Items:Header({ Name = "Items" })

sections.Items:Toggle({
    Name = "Highlight",
    Default = false,
    Callback = function(Value)
        exoz.Esp.ItemHighlight.Enabled = Value
        if Value then
            InitializeItemHighlightSystem()
            Notify("Exoz", "Item Highlight enabled", 2)
        else
            CleanupItemHighlights()
            Notify("Exoz", "Item Highlight disabled", 2)
        end
    end
}, "ItemHighlightToggle")

sections.Items:Toggle({
    Name = "See Through Walls",
    Default = true,
    Callback = function(Value)
        exoz.Esp.ItemHighlight.SeeThroughWalls = Value
        UpdateAllItemHighlights()
    end
}, "ItemSeeThroughWallsToggle")

sections.Items:Colorpicker({
    Name = "Fill Color",
    Default = exoz.Esp.ItemHighlight.Fill.Color,
    Callback = function(Value)
        exoz.Esp.ItemHighlight.Fill.Color = Value
        UpdateAllItemHighlights()
    end
}, "ItemFillColorPicker")

sections.Items:Colorpicker({
    Name = "Outline Color",
    Default = exoz.Esp.ItemHighlight.Outline.Color,
    Callback = function(Value)
        exoz.Esp.ItemHighlight.Outline.Color = Value
        UpdateAllItemHighlights()
    end
}, "ItemOutlineColorPicker")

sections.BotsUtility:Header({ Name = "Bots" })

sections.BotsUtility:Toggle({
    Name = "Void Bots",
    Default = false,
    Callback = function(Value)
        exoz.VoidBots.Enabled = Value
        if Value then
            VoidBots()
            exoz.VoidBots.Connection = RunService.Heartbeat:Connect(function()
                VoidBots()
            end)
            Notify("Exoz", "Void Bots enabled", 2)
        else
            if exoz.VoidBots.Connection then
                exoz.VoidBots.Connection:Disconnect()
                exoz.VoidBots.Connection = nil
            end
            RestoreBots()
            Notify("Exoz", "Void Bots disabled", 2)
        end
    end
}, "VoidBotsToggle")

sections.BotsUtility:Toggle({
    Name = "Break Bots",
    Default = false,
    Callback = function(Value)
        exoz.BreakBots.Enabled = Value
        if Value then
            BreakBots()
            exoz.BreakBots.Connection = RunService.Heartbeat:Connect(function()
                if exoz.BreakBots.Enabled then
                    BreakBots()
                else
                    if exoz.BreakBots.Connection then
                        exoz.BreakBots.Connection:Disconnect()
                        exoz.BreakBots.Connection = nil
                    end
                    CleanupBreakBots()
                end
            end)
            Notify("Exoz", "Break Bots enabled", 2)
        else
            if exoz.BreakBots.Connection then
                exoz.BreakBots.Connection:Disconnect()
                exoz.BreakBots.Connection = nil
            end
            CleanupBreakBots()
            Notify("Exoz", "Break Bots disabled", 2)
        end
    end
}, "BreakBotsToggle")

sections.AntiTrapUtil:Header({ Name = "Anti Trap" })

sections.AntiTrapUtil:Toggle({
    Name = "Anti Trap",
    Default = false,
    Callback = function(Value)
        exoz.AntiTrap.Enabled = Value
        if Value then
            DisableTraps()
            exoz.AntiTrap.Connection = RunService.Heartbeat:Connect(function()
                if exoz.AntiTrap.Enabled then
                    DisableTraps()
                else
                    if exoz.AntiTrap.Connection then
                        exoz.AntiTrap.Connection:Disconnect()
                        exoz.AntiTrap.Connection = nil
                    end
                    EnableTraps()
                end
            end)
            AntiTrap()
            Notify("Exoz", "Anti Trap enabled", 2)
        else
            if exoz.AntiTrap.Connection then
                exoz.AntiTrap.Connection:Disconnect()
                exoz.AntiTrap.Connection = nil
            end
            EnableTraps()
            Notify("Exoz", "Anti Trap disabled", 2)
        end
    end
}, "AntiTrapToggle")

sections.WinUtil:Header({ Name = "Win" })

sections.WinUtil:Button({
    Name = "Auto Win",
    Callback = function()
        local killedPlayers = {}
        
        local function AutoWin()
            local killedAll = true
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    local character = player.Character
                    if character and not killedPlayers[player] then
                        local enemyValue = character:FindFirstChild("Enemy")
                        if not enemyValue or not enemyValue.Value then
                            killedAll = false
                            local root = player.Character:FindFirstChild("HumanoidRootPart")
                            local myRoot = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if root and myRoot then
                                myRoot.CFrame = root.CFrame
                                break
                            end
                        end
                    end
                end
            end
            
            if killedAll then
                return true
            end
            return false
        end
        
        local function CheckDeaths()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer and not killedPlayers[player] then
                    local character = player.Character
                    if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
                        killedPlayers[player] = true
                    end
                end
            end
        end
        
        local connection = RunService.Heartbeat:Connect(function()
            CheckDeaths()
            if AutoWin() then
                connection:Disconnect()
                Notify("Exoz", "Won", 3)
            end
        end)
        
        Notify("Exoz", "Auto Win started", 2)
    end
})

tabs.Settings:InsertConfigSection("Left")

Window.onUnloaded(function()
    pcall(function() if getgenv().ExozSpeedConnection then getgenv().ExozSpeedConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozJumpPowerConnection then getgenv().ExozJumpPowerConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozNoclipConnection then getgenv().ExozNoclipConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozGravityConnection then getgenv().ExozGravityConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozInfJumpConnection then getgenv().ExozInfJumpConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozFlyConnection then getgenv().ExozFlyConnection:Disconnect() end end)
    pcall(function() if getgenv().ExozFlyKeyDown then getgenv().ExozFlyKeyDown:Disconnect() end end)
    pcall(function() if getgenv().ExozFlyKeyUp then getgenv().ExozFlyKeyUp:Disconnect() end end)
end)

tabs.Main:Select()
MacLib:SetFolder("Exoz/" .. gameName)
MacLib:LoadAutoLoadConfig()

Notify("Exoz", "Loaded ".. gameName .. " script successfully.")
