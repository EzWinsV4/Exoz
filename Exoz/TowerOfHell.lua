if not game:IsLoaded() then
    game.Loaded:Wait()
end

local function cleanupConnections()
    local connections = {
        "ExozSpeedConnection",
        "ExozJumpPowerConnection", 
        "ExozInfJumpConnection", 
        "ExozGodmodeConnection",
        "ExozRainbowConnection", 
        "ExozDisablerConnection"
    }
    
    for _, connName in pairs(connections) do
        pcall(function()
            if getgenv()[connName] then 
                getgenv()[connName]:Disconnect() 
                getgenv()[connName] = nil 
            end
        end)
    end
end

cleanupConnections()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Options = Fluent.Options

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gameName = "Tower of Hell"
local discord = "https://discord.com/invite/7DVEpdpsyf"
local theme = "Rose"
local player = Players.LocalPlayer

local exoz = {
    TowerOfHell = {
        Hitbox = {
            Hitboxes = {},
            Scripts = {}
        },
        Killparts = {
            Original = {
                Collision = {}
            },
        },
        Fog = {
            fEnd = Lighting.FogEnd,
            Start = Lighting.FogStart
        },
        Gears = {
            {Name = "Banana", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("banana")},
            {Name = "Bomb", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("bomb")},
            {Name = "Cola", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("cola")},
            {Name = "Fishing Rod", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("fishingrod")},
            {Name = "Fusion Coil", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("fusion")},
            {Name = "Gravity Coil", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("gravity")},
            {Name = "Grappling Hook", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("hook")},
            {Name = "Hour Glass", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("hourglass")},
            {Name = "Infinite Jump Coil", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("jump")},
            {Name = "Kill Part", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("killpart")},
            {Name = "Speed Coil", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("speed")},
            {Name = "Trowel", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("trowel")},
            {Name = "YX Terminator", Event = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Gear"):WaitForChild("yxterminator")},
        }
    },
    Speed = {
        Enabled = false,
        Current = 16
    },
    Jumppower = {
        Enabled = false,
        Current = 50.145
    },
    Infjump = {
        Enabled = false,
        Height = 50.145
    },
    Godmode = {
        Enabled = false
    },
    Win = {
        Speed = 2
    },
    Antifog = {
        Enabled = false
    },
    Antinegative = {
        Enabled = false
    },
    Disabler = {
        Enabled = true,
        Connection = nil
    }
}

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

local function getHumanoid()
    local character = Players.LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        return character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function getRootPart()
    local character = Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        return character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function getKillParts()
    local killParts = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") and string.find(string.lower(obj.Name), "kill") then
            table.insert(killParts, obj)
        end
    end
    return killParts
end

local function disableHitboxes()
    local character = player.Character
    if character then
        exoz.TowerOfHell.Hitbox.Hitboxes = {}
        exoz.TowerOfHell.Hitbox.Scripts = {}
        
        for _, obj in pairs(character:GetDescendants()) do
            if obj.Name == "hitbox" then
                exoz.TowerOfHell.Hitbox.Hitboxes[obj] = obj.Parent
                obj.Parent = nil
            elseif obj.Name == "hitboxScript" and obj:IsA("Script") then
                exoz.TowerOfHell.Hitbox.Scripts[obj] = {
                    Parent = obj.Parent,
                    Disabled = obj.Disabled
                }
                obj.Disabled = true
            end
        end
    end
end

local function enableHitboxes()
    for hitbox, parent in pairs(exoz.TowerOfHell.Hitbox.Hitboxes) do
        if hitbox and parent then
            hitbox.Parent = parent
        end
    end
    for script, data in pairs(exoz.TowerOfHell.Hitbox.Scripts) do
        if script and data then
            script.Disabled = data.Disabled
        end
    end
    exoz.TowerOfHell.Hitbox.Hitboxes = {}
    exoz.TowerOfHell.Hitbox.Scripts = {}
end

local function enableKillPartsCollision()
    local killParts = getKillParts()
    exoz.TowerOfHell.Killparts.Original.Collision = {}
    for _, part in pairs(killParts) do
        exoz.TowerOfHell.Killparts.Original.Collision[part] = part.CanCollide
        part.CanCollide = true
    end
end

local function restoreKillPartsCollision()
    for part, originalCollide in pairs(exoz.TowerOfHell.Killparts.Original.Collision) do
        if part and part.Parent then
            part.CanCollide = originalCollide
        end
    end
    exoz.TowerOfHell.Killparts.Original.Collision = {}
end

local function handleInfiniteJump()
    if getgenv().ExozInfJumpConnection then
        getgenv().ExozInfJumpConnection:Disconnect()
        getgenv().ExozInfJumpConnection = nil
    end

    getgenv().ExozInfJumpConnection = UserInputService.JumpRequest:Connect(function()
        if exoz.Infjump.Enabled then
            local humanoid = getHumanoid()
            local rootPart = getRootPart()
            
            if humanoid and rootPart then
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, exoz.Infjump.Height, rootPart.Velocity.Z)
            end
        end
    end)
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
    Max = 50,
    Default = 16,
    Rounding = 1,
    Callback = function(Value)
        exoz.Speed.Current = Value
    end
})

