local MacLib = loadstring(game:HttpGet("https://github.com/biggaboy212/Maclib/releases/latest/download/maclib.txt"))()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

pcall(function() if getgenv().ExozSpeedConnection then getgenv().ExozSpeedConnection:Disconnect() getgenv().ExozSpeedConnection = nil end end)
pcall(function() if getgenv().ExozFlyConnection then getgenv().ExozFlyConnection:Disconnect() getgenv().ExozFlyConnection = nil end end)

local EspLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EzWinsV4/Exoz/refs/heads/main/Library/Esp.lua", true))()
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
        Value = 50,
        Up = false,
        Down = false,
    },
    SilentAim = {
        Enabled = false,
        Method = "GunHandler",
        Mode = "Mouse",
        FOVRadius = 100,
        FOVVisible = true,
        TeamCheck = false,
        VisibleCheck = false,
        TargetPart = "Head",
        HitChance = 100,
        GunHandlerHooked = false,
        OriginalGetAim = nil,
        RemoteEvent = nil,
        isMouseDown = false,
        RemoteConnection = nil,
        InputConnected = false
    },
    Aimlock = {
        Enabled = false,
        Active = false,
        Target = nil,
        TargetPart = "Head",
        WallCheck = true,
        Smoothness = 0.45,
        RequireRightClick = false,
        FOV = {
            Visible = true,
            Radius = 100,
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Transparency = 0.5,
            Filled = false
        }
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
        Flashback = false
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
    },
    RapidFire = {
        Enabled = false
    },
    Wallbang = {
        Enabled = false
    },
    NoRecoil = {
        Enabled = false
    },
    AutoFarm = {
        Enabled = false,
        ToolName = "Combat",
        CollectionRadius = 20,
        AttackDelay = 0.2,
        AttackTimeout = 10,
        HopWhenNoCashiers = true,
        RandomDelays = true
    },
    Desync = {
        Enabled = false,
        Hook = nil,
    }
}

local Window = MacLib:Window({
    Title = "Exoz",
    Subtitle = gameName,
    Size = UDim2.fromOffset(900, 650),
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

local function Notify2(title, desc, subdesc, time)
    Window:Notify({
        Title = title,
        Description = desc .. " | " .. subdesc,
        Lifetime = time or 5
    })
end

local tabGroups = {
    TabGroup1 = Window:TabGroup(),
    TabGroup2 = Window:TabGroup()
}

local tabs = {
    Main = tabGroups.TabGroup1:Tab({ Name = "Main", Image = "rbxassetid://101060850237115" }),
    Combat = tabGroups.TabGroup1:Tab({ Name = "Combat", Image = "rbxassetid://99199363807265" }),
    Visuals = tabGroups.TabGroup1:Tab({ Name = "Visuals", Image = "rbxassetid://127234874352422" }),
    Utility = tabGroups.TabGroup1:Tab({ Name = "Utility", Image = "rbxassetid://85345725497834" }),
    Target = tabGroups.TabGroup1:Tab({ Name = "Target", Image = "rbxassetid://121091323240554" }),
    Purchase = tabGroups.TabGroup1:Tab({ Name = "Purchase", Image = "rbxassetid://110161824939086" }),
    Teleports = tabGroups.TabGroup1:Tab({ Name = "Teleports", Image = "rbxassetid://137091405832737" }),
    Credits = tabGroups.TabGroup2:Tab({ Name = "Credits", Image = "rbxassetid://75851496262862" }),
    Settings = tabGroups.TabGroup2:Tab({ Name = "Settings", Image = "rbxassetid://10734950309" })
}

local sections = {
    Speed = tabs.Main:Section({ Side = "Left" }),
    Fly = tabs.Main:Section({ Side = "Right" }),
    SilentAim = tabs.Combat:Section({ Side = "Left" }),
    Aimlock = tabs.Combat:Section({ Side = "Right" }),
    RapidFire = tabs.Combat:Section({ Side = "Left" }),
    Wallbang = tabs.Combat:Section({ Side = "Right" }),
    NoRecoil = tabs.Combat:Section({ Side = "Left" }),
    ESP = tabs.Visuals:Section({ Side = "Left" }),
    Bullet = tabs.Visuals:Section({ Side = "Right" }),
    Hit = tabs.Visuals:Section({ Side = "Right" }),
    Anticheat = tabs.Utility:Section({ Side = "Left" }),
    Staff = tabs.Utility:Section({ Side = "Right" }),
    AntiStomp = tabs.Utility:Section({ Side = "Left" }),
    Desync = tabs.Utility:Section({ Side = "Right" }),
    AutoFarm = tabs.Utility:Section({ Side = "Left" }),
    Select = tabs.Target:Section({ Side = "Left" }),
    Info = tabs.Target:Section({ Side = "Right" }),
    Actions = tabs.Target:Section({ Side = "Left" }),
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
    Callback = function(v)
        exoz.Speed.Enabled = v
    end
}, "SpeedToggle")

sections.Speed:Slider({
    Name = "Speed Slider",
    Default = 1,
    Minimum = 1,
    Maximum = 250,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(v)
        exoz.Speed.Value = v * 2
    end
}, "SpeedSlider")

getgenv().ExozSpeedConnection = RunService.Heartbeat:Connect(function(delta)
    if not exoz.Speed.Enabled then return end
    local humanoid = getHumanoid()
    local rootPart = getRootPart()
    if humanoid and rootPart and humanoid.MoveDirection.Magnitude > 0 then
        rootPart.CFrame = rootPart.CFrame + (humanoid.MoveDirection * exoz.Speed.Value * delta)
    end
end)

sections.Fly:Header({ Name = "Fly" })

sections.Fly:Toggle({
    Name = "Fly",
    Default = false,
    Callback = function(v)
        exoz.Fly.Enabled = v
        local humanoid = getHumanoid()
        local rootPart = getRootPart()
        if humanoid then
            humanoid.PlatformStand = v
            if not v then
                humanoid.AutoRotate = true
            end
        end
        if not v and rootPart then
            rootPart.AssemblyLinearVelocity = Vector3.zero
        end
    end
}, "FlyToggle")

sections.Fly:Slider({
    Name = "Fly Speed",
    Default = 50,
    Minimum = 1,
    Maximum = 250,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(v)
        exoz.Fly.Value = v * 2.5
    end
}, "FlySlider")

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Space then exoz.Fly.Up = true end
    if input.KeyCode == Enum.KeyCode.LeftShift then exoz.Fly.Down = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then exoz.Fly.Up = false end
    if input.KeyCode == Enum.KeyCode.LeftShift then exoz.Fly.Down = false end
end)

