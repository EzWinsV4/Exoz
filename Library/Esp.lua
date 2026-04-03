local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local EspLib = {}
EspLib.__index = EspLib

EspLib.Settings = {
	TeamCheck = true,
	MaxDistance = 1000,
	BoxVisible = false,
	BoxColor = Color3.new(1, 1, 1),
	BoxFilled = false,
	BoxFillColor = Color3.new(1, 1, 1),
	BoxFillTransparency = 0.5,
	BoxOutline = true,
	BoxOutlineColor = Color3.new(0, 0, 0),
	NametagVisible = false,
	NametagFilled = true,
	NametagFillTransparency = 0.5,
	NametagFillColor = Color3.fromRGB(0, 0, 0),
	NametagTextColor = Color3.fromRGB(255, 255, 255),
	NametagOutline = true,
	NametagOutlineColor = Color3.fromRGB(0, 0, 0),
	NametagFont = Enum.Font.GothamBold,
	NametagSize = 14,
	NametagCornerRadius = 8,
	HealthbarVisible = false,
	HealthbarSpeed = 0.2,
	HealthbarWidth = 4,
	HealthbarColor1 = Color3.fromRGB(0, 216, 100),
	HealthbarColor2 = Color3.fromRGB(255, 206, 8),
	HealthbarColor3 = Color3.fromRGB(248, 150, 51),
	HealthbarColor4 = Color3.fromRGB(221, 21, 51),
	ArmorbarVisible = false,
	ArmorbarWidth = 4,
	ArmorbarColor1 = Color3.fromRGB(1, 31, 75),
	ArmorbarColor2 = Color3.fromRGB(100, 151, 177),
	ArmorbarColor3 = Color3.fromRGB(17, 17, 17),
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
		warn("ESP Error: " .. tostring(err))
	end
end

local function GetDistance(pos)
	return (CurrentCamera.CFrame.Position - pos).Magnitude
end

local function LerpNumber(a, b, t)
	return a + (b - a) * t
end

local function GetScreenBounds(char)
	local minX, minY = math.huge, math.huge
	local maxX, maxY = -math.huge, -math.huge
	local found = false

	for _, part in ipairs(char:GetChildren()) do
		if part:IsA("BasePart") then
			local screen, onScreen = CurrentCamera:WorldToViewportPoint(part.Position)
			if onScreen then
				found = true
				if screen.X < minX then minX = screen.X end
				if screen.Y < minY then minY = screen.Y end
				if screen.X > maxX then maxX = screen.X end
				if screen.Y > maxY then maxY = screen.Y end
			end
		end
	end

	if not found then return nil end

	local pad = 6
	return Vector2.new(minX - pad, minY - pad), (maxX - minX) + pad * 2, (maxY - minY) + pad * 2
end

function EspLib:CreateBox()
	local box = {
		Outline = Drawing.new("Square"),
		Fill = Drawing.new("Square"),
		Main = Drawing.new("Square"),
	}

	box.Outline.Thickness = 0.5
	box.Outline.Color = self.Settings.BoxOutlineColor
	box.Outline.Filled = false
	box.Outline.Visible = false
	box.Outline.Transparency = 1

	box.Fill.Filled = true
	box.Fill.Color = self.Settings.BoxFillColor
	box.Fill.Transparency = self.Settings.BoxFillTransparency
	box.Fill.Visible = false
	box.Fill.Thickness = 0

	box.Main.Thickness = 1
	box.Main.Color = self.Settings.BoxColor
	box.Main.Filled = false
	box.Main.Visible = false
	box.Main.Transparency = 0

	return box
end

local function HideBox(box)
	box.Main.Visible = false
	box.Outline.Visible = false
	box.Fill.Visible = false
end

local function DestroyBox(box)
	box.Main:Remove()
	box.Outline:Remove()
	box.Fill:Remove()
end

function EspLib:UpdateBoxes()
	for _, data in pairs(self.Storage.Boxes) do
		HideBox(data)
	end

	if not self.Settings.BoxVisible then return end

	for _, other in ipairs(Players:GetPlayers()) do
		if other == LocalPlayer then continue end

		SafeExecute(function()
			local char = other.Character
			if not char then return end

			local root = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChild("Humanoid")
			if not root or not hum or hum.Health <= 0 then return end
			if GetDistance(root.Position) > self.Settings.MaxDistance then return end
			if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then return end

			if not self.Storage.Boxes[other] then
				self.Storage.Boxes[other] = self:CreateBox()
			end

			local topLeft, width, height = GetScreenBounds(char)
			if not topLeft then return end

			local box = self.Storage.Boxes[other]

			if self.Settings.BoxOutline then
				local t = 0.5
				
				box.Outline.Thickness = 1
				box.Outline.Size = Vector2.new(width + t * 2, height + t * 2)
				box.Outline.Position = topLeft - Vector2.new(t, t)
				box.Outline.Color = self.Settings.BoxOutlineColor
				box.Outline.Visible = true
			end

			if self.Settings.BoxFilled then
				box.Fill.Size = Vector2.new(width, height)
				box.Fill.Position = topLeft
				box.Fill.Color = self.Settings.BoxFillColor
				box.Fill.Transparency = self.Settings.BoxFillTransparency
				box.Fill.Visible = true
			end

			box.Main.Size = Vector2.new(width, height)
			box.Main.Position = topLeft
			box.Main.Color = self.Settings.BoxColor
			box.Main.Visible = true
		end)
	end
end

function EspLib:CreateNametag()
	local tag = Instance.new("TextLabel")
	tag.Parent = self.Gui
	tag.BackgroundColor3 = self.Settings.NametagFillColor
	tag.BackgroundTransparency = self.Settings.NametagFillTransparency
	tag.TextColor3 = self.Settings.NametagTextColor
	tag.TextStrokeTransparency = 0
	tag.TextStrokeColor3 = self.Settings.NametagOutlineColor
	tag.Font = self.Settings.NametagFont
	tag.TextSize = self.Settings.NametagSize
	tag.BorderSizePixel = 0
	tag.TextXAlignment = Enum.TextXAlignment.Center
	tag.TextYAlignment = Enum.TextYAlignment.Center
	tag.Visible = false

	local stroke = Instance.new("UIStroke")
	stroke.Color = self.Settings.NametagOutlineColor
	stroke.Thickness = 1
	stroke.Enabled = self.Settings.NametagOutline
	stroke.Parent = tag

	local corners = Instance.new("UICorner")
	corners.CornerRadius = UDim.new(0, self.Settings.NametagCornerRadius)
	corners.Parent = tag

	return tag
end

function EspLib:UpdateNametags()
	for _, tag in pairs(self.Storage.Nametags) do
		tag.Visible = false
	end

	if not self.Settings.NametagVisible then return end

	for _, other in ipairs(Players:GetPlayers()) do
		if other == LocalPlayer then continue end

		SafeExecute(function()
			local char = other.Character
			if not char then return end

			local root = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChild("Humanoid")
			if not root or not hum or hum.Health <= 0 then return end
			if GetDistance(root.Position) > self.Settings.MaxDistance then return end
			if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then return end

			if not self.Storage.Nametags[other] then
				self.Storage.Nametags[other] = self:CreateNametag()
			end

			local head = char:FindFirstChild("Head")
			local headPos = head and head.Position or (root.Position + Vector3.new(0, 2, 0))
			local screenPos, onScreen = CurrentCamera:WorldToViewportPoint(headPos + Vector3.new(0, 1.5, 0))
			if not onScreen then return end

			local tag = self.Storage.Nametags[other]
			local nameText = other.Name
			local textWidth = #nameText * (self.Settings.NametagSize * 0.55)
			local textHeight = self.Settings.NametagSize * 1.5
			local finalW = textWidth + 16
			local finalH = textHeight + 6

			tag.Text = nameText
			tag.Size = UDim2.new(0, finalW, 0, finalH)
			tag.Position = UDim2.new(0, screenPos.X - finalW * 0.5, 0, screenPos.Y - finalH - 5)
			tag.BackgroundTransparency = self.Settings.NametagFilled and self.Settings.NametagFillTransparency or 1
			tag.BackgroundColor3 = self.Settings.NametagFillColor
			tag.TextColor3 = self.Settings.NametagTextColor
			tag.TextSize = self.Settings.NametagSize

			for _, child in ipairs(tag:GetChildren()) do
				if child:IsA("UIStroke") then
					child.Enabled = self.Settings.NametagOutline
					child.Color = self.Settings.NametagOutlineColor
				end
			end

			tag.Visible = true
		end)
	end
end

function EspLib:CreateHealthbar()
	local bar = {
		Background = Instance.new("Frame"),
		Fill = Instance.new("Frame"),
		Gradient = Instance.new("UIGradient"),
		Current = 100,
		Target = 100
	}

	bar.Background.Parent = self.Gui
	bar.Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bar.Background.BackgroundTransparency = 0.5
	bar.Background.BorderSizePixel = 0
	bar.Background.Visible = false

	bar.Fill.Parent = bar.Background
	bar.Fill.BackgroundTransparency = 0
	bar.Fill.BorderSizePixel = 0

	bar.Gradient.Parent = bar.Fill
	bar.Gradient.Rotation = 90
	bar.Gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, self.Settings.HealthbarColor1),
		ColorSequenceKeypoint.new(0.33, self.Settings.HealthbarColor2),
		ColorSequenceKeypoint.new(0.66, self.Settings.HealthbarColor3),
		ColorSequenceKeypoint.new(1, self.Settings.HealthbarColor4),
	})

	return bar
