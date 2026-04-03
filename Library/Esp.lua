local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local EspLib = {}
EspLib.__index = EspLib

EspLib.Settings = {
    TeamCheck = true,
    MaxDistance = 1000,
    BoxVisible = false,
    BoxColor = Color3.new(0.403922, 0.34902, 0.701961),
    BoxFilled = false,
    BoxFillColor = Color3.new(0.403922, 0.34902, 0.701961),
    BoxFillTransparency = 0.5,
    NametagVisible = false,
    HealthbarVisible = false,
    HealthbarSpeed = 0.2,
    HealthbarColor1 = Color3.fromRGB(0, 255, 0),
    HealthbarColor2 = Color3.fromRGB(255, 255, 0),
    HealthbarColor3 = Color3.fromRGB(255, 0, 0),
    ArmorbarVisible = false,
    ArmorbarColor1 = Color3.fromRGB(0, 0, 255),
    ArmorbarColor2 = Color3.fromRGB(135, 206, 235),
    ArmorbarColor3 = Color3.fromRGB(1, 0, 0),
    RingVisible = false,
    RingColor = Color3.fromRGB(255, 255, 255),
    RingSpeed = 2.5,
    RingHeight = 3.5,
    RingRadius = 2.5
}

EspLib.Storage = {
    Boxes = {},
    Nametags = {},
    Healthbars = {},
    Armorbars = {},
    Rings = {}
}

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local RenderConn = nil

local function SafeExecute(func)
    local ok, err = pcall(func)
    if not ok then
        warn("Error: " .. tostring(err))
    end
end

local function GetDistance(pos)
    return (CurrentCamera.CFrame.Position - pos).Magnitude
end

local function LerpNumber(a, b, t)
    return a + (b - a) * t
end

function EspLib:CreateBox(target)
    local box = {
        Main = Drawing.new("Square"),
        Fill = Instance.new("Frame")
    }
    
    box.Main.Thickness = 1
    box.Main.Color = self.Settings.BoxColor
    box.Main.Filled = self.Settings.BoxFilled
    box.Main.Visible = false
    
    box.Fill.Parent = self.Gui
    box.Fill.BackgroundColor3 = self.Settings.BoxFillColor
    box.Fill.BackgroundTransparency = self.Settings.BoxFillTransparency
    box.Fill.BorderSizePixel = 0
    box.Fill.Visible = false
    
    return box
end

function EspLib:UpdateBoxes()
    if not self.Settings.BoxVisible then
        for _, data in pairs(self.Storage.Boxes) do
            data.Main.Visible = false
            data.Fill.Visible = false
        end
        return
    end
    
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= LocalPlayer then
            SafeExecute(function()
                local char = other.Character
                if not char then return end
                
                local root = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not root or not hum or hum.Health <= 0 then return end
                
                local dist = GetDistance(root.Position)
                if dist > self.Settings.MaxDistance then return end
                
                if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then
                    if self.Storage.Boxes[other] then
                        self.Storage.Boxes[other].Main.Visible = false
                        self.Storage.Boxes[other].Fill.Visible = false
                    end
                    return
                end
                
                if not self.Storage.Boxes[other] then
                    self.Storage.Boxes[other] = self:CreateBox(other)
                end
                
                local head = char:FindFirstChild("Head")
                local headPos = (head and head.Position + Vector3.new(0, 1, 0)) or (root.Position + Vector3.new(0, 3, 0))
                local feetPos = root.Position - Vector3.new(0, 3, 0)
                
                local headScreen = CurrentCamera:WorldToViewportPoint(headPos)
                local feetScreen = CurrentCamera:WorldToViewportPoint(feetPos)
                local rootScreen = CurrentCamera:WorldToViewportPoint(root.Position)
                
                local height = math.abs(headScreen.Y - feetScreen.Y)
                local width = height * 0.6
                local centerX = rootScreen.X
                local topY = (headScreen.Y + feetScreen.Y) / 2 - height / 2
                
                local box = self.Storage.Boxes[other]
                
                if self.Settings.BoxFilled then
                    box.Fill.Position = UDim2.fromOffset(centerX - width/2, topY)
                    box.Fill.Size = UDim2.fromOffset(width, height)
                    box.Fill.BackgroundColor3 = self.Settings.BoxFillColor
                    box.Fill.BackgroundTransparency = self.Settings.BoxFillTransparency
                    box.Fill.Visible = true
                    box.Main.Visible = false
                else
                    box.Main.Size = Vector2.new(width, height)
                    box.Main.Position = Vector2.new(centerX - width/2, topY)
                    box.Main.Color = self.Settings.BoxColor
                    box.Main.Visible = true
                    box.Fill.Visible = false
                end
            end)
        end
    end