local smoothVelocity = Vector3.zero
local camera = workspace.CurrentCamera

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

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = exoz.SilentAim.FOVRadius
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.ZIndex = 999

local function CalculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.random(1, 100)
    return chance <= Percentage
end

local function GetMousePosition()
    return UserInputService:GetMouseLocation()
end

local function GetPositionOnScreen(Vector)
    local Vec3, OnScreen = Camera:WorldToViewportPoint(Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function IsPlayerVisible(TargetPlayer)
    local PlayerCharacter = TargetPlayer.Character
    local LocalPlayerCharacter = player.Character
    
    if not (PlayerCharacter and LocalPlayerCharacter) then return false end
    
    local TargetPartInstance = PlayerCharacter:FindFirstChild("Head") or PlayerCharacter:FindFirstChild("HumanoidRootPart")
    if not TargetPartInstance then return false end
    
    local CastPoints = {TargetPartInstance.Position, LocalPlayerCharacter, PlayerCharacter}
    local IgnoreList = {LocalPlayerCharacter, PlayerCharacter}
    
    local success, result = pcall(function()
        return #Camera:GetPartsObscuringTarget(CastPoints, IgnoreList)
    end)
    
    if not success then return false end
    
    return result == 0
end

local function GetTargetPartInstance(Character)
    local targetPart = exoz.SilentAim.TargetPart
    if targetPart == "Head" then
        return Character:FindFirstChild("Head")
    elseif targetPart == "HumanoidRootPart" then
        return Character:FindFirstChild("HumanoidRootPart")
    end
    return Character:FindFirstChild("Head")
end

local function GetClosestPlayerToMouse()
    local Closest = nil
    local ClosestDistance = exoz.SilentAim.FOVRadius
    local MousePos = GetMousePosition()
    
    for _, TargetPlayer in pairs(Players:GetPlayers()) do
        if TargetPlayer == player then continue end
        if exoz.SilentAim.TeamCheck and TargetPlayer.Team == player.Team then continue end
        
        local Character = TargetPlayer.Character
        if not Character then continue end
        
        if exoz.SilentAim.VisibleCheck and not IsPlayerVisible(TargetPlayer) then continue end
        
        local TargetInstance = GetTargetPartInstance(Character)
        if not TargetInstance then continue end
        
        local Humanoid = Character:FindFirstChild("Humanoid")
        if not Humanoid or Humanoid.Health <= 0 then continue end
        
        local ScreenPos, OnScreen = GetPositionOnScreen(TargetInstance.Position)
        if not OnScreen then continue end
        
        local Distance = (MousePos - ScreenPos).Magnitude
        
        if Distance <= ClosestDistance then
            Closest = TargetInstance
            ClosestDistance = Distance
        end
    end
    
    return Closest
end

local function GetClosestPlayerToPosition()
    local Closest = nil
    local ClosestDistance = math.huge
    local localRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if not localRoot then return nil end
    
    for _, TargetPlayer in pairs(Players:GetPlayers()) do
        if TargetPlayer == player then continue end
        if exoz.SilentAim.TeamCheck and TargetPlayer.Team == player.Team then continue end
        
        local Character = TargetPlayer.Character
        if not Character then continue end
        
        if exoz.SilentAim.VisibleCheck and not IsPlayerVisible(TargetPlayer) then continue end
        
        local TargetInstance = GetTargetPartInstance(Character)
        if not TargetInstance then continue end
        
        local Humanoid = Character:FindFirstChild("Humanoid")
        if not Humanoid or Humanoid.Health <= 0 then continue end
        
        local Distance = (localRoot.Position - TargetInstance.Position).Magnitude
        
        if Distance < ClosestDistance then
            Closest = TargetInstance
            ClosestDistance = Distance
        end
    end
    
    return Closest
end

local function GetClosestPlayer()
    if exoz.SilentAim.Mode == "Mouse" then
        return GetClosestPlayerToMouse()
    else
        return GetClosestPlayerToPosition()
    end
end

local function gunHandler()
    if exoz.SilentAim.GunHandlerHooked then return true end
    
    local success, err = pcall(function()
        local GunHandlerModule = ReplicatedStorage:FindFirstChild("Modules")
        if GunHandlerModule then
            GunHandlerModule = GunHandlerModule:FindFirstChild("GunHandler")
        end
        
        if not GunHandlerModule then
            for _, child in pairs(ReplicatedStorage:GetChildren()) do
                if child.Name == "GunHandler" then
                    GunHandlerModule = child
                    break
                end
            end
        end
        
        if not GunHandlerModule then
            Notify("Exoz", "No gunhandler module")
            return false
        end
        
        local GunHandler = require(GunHandlerModule)
        exoz.SilentAim.OriginalGetAim = GunHandler.getAim
        
        GunHandler.getAim = function(origin, range)
            if not exoz.SilentAim.Enabled then
                return exoz.SilentAim.OriginalGetAim(origin, range)
            end
            
            if not CalculateChance(exoz.SilentAim.HitChance) then
                return exoz.SilentAim.OriginalGetAim(origin, range)
            end
            
            local target = GetClosestPlayer()
            if target and target.Position then
                local direction = (target.Position - origin)
                local magnitude = math.min(direction.Magnitude, range or 500)
                return direction.Unit, magnitude
            end
            
            return exoz.SilentAim.OriginalGetAim(origin, range)
        end        
        exoz.SilentAim.GunHandlerHooked = true
        return true
    end)
    
    if not success then
        Notify("Exoz", "GunHandler error: " .. tostring(err))
        return false
    end
    
    return true
end

local function remoteMethod()
    if exoz.SilentAim.RemoteConnection and exoz.SilentAim.RemoteConnection.Connected then
        return true
    end
    
    if not exoz.SilentAim.RemoteEvent then
        exoz.SilentAim.RemoteEvent = ReplicatedStorage:FindFirstChild("MainEvent")
        if not exoz.SilentAim.RemoteEvent then
            for _, child in pairs(ReplicatedStorage:GetChildren()) do
                if child.Name == "MainEvent" or child.Name == "ShootEvent" or child.Name == "FireGun" then
                    exoz.SilentAim.RemoteEvent = child
                    break
                end
            end
        end
    end
    
    if not exoz.SilentAim.RemoteEvent then
        Notify("Exoz", "No remote event found")
        return false
    end
    
    if not exoz.SilentAim.InputConnected then
        UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                exoz.SilentAim.isMouseDown = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input, processed)
            if processed then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                exoz.SilentAim.isMouseDown = false
            end
        end)
        exoz.SilentAim.InputConnected = true
    end
    
    if exoz.SilentAim.RemoteConnection then
        exoz.SilentAim.RemoteConnection:Disconnect()
    end
    
    exoz.SilentAim.RemoteConnection = RunService.Heartbeat:Connect(function()
        if not exoz.SilentAim.Enabled then return end
        if not exoz.SilentAim.isMouseDown then return end
        if not CalculateChance(exoz.SilentAim.HitChance) then return end
        
        local target = GetClosestPlayer()
        if not target or not target.Parent then return end
        
        local character = player.Character
        if not character then return end
        
        local tool = character:FindFirstChildOfClass("Tool")
        if not tool then return end
        
        local handle = tool:FindFirstChild("Handle")
        if not handle then return end
        
        local targetHead = target.Parent:FindFirstChild("Head")
        if not targetHead then return end
        
        pcall(function()
            exoz.SilentAim.RemoteEvent:FireServer("ShootGun", handle, handle.Position, targetHead.Position, targetHead, Vector3.new(0, 0, 0))
        end)
    end)
    
    return true
