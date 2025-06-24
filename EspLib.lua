-- Combined ESP + PopupSpam + FullBright + AntiStun Module

-- Services
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local VIM = game:GetService("VirtualInputManager")
local lp = Players.LocalPlayer
local LocalPlayer = lp
local Camera = workspace.CurrentCamera
local PlayersFolder = workspace:WaitForChild("Players")
local SurvivorsFolder = PlayersFolder:WaitForChild("Survivors")
local KillersFolder = PlayersFolder:WaitForChild("Killers")

--------------------------------------------------
-- GLOBAL STATE HOLDER
--------------------------------------------------

_G = rawget(_G, "_G") or {}
_G.FullBrightExecuted = _G.FullBrightExecuted or false
_G.FullBrightEnabled = _G.FullBrightEnabled or false
_G.AntiStun = _G.AntiStun or false

--------------------------------------------------
-- ESP SECTION
--------------------------------------------------

local ESPConfig = {
	killers = false,
	survivors = false,
	items = false,
	generators = false,
	projectiles = false,
	minions = false,
	showstuds = false,
	rainbow = false
}

local function getRainbowColor()
	local t = tick()
	return Color3.new(
		math.sin(t * 2) * 0.5 + 0.5,
		math.sin(t * 2 + 2) * 0.5 + 0.5,
		math.sin(t * 2 + 4) * 0.5 + 0.5
	)
end

local function attachNameTag(model, text)
	if model:FindFirstChild("ESPNameTag") then return end
	local attachTo = model:FindFirstChild("Head") or model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart")
	if not attachTo then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESPNameTag"
	billboard.Adornee = attachTo
	billboard.Size = UDim2.new(0, 100, 0, 60)
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = model

	for i, name in ipairs({ "NameLabel", "HPLabel", "DistLabel" }) do
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 0.33, 0)
		label.Position = UDim2.new(0, 0, (i - 1) * 0.33, 0)
		label.BackgroundTransparency = 1
		label.TextStrokeTransparency = 0.5
		label.TextScaled = true
		label.Font = Enum.Font.SourceSansBold
		label.Name = name
		label.Text = ""
		label.Parent = billboard
	end

	billboard.NameLabel.Text = text
end

local function updateTag(model, defaultColor)
	local tag = model:FindFirstChild("ESPNameTag")
	if not tag then return end
	local head = model:FindFirstChild("Head") or model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart")
	if not head then return end

	local humanoid = model:FindFirstChildOfClass("Humanoid")
	local hpLabel = tag:FindFirstChild("HPLabel")
	local distLabel = tag:FindFirstChild("DistLabel")
	local nameLabel = tag:FindFirstChild("NameLabel")
	local color = ESPConfig.rainbow and getRainbowColor() or defaultColor

	if nameLabel then nameLabel.TextColor3 = color end
	if hpLabel and humanoid then
		hpLabel.Text = ("%d/%d"):format(humanoid.Health, humanoid.MaxHealth)
		hpLabel.TextColor3 = color
	end
	if distLabel then
		local char = LocalPlayer.Character
		if model ~= char and char and char:FindFirstChild("HumanoidRootPart") then
			distLabel.Text = ESPConfig.showstuds and ("%dm away"):format((char.HumanoidRootPart.Position - head.Position).Magnitude) or ""
			distLabel.TextColor3 = color
		end
	end
end

local function espAll()
	if ESPConfig.survivors then
		for _, m in pairs(SurvivorsFolder:GetChildren()) do
			attachNameTag(m, m.Name)
			updateTag(m, Color3.fromRGB(255, 255, 255))
		end
	end
	if ESPConfig.killers then
		for _, m in pairs(KillersFolder:GetChildren()) do
			attachNameTag(m, m.Name)
			updateTag(m, Color3.fromRGB(255, 0, 0))
		end
	end

	local map = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
	if map then
		if ESPConfig.items then
			for _, obj in pairs(map:GetChildren()) do
				if obj.Name == "BloxyCola" or obj.Name == "Medkit" then
					attachNameTag(obj, obj.Name)
					updateTag(obj, Color3.fromRGB(255, 255, 255))
				end
			end
		end
		if ESPConfig.projectiles then
			for _, obj in pairs(map:GetChildren()) do
				local nameMap = {
					Shockwave = "Mass Infection",
					Swords = "Entanglement",
					HumanoidRootProjectile = "Corrupt Nature"
				}
				if nameMap[obj.Name] then
					attachNameTag(obj, nameMap[obj.Name])
					updateTag(obj, Color3.fromRGB(255, 0, 0))
				end
			end
		end
		if ESPConfig.minions then
			for _, obj in pairs(map:GetChildren()) do
				local nameMap = {
					["1x1x1x1Zombie"] = "1x1x1x1 Zombie",
					["PizzaDeliveryRig"] = "Pizza Delivery"
				}
				if nameMap[obj.Name] then
					attachNameTag(obj, nameMap[obj.Name])
					updateTag(obj, Color3.fromRGB(0, 255, 0))
				end
			end
		end
		if ESPConfig.generators then
			local folder = map:FindFirstChild("Map")
			if folder then
				for _, gen in pairs(folder:GetChildren()) do
					if gen.Name == "Generator" then
						attachNameTag(gen, "Generator")
						updateTag(gen, Color3.fromRGB(255, 255, 0))
					end
				end
			end
		end
	end