end

function EspLib:CreateNametag(target)
    local tag = Instance.new("TextLabel")
    tag.Parent = self.Gui
    tag.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tag.BackgroundTransparency = 0.5
    tag.TextColor3 = Color3.fromRGB(255, 255, 255)
    tag.TextStrokeTransparency = 0
    tag.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    tag.Font = Enum.Font.GothamBold
    tag.TextSize = 14
    tag.Size = UDim2.new(0, 100, 0, 20)
    tag.BorderSizePixel = 0
    
    local corners = Instance.new("UICorner")
    corners.CornerRadius = UDim.new(0, 8)
    corners.Parent = tag
    
    return tag
end

function EspLib:UpdateNametags()
    if not self.Settings.NametagVisible then
        for _, tag in pairs(self.Storage.Nametags) do
            tag.Visible = false
        end
        return
    end
    
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= LocalPlayer then
            SafeExecute(function()
                local char = other.Character
                if not char then return end
                
                local root = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not root or not hum or hum.Health <= 0 then return end
                
                local dist = GetDistance(root.Position)
                if dist > self.Settings.MaxDistance then return end
                
                if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then
                    if self.Storage.Nametags[other] then
                        self.Storage.Nametags[other].Visible = false
                    end
                    return
                end
                
                if not self.Storage.Nametags[other] then
                    self.Storage.Nametags[other] = self:CreateNametag(other)
                end
                
                local head = char:FindFirstChild("Head")
                local headPos = head and head.Position or root.Position + Vector3.new(0, 2, 0)
                local screenPos, onScreen = CurrentCamera:WorldToViewportPoint(headPos + Vector3.new(0, 1.5, 0))
                
                if onScreen then
                    local tag = self.Storage.Nametags[other]
                    tag.Text = other.Name
                    tag.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 30)
                    tag.Visible = true
                else
                    self.Storage.Nametags[other].Visible = false
                end
            end)
        end
    end
end

function EspLib:CreateHealthbar(target)
    local bar = {
        Background = Instance.new("Frame"),
        Fill = Instance.new("Frame"),
        Gradient = Instance.new("UIGradient"),
        Text = Instance.new("TextLabel"),
        Current = 100,
        Target = 100
    }
    
    bar.Background.Parent = self.Gui
    bar.Background.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
    bar.Background.BackgroundTransparency = 0.45
    bar.Background.BorderSizePixel = 0
    bar.Background.Visible = false
    
    bar.Fill.Parent = bar.Background
    bar.Fill.BackgroundTransparency = 0
    bar.Fill.BorderSizePixel = 0
    
    bar.Gradient.Parent = bar.Fill
    bar.Gradient.Rotation = 90
    bar.Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Settings.HealthbarColor1),
        ColorSequenceKeypoint.new(0.5, self.Settings.HealthbarColor2),
        ColorSequenceKeypoint.new(1, self.Settings.HealthbarColor3)
    })
    
    bar.Text.Parent = self.Gui
    bar.Text.BackgroundTransparency = 1
    bar.Text.TextSize = 10
    bar.Text.Font = Enum.Font.Code
    bar.Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    bar.Text.TextStrokeTransparency = 0
    bar.Text.Visible = false
    
    return bar
end