end

local function SwitchSilentAimMethod(method)
    if method == "GunHandler" then
        if exoz.SilentAim.RemoteConnection then
            exoz.SilentAim.RemoteConnection:Disconnect()
            exoz.SilentAim.RemoteConnection = nil
        end
        gunHandler()
    elseif method == "Remote" then
        if exoz.SilentAim.GunHandlerHooked and exoz.SilentAim.OriginalGetAim then
            pcall(function()
                local GunHandlerModule = ReplicatedStorage:FindFirstChild("Modules")
                if GunHandlerModule then
                    GunHandlerModule = GunHandlerModule:FindFirstChild("GunHandler")
                end
                if not GunHandlerModule then
                    for _, child in pairs(ReplicatedStorage:GetChildren()) do
                        if child.Name == "GunHandler" then
                            GunHandlerModule = child
                            break
                        end
                    end
                end
                if GunHandlerModule then
                    local GunHandler = require(GunHandlerModule)
                    GunHandler.getAim = exoz.SilentAim.OriginalGetAim
                end
            end)
            exoz.SilentAim.GunHandlerHooked = false
        end
        remoteMethod()
    end
end

local function SetupFOV()
    RunService.RenderStepped:Connect(function()
        if exoz.SilentAim.Enabled and exoz.SilentAim.FOVVisible and exoz.SilentAim.Mode == "Mouse" then
            pcall(function()
                FOVCircle.Position = GetMousePosition()
                FOVCircle.Radius = exoz.SilentAim.FOVRadius
                FOVCircle.Visible = true
            end)
        else
            pcall(function()
                FOVCircle.Visible = false
            end)
        end
    end)
end

SetupFOV()

sections.SilentAim:Header({ Name = "Silent Aim" })

sections.SilentAim:Toggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(v)
        exoz.SilentAim.Enabled = v
        if v then
            if exoz.SilentAim.Method == "GunHandler" then
                gunHandler()
            elseif exoz.SilentAim.Method == "Remote" then
                remoteMethod()
            end
            Notify("Exoz", "Silent Aim enabled | Mode: " .. exoz.SilentAim.Mode)
        else
            Notify("Exoz", "Silent Aim disabled")
        end
    end
}, "SilentAimToggle")

sections.SilentAim:Dropdown({
    Name = "Method",
    Options = {"GunHandler", "Remote [DETECTED]"},
    Multi = false,
	Required = true,
    Default = 1,
    Callback = function(value)
        exoz.SilentAim.Method = value
        if exoz.SilentAim.Enabled then
            SwitchSilentAimMethod(value)
            Notify("Exoz", "Switched to " .. value .. " method")
        end
    end
}, "SilentAimMethod")

sections.SilentAim:Dropdown({
    Name = "Aim Mode",
    Options = {"Mouse", "Position"},
    Multi = false,
	Required = true,
    Default = 1,
    Callback = function(value)
        exoz.SilentAim.Mode = value
        Notify("Exoz", "Aim mode: " .. value .. " (" .. (value == "Mouse" and "FOV range" or "Closest player to you") .. ")")
    end
}, "SilentAimMode")

sections.SilentAim:Slider({
    Name = "FOV Radius",
    Default = 100,
    Minimum = 50,
    Maximum = 500,
    DisplayMethod = "Number",
    Precision = 0,
    Callback = function(value)
        exoz.SilentAim.FOVRadius = value
    end
}, "SilentAimFOV")

sections.SilentAim:Toggle({
    Name = "Show FOV Circle",
    Default = true,
    Callback = function(v)
        exoz.SilentAim.FOVVisible = v
    end
}, "SilentAimFOVVisible")

sections.SilentAim:Colorpicker({
    Name = "FOV Circle Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(value)
        FOVCircle.Color = value
    end
}, "SilentAimFOVColor")

sections.SilentAim:Toggle({
    Name = "Team Check",
    Default = false,
    Callback = function(v)
        exoz.SilentAim.TeamCheck = v
    end
}, "SilentAimTeamCheck")

sections.SilentAim:Toggle({
    Name = "Wall Check",
    Default = false,
    Callback = function(v)
        exoz.SilentAim.VisibleCheck = v
    end
}, "SilentAimVisibleCheck")

sections.SilentAim:Dropdown({
    Name = "Target Part",
    Options = {"Head", "HumanoidRootPart"},
    Multi = false,
	Required = true,
    Default = 1,
    Callback = function(value)
        exoz.SilentAim.TargetPart = value
    end
}, "SilentAimTargetPart")

sections.SilentAim:Slider({
    Name = "Hit Chance",
    Default = 100,
    Minimum = 1,
    Maximum = 100,
    DisplayMethod = "Percent",
    Precision = 0,
    Callback = function(value)
        exoz.SilentAim.HitChance = value
    end
}, "SilentAimHitChance")

sections.Aimlock:Header({ Name = "Aimlock" })