end

function EspLib:UpdateHealthbars()
	for _, data in pairs(self.Storage.Healthbars) do
		data.Background.Visible = false
	end

	if not self.Settings.HealthbarVisible then return end

	for _, other in ipairs(Players:GetPlayers()) do
		if other == LocalPlayer then continue end

		SafeExecute(function()
			local char = other.Character
			if not char then return end

			local root = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChild("Humanoid")
			if not root or not hum or hum.Health <= 0 then return end
			if GetDistance(root.Position) > self.Settings.MaxDistance then return end
			if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then return end

			if not self.Storage.Healthbars[other] then
				self.Storage.Healthbars[other] = self:CreateHealthbar()
			end

			local topLeft, width, height = GetScreenBounds(char)
			if not topLeft then return end

			local barWidth = self.Settings.HealthbarWidth
			local barX = topLeft.X - barWidth - 3
			local barY = topLeft.Y
			local healthPercent = math.clamp(hum.Health / hum.MaxHealth * 100, 0, 100)

			local data = self.Storage.Healthbars[other]
			data.Target = healthPercent
			data.Current = LerpNumber(data.Current, data.Target, self.Settings.HealthbarSpeed)

			data.Background.Size = UDim2.new(0, barWidth, 0, height)
			data.Background.Position = UDim2.new(0, barX, 0, barY)
			data.Background.Visible = true

			local fillH = height * (data.Current / 100)
			data.Fill.Size = UDim2.new(1, 0, 0, fillH)
			data.Fill.Position = UDim2.new(0, 0, 0, height - fillH)
		end)
	end