function EspLib:UpdateHealthbars()
    if not self.Settings.HealthbarVisible then
        for _, data in pairs(self.Storage.Healthbars) do
            data.Background.Visible = false
            data.Text.Visible = false
        end
        return
    end
    
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= LocalPlayer then
            SafeExecute(function()
                local char = other.Character
                if not char then return end
                
                local root = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not root or not hum or hum.Health <= 0 then return end
                
                local dist = GetDistance(root.Position)
                if dist > self.Settings.MaxDistance then return end
                
                if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then
                    if self.Storage.Healthbars[other] then
                        self.Storage.Healthbars[other].Background.Visible = false
                    end
                    return
                end
                
                if not self.Storage.Healthbars[other] then
                    self.Storage.Healthbars[other] = self:CreateHealthbar(other)
                end
                
                local head = char:FindFirstChild("Head")
                local headPos = (head and head.Position) or (root.Position + Vector3.new(0, 2, 0))
                local feetPos = root.Position - Vector3.new(0, 3, 0)
                
                local headScreen = CurrentCamera:WorldToViewportPoint(headPos)
                local feetScreen = CurrentCamera:WorldToViewportPoint(feetPos)
                local rootScreen = CurrentCamera:WorldToViewportPoint(root.Position)
                
                local height = math.abs(headScreen.Y - feetScreen.Y)
                local barX = rootScreen.X - 30
                local barY = (headScreen.Y + feetScreen.Y) / 2 - height / 2
                
                local healthPercent = (hum.Health / hum.MaxHealth) * 100
                local barHeight = height * (healthPercent / 100)
                
                local data = self.Storage.Healthbars[other]
                data.Target = healthPercent
                data.Current = LerpNumber(data.Current, data.Target, self.Settings.HealthbarSpeed)
                
                data.Background.Size = UDim2.new(0, 3, 0, height)
                data.Background.Position = UDim2.new(0, barX, 0, barY)
                data.Background.Visible = true
                
                data.Fill.Size = UDim2.new(0, 3, 0, height * (data.Current / 100))
                data.Fill.Position = UDim2.new(0, 0, 0, height - (height * (data.Current / 100)))
                
                local percentText = math.floor(healthPercent)
                data.Text.Text = tostring(percentText)
                data.Text.Position = UDim2.new(0, barX - 20, 0, barY + height - (height * (healthPercent / 100)) - 6)
                data.Text.Visible = true
            end)
        end
    end
end

function EspLib:CreateArmorbar(target)
    local bar = {
        Background = Instance.new("Frame"),
        Fill = Instance.new("Frame"),
        Gradient = Instance.new("UIGradient"),
        Text = Instance.new("TextLabel")
    }
    
    bar.Background.Parent = self.Gui
    bar.Background.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
    bar.Background.BackgroundTransparency = 0.45
    bar.Background.BorderSizePixel = 0
    bar.Background.Visible = false
    
    bar.Fill.Parent = bar.Background
    bar.Fill.BackgroundTransparency = 0
    bar.Fill.BorderSizePixel = 0
    
    bar.Gradient.Parent = bar.Fill
    bar.Gradient.Rotation = 90
    bar.Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, self.Settings.ArmorbarColor1),
        ColorSequenceKeypoint.new(0.5, self.Settings.ArmorbarColor2),
        ColorSequenceKeypoint.new(1, self.Settings.ArmorbarColor3)
    })
    
    bar.Text.Parent = self.Gui
    bar.Text.BackgroundTransparency = 1
    bar.Text.TextSize = 10
    bar.Text.Font = Enum.Font.Code
    bar.Text.TextColor3 = Color3.fromRGB(135, 206, 235)
    bar.Text.TextStrokeTransparency = 0
    bar.Text.Visible = false
    
    return bar
end