local AimlockFOVCircle = Drawing.new("Circle")
AimlockFOVCircle.Color = exoz.Aimlock.FOV.Color
AimlockFOVCircle.Thickness = exoz.Aimlock.FOV.Thickness
AimlockFOVCircle.Radius = exoz.Aimlock.FOV.Radius
AimlockFOVCircle.Transparency = exoz.Aimlock.FOV.Transparency
AimlockFOVCircle.Visible = exoz.Aimlock.FOV.Visible
AimlockFOVCircle.Filled = exoz.Aimlock.FOV.Filled

local function isEnemy(plr)
    if not player.Team then return true end
    if not plr.Team then return true end
    return player.Team ~= plr.Team
end

local function wallCheck(targetPart)
    if not exoz.Aimlock.WallCheck then return true end
    
    local origin = Camera.CFrame.Position
    local target = targetPart.Position
    local direction = (target - origin).Unit * (origin - target).Magnitude
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {player.Character, Camera}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    
    if raycastResult then
        local hitPart = raycastResult.Instance
        return hitPart and hitPart:IsDescendantOf(targetPart.Parent)
    end
    
    return true
end

local function getClosestTarget()
    if not exoz.Aimlock.Enabled then return nil end
    
    local closestPlr = nil
    local shortestDistance = exoz.Aimlock.FOV.Radius
    local mousePos = UserInputService:GetMouseLocation()
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and isEnemy(plr) and plr.Character and plr.Character:FindFirstChild(exoz.Aimlock.TargetPart) then
            local targetPart = plr.Character[exoz.Aimlock.TargetPart]
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            
            if onScreen and wallCheck(targetPart) then
                local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
                local distance = (screenPoint - mousePos).Magnitude
                
                if distance <= exoz.Aimlock.FOV.Radius and distance < shortestDistance then
                    shortestDistance = distance
                    closestPlr = plr
                end
            end
        end
    end
    
    return closestPlr
end

local function aimlock()
    local shouldBeActive = exoz.Aimlock.Enabled
    
    if exoz.Aimlock.RequireRightClick then
        shouldBeActive = shouldBeActive and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    end
    
    exoz.Aimlock.Active = shouldBeActive
    
    if not exoz.Aimlock.Active then
        if exoz.Aimlock.Target then
            exoz.Aimlock.Target = nil
        end
        return
    end
    
    if not exoz.Aimlock.Target then
        exoz.Aimlock.Target = getClosestTarget()
        if not exoz.Aimlock.Target then
            return 
        end
    end
    
    local targetPlr = exoz.Aimlock.Target
    if not targetPlr.Character or not targetPlr.Character:FindFirstChild(exoz.Aimlock.TargetPart) then
        exoz.Aimlock.Target = getClosestTarget()
        if not exoz.Aimlock.Target then return end
        targetPlr = exoz.Aimlock.Target
    end
    
    local targetPart = targetPlr.Character[exoz.Aimlock.TargetPart]
    
    if not wallCheck(targetPart) then
        exoz.Aimlock.Target = getClosestTarget()
        if not exoz.Aimlock.Target then return end
        targetPlr = exoz.Aimlock.Target
        targetPart = targetPlr.Character[exoz.Aimlock.TargetPart]
    end
    
    local mousePos = UserInputService:GetMouseLocation()
    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
    
    if onScreen then
        local screenPoint = Vector2.new(screenPos.X, screenPos.Y)
        local distance = (screenPoint - mousePos).Magnitude
        
        if distance > exoz.Aimlock.FOV.Radius then
            exoz.Aimlock.Target = getClosestTarget()
            if not exoz.Aimlock.Target then return end
            targetPlr = exoz.Aimlock.Target
            targetPart = targetPlr.Character[exoz.Aimlock.TargetPart]
        end
    else
        exoz.Aimlock.Target = getClosestTarget()
        if not exoz.Aimlock.Target then return end
        targetPlr = exoz.Aimlock.Target
        targetPart = targetPlr.Character[exoz.Aimlock.TargetPart]
    end
    
    local cameraCFrame = Camera.CFrame
    local targetPosition = targetPart.Position
    local newCFrame = CFrame.lookAt(
        cameraCFrame.Position,
        Vector3.new(
            targetPosition.X,
            targetPosition.Y + (exoz.Aimlock.TargetPart == "Head" and 0.5 or 0),
            targetPosition.Z
        )
    )
    
    Camera.CFrame = cameraCFrame:Lerp(newCFrame, exoz.Aimlock.Smoothness)
end

local function handleAimlockMouseButton(input)
    if exoz.Aimlock.RequireRightClick and input.UserInputType == Enum.UserInputType.MouseButton2 then
        if input.UserInputState == Enum.UserInputState.Begin then
            if exoz.Aimlock.Enabled then
                exoz.Aimlock.Active = true
                exoz.Aimlock.Target = getClosestTarget()
            end
        elseif input.UserInputState == Enum.UserInputState.End then
            exoz.Aimlock.Active = false
            exoz.Aimlock.Target = nil
        end
    end
end

local function updateAimlockFOV()
    AimlockFOVCircle.Color = exoz.Aimlock.FOV.Color
    AimlockFOVCircle.Thickness = exoz.Aimlock.FOV.Thickness
    AimlockFOVCircle.Radius = exoz.Aimlock.FOV.Radius
    AimlockFOVCircle.Transparency = exoz.Aimlock.FOV.Transparency
    AimlockFOVCircle.Filled = exoz.Aimlock.FOV.Filled
    AimlockFOVCircle.Visible = exoz.Aimlock.FOV.Visible and exoz.Aimlock.Enabled
end

sections.Aimlock:Toggle({
    Name = "Aimlock",
    Default = false,
    Callback = function(val)
        exoz.Aimlock.Enabled = val
        Notify("Exoz", "Aimlock " .. (val and "enabled" or "disabled"))
        if not val then
            exoz.Aimlock.Active = false
            exoz.Aimlock.Target = nil
        end
        updateAimlockFOV()
    end
}, "AimlockToggle")

sections.Aimlock:Toggle({
    Name = "Require Right Click",
    Default = false,
    Callback = function(val)
        exoz.Aimlock.RequireRightClick = val
        Notify("Exoz", "Require right click: " .. (val and "enabled" or "disabled"))
        if not val then
            exoz.Aimlock.Active = exoz.Aimlock.Enabled
        end
    end
}, "AimlockRightClickToggle")