end

task.spawn(function()
	while true do
		task.wait(0.1)
		espAll()
	end
end)

--------------------------------------------------
-- POPUP SPAM SECTION
--------------------------------------------------

local popupLoop = false

local function drawClick(x, y)
	local dot = Drawing.new("Circle")
	dot.Position = Vector2.new(x, y)
	dot.Radius = 5
	dot.Color = Color3.new(1, 1, 0)
	dot.Filled = true
	dot.Visible = true
	task.delay(1, function() dot:Remove() end)
end

local function clickAt(x, y)
	VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
	VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
	drawClick(x, y)
end

local function isSwordsNear()
	local char = lp.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local swords = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame"):FindFirstChild("Swords")
	return hrp and swords and swords:IsA("BasePart") and (hrp.Position - swords.Position).Magnitude <= 5
end

local function popupClickSpam()
	local screenSize = Camera.ViewportSize
	local spacing = 100
	while popupLoop do
		if isSwordsNear() then
			for y = 0, screenSize.Y, spacing do
				for x = 0, screenSize.X, spacing do
					if not popupLoop then return end
					clickAt(x, y)
					task.wait(0.01)
				end
			end
		else
			task.wait(0.2)
		end
	end
end

local function setPopupEnabled(state)
	popupLoop = state
end

--------------------------------------------------
-- FULLBRIGHT SECTION
--------------------------------------------------

if not _G.FullBrightExecuted then
	_G.NormalLightingSettings = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		FogEnd = Lighting.FogEnd,
		GlobalShadows = Lighting.GlobalShadows,
		Ambient = Lighting.Ambient
	}

	local function forceFullBright()
		Lighting.Brightness = 1
		Lighting.ClockTime = 12
		Lighting.FogEnd = 786543
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.fromRGB(178, 178, 178)
	end

	local function restoreLighting()
		local s = _G.NormalLightingSettings
		Lighting.Brightness = s.Brightness
		Lighting.ClockTime = s.ClockTime
		Lighting.FogEnd = s.FogEnd
		Lighting.GlobalShadows = s.GlobalShadows
		Lighting.Ambient = s.Ambient
	end

	for _, prop in ipairs({ "Brightness", "ClockTime", "FogEnd", "GlobalShadows", "Ambient" }) do
		Lighting:GetPropertyChangedSignal(prop):Connect(function()
			if _G.FullBrightEnabled then forceFullBright() end
		end)
	end

	forceFullBright()

	task.spawn(function()
		local last = _G.FullBrightEnabled
		while task.wait(1) do
			if _G.FullBrightEnabled ~= last then
				last = _G.FullBrightEnabled
				if last then forceFullBright() else restoreLighting() end
			end
		end
	end)

	_G.FullBrightExecuted = true
end

--------------------------------------------------
-- ANTISTUN SECTION
--------------------------------------------------

local function setupCharacter(char)
	local humanoid = char:WaitForChild("Humanoid")
	humanoid.Sit = false
	local connections = {}

	local function fixState(newState)
		if _G.AntiStun and (
			newState == Enum.HumanoidStateType.Ragdoll or
			newState == Enum.HumanoidStateType.FallingDown or
			newState == Enum.HumanoidStateType.Seated or
			newState == Enum.HumanoidStateType.PlatformStanding
		) then
			humanoid.Sit = false
			humanoid.PlatformStand = false
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			if char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.Anchored = false
			end
		end
	end

	fixState(humanoid:GetState())

	table.insert(connections, humanoid.StateChanged:Connect(function(_, new)
		fixState(new)
	end))

	for _, seat in pairs(workspace:GetDescendants()) do
		if seat:IsA("Seat") then
			table.insert(connections, seat:GetPropertyChangedSignal("Occupant"):Connect(function()
				if seat.Occupant == humanoid then
					task.wait(0.1)
					humanoid.Sit = false
					humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
			end))
		end
	end

	table.insert(connections, humanoid.Died:Connect(function()
		for _, conn in ipairs(connections) do conn:Disconnect() end
	end))
end

if lp.Character then setupCharacter(lp.Character) end
lp.CharacterAdded:Connect(setupCharacter)

--------------------------------------------------
-- EXPORT MODULE
--------------------------------------------------

return {
	ESPConfig = ESPConfig,
	setPopupEnabled = setPopupEnabled,
	popupClickSpam = popupClickSpam,
	_G = _G -- Access FullBright and AntiStun toggles
}
