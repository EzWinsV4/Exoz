-- Dahood patched every silent aim method, enjoy this shit script with no silent aim.

if not game:IsLoaded() then
    game.Loaded:Wait()
end

pcall(function() if getgenv().ExozSpeedConnection then getgenv().ExozSpeedConnection:Disconnect() getgenv().ExozSpeedConnection = nil end end)
pcall(function() if getgenv().ExozFlyConnection then getgenv().ExozFlyConnection:Disconnect() getgenv().ExozFlyConnection = nil end end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local EspLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EzWinsV4/Exoz/refs/heads/main/Library/Esp.lua", true))()
local Options = Fluent.Options
EspLib:Init()
EspLib:SetTeamCheck(false)

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local Mouse = player:GetMouse()

local gameName = "Dahood"
local discord = "https://discord.com/invite/vEFgumaTBA"
local theme = "Rose"

local function getHumanoid()
    local character = player.Character
    if character then
        return character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function getRootPart()
    local character = player.Character
    if character then
        return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    end
    return nil
end

local exoz = {
    Dahood = {
        Anticheat = {
            Remotes = {
                ["TeleportDetect"] = true,
                ["CHECKER_1"] = true,
                ["CHECKER"] = true,
                ["GUI_CHECK"] = true,
                ["OneMoreTime"] = true,
                ["checkingSPEED"] = true,
                ["BANREMOTE"] = true,
                ["PERMAIDBAN"] = true,
                ["KICKREMOTE"] = true,
                ["BR_KICKPC"] = true,
                ["BR_KICKMOBILE"] = true
            }
        },
        StaffList = {
            17215700, 10604500, 2395613299, 29242182, 2212830051,
            99356639, 84570351, 30586516, 4969374172, 149290866,
            5136267958, 6074834798, 170526279, 3944434729, 7001683347,
            328566086, 7389058043, 752396154, 1962396833, 213277245,
            127663566, 8886994638, 212276218, 910085146, 2780817879,
            4799723354, 90717598, 32829903, 2238004736, 7548693589,
            1391585577, 1227049, 368128037, 3055227728, 8195210,
            2327001188, 65217781, 970166262, 315592893, 139852375,
            123597957, 1424338327, 244844600, 69612307, 38079729,
            385530900, 228204181, 89473551, 3146910490, 95397144,
            878279238, 2456939876, 601262307, 186731666, 4337241317,
            1708929528, 1878414563, 133136396, 969098547, 1174637810,
            56602747, 1220684901, 385900233, 91167436, 14921263,
            186480194, 372914675, 86256991, 173500963, 5070197615,
            448012101, 3333755037, 240075378, 3934559413, 1333636279,
            32581425, 336965291, 50801509, 448443585, 3044484840,
            343431112, 524527539, 1446694201, 971662350, 1391475335,
            81720432, 5348287604, 94102158, 948293345, 296295541,
            2269462008, 1523513359, 119770566, 63531881, 534942844,
            1527425585, 2962579319, 893610805, 2278707804, 118842399,
            999511943, 4932403585, 295762020, 654712576, 178740562,
            3894123313, 1662851274, 422314979, 3354916126, 186804856,
            544064867, 2338712284, 21345211, 9221415, 3185389788,
            4061250786, 2693040181, 499671971, 1516086396, 4365585353,
            2320169967, 191961778, 195399682, 4423402956, 225429011,
            224068649, 5832953307, 145740081, 40527673, 14740678,
            3525918505, 5817777160, 971193650, 259420681, 812291,
            1485126185, 2393807480, 1177029768, 1538998338, 3617153442,
            1029137081, 4448767244, 103313777, 175846384, 419293944,
            3192549270, 628662650, 7198900465, 2205951910, 339868684,
            3950637598, 279000539, 4002541497, 439942262, 469524638,
            178663874, 3488718508, 607348662, 359209880, 78295368,
            3790829783, 181751703, 96315796, 2230964929, 133827245,
            665469352, 1570505562, 5476000547, 29761878, 207355228,
            5554615552, 3689221411, 2589966928, 52535762, 3053056654,
            416923057, 406735038, 325087804, 5459075255, 2856873958,
            2521650242, 4727925243, 23337851, 321178532, 5849024706,
            4303763714, 929888317, 4656808630, 473150067, 1679536495,
            4717217397, 2207291, 275686568, 4553168881, 1111528852,
            236304447, 550860854, 3756657101, 3701423181, 4001569683,
            1046851536, 140258990, 8130930626, 1636862322, 1524932728,
            2478082912, 30496644, 3173624, 4773226373, 1682493839,
            3207097146, 3142671140, 4485539731, 932528290, 853410469,
            597408469, 9328040337, 196383060, 1942994410, 122690972,
            864989902, 3296469635, 10550151501, 10645213918, 7470023084,
            10505031738, 163721789, 15427717, 201454243, 822999, 63794379,
            17260230, 28357488, 93101606, 16917269, 85989579, 1553950697,
            476537893, 155627580, 31163456, 7200829, 25717070, 16138978,
            60660789, 1161411094, 9125623, 11319153, 34758833, 194109750,
            35616559, 1257271138, 28885841, 23558830, 4255947062, 3314981799,
            3390225662, 2459178, 2846299656, 2967502742, 7312775547, 352087139,
            542488819, 1830168970
        },
        Shop = {
            {name = "Pizza", price = 6},
            {name = "Chicken", price = 8},
            {name = "Taser", price = 1126},
            {name = "Weights", price = 135},
            {name = "HeavyWeights", price = 281},
            {name = "Popcorn", price = 8},
            {name = "Rifle", price = 1745},
            {name = "Camera", price = 113},
            {name = "Grenade", price = 788},
            {name = "RPG", price = 6753},
            {name = "RPG Ammo", price = 1126},
            {name = "Key", price = 141},
            {name = "Cranberry", price = 3},
            {name = "Flashlight", price = 11},
            {name = "SMG Ammo", price = 68},
            {name = "SMG", price = 844},
            {name = "Double-Barrel SG", price = 1519},
            {name = "Double-Barrel SG Ammo", price = 56},
            {name = "Silencer Ammo", price = 56},
            {name = "Silencer", price = 450},
            {name = "Flashbang", price = 619},
            {name = "AR Ammo", price = 84},
            {name = "AR", price = 1126},
            {name = "Bat", price = 281},
            {name = "Lettuce", price = 6},
            {name = "Revolver", price = 1463},
            {name = "Rifle Ammo", price = 281},
            {name = "Donut", price = 6},
            {name = "Basketball", price = 113},
            {name = "SledgeHammer", price = 394},
            {name = "Hamburger", price = 6},
            {name = "Riot Mask", price = 68},
            {name = "Pitchfork", price = 360},
            {name = "Taco", price = 2},
            {name = "Hockey Mask", price = 68},
            {name = "Lemonade", price = 3},
            {name = "PepperSpray", price = 84},
            {name = "Knife", price = 169},
            {name = "AUG Ammo", price = 90},
            {name = "AUG", price = 2195},
            {name = "P90 Ammo", price = 68},
            {name = "Shotgun", price = 1407},
            {name = "Shotgun Ammo", price = 68},
            {name = "Paintball Mask", price = 68},
            {name = "Revolver Ammo", price = 56},
            {name = "Glock", price = 338},
            {name = "Glock Ammo", price = 68},
            {name = "Flintlock Ammo", price = 168},
            {name = "Flintlock", price = 1463},
            {name = "Medium Armor", price = 1126},
            {name = "Hair Glue", price = 23},
            {name = "Whip", price = 281},
            {name = "Fire Armor", price = 2701},
            {name = "LMG Ammo", price = 338},
            {name = "LMG", price = 4221},
            {name = "BrownBag", price = 28},
            {name = "Shovel", price = 360},
            {name = "Firework", price = 11255},
            {name = "Flowers", price = 6},
            {name = "AK47 Ammo", price = 90},
            {name = "AK47", price = 2532},
            {name = "SilencerAR Ammo", price = 84},
            {name = "SilencerAR", price = 1407},
            {name = "StopSign", price = 338},
            {name = "Skull Mask", price = 68},
            {name = "Pumpkin Mask", price = 68},
            {name = "Drum-Shotgun Ammo", price = 73},
            {name = "Drum-Shotgun", price = 1238},
            {name = "HotDog", price = 9},
            {name = "TearGas", price = 5628},
            {name = "AntiBodies", price = 113},
            {name = "DrumGun Ammo", price = 225},
            {name = "DrumGun", price = 3377},
            {name = "TacticalShotgun", price = 1970},
            {name = "Ninja Mask", price = 68},
            {name = "TacticalShotgun Ammo", price = 68},
            {name = "P90", price = 1126},
            {name = "LockPicker", price = 113},
            {name = "Starblox Latte", price = 6},
            {name = "Surgeon Mask", price = 28},
            {name = "GrenadeLauncher", price = 11255},
            {name = "Pencil", price = 197},
            {name = "High-Medium Armor", price = 2589},
            {name = "GrenadeLauncher Ammo", price = 3377},
            {name = "Original Phone", price = 56},
            {name = "iPhone", price = 675},
            {name = "iPhoneB", price = 675},
            {name = "iPhoneP", price = 675},
            {name = "iPhoneG", price = 675},
            {name = "Orange Phone", price = 450},
            {name = "PinkPhone", price = 450},
            {name = "Da Milk", price = 8},
            {name = "Default Moveset", price = 0},
            --{name = "BloxyCola", price = 11255087}, [[ This is a real item in dahood btw lmfao ]]
            {name = "Flamethrower Ammo", price = 1126},
            {name = "Flamethrower", price = 10130},
            {name = "Tele", price = 169},
            {name = "Old Phone", price = 113},
            {name = "Deagle Ammo", price = 1462},
            {name = "Deagle", price = 11255},
            {name = "FoodsCart", price = 17},
            {name = "Money Gun", price = 875},
            {name = "Breathing Mask", price = 68},
            {name = "Meat", price = 14},
        }
    },
    Speed = {
        Enabled = false,
        Value = 1,
    },
    Fly = {
        Enabled = false,
        Value = 1,
        Up = false,
        Down = false,
    },
    ESP = {
        Enabled = false,
        Box = {
            Enabled = true,
            Filled = false,
            FillColor = Color3.fromRGB(255, 255, 255),
            Transparency = 0.25,
            Outline = true,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        },
        Nametag = false,
        Healthbar = false,
        Armorbar = false,
        Ring = {
            Enabled = false,
            Color = Color3.fromRGB(255, 255, 255),
            Speed = 2.5,
            Height = 3.5,
            Radius = 2.5
        }
    },
    BulletTracers = {
        Enabled = false,
        StartColor = Color3.fromRGB(255, 255, 255),
        EndColor = Color3.fromRGB(255, 255, 255), 
        TracerTexture = "rbxassetid://446111271",
        Life = 0.5
    },
    HitSounds = {
        Enabled = false,
        Volume = 5,
        Sounds = {
            {name = "Neverlose", id = "rbxassetid://6534948092"},
            {name = "Bubble", id = "rbxassetid://6534947588"},
            {name = "Lazer", id = "rbxassetid://130791043"},
            {name = "Pick", id = "rbxassetid://1347140027"},
            {name = "Pop", id = "rbxassetid://198598793"},
            {name = "Rust", id = "rbxassetid://1255040462"},
            {name = "Sans", id = "rbxassetid://3188795283"},
            {name = "Fart", id = "rbxassetid://130833677"},
            {name = "Big", id = "rbxassetid://5332005053"},
            {name = "Vine", id = "rbxassetid://5332680810"},
            {name = "UwU", id = "rbxassetid://8679659744"},
            {name = "Bruh", id = "rbxassetid://4578740568"},
            {name = "Skeet", id = "rbxassetid://5633695679"},
            {name = "Fatality", id = "rbxassetid://6534947869"},
            {name = "Bonk", id = "rbxassetid://5766898159"},
            {name = "Minecraft", id = "rbxassetid://5869422451"},
            {name = "Gamesense", id = "rbxassetid://4817809188"},
            {name = "RIFK7", id = "rbxassetid://9102080552"},
            {name = "Bamboo", id = "rbxassetid://3769434519"},
            {name = "Crowbar", id = "rbxassetid://546410481"},
            {name = "Weeb", id = "rbxassetid://6442965016"},
            {name = "Beep", id = "rbxassetid://8177256015"},
            {name = "Bambi", id = "rbxassetid://8437203821"},
            {name = "Stone", id = "rbxassetid://3581383408"},
            {name = "Old Fatality", id = "rbxassetid://6607142036"},
            {name = "Click", id = "rbxassetid://8053704437"},
            {name = "Ding", id = "rbxassetid://7149516994"},
            {name = "Snow", id = "rbxassetid://6455527632"},
            {name = "Laser", id = "rbxassetid://7837461331"},
            {name = "Mario", id = "rbxassetid://2815207981"},
            {name = "Steve", id = "rbxassetid://4965083997"},
            {name = "Call of Duty", id = "rbxassetid://5952120301"},
            {name = "Bat", id = "rbxassetid://3333907347"},
            {name = "TF2 Critical", id = "rbxassetid://296102734"},
            {name = "Saber", id = "rbxassetid://8415678813"},
            {name = "Baimware", id = "rbxassetid://3124331820"},
            {name = "Osu", id = "rbxassetid://7149255551"},
            {name = "TF2", id = "rbxassetid://2868331684"},
            {name = "Slime", id = "rbxassetid://6916371803"},
            {name = "Among Us", id = "rbxassetid://5700183626"},
            {name = "One", id = "rbxassetid://7380502345"},
        },
        Active = {
            ID = "rbxassetid://6534948092"
        }
    },
    StaffDetector = {
        Enabled = true,
        Leave = false,
        StaffOnline = {}
    },
    AntiStomp = {
        Enabled = false,
    },
    Target = {
        Player = nil,
        ForceHit = {
            Enabled = false,
            isMouseDown = false
        },
        Highlight = {
            Enabled = false
        },
        Viewing = false,
        AutoKill = false
    }
}

local function Notify(title, desc, time)
    Fluent:Notify({Title = title, Content = desc, Duration = time or 5})
end

local function Notify2(title, desc, subdesc, time)
    Fluent:Notify({Title = title, Content = desc, SubContent = subdesc, Duration = time or 5})
end

local Window = Fluent:CreateWindow({
    Title = "Exoz",
    SubTitle = gameName,
    TabWidth = 140,
    Size = UDim2.fromOffset(780, 460),
    Acrylic = false,
    Theme = theme,
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({Title = "Main", Icon = "skull"}),
    Combat = Window:AddTab({Title = "Combat", Icon = "swords"}),
    Visuals = Window:AddTab({Title = "Visuals", Icon = "eye"}),
    Utility = Window:AddTab({Title = "Utility", Icon = "wrench"}),
    Target = Window:AddTab({Title = "Target", Icon = "target"}),
    --Purchase = Window:AddTab({Title = "Purchase", Icon = "shopping-cart"}),
    --Teleports = Window:AddTab({Title = "Teleports", Icon = "pin"}),
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
    Callback = function(v)
        exoz.Speed.Enabled = v
    end
})

SpeedSection:AddSlider("SpeedSlider", {
    Title = "Speed Slider",
    Min = 1,
    Max = 250,
    Default = 1,
    Rounding = 1,
    Callback = function(v)
        exoz.Speed.Value = v * 2
    end
})

getgenv().ExozSpeedConnection = RunService.Heartbeat:Connect(function(delta)
    if not exoz.Speed.Enabled then return end
    local humanoid = getHumanoid()
    local rootPart = getRootPart()
    if humanoid and rootPart and humanoid.MoveDirection.Magnitude > 0 then
        rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * exoz.Speed.Value * delta)
    end
end)