end

function EspLib:CreateArmorbar()
	local bar = {
		Background = Instance.new("Frame"),
		Fill = Instance.new("Frame"),
		Gradient = Instance.new("UIGradient"),
		Text = Instance.new("TextLabel"),
	}

	bar.Background.Parent = self.Gui
	bar.Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bar.Background.BackgroundTransparency = 0.5
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
		ColorSequenceKeypoint.new(1, self.Settings.ArmorbarColor3),
	})

	bar.Text.Parent = self.Gui
	bar.Text.BackgroundTransparency = 1
	bar.Text.TextSize = 11
	bar.Text.Font = Enum.Font.GothamBold
	bar.Text.TextColor3 = Color3.fromRGB(135, 206, 235)
	bar.Text.TextStrokeTransparency = 0
	bar.Text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	bar.Text.Visible = false

	return bar
end

function EspLib:UpdateArmorbars()
	for _, data in pairs(self.Storage.Armorbars) do
		data.Background.Visible = false
		data.Text.Visible = false
	end

	if not self.Settings.ArmorbarVisible then return end

	for _, other in ipairs(Players:GetPlayers()) do
		if other == LocalPlayer then continue end

		SafeExecute(function()
			local char = other.Character
			if not char then return end

			local root = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChild("Humanoid")
			if not root or not hum or hum.Health <= 0 then return end
			if GetDistance(root.Position) > self.Settings.MaxDistance then return end
			if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then return end

			if not self.Storage.Armorbars[other] then
				self.Storage.Armorbars[other] = self:CreateArmorbar()
			end

			local topLeft, width, height = GetScreenBounds(char)
			if not topLeft then return end

			local bodyEffects = char:FindFirstChild("BodyEffects")
			local armorVal = bodyEffects and bodyEffects:FindFirstChild("Armor") and bodyEffects.Armor.Value or 0
			local armorPct = math.clamp(armorVal, 0, 100)

			local barWidth = self.Settings.ArmorbarWidth
			local offset = self.Settings.HealthbarVisible and (self.Settings.HealthbarWidth + 5) or 0
			local barX = topLeft.X - barWidth - 3 - offset
			local barY = topLeft.Y

			local data = self.Storage.Armorbars[other]
			data.Background.Size = UDim2.new(0, barWidth, 0, height)
			data.Background.Position = UDim2.new(0, barX, 0, barY)
			data.Background.Visible = true

			local fillH = height * (armorPct / 100)
			data.Fill.Size = UDim2.new(1, 0, 0, fillH)
			data.Fill.Position = UDim2.new(0, 0, 0, height - fillH)

			if armorPct > 0 then
				data.Text.Text = math.floor(armorPct) .. "%"
				data.Text.Position = UDim2.new(0, barX - 25, 0, barY + height * (1 - armorPct / 100) - 8)
				data.Text.Visible = true
			end
		end)
	end