getgenv().ExozSpeedConnection = RunService.Heartbeat:Connect(function()
    local humanoid = getHumanoid()
    local rootPart = getRootPart()
    
    if humanoid and rootPart and exoz.Speed.Enabled then
        if humanoid.MoveDirection.Magnitude > 0 then
            local delta = RunService.Heartbeat:Wait()
            local moveDirection = humanoid.MoveDirection
            rootPart.CFrame = rootPart.CFrame + (moveDirection * exoz.Speed.Current * delta)
        end
    end
end)

local JumpPowerSection = Tabs.Main:AddSection("Jump Power")

JumpPowerSection:AddToggle("JumpPowerToggle", {
    Title = "Jump Power",
    Default = false,
    Callback = function(Value)
        exoz.Jumppower.Enabled = Value
        Notify("Exoz", "Jump power toggled " .. (Value and "on" or "off"), 2)
    end
})

JumpPowerSection:AddSlider("JumpPowerSlider", {
    Title = "Jump Power Slider",
    Min = 50.145,
    Max = 400,
    Default = 50.145,
    Rounding = 1,
    Callback = function(Value)
        exoz.Jumppower.Current = Value
    end
})

getgenv().ExozJumpPowerConnection = RunService.Heartbeat:Connect(function()
    local humanoid = getHumanoid()
    if humanoid then
        if exoz.Jumppower.Enabled then
            humanoid.JumpPower = exoz.Jumppower.Current
        else
            humanoid.JumpPower = 50.145
        end
    end
end)

local InfJumpSection = Tabs.Main:AddSection("Infinite Jump")

InfJumpSection:AddToggle("InfJumpToggle", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        exoz.Infjump.Enabled = Value
        if Value then
            handleInfiniteJump()
        else
            if getgenv().ExozInfJumpConnection then
                getgenv().ExozInfJumpConnection:Disconnect()
                getgenv().ExozInfJumpConnection = nil
            end
        end
        Notify("Exoz", "Infinite jump toggled " .. (Value and "on" or "off"), 2)
    end
})

InfJumpSection:AddSlider("InfJumpSlider", {
    Title = "Infinite Jump Height",
    Min = 50.145,
    Max = 100,
    Default = 50.145,
    Rounding = 1,
    Callback = function(Value)
        exoz.Infjump.Height = Value
    end
})

handleInfiniteJump()

local GodmodeSection = Tabs.Main:AddSection("Godmode")

GodmodeSection:AddToggle("GodmodeToggle", {
    Title = "Godmode",
    Default = false,
    Callback = function(Value)
        exoz.Godmode.Enabled = Value
        if exoz.Godmode.Enabled then
            disableHitboxes()
            enableKillPartsCollision()
        else
            enableHitboxes()
            restoreKillPartsCollision()
        end
        Notify("Exoz", "Godmode toggled " .. (Value and "on" or "off"), 2)
    end
})

getgenv().ExozGodmodeConnection = player.CharacterAdded:Connect(function(character)
    if exoz.Godmode.Enabled then
        character:WaitForChild("HumanoidRootPart")
        task.wait(0.5)
        disableHitboxes()
        enableKillPartsCollision()
    end
end)

local WinSection = Tabs.Main:AddSection("Win")

WinSection:AddParagraph({Title = "Note:", Content = "Don't use in the first 30 seconds of the round. Anticheat will trigger on you."})

WinSection:AddButton({
    Title = "Win",
    Callback = function()
        local character = player.Character
        local rootPart = getRootPart()
        local finish = Workspace:FindFirstChild("tower")
        if finish then
            finish = finish:FindFirstChild("sections")
            if finish then
                finish = finish:FindFirstChild("finish")
                if finish then
                    finish = finish:FindFirstChild("exit")
                    if finish then
                        local particleBrick = finish:FindFirstChild("ParticleBrick")
                        if particleBrick and rootPart then
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            if humanoid and humanoid.SeatPart then
                                humanoid.Sit = true
                                task.wait(0.1)
                            end
                            
                            disableHitboxes()
                            
                            rootPart.Velocity = Vector3.new(0, 0, 0)
                            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                            
                            local targetCFrame = CFrame.new(particleBrick.Position + Vector3.new(0, 5, 0))
                            
                            local tween = TweenService:Create(rootPart, TweenInfo.new(exoz.Win.Speed, Enum.EasingStyle.Linear), {
                                CFrame = targetCFrame
                            })
                            tween:Play()
                            
                            Notify("Exoz", "Teleporting to finish!", 2)
                            
                            tween.Completed:Connect(function()
                                enableHitboxes()
                                Notify("Exoz", "Won!", 2)
                            end)
                            
                            return
                        end
                    end
                end
            end
        end
        Notify("Exoz", "Finish not found!", 2)
    end
})