local FlySection = Tabs.Main:AddSection("Fly")

FlySection:AddToggle("FlyToggle", {
    Title = "Fly",
    Default = false,
    Callback = function(v)
        exoz.Fly.Enabled = v
        local humanoid = getHumanoid()
        local rootPart = getRootPart()
        if humanoid then
            humanoid.PlatformStand = v
        end
        if not v and rootPart then
            rootPart.AssemblyLinearVelocity = Vector3.zero
        end
    end
})

FlySection:AddSlider("FlySlider", {
    Title = "Fly Speed",
    Min = 1,
    Max = 250,
    Default = 50,
    Rounding = 1,
    Callback = function(v)
        exoz.Fly.Value = v * 2.5
    end
})

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Space then exoz.Fly.Up = true end
    if input.KeyCode == Enum.KeyCode.LeftShift then exoz.Fly.Down = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then exoz.Fly.Up = false end
    if input.KeyCode == Enum.KeyCode.LeftShift then exoz.Fly.Down = false end
end)

getgenv().ExozFlyConnection = RunService.Heartbeat:Connect(function(delta)
    if not exoz.Fly.Enabled then return end
    local humanoid = getHumanoid()
    local rootPart = getRootPart()
    if not humanoid or not rootPart then return end
    humanoid.PlatformStand = true
    rootPart.AssemblyLinearVelocity = Vector3.zero
    local flyVector = humanoid.MoveDirection
    if exoz.Fly.Up then
        flyVector = flyVector + Vector3.new(0, 1, 0)
    elseif exoz.Fly.Down then
        flyVector = flyVector + Vector3.new(0, -1, 0)
    end
    if flyVector.Magnitude > 0 then
        if not humanoid or not rootPart then return end
        rootPart.CFrame = rootPart.CFrame + (flyVector.Unit * exoz.Fly.Value * delta)
    end
end)