end

function EspLib:CreateRing()
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

	return {Holder = holder, Ring = ring}
end

function EspLib:UpdateRings()
	for _, data in pairs(self.Storage.Rings) do
		data.Ring.Visible = false
	end

	if not self.Settings.RingVisible then return end

	local t = tick()

	for _, other in ipairs(Players:GetPlayers()) do
		if other == LocalPlayer then continue end

		SafeExecute(function()
			local char = other.Character
			if not char then return end

			local root = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChild("Humanoid")
			if not root or not hum or hum.Health <= 0 then return end
			if GetDistance(root.Position) > self.Settings.MaxDistance then return end
			if self.Settings.TeamCheck and LocalPlayer.Team and other.Team == LocalPlayer.Team then return end

			if not self.Storage.Rings[other] then
				self.Storage.Rings[other] = self:CreateRing()
			end

			local data = self.Storage.Rings[other]
			local yOffset = math.sin(t * self.Settings.RingSpeed) * self.Settings.RingHeight
			data.Holder.CFrame = root.CFrame * CFrame.new(0, yOffset, 0)
			data.Ring.Color3 = self.Settings.RingColor
			data.Ring.Transparency = 0.2 + math.abs(math.sin(t * self.Settings.RingSpeed)) * 0.4
			data.Ring.Visible = true
		end)
	end
end