WinSection:AddToggle("InstantWinToggle", {
    Title = "Instant",
    Default = false,
    Callback = function(Value)
        if Value then
            exoz.Win.Speed = 0.05
        else
            exoz.Win.Speed = 1
        end
        Notify("Exoz", "Instant Win toggled " .. (Value and "on" or "off"), 2)
    end
})

local AntiSection = Tabs.Visuals:AddSection("Anti")

AntiSection:AddToggle("AntiFogToggle", {
    Title = "Anti Fog",
    Default = false,
    Callback = function(Value)
        exoz.Antifog.Enabled = Value
        local lighting = game:GetService("Lighting")
        if exoz.Antifog.Enabled then
            lighting.FogEnd = 1000000
            lighting.FogStart = 1000000
            Notify("Exoz", "Fog removed!", 2)
        else
            lighting.FogEnd = exoz.TowerOfHell.Fog.fEnd
            lighting.FogStart = exoz.TowerOfHell.Fog.Start
            Notify("Exoz", "Fog restored!", 2)
        end
    end
})

AntiSection:AddToggle("AntiNegativeToggle", {
    Title = "Anti Negative", 
    Default = false,
    Callback = function(Value)
        exoz.Antinegative.Enabled = Value
        local negative = Lighting:FindFirstChild("Negative")
        
        if negative then
            negative.Enabled = not exoz.Antinegative.Enabled
            Notify("Exoz", "Negative effect " .. (exoz.Antinegative.Enabled and "removed!" or "restored!"), 2)
        else
            Notify("Exoz", "No negative effect found!", 2)
        end
    end
})

local AnticheatBypassSection = Tabs.Utility:AddSection("Anticheat Bypass")

AnticheatBypassSection:AddToggle("Disabler", {
    Title = "Disabler",
    Description = "Credits to 7granddadpgn.",
    Default = true,
    Callback = function(Value)
        exoz.Disabler.Enabled = Value
        if exoz.Disabler.Enabled then
            local function characterAdded(char)
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    for _, v in pairs(getconnections(rootPart:GetPropertyChangedSignal('CFrame'))) do
                        if v.Function then
                            v:Disable()
                        end
                    end
                    for _, v in pairs(getconnections(rootPart:GetPropertyChangedSignal('Velocity'))) do
                        if v.Function then
                            v:Disable()
                        end
                    end
                end
            end

            getgenv().ExozDisablerConnection = player.CharacterAdded:Connect(characterAdded)

            if player.Character then
                characterAdded(player.Character)
            end
            
            Notify("Exoz", "Disabler enabled!", 2)
        else
            if getgenv().ExozDisablerConnection then
                getgenv().ExozDisablerConnection:Disconnect()
                getgenv().ExozDisablerConnection = nil
            end
            Notify("Exoz", "Disabler disabled!", 2)
        end
    end
})

AnticheatBypassSection:AddButton({
    Title = "Anti Kick",
    Callback = function()
        Window:Dialog({
            Title   = "Anti Kick",
            Content = "Are you sure you want to enable Anti Kick?",
            Buttons = {
                {
                    Title    = "Confirm",
                    Callback = function()
                        local success, error = pcall(function()
                            local localScript = game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("LocalScript")
                            if localScript then
                                local scriptEnv = getsenv(localScript)
                                if scriptEnv and scriptEnv.kick then
                                    scriptEnv.kick = function()
                                        return
                                    end
                                    Notify("Exoz", "Anti Kick Enabled.", 2)
                                else
                                    Notify("Exoz", "Kick function not found.", 2)
                                end
                            else
                                Notify("Exoz", "LocalScript not found.", 2)
                            end
                        end)
                        
                        if not success then
                            Notify("Exoz", "Failed to enable Anti Kick: " .. tostring(error), 2)
                        end
                    end
                },
                {
                    Title    = "Cancel",
                    Callback = function()
                        Notify("Exoz", "Cancelled Anti Kick toggle.", 2)
                    end
                }
            }
        })
    end
})

local GearsSection = Tabs.Utility:AddSection("Gears")

local lastGearSpawn = 0
for _, gear in pairs(exoz.TowerOfHell.Gears) do
    GearsSection:AddButton({
        Title = gear.Name,
        Callback = function()
            if tick() - lastGearSpawn < 1 then
                Notify("Exoz", "Please wait before spawning more gears", 2)
                return
            end
            lastGearSpawn = tick()
            
            local clone = gear.Event:Clone()
            clone.Parent = player.Backpack
            Notify("Exoz", "Got " .. gear.Name, 2)
        end
    })
end

GearsSection:AddButton({
    Title = "Get All Gears",
    Callback = function()
        if tick() - lastGearSpawn < 2 then
            Notify("Exoz", "Please wait before spawning more gears", 2)
            return
        end
        lastGearSpawn = tick()
        
        for _, gear in pairs(exoz.TowerOfHell.Gears) do
            local clone = gear.Event:Clone()
            clone.Parent = player.Backpack
            task.wait(0.2)
        end
        Notify("Exoz", "Got all gears!", 2)
    end
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
Notify("Exoz", "Loaded ".. gameName .. " script successfully.")
SaveManager:LoadAutoloadConfig()