function EspLib:UpdateArmorbars()
    if not self.Settings.ArmorbarVisible then
        for _, data in pairs(self.Storage.Armorbars) do
            data.Background.Visible = false
            data.Text.Visible = false
        end
        return
    end
    
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= LocalPlayer then
            SafeExecute(function()
                local char = other.Character
                if not char then return end
                
                local root = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not root or not hum or hum.Health <= 0 then return end
                
                local dist = GetDistance(root.Position)
                if dist > self.Settings.MaxDistance then return end
                
                if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then
                    if self.Storage.Armorbars[other] then
                        self.Storage.Armorbars[other].Background.Visible = false
                    end
                    return
                end
                
                if not self.Storage.Armorbars[other] then
                    self.Storage.Armorbars[other] = self:CreateArmorbar(other)
                end
                
                local head = char:FindFirstChild("Head")
                local headScreen = CurrentCamera:WorldToViewportPoint((head and head.Position) or (root.Position + Vector3.new(0, 2, 0)))
                local feetScreen = CurrentCamera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
                local rootScreen = CurrentCamera:WorldToViewportPoint(root.Position)
                
                local height = math.abs(headScreen.Y - feetScreen.Y)
                local barX = rootScreen.X - 35
                local barY = (headScreen.Y + feetScreen.Y) / 2 - height / 2
                
                local bodyEffects = char:FindFirstChild("BodyEffects")
                local armorVal = (bodyEffects and bodyEffects:FindFirstChild("Armor")) and bodyEffects.Armor.Value or 0
                local armorPercent = math.floor((armorVal / 200) * 100)
                local barHeight = height * (armorPercent / 100)
                
                local data = self.Storage.Armorbars[other]
                
                data.Background.Size = UDim2.new(0, 3, 0, height)
                data.Background.Position = UDim2.new(0, barX, 0, barY)
                data.Background.Visible = true
                
                data.Fill.Size = UDim2.new(0, 3, 0, barHeight)
                data.Fill.Position = UDim2.new(0, 0, 0, height - barHeight)
                
                if armorPercent > 0 then
                    data.Text.Text = tostring(armorPercent)
                    data.Text.Position = UDim2.new(0, barX - 20, 0, barY + height - barHeight - 6)
                    data.Text.Visible = true
                else
                    data.Text.Visible = false
                end
            end)
        end
    end
end

function EspLib:CreateRing(target)
    local holder = Instance.new("Part")
    holder.Name = "RingHolder"
    holder.Transparency = 1
    holder.CanCollide = false
    holder.Anchored = true
    holder.Parent = Workspace
    
    local ring = Instance.new("CylinderHandleAdornment")
    ring.Adornee = holder
    ring.AlwaysOnTop = true
    ring.ZIndex = 10
    ring.Color3 = self.Settings.RingColor
    ring.InnerRadius = self.Settings.RingRadius - 0.1
    ring.Radius = self.Settings.RingRadius
    ring.Height = 0.08
    ring.CFrame = CFrame.Angles(math.rad(90), 0, 0)
    ring.Parent = holder
    ring.Visible = false
    
    return {Holder = holder, Ring = ring, Root = nil}
end

function EspLib:UpdateRings(deltaTime)
    if not self.Settings.RingVisible then
        for _, data in pairs(self.Storage.Rings) do
            if data.Ring then
                data.Ring.Visible = false
            end
        end
        return
    end
    
    local time = tick()
    
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= LocalPlayer then
            SafeExecute(function()
                local char = other.Character
                if not char then return end
                
                local root = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not root or not hum or hum.Health <= 0 then return end
                
                local dist = GetDistance(root.Position)
                if dist > self.Settings.MaxDistance then return end
                
                if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then
                    if self.Storage.Rings[other] then
                        self.Storage.Rings[other].Ring.Visible = false
                    end
                    return
                end
                
                if not self.Storage.Rings[other] then
                    self.Storage.Rings[other] = self:CreateRing(other)
                end
                
                local data = self.Storage.Rings[other]
                data.Root = root
                
                local yOffset = math.sin(time * self.Settings.RingSpeed) * self.Settings.RingHeight
                data.Holder.CFrame = root.CFrame * CFrame.new(0, yOffset, 0)
                data.Ring.Color3 = self.Settings.RingColor
                data.Ring.Transparency = 0.2 + (math.abs(math.sin(time * self.Settings.RingSpeed)) * 0.4)
                data.Ring.Visible = true
            end)
        end
    end
end