function EspLib:ClearAll()
	for _, box in pairs(self.Storage.Boxes) do DestroyBox(box) end
	for _, tag in pairs(self.Storage.Nametags) do tag:Destroy() end
	for _, bar in pairs(self.Storage.Healthbars) do bar.Background:Destroy() end
	for _, bar in pairs(self.Storage.Armorbars) do bar.Background:Destroy(); bar.Text:Destroy() end
	for _, ring in pairs(self.Storage.Rings) do ring.Holder:Destroy() end

	self.Storage.Boxes = {}
	self.Storage.Nametags = {}
	self.Storage.Healthbars = {}
	self.Storage.Armorbars = {}
	self.Storage.Rings = {}
end

function EspLib:Destroy()
	self:ClearAll()
	if RenderConn then RenderConn:Disconnect() end
	if self.Gui then self.Gui:Destroy() end
end

function EspLib:SetBox(enabled, color, filled, fillColor, transparency, outline, outlineColor)
	self.Settings.BoxVisible = enabled
	if color then self.Settings.BoxColor = color end
	if filled ~= nil then self.Settings.BoxFilled = filled end
	if fillColor then self.Settings.BoxFillColor = fillColor end
	if transparency then self.Settings.BoxFillTransparency = transparency end
	if outline ~= nil then self.Settings.BoxOutline = outline end
	if outlineColor then self.Settings.BoxOutlineColor = outlineColor end
end

function EspLib:SetNametag(enabled, filled, fillTransparency, fillColor, textColor, outlineColor, fontSize, cornerRadius)
	self.Settings.NametagVisible = enabled
	if filled ~= nil then self.Settings.NametagFilled = filled end
	if fillTransparency then self.Settings.NametagFillTransparency = fillTransparency end
	if fillColor then self.Settings.NametagFillColor = fillColor end
	if textColor then self.Settings.NametagTextColor = textColor end
	if outlineColor then self.Settings.NametagOutlineColor = outlineColor end
	if fontSize then self.Settings.NametagSize = fontSize end
	if cornerRadius then self.Settings.NametagCornerRadius = cornerRadius end
end

function EspLib:SetHealthbar(enabled, width, color1, color2, color3)
	self.Settings.HealthbarVisible = enabled
	if width then self.Settings.HealthbarWidth = width end
	if color1 then self.Settings.HealthbarColor1 = color1 end
	if color2 then self.Settings.HealthbarColor2 = color2 end
	if color3 then self.Settings.HealthbarColor3 = color3 end
	if color4 then self.Settings.HealthbarColor4 = color4 end
end

function EspLib:SetArmorbar(enabled, width, color1, color2, color3)
	self.Settings.ArmorbarVisible = enabled
	if width then self.Settings.ArmorbarWidth = width end
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

function EspLib:SetTeamCheck(enabled) self.Settings.TeamCheck = enabled end
function EspLib:SetDistance(distance) self.Settings.MaxDistance = distance end

function EspLib:Init()
	self.Gui = Instance.new("ScreenGui")
	self.Gui.Name = "EspGui"
	self.Gui.Parent = LocalPlayer.PlayerGui
	self.Gui.IgnoreGuiInset = true
	self.Gui.ResetOnSpawn = false

	Players.PlayerRemoving:Connect(function(removed)
		SafeExecute(function()
			if self.Storage.Boxes[removed] then
				DestroyBox(self.Storage.Boxes[removed])
				self.Storage.Boxes[removed] = nil
			end
			if self.Storage.Nametags[removed] then
				self.Storage.Nametags[removed]:Destroy()
				self.Storage.Nametags[removed] = nil
			end
			if self.Storage.Healthbars[removed] then
				self.Storage.Healthbars[removed].Background:Destroy()
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

	RenderConn = RunService.RenderStepped:Connect(function()
		SafeExecute(function()
			self:UpdateBoxes()
			self:UpdateNametags()
			self:UpdateHealthbars()
			self:UpdateArmorbars()
			self:UpdateRings()
		end)
	end)
end

return EspLib