local RapidFireSection = Tabs.Combat:AddSection("Rapid Fire")

RapidFireSection:AddToggle("RapidFireToggle", {
    Title = "Rapid Fire",
    Default = false,
    Callback = function(v)
        if v then
            Notify("Exoz", "Scammer get scammed >.<", 7)
        end
    end
})

local WallbangSection = Tabs.Combat:AddSection("Wallbang")

WallbangSection:AddToggle("WallbangToggle", {
    Title = "Wallbang",
    Default = false,
    Callback = function(v)
        if v then
            Notify("Exoz", "Scammer get scammed >.<", 7)
        end
    end
})

local ESPSection = Tabs.Visuals:AddSection("ESP")

local function UpdateESP()
    EspLib:SetBox(
        exoz.ESP.Enabled and exoz.ESP.Box.Enabled,
        exoz.ESP.Box.Color,
        exoz.ESP.Box.Filled,
        exoz.ESP.Box.FillColor,
        exoz.ESP.Box.Transparency,
        exoz.ESP.Box.Outline,
        exoz.ESP.Box.OutlineColor
    )
    if exoz.ESP.Enabled then
        EspLib:SetNametag(exoz.ESP.Nametag)
    else
        EspLib:SetNametag(nil)
    end
    if exoz.ESP.Enabled then
        EspLib:SetHealthbar(exoz.ESP.Healthbar)
    else
        EspLib:SetHealthbar(nil)
    end
    if exoz.ESP.Enabled then
        EspLib:SetArmorbar(exoz.ESP.Armorbar)
    else
        EspLib:SetArmorbar(nil)
    end
    EspLib:SetRing(
        exoz.ESP.Enabled and exoz.ESP.Ring.Enabled,
        exoz.ESP.Ring.Color,
        exoz.ESP.Ring.Speed,
        exoz.ESP.Ring.Height,
        exoz.ESP.Ring.Radius
    )