sections.Aimlock:Toggle({
    Name = "Wall Check",
    Default = true,
    Callback = function(val)
        exoz.Aimlock.WallCheck = val
    end
}, "AimlockWallCheckToggle")

sections.Aimlock:Toggle({
    Name = "Show FOV Circle",
    Default = true,
    Callback = function(val)
        exoz.Aimlock.FOV.Visible = val
        updateAimlockFOV()
    end
}, "AimlockFOVToggle")

sections.Aimlock:Toggle({
    Name = "Filled FOV",
    Default = false,
    Callback = function(val)
        exoz.Aimlock.FOV.Filled = val
        updateAimlockFOV()
    end
}, "AimlockFOVFilledToggle")

sections.Aimlock:Dropdown({
    Name = "Target Part",
    Options = {"Head", "HumanoidRootPart"},
    Multi = false,
    Required = true,
    Default = 1,
    Callback = function(val)
        exoz.Aimlock.TargetPart = val
    end
}, "AimlockTargetPartDropdown")

sections.Aimlock:Colorpicker({
    Name = "FOV Color",
    Default = exoz.Aimlock.FOV.Color,
    Callback = function(val)
        exoz.Aimlock.FOV.Color = val
        updateAimlockFOV()
    end
}, "AimlockFOVColorPicker")

sections.Aimlock:Slider({
    Name = "Smoothness",
    Description = "Lower = smoother",
    Default = 0.45,
    Minimum = 0.01,
    Maximum = 1,
    DisplayMethod = "Number",
    Precision = 2,
    Callback = function(val)
        exoz.Aimlock.Smoothness = val
    end
}, "AimlockSmoothnessSlider")

sections.Aimlock:Slider({
    Name = "FOV Radius",
    Default = 100,
    Minimum = 25,
    Maximum = 500,
    DisplayMethod = "Number",
    Precision = 0,
    Callback = function(val)
        exoz.Aimlock.FOV.Radius = val
        updateAimlockFOV()
    end
}, "AimlockFOVRadiusSlider")

sections.Aimlock:Slider({
    Name = "FOV Transparency",
    Default = 0.5,
    Minimum = 0,
    Maximum = 1,
    DisplayMethod = "Number",
    Precision = 2,
    Callback = function(val)
        exoz.Aimlock.FOV.Transparency = val
        updateAimlockFOV()
    end
}, "AimlockFOVTransparencySlider")

sections.Aimlock:Slider({
    Name = "FOV Thickness",
    Default = 1,
    Minimum = 1,
    Maximum = 10,
    DisplayMethod = "Number",
    Precision = 0,
    Callback = function(val)
        exoz.Aimlock.FOV.Thickness = val
        updateAimlockFOV()
    end
}, "AimlockFOVThicknessSlider")

local aimlockConnection = RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    AimlockFOVCircle.Position = mousePos
    aimlock()
    updateAimlockFOV()
end)

UserInputService.InputBegan:Connect(function(input)
    handleAimlockMouseButton(input)
end)

UserInputService.InputEnded:Connect(function(input)
    handleAimlockMouseButton(input)
end)

game:GetService("UserInputService").WindowFocused:Connect(function()
    AimlockFOVCircle.Visible = exoz.Aimlock.FOV.Visible and exoz.Aimlock.Enabled
end)

game:GetService("UserInputService").WindowFocusReleased:Connect(function()
    AimlockFOVCircle.Visible = false
end)

sections.RapidFire:Header({ Name = "Rapid Fire" })

sections.RapidFire:Button({
    Name = "Rapid Fire",
    Callback = function()
        exoz.RapidFire.Enabled = true
        Notify("Exoz", "Rapid Fire enabled")

        while true do 
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("GunScript") then 
                for _, v in ipairs(getconnections(tool.Activated)) do
                    local funcinfo = debug.getinfo(v.Function)
                    for i = 1, funcinfo.nups do
                        local c, n = debug.getupvalue(v.Function, i)
                        if type(c) == "number" then 
                            debug.setupvalue(v.Function, i, -67)
                        end
                    end
                end
            end
            task.wait()
        end
    end
})

sections.Wallbang:Header({ Name = "Wallbang" })

sections.Wallbang:Button({
    Name = "Wallbang",
    Callback = function()
        Window:Dialog({
            Title = "Are you sure?",
            Description = "Wallbang is known to be detected, are you sure you want to enable it?",
            Buttons = {
                {
                    Name = "OK",
                    Callback = function()
                        exoz.Wallbang.Enabled = true
                        Notify("Exoz", "Wallbang enabled")
                        local Module = require(game:FindService("ReplicatedStorage").MainModule)
                        Module.Ignored = {workspace:WaitForChild("Vehicles"), workspace:WaitForChild("MAP"), workspace:WaitForChild("Ignored")}
                    end
                },
                {
                    Name = "Cancel",
                }
            }
        })
    end
})

sections.NoRecoil:Header({ Name = "No Recoil" })

local function isframework(scr)
    return tostring(scr) == "Framework"
end

local function checkArgs(inst, idx)
    return tostring(inst):lower():find("camera") and tostring(idx) == "CFrame"
end

sections.NoRecoil:Toggle({
    Name = "No Recoil",
    Default = false,
    Callback = function(v)
        exoz.NoRecoil.Enabled = v
    end
}, "NoRecoilToggle")

local oldNewIndex
oldNewIndex = hookmetamethod(game, "__newindex", function(self, idx, val)
    if exoz.NoRecoil.Enabled and isframework(getcallingscript()) and checkArgs(self, idx) then
        return
    end
    return oldNewIndex(self, idx, val)
end)

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

sections.ESP:Header({ Name = "ESP" })

sections.ESP:Toggle({
    Name = "ESP",
    Default = false,
    Callback = function(v)
        exoz.ESP.Enabled = v
        UpdateESP()
    end
}, "ESPToggle")

sections.ESP:Toggle({
    Name = "Box",
    Default = true,
    Callback = function(v)
        exoz.ESP.Box.Enabled = v
        UpdateESP()
    end
}, "BoxToggle")

sections.ESP:Colorpicker({
    Name = "Fill Color",
    Default = exoz.ESP.Box.FillColor,
    Callback = function(v)
        exoz.ESP.Box.FillColor = v
        UpdateESP()
    end
}, "FillColorColorpicker")