function EspLib:ClearAll()
    for _, box in pairs(self.Storage.Boxes) do
        box.Main:Remove()
        box.Fill:Destroy()
    end
    for _, tag in pairs(self.Storage.Nametags) do
        tag:Destroy()
    end
    for _, bar in pairs(self.Storage.Healthbars) do
        bar.Background:Destroy()
        bar.Text:Destroy()
    end
    for _, bar in pairs(self.Storage.Armorbars) do
        bar.Background:Destroy()
        bar.Text:Destroy()
    end
    for _, ring in pairs(self.Storage.Rings) do
        ring.Holder:Destroy()
    end
    self.Storage.Boxes = {}
    self.Storage.Nametags = {}
    self.Storage.Healthbars = {}
    self.Storage.Armorbars = {}
    self.Storage.Rings = {}
end

function EspLib:Destroy()
    self:ClearAll()
    if RenderConn then
        RenderConn:Disconnect()
    end
    if self.Gui then
        self.Gui:Destroy()
    end
end

function EspLib:SetBox(enabled, color, filled, fillColor, transparency)
    self.Settings.BoxVisible = enabled
    if color then self.Settings.BoxColor = color end
    if filled ~= nil then self.Settings.BoxFilled = filled end
    if fillColor then self.Settings.BoxFillColor = fillColor end
    if transparency then self.Settings.BoxFillTransparency = transparency end
end

function EspLib:SetNametag(enabled)
    self.Settings.NametagVisible = enabled
end

function EspLib:SetHealthbar(enabled, color1, color2, color3)
    self.Settings.HealthbarVisible = enabled
    if color1 then self.Settings.HealthbarColor1 = color1 end
    if color2 then self.Settings.HealthbarColor2 = color2 end
    if color3 then self.Settings.HealthbarColor3 = color3 end
end

function EspLib:SetArmorbar(enabled, color1, color2, color3)
    self.Settings.ArmorbarVisible = enabled
    if color1 then self.Settings.ArmorbarColor1 = color1 end
    if color2 then self.Settings.ArmorbarColor2 = color2 end
    if color3 then self.Settings.ArmorbarColor3 = color3 end
end

function EspLib:SetRing(enabled, color, speed, height, radius)
    self.Settings.RingVisible = enabled
    if color then self.Settings.RingColor = color end
    if speed then self.Settings.RingSpeed = speed end
    if height then self.Settings.RingHeight = height end
    if radius then self.Settings.RingRadius = radius end
end

function EspLib:SetTeamCheck(enabled)
    self.Settings.TeamCheck = enabled
end

function EspLib:SetDistance(distance)
    self.Settings.MaxDistance = distance
end

function EspLib:Init()
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "EspGui"
    self.Gui.Parent = LocalPlayer.PlayerGui
    self.Gui.IgnoreGuiInset = true
    self.Gui.ResetOnSpawn = false
    
    Players.PlayerRemoving:Connect(function(removed)
        SafeExecute(function()
            if self.Storage.Boxes[removed] then
                self.Storage.Boxes[removed].Main:Remove()
                self.Storage.Boxes[removed].Fill:Destroy()
                self.Storage.Boxes[removed] = nil
            end
            if self.Storage.Nametags[removed] then
                self.Storage.Nametags[removed]:Destroy()
                self.Storage.Nametags[removed] = nil
            end
            if self.Storage.Healthbars[removed] then
                self.Storage.Healthbars[removed].Background:Destroy()
                self.Storage.Healthbars[removed].Text:Destroy()
                self.Storage.Healthbars[removed] = nil
            end
            if self.Storage.Armorbars[removed] then
                self.Storage.Armorbars[removed].Background:Destroy()
                self.Storage.Armorbars[removed].Text:Destroy()
                self.Storage.Armorbars[removed] = nil
            end
            if self.Storage.Rings[removed] then
                self.Storage.Rings[removed].Holder:Destroy()
                self.Storage.Rings[removed] = nil
            end
        end)
    end)
    
    RenderConn = RunService.RenderStepped:Connect(function(dt)
        SafeExecute(function()
            self:UpdateBoxes()
            self:UpdateNametags()
            self:UpdateHealthbars()
            self:UpdateArmorbars()
            self:UpdateRings(dt)
        end)
    end)
end

return EspLib