end

ESPSection:AddToggle("ESPToggle", {
    Title = "ESP",
    Default = false,
    Callback = function(v)
        exoz.ESP.Enabled = v
        UpdateESP()
    end
})

ESPSection:AddToggle("BoxToggle", {
    Title = "Box",
    Default = true,
    Callback = function(v)
        exoz.ESP.Box.Enabled = v
        UpdateESP()
    end
})

ESPSection:AddColorpicker("FillColorColorpicker", {
    Title = "Fill Color",
    Default = exoz.ESP.Box.FillColor,
    Callback = function(v)
        exoz.ESP.Box.FillColor = v
        UpdateESP()
    end
})

ESPSection:AddToggle("BoxFilledToggle", {
    Title = "Filled",
    Default = false,
    Callback = function(v)
        exoz.ESP.Box.Filled = v
        UpdateESP()
    end
})

ESPSection:AddSlider("FillTransparencySlider", {
    Title = "Fill Transparency",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Rounding = 2,
    Callback = function(v)
        exoz.ESP.Box.Transparency = v
        UpdateESP()
    end
})

ESPSection:AddColorpicker("OutlineColorColorpicker", {
    Title = "Outline Color",
    Default = exoz.ESP.Box.OutlineColor,
    Callback = function(v)
        exoz.ESP.Box.OutlineColor = v
        UpdateESP()
    end
})