sections.ESP:Toggle({
    Name = "Filled",
    Default = false,
    Callback = function(v)
        exoz.ESP.Box.Filled = v
        UpdateESP()
    end
}, "BoxFilledToggle")

sections.ESP:Slider({
    Name = "Fill Transparency",
    Default = 0.5,
    Minimum = 0,
    Maximum = 1,
    DisplayMethod = "Number",
    Precision = 2,
    Callback = function(v)
        exoz.ESP.Box.Transparency = v
        UpdateESP()
    end
}, "FillTransparencySlider")

sections.ESP:Colorpicker({
    Name = "Outline Color",
    Default = exoz.ESP.Box.OutlineColor,
    Callback = function(v)
        exoz.ESP.Box.OutlineColor = v
        UpdateESP()
    end
}, "OutlineColorColorpicker")

sections.ESP:Toggle({
    Name = "Outline",
    Default = true,
    Callback = function(v)
        exoz.ESP.Box.Outline = v
        UpdateESP()
    end
}, "OutlineToggle")

sections.ESP:Toggle({
    Name = "Nametag",
    Default = false,
    Callback = function(v)
        exoz.ESP.Nametag = v
        UpdateESP()
    end
}, "NametagToggle")

sections.ESP:Toggle({
    Name = "Healthbar",
    Default = false,
    Callback = function(v)
        exoz.ESP.Healthbar = v
        UpdateESP()
    end
}, "HealthbarToggle")

sections.ESP:Toggle({
    Name = "Armorbar",
    Default = false,
    Callback = function(v)
        exoz.ESP.Armorbar = v
        UpdateESP()
    end
}, "ArmorbarToggle")

sections.ESP:Toggle({
    Name = "Ring",
    Default = false,
    Callback = function(v)
        exoz.ESP.Ring.Enabled = v
        UpdateESP()
    end
}, "RingToggle")

sections.ESP:Colorpicker({
    Name = "Ring Color",
    Default = exoz.ESP.Ring.Color,
    Callback = function(v)
        exoz.ESP.Ring.Color = v
        UpdateESP()
    end
}, "RingColorColorpicker")

sections.ESP:Slider({
    Name = "Ring Speed",
    Default = 2.5,
    Minimum = 0.5,
    Maximum = 10,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(v)
        exoz.ESP.Ring.Speed = v
        UpdateESP()
    end
}, "RingSpeedSlider")

sections.ESP:Slider({
    Name = "Ring Height",
    Default = 3.5,
    Minimum = 1,
    Maximum = 10,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(v)
        exoz.ESP.Ring.Height = v
        UpdateESP()
    end
}, "RingHeightSlider")

UpdateESP()

sections.Bullet:Header({ Name = "Bullet" })

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

sections.Bullet:Toggle({
    Name = "Bullet Tracers",
    Default = false,
    Callback = function(v)
        exoz.BulletTracers.Enabled = v
    end
}, "BulletTracerToggle")

sections.Bullet:Colorpicker({
    Name = "Bullet Tracer Start Color",
    Default = exoz.BulletTracers.StartColor,
    Callback = function(v)
        exoz.BulletTracers.StartColor = v
    end
}, "BulletTracerStartColorpicker")

sections.Bullet:Colorpicker({
    Name = "Bullet Tracer End Color",
    Default = exoz.BulletTracers.EndColor,
    Callback = function(v)
        exoz.BulletTracers.EndColor = v
    end
}, "BulletTracerEndColorpicker")

sections.Bullet:Slider({
    Name = "Bullet Tracer Lifetime",
    Default = exoz.BulletTracers.Life,
    Minimum = 0.1,
    Maximum = 5,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(v)
        exoz.BulletTracers.Life = v
    end
}, "BulletTracerLifetime")

getgenv().ExozBulletTracersConnection = RunService.Heartbeat:Connect(function()
    if exoz.BulletTracers.Enabled then
        for _, child in pairs(workspace.Ignored.Siren.Radius:GetChildren()) do
            if child.Name == "BULLET_RAYS" then
                child:Destroy()
            end
        end
    end
end)

sections.Hit:Header({ Name = "Hit" })

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

sections.Hit:Dropdown({
    Name = "Change Hit Sound",
    Options = HitSoundsList,
    Multi = false,
	Required = true,
    Default = 2,
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
}, "HitSoundsDropdown")

sections.Hit:Toggle({
    Name = "Hit Sounds",
    Default = false,
    Callback = function(v)
        exoz.HitSounds.Enabled = v
    end
}, "HitSoundsToggle")

sections.Hit:Slider({
    Name = "Volume",
    Default = 5,
    Minimum = 1,
    Maximum = 10,
    DisplayMethod = "Number",
    Precision = 1,
    Callback = function(v)
        exoz.HitSounds.Volume = v
    end
}, "HitSoundsVolume")

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
            if ray and ray.Instance then                local hitPlayer = Players:GetPlayerFromCharacter(ray.Instance:FindFirstAncestorOfClass("Model"))
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

sections.Anticheat:Header({ Name = "Anticheat" })

getgenv().HookedAnticheat = false

sections.Anticheat:Button({
    Name = "Anticheat Block",
    Callback = function()
        Window:Dialog({
            Title = "Anticheat Block",
            Description = "Are you sure you want to enable Anticheat Block?",
            Buttons = {
                {
                    Name = "Confirm",
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
                                getgenv().HookedAnticheat = false
                                Notify("Exoz", "Executor can't handle this.", 7)
                            else
                                Notify("Exoz", "Anticheat blocked successfully.", 5)
                            end
                        end)()
                    end
                },
                {
                    Name = "Cancel",
                    Callback = function()
                        Notify("Exoz", "Cancelled Anticheat Block toggle.", 2)
                    end
                }
            }
        })
    end
})

sections.Staff:Header({ Name = "Staff Detector" })

local isStaff = function(p)
    for _, id in ipairs(exoz.Dahood.StaffList) do
        if p.UserId == id then return true end
    end
    return false
end

local function exit()
    player:Kick("Exoz Staff detector - Auto left game.")
end

sections.Staff:Toggle({
    Name = "Staff Detector",
    Default = true,
    Callback = function(v)
        exoz.StaffDetector.Enabled = v
        if not v then
            exoz.StaffDetector.StaffOnline = {}
        end
    end
}, "StaffDetectorToggle")

sections.Staff:Toggle({
    Name = "Exit On Staff Detected",
    Default = false,
    Callback = function(v)
        exoz.StaffDetector.Leave = v
    end
}, "ExitToggle")

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

sections.AntiStomp:Header({ Name = "Anti Stomp" })

local tweenSpeed = 0.3

local antiStompBusy = false

local function antiStomp()
    if not exoz.AntiStomp.Enabled then return end
    if antiStompBusy then return end

    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local bodyEffects = character:FindFirstChild("BodyEffects")

    if not humanoid or not rootPart or not bodyEffects then return end

    local knocked = bodyEffects:FindFirstChild("K.O")
    if not knocked or not knocked.Value then return end

    antiStompBusy = true

    local savedPos = rootPart.CFrame
    
    humanoid.Health = 0
    
    local newCharacter = player.CharacterAdded:Wait()
    local newHumanoid = newCharacter:WaitForChild("Humanoid")
    local newRoot = newCharacter:WaitForChild("HumanoidRootPart")
    
    task.wait(0.2)
    
    newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    newHumanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
    
    if newHumanoid.SeatPart then
        newHumanoid.Sit = false
    end
    
    if exoz.AntiStomp.Flashback then
        pcall(function()
            newRoot.CFrame = savedPos
        end)
    end
    
    task.wait(0.3)
    
    antiStompBusy = false
end

sections.AntiStomp:Toggle({
    Name = "Anti Stomp",
    Default = false,
    Callback = function(v)
        exoz.AntiStomp.Enabled = v
        Notify("Exoz", "Anti Stomp " .. (v and "enabled" or "disabled"))
    end
}, "AntiStompToggle")

sections.AntiStomp:Toggle({
    Name = "Flashback",
    Default = false,
    Callback = function(v)
        exoz.AntiStomp.Flashback = v
    end
}, "FlashbackToggle")

task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(antiStomp)
    end
end)

sections.Desync:Header({ Name = "Desync" })

local function isRakNetAvailable()
    return raknet ~= nil and type(raknet.add_send_hook) == "function"
end

local function rakhook(packet)
    if packet.PacketId == 0x1B then
        local buf = packet.AsBuffer
        buffer.writeu32(buf, 1, 0xFFFFFFFF)
        packet:SetData(buf)
    end
end

local function enableDesync()
    if exoz.Desync.Enabled then return false end
    if not isRakNetAvailable() then
        Notify("Exoz", "RakNet not available on this executor", 3)
        return false
    end
    
    exoz.Desync.Hook = rakhook
    raknet.add_send_hook(exoz.Desync.Hook)
    exoz.Desync.Enabled = true
    return true
end

local function disableDesync()
    if not exoz.Desync.Enabled then return end
    if exoz.Desync.Hook and isRakNetAvailable() then
        raknet.remove_send_hook(exoz.Desync.Hook)
    end
    exoz.Desync.Hook = nil
    exoz.Desync.Enabled = false
end

sections.Desync:Toggle({
    Name = "Desync",
    Default = false,
    Tooltip = "Prevent the server from replicating your current position to other players.",
    Callback = function(v)
        if v then
            local success = enableDesync()
            if success then
                Notify("Exoz", "Desync enabled - position desynchronized", 3)
            else
                Notify("Exoz", "Failed to enable Desync", 3)
            end
        else
            disableDesync()
            Notify("Exoz", "Desync disabled", 3)
        end
    end
}, "DesyncToggle")

sections.AutoFarm:Header({ Name = "AutoFarm" })

local humanoid
local tool
local character
local isInitializing = false
local farmThread = nil
local respawnConn = nil
local equipConn = nil

local function handleKOState()
    if not character or not character.Parent then return false end
    local bodyEffects = character:FindFirstChild("BodyEffects")
    if bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value then
        if humanoid and humanoid.Health > 0 then
            humanoid.Health = 0
        end
        return true
    end
    return false
end

local function initializeCharacter()
    if isInitializing then return false end
    isInitializing = true
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    local attempts = 0
    repeat
        tool = player.Backpack:FindFirstChild(exoz.AutoFarm.ToolName)
        if not tool then
            wait(0.5)
            attempts = attempts + 1
            if attempts >= 10 then return false end
        end
    until tool
    humanoid:EquipTool(tool)
    local delay = exoz.AutoFarm.RandomDelays and (0.5 + math.random() * 0.3) or 0.5
    wait(delay)
    isInitializing = false
    return true
end

local function ensureToolEquipped()
    if not character or not humanoid or not tool then return false end
    if not character:FindFirstChildOfClass("Tool") and tool.Parent == player.Backpack then
        humanoid:EquipTool(tool)
        local delay = exoz.AutoFarm.RandomDelays and (0.1 + math.random() * 0.1) or 0.1
        wait(delay)
    end
    return character:FindFirstChildOfClass("Tool") ~= nil
end

local function collectAllMoney()
    local dropContainer = game.Workspace.Ignored.Drop
    local radius = exoz.AutoFarm.CollectionRadius
    local collected = true
    while collected and exoz.AutoFarm.Enabled do
        collected = false
        for _, money in ipairs(dropContainer:GetChildren()) do
            if money.Name == "MoneyDrop" and character and character:FindFirstChild("HumanoidRootPart") then
                local distance = (money.Position - character.HumanoidRootPart.Position).magnitude
                if distance <= radius then
                    pcall(function()
                        character.HumanoidRootPart.CFrame = money.CFrame
                        if money:FindFirstChild("ClickDetector") then
                            fireclickdetector(money.ClickDetector)
                        end
                    end)
                    collected = true
                    local delay = exoz.AutoFarm.RandomDelays and (0.2 + math.random() * 0.1) or 0.2
                    wait(delay)
                    break
                end
            end
        end
        if not collected then
            wait(0.3)
        end
    end
end

local function hopToAnotherServer()
    TeleportService:Teleport(game.PlaceId, player)
end

local function isCharacterKOd()
    if not character or not character.Parent then return true end
    return handleKOState()
end

local lastCharacter = nil
local isWaitingForRespawn = false

local function setupRespawnMonitoring()
    if respawnConn then respawnConn:Disconnect() end
    lastCharacter = player.Character
    respawnConn = RunService.Heartbeat:Connect(function()
        if not exoz.AutoFarm.Enabled then return end
        handleKOState()
        if player.Character ~= lastCharacter then
            if player.Character then
                character = player.Character
                isWaitingForRespawn = false
                task.spawn(function() wait(1); initializeCharacter() end)
            else
                isWaitingForRespawn = true
            end
            lastCharacter = player.Character
        elseif isCharacterKOd() and not isWaitingForRespawn then
            isWaitingForRespawn = true
        elseif not isCharacterKOd() and isWaitingForRespawn then
            isWaitingForRespawn = false
            task.spawn(function() wait(0.5); initializeCharacter() end)
        end
    end)
    return respawnConn