ESPSection:AddToggle("OutlineToggle", {
    Title = "Outline",
    Default = true,
    Callback = function(v)
        exoz.ESP.Box.Outline = v
        UpdateESP()
    end
})

ESPSection:AddToggle("NametagToggle", {
    Title = "Nametag",
    Default = false,
    Callback = function(v)
        exoz.ESP.Nametag = v
        UpdateESP()
    end
})

ESPSection:AddToggle("HealthbarToggle", {
    Title = "Healthbar",
    Default = false,
    Callback = function(v)
        exoz.ESP.Healthbar = v
        UpdateESP()
    end
})

ESPSection:AddToggle("ArmorbarToggle", {
    Title = "Armorbar",
    Default = false,
    Callback = function(v)
        exoz.ESP.Armorbar = v
        UpdateESP()
    end
})

ESPSection:AddToggle("RingToggle", {
    Title = "Ring",
    Default = false,
    Callback = function(v)
        exoz.ESP.Ring.Enabled = v
        UpdateESP()
    end
})

ESPSection:AddColorpicker("RingColorColorpicker", {
    Title = "Ring Color",
    Default = exoz.ESP.Ring.Color,
    Callback = function(v)
        exoz.ESP.Ring.Color = v
        UpdateESP()
    end
})

ESPSection:AddSlider("RingSpeedSlider", {
    Title = "Ring Speed",
    Min = 0.5,
    Max = 10,
    Default = 2.5,
    Rounding = 1,
    Callback = function(v)
        exoz.ESP.Ring.Speed = v
        UpdateESP()
    end
})

ESPSection:AddSlider("RingHeightSlider", {
    Title = "Ring Height",
    Min = 1,
    Max = 10,
    Default = 3.5,
    Rounding = 1,
    Callback = function(v)
        exoz.ESP.Ring.Height = v
        UpdateESP()
    end
})

UpdateESP()

local BulletSection = Tabs.Visuals:AddSection("Bullet")

local tracerContainer = Instance.new("Folder", workspace)
tracerContainer.Name = "ExozBulletTracers"

local function CreateTracer(startPosition, endPosition)
    if not exoz.BulletTracers.Enabled then return end

    local startPart = Instance.new("Part", tracerContainer)
    startPart.Size = Vector3.new(0,0,0)
    startPart.Transparency = 1
    startPart.CanCollide = false
    startPart.Anchored = true
    startPart.Position = startPosition

    local endPart = Instance.new("Part", tracerContainer)
    endPart.Size = Vector3.new(0,0,0)
    endPart.Transparency = 1
    endPart.CanCollide = false
    endPart.Anchored = true
    endPart.Position = endPosition

    local att0 = Instance.new("Attachment", startPart)
    local att1 = Instance.new("Attachment", endPart)

    local beam = Instance.new("Beam", startPart)
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(exoz.BulletTracers.StartColor, exoz.BulletTracers.EndColor)
    beam.Width0 = 1
    beam.Width1 = 1
    beam.Texture = exoz.BulletTracers.TracerTexture
    beam.Transparency = NumberSequence.new(0)

    task.delay(exoz.BulletTracers.Life, function()
        startPart:Destroy()
        endPart:Destroy()
    end)
end

local ChildAdded = workspace.Ignored.Siren.Radius.ChildAdded:Connect(function(Object)
    if Object.Name == "BULLET_RAYS" then
        local ownerCharacterName = Object:GetAttribute("OwnerCharacter")
        if ownerCharacterName and ownerCharacterName == player.Name then
            local startPosition = Object.CFrame.Position
            local lookVector = Object.CFrame.LookVector

            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.IgnoreWater = true
            raycastParams.FilterDescendantsInstances = {player.Character}

            local ray = workspace:Raycast(startPosition, lookVector * 1000, raycastParams)
            if ray then
                local endPos = ray.Position
                CreateTracer(startPosition, endPos)
            end
        end
    end
end)

BulletSection:AddToggle("BulletTracerToggle", {
    Title = "Bullet Tracers",
    Default = false,
    Callback = function(v)
        exoz.BulletTracers.Enabled = v
    end
})

BulletSection:AddColorpicker("BulletTracerStartColorpicker", {
    Title = "Bullet Tracer Start Color",
    Default = exoz.BulletTracers.StartColor,
    Callback = function(v)
        exoz.BulletTracers.StartColor = v
    end
})

BulletSection:AddColorpicker("BulletTracerEndColorpicker", {
    Title = "Bullet Tracer End Color",
    Default = exoz.BulletTracers.EndColor,
    Callback = function(v)
        exoz.BulletTracers.EndColor = v
    end
})

BulletSection:AddSlider("BulletTracerLifetime", {
    Title = "Bullet Tracer Lifetime",
    Min = 0.1,
    Max = 5,
    Default = exoz.BulletTracers.Life,
    Rounding = 1,
    Callback = function(v)
        exoz.BulletTracers.Life = v
    end
})

getgenv().ExozBulletTracersConnection = RunService.Heartbeat:Connect(function()
    if exoz.BulletTracers.Enabled then
        for _, child in pairs(workspace.Ignored.Siren.Radius:GetChildren()) do
            if child.Name == "BULLET_RAYS" then
                child:Destroy()
            end
        end
    end
end)

local HitSection = Tabs.Visuals:AddSection("Hit")

local activeSounds = {}

local function createHitSound(targetPosition)
    if not exoz.HitSounds.Enabled then return end
    if not exoz.HitSounds.Active.ID then return end

    local soundPart = Instance.new("Part")
    soundPart.Size = Vector3.new(1, 1, 1)
    soundPart.Transparency = 1
    soundPart.CanCollide = false
    soundPart.Anchored = true
    soundPart.Position = targetPosition
    soundPart.Parent = workspace
    
    local audio = Instance.new("Sound")
    audio.Parent = soundPart
    audio.SoundId = exoz.HitSounds.Active.ID
    audio.Volume = exoz.HitSounds.Volume
    audio:Play()
    
    table.insert(activeSounds, soundPart)
    
    local function cleanup()
        if soundPart and soundPart.Parent then
            soundPart:Destroy()
        end
        for i, v in ipairs(activeSounds) do
            if v == soundPart then
                table.remove(activeSounds, i)
                break
            end
        end
    end
    
    audio.Ended:Connect(cleanup)
    
    task.delay(3, cleanup)
end

local HitSoundsList = {"None"}

for _, sound in ipairs(exoz.HitSounds.Sounds) do
    table.insert(HitSoundsList, sound.name)
end

HitSection:AddDropdown("HitSoundsDropdown", {
    Title = "Change Hit Sound",
    Values = HitSoundsList,
    Multi = false,
    Default = 1,
    Callback = function(selected)
        if selected == "None" then
            exoz.HitSounds.Active.ID = nil
            return
        end

        for _, sound in ipairs(exoz.HitSounds.Sounds) do
            if sound.name == selected then
                exoz.HitSounds.Active.ID = sound.id
                break
            end
        end
    end
})

HitSection:AddToggle("HitSoundsToggle", {
    Title = "Hit Sounds",
    Default = false,
    Callback = function(v)
        exoz.HitSounds.Enabled = v
    end
})

HitSection:AddSlider("HitSoundsVolume", {
    Title = "Volume",
    Min = 1,
    Max = 10,
    Default = 5,
    Rounding = 1,
    Callback = function(v)
        exoz.HitSounds.Volume = v
    end
})

local bulletConnection = workspace.Ignored.Siren.Radius.ChildAdded:Connect(function(Object)
    if not exoz.HitSounds.Enabled then return end
    if Object.Name == "BULLET_RAYS" then
        local ownerCharacterName = Object:GetAttribute("OwnerCharacter")
        if ownerCharacterName and ownerCharacterName == player.Name then
            local startPosition = Object.CFrame.Position
            local lookVector = Object.CFrame.LookVector
            
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.IgnoreWater = true
            raycastParams.FilterDescendantsInstances = {player.Character}
            
            local ray = workspace:Raycast(startPosition, lookVector * 1000, raycastParams)
            if ray and ray.Instance then
                local hitPlayer = Players:GetPlayerFromCharacter(ray.Instance:FindFirstAncestorOfClass("Model"))
                if hitPlayer and hitPlayer ~= player then
                    local hitPosition = ray.Position
                    task.spawn(function()
                        createHitSound(hitPosition)
                    end)
                end
            end
        end
    end
end)

local AnticheatBypassSection = Tabs.Utility:AddSection("Anticheat")

getgenv().HookedAnticheat = false

AnticheatBypassSection:AddButton({
    Title = "Anticheat Block",
    Callback = function()
        Window:Dialog({
            Title   = "Anticheat Block",
            Content = "Are you sure you want to enable Anticheat Block?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        coroutine.wrap(function()
                            if getgenv().HookedAnticheat then
                                Notify("Exoz", "Anticheat already hooked.", 3)
                                return
                            end

                            local success, err = pcall(function()
                                local grmt = getrawmetatable(game)
                                setreadonly(grmt, false)
                                local old = grmt.__namecall

                                getgenv().HookedAnticheat = true

                                grmt.__namecall = newcclosure(function(self, ...)
                                    local method = getnamecallmethod()
                                    
                                    if not self or typeof(self) ~= "Instance" then
                                        return old(self, ...)
                                    end

                                    if method ~= "FireServer" and method ~= "InvokeServer" then
                                        return old(self, ...)
                                    end

                                    local remotes = exoz.Dahood.Anticheat.Remotes
                                    local name = self.Name

                                    if remotes[name] and method == "FireServer" then
                                        return nil
                                    end

                                    return old(self, ...)
                                end)

                                setreadonly(grmt, true)
                            end)

                            if not success then
                                getgenv().HookedAnticheat = falses
                                Notify("Exoz", "Executor can't handle this.", 7)
                            else
                                Notify("Exoz", "Anticheat blocked successfully.", 5)
                            end
                        end)()
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        Notify("Exoz", "Cancelled Anticheat Block toggle.", 2)
                    end
                }
            }
        })
    end
})