end

local function waitForCharacterAlive()
    local timeout = tick() + 10
    while (not character or isCharacterKOd()) and tick() < timeout do
        wait(0.5)
    end
    return tick() < timeout
end

local function attackCashier(cashier)
    if not cashier or not cashier:FindFirstChild("Humanoid") then return false end
    local cashierHumanoid = cashier.Humanoid
    if cashierHumanoid.Health <= 0 then return false end
    if not cashier:FindFirstChild("Open") or not character or not character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    local attackPosition = cashier.Open.CFrame * CFrame.new(0, 0, 2)
    local attackTimeout = tick() + exoz.AutoFarm.AttackTimeout
    while cashierHumanoid.Health > 0 and exoz.AutoFarm.Enabled do
        if tick() > attackTimeout then return false end
        if not cashier.Parent or not cashierHumanoid.Parent then return false end
        if isCharacterKOd() or not character or not character.Parent then return false end
        if not ensureToolEquipped() then wait(0.5); continue end
        pcall(function() character.HumanoidRootPart.CFrame = attackPosition end)
        if tool and tool.Parent == character then
            pcall(function() tool:Activate() end)
            local delay = exoz.AutoFarm.RandomDelays and (exoz.AutoFarm.AttackDelay + math.random() * 0.1) or exoz.AutoFarm.AttackDelay
            wait(delay)
        else
            return false
        end
    end
    return true
end

local function farmLoop()
    if not initializeCharacter() then wait(2); return end
    respawnConn = setupRespawnMonitoring()
    equipConn = RunService.Heartbeat:Connect(function()
        if exoz.AutoFarm.Enabled and character and character.Parent and not isWaitingForRespawn then
            ensureToolEquipped()
        end
    end)

    while exoz.AutoFarm.Enabled do
        if not waitForCharacterAlive() then wait(1); continue end
        if not ensureToolEquipped() then wait(1); continue end

        local foundCashier = false
        for _, cashier in ipairs(workspace.Cashiers:GetChildren()) do
            local cashierHumanoid = cashier:FindFirstChild("Humanoid")
            if cashierHumanoid and cashierHumanoid.Health > 0 and cashier:FindFirstChild("Open") then
                foundCashier = true
                if attackCashier(cashier) then
                    local delay = exoz.AutoFarm.RandomDelays and (0.5 + math.random() * 0.3) or 0.5
                    wait(delay)
                    pcall(collectAllMoney)
                end
                local delay = exoz.AutoFarm.RandomDelays and (1 + math.random() * 0.5) or 1
                wait(delay)
                break
            end
        end

        if not foundCashier and exoz.AutoFarm.HopWhenNoCashiers then
            if respawnConn then respawnConn:Disconnect() end
            if equipConn then equipConn:Disconnect() end
            hopToAnotherServer()
            return
        end
        local delay = exoz.AutoFarm.RandomDelays and (0.5 + math.random() * 0.3) or 0.5
        wait(delay)
    end
end

sections.AutoFarm:Toggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(v)
        exoz.AutoFarm.Enabled = v
        if v then
            if farmThread and coroutine.status(farmThread) ~= "dead" then
                return
            end
            farmThread = coroutine.create(function()
                while exoz.AutoFarm.Enabled do
                    farmLoop()
                    if not exoz.AutoFarm.Enabled then break end
                end
            end)
            coroutine.resume(farmThread)
        else
            if respawnConn then respawnConn:Disconnect() end
            if equipConn then equipConn:Disconnect() end
            respawnConn = nil
            equipConn = nil
        end
    end
}, "AutoFarmToggle")

sections.Select:Header({ Name = "Select Target" })

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

local PlayerDropdown = sections.Select:Dropdown({
    Name = "Select Target",
    Options = getPlayerList(),
    Multi = false,
	Required = false,
    Default = nil,
    Callback = function(v)
        local targetPlayer = PlayerMap[v]
        if targetPlayer then
            exoz.Target.Player = targetPlayer
            Notify("Exoz", "Target Selected: " .. targetPlayer.Name)
        end
    end
}, "PlayerListDropdown")

local function refreshDropdown()
    if PlayerDropdown then
        local newList = getPlayerList()
        PlayerDropdown:SetOptions(newList)
        
        if exoz.Target.Player and not Players:FindFirstChild(exoz.Target.Player.Name) then
            exoz.Target.Player = nil
        end
    end
end

sections.Select:Button({
    Name = "Refresh Dropdown",
    Callback = function()
        refreshDropdown()
    end
})

sections.Info:Header({ Name = "Target Info" })

sections.Info:Button({
    Name = "Show Target Info",
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

        Window:Dialog({
            Title = "Target Info",
            Description = "Username: " .. username .. "\nDisplay Name: " .. displayname .. "\nUser ID: " .. userid .. "\nHealth: " .. health .. "\nArmor: " .. armor .. "\nFire Armor: " .. fireArmor .. "\nKnocked: " .. tostring(knocked) .. "\nJailed: " .. tostring(jailed) .. "\nMoney: " .. tostring(money) .. "\nReported: " .. tostring(reportCount) .. "\nStaff: " .. tostring(staff),
            Buttons = {
                {
                    Name = "OK",
                }
            }
        })
    end
})

sections.Actions:Header({ Name = "Actions" })

local currentHighlight = nil
local highlightConnection = nil

sections.Actions:Toggle({
    Name = "Highlight Target",
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
}, "HighlightTargetToggle")

tabs.Settings:InsertConfigSection("Left")

local oldOnUnloaded = Window.onUnloaded
Window.onUnloaded = function()
    if oldOnUnloaded then oldOnUnloaded() end
    if aimlockConnection then aimlockConnection:Disconnect() end
    if AimlockFOVCircle then AimlockFOVCircle:Remove() end
    disableDesync()
end

tabs.Main:Select()
MacLib:SetFolder("Exoz/" .. gameName)
MacLib:LoadAutoLoadConfig()

Notify("Exoz", "Loaded ".. gameName .. " script successfully.")