local StaffSection = Tabs.Utility:AddSection("Staff Detector")

local isStaff = function(p)
    for _, id in ipairs(exoz.Dahood.StaffList) do
        if p.UserId == id then return true end
    end
    return false
end

local function exit()
    player:Kick("Exoz Staff detector - Auto left game.")
end

StaffSection:AddToggle("StaffDetectorToggle", {
    Title = "Staff Detector",
    Default = true,
    Callback = function(v)
        exoz.StaffDetector.Enabled = v
        if not v then
            exoz.StaffDetector.StaffOnline = {}
        end
    end
})

StaffSection:AddToggle("ExitToggle", {
    Title = "Exit On Staff Detected",
    Default = false,
    Callback = function(v)
        exoz.StaffDetector.Leave = v
    end
})

Players.PlayerAdded:Connect(function(player)
    task.wait(1)
    if isStaff(player) and exoz.StaffDetector.Enabled then
        exoz.StaffDetector.StaffOnline[player.UserId] = {
            Name = player.Name,
            Id = player.UserId
        }
        Notify2("Exoz", "Staff detector - A staff member has joined this server!", "Staff: " .. player.Name .. " (" .. player.UserId .. ")", 120)
        if exoz.StaffDetector.Leave then
            exit()
        end
    end
end)

getgenv().ExozStaffConnection = RunService.Heartbeat:Connect(function()
    if not exoz.StaffDetector.Enabled then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if isStaff(player) and not exoz.StaffDetector.StaffOnline[player.UserId] then
            exoz.StaffDetector.StaffOnline[player.UserId] = {
                Name = player.Name,
                Id = player.UserId
            }
            Notify2("Exoz", "Staff detector - A staff member is in this server!", "Staff: " .. player.Name .. " (" .. player.UserId .. ")", 120)
            if exoz.StaffDetector.Leave then
                exit()
            end
        end
    end
end)

local AntiStompSection = Tabs.Utility:AddSection("Anti Stomp")
local tweenSpeed = 0.3

local antiStompBusy = false

local function antiStomp()
    if not exoz.AntiStomp.Enabled then return end
    if antiStompBusy then return end

    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    local bodyEffects = character:FindFirstChild("BodyEffects")

    if not humanoid or not root or not bodyEffects then return end

    local knocked = bodyEffects:FindFirstChild("K.O")
    if not knocked or not knocked.Value then return end

    antiStompBusy = true

    local savedPosition = root.CFrame
    humanoid.Health = 0

    local newCharacter = player.CharacterAdded:Wait()
    local newHumanoid = newCharacter:WaitForChild("Humanoid")
    local newRoot = newCharacter:WaitForChild("HumanoidRootPart")

    task.wait(0.3)

    local oldState = newHumanoid:GetStateEnabled(Enum.HumanoidStateType.Seated)
    newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    if newHumanoid.SeatPart then
        newHumanoid.Sit = false
        task.wait(0.1)
    end

    if exoz.AntiStomp.Flashback then
        pcall(function()
            newRoot.CFrame = savedPosition + Vector3.new(0, 3, 0)
        end)
    end

    if type(oldState) == "boolean" then
        newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, oldState)
    end

    repeat
        task.wait(0.2)
        character = player.Character
        if not character then break end
        bodyEffects = character:FindFirstChild("BodyEffects")
        knocked = bodyEffects and bodyEffects:FindFirstChild("K.O")
    until not knocked or not knocked.Value

    antiStompBusy = false
end

AntiStompSection:AddToggle("AntiStompToggle", {
    Title = "Anti Stomp",
    Default = false,
    Callback = function(v)
        exoz.AntiStomp.Enabled = v
    end
})

AntiStompSection:AddToggle("FlashbackToggle", {
    Title = "Flashback",
    Default = false,
    Callback = function(v)
        exoz.AntiStomp.Flashback = v
    end
})

task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(antiStomp)
    end
end)

local DesyncSection = Tabs.Utility:AddSection("Desync")

DesyncSection:AddToggle("DesyncToggle", {
    Title = "Desync",
    Default = false,
    Callback = function(v)
        if v then
            Notify("Exoz", "Scammer get scammed >.<")
        end
    end
})

local SelectSection = Tabs.Target:AddSection("Select Target")

PlayerMap = {}

local function getPlayerList()
    local list = {}
    PlayerMap = {}

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local display = p.DisplayName .. " (" .. p.Name .. ")"
            table.insert(list, display)
            PlayerMap[display] = p
        end
    end
    return list
end

local PlayerDropdown = SelectSection:AddDropdown("PlayerListDropdown", {
    Title = "Select Target",
    Values = getPlayerList(),
    Multi = false,
    Default = nil,
    Callback = function(v)
        local targetPlayer = PlayerMap[v]
        if targetPlayer then
            exoz.Target.Player = targetPlayer
            Notify("Exoz", "Target Selected: " .. targetPlayer.Name)
        end
    end
})

local function refreshDropdown()
    if PlayerDropdown then
        local newList = getPlayerList()
        PlayerDropdown:SetValues(newList)
        
        if exoz.Target.Player and not Players:FindFirstChild(exoz.Target.Player.Name) then
            exoz.Target.Player = nil
        end
    end
end

SelectSection:AddButton({
    Title = "Refresh Dropdown",
    Callback = function()
        refreshDropdown()
    end
})

local debounce = false
Players.PlayerAdded:Connect(function()
    if not debounce then
        debounce = true
        task.wait(1)
        refreshDropdown()
        debounce = false
    end
end)

Players.PlayerRemoving:Connect(function()
    if not debounce then
        debounce = true
        task.wait(1)
        refreshDropdown()
        debounce = false
    end
end)

task.wait(1)
refreshDropdown()

local InfoSection = Tabs.Target:AddSection("Target Info")

InfoSection:AddButton({
    Title = "Show Target Info",
    Callback = function()
        local target = exoz.Target.Player
        if not target then
            Notify("Exoz", "No target selected.", 3)
            return
        end

        local character = target.Character or target.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 3)
        local bodyEffects = character:FindFirstChild("BodyEffects") or character:WaitForChild("BodyEffects", 3)
        local dataFolder = target:FindFirstChild("DataFolder") or target:WaitForChild("DataFolder", 3)

        local username = target.Name
        local displayname = target.DisplayName
        local userid = target.UserId
        local health = humanoid and humanoid.Health or "N/A"

        local armor = bodyEffects and bodyEffects:FindFirstChild("Armor") and bodyEffects.Armor.Value or 0
        local fireArmor = bodyEffects and bodyEffects:FindFirstChild("FireArmor") and bodyEffects.FireArmor.Value or 0
        local knocked = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value or false
        local jailed = bodyEffects and bodyEffects:FindFirstChild("Cuff") and bodyEffects.Cuff.Value or false

        local money = dataFolder and dataFolder:FindFirstChild("Currency") and dataFolder.Currency.Value or 0
        local reportCount = dataFolder and dataFolder:FindFirstChild("ReportedCount") and dataFolder.ReportedCount.Value or 0

        local staff = false
        for _, id in ipairs(exoz.Dahood.StaffList) do
            if target.UserId == id then
                staff = true
                break
            end
        end

        Notify("Exoz", "Username: ".. username, 15)
        Notify("Exoz", "Display Name: ".. displayname, 15)
        Notify("Exoz", "User ID: ".. userid, 15)
        Notify("Exoz", "Health: ".. health, 15)
        Notify("Exoz", "Armor: ".. armor, 15)
        Notify("Exoz", "Fire Armor: ".. fireArmor, 15)
        Notify("Exoz", "Knocked: ".. tostring(knocked), 15)
        Notify("Exoz", "Jailed: ".. tostring(jailed), 15)
        Notify("Exoz", "Money: ".. tostring(money), 15)
        Notify("Exoz", "Reported: ".. tostring(reportCount), 15)
        Notify("Exoz", "Staff: ".. tostring(staff), 15)
    end
})

local ActionSection = Tabs.Target:AddSection("Actions")

local currentHighlight = nil
local highlightConnection = nil

ActionSection:AddToggle("HighlightTargetToggle", {
    Title = "Highlight Target",
    Default = false,
    Callback = function(v)
        if v then
            if highlightConnection then
                highlightConnection:Disconnect()
                highlightConnection = nil
            end
            
            highlightConnection = RunService.Heartbeat:Connect(function()
                if not exoz.Target.Highlight.Enabled then return end

                local target = exoz.Target.Player
                if target and target.Character then 
                    if not currentHighlight then 
                        currentHighlight = Instance.new("Highlight")
                        currentHighlight.FillTransparency = 0.5
                        currentHighlight.OutlineTransparency = 0.25
                        currentHighlight.FillColor = Color3.fromRGB(255, 50, 90)
                    end
                    currentHighlight.Adornee = target.Character
                    currentHighlight.Parent = target.Character
                elseif currentHighlight then
                    currentHighlight:Destroy()
                    currentHighlight = nil
                end
            end)

            exoz.Target.Highlight.Enabled = true
        else
            exoz.Target.Highlight.Enabled = false
            if highlightConnection then
                highlightConnection:Disconnect()
                highlightConnection = nil
            end
            if currentHighlight then
                currentHighlight:Destroy()
                currentHighlight = nil
            end
        end
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
Notify("Exoz", "Your rank is: [EXOZ OWNER]")
SaveManager:LoadAutoloadConfig()
