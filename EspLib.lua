-- ESP + PopupSpam Combined Module

local PlayersFolder = workspace:WaitForChild("Players")
local SurvivorsFolder = PlayersFolder:WaitForChild("Survivors")
local KillersFolder = PlayersFolder:WaitForChild("Killers")
local LocalPlayer = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

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
	local r = math.sin(t * 2) * 0.5 + 0.5
	local g = math.sin(t * 2 + 2) * 0.5 + 0.5
	local b = math.sin(t * 2 + 4) * 0.5 + 0.5
	return Color3.new(r, g, b)
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

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 0.33, 0)
	nameLabel.Position = UDim2.new(0, 0, 0.00, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = text
	nameLabel.TextStrokeTransparency = 0.5
	nameLabel.TextScaled = true
	nameLabel.Font = Enum.Font.SourceSansBold
	nameLabel.Name = "NameLabel"
	nameLabel.Parent = billboard

	local hpLabel = Instance.new("TextLabel")
	hpLabel.Size = UDim2.new(1, 0, 0.33, 0)
	hpLabel.Position = UDim2.new(0, 0, 0.33, 0)
	hpLabel.BackgroundTransparency = 1
	hpLabel.TextStrokeTransparency = 0.5
	hpLabel.TextScaled = true
	hpLabel.Font = Enum.Font.SourceSans
	hpLabel.Name = "HPLabel"
	hpLabel.Text = ""
	hpLabel.Parent = billboard

	local distLabel = Instance.new("TextLabel")
	distLabel.Size = UDim2.new(1, 0, 0.33, 0)
	distLabel.Position = UDim2.new(0, 0, 0.66, 0)
	distLabel.BackgroundTransparency = 1
	distLabel.TextStrokeTransparency = 0.5
	distLabel.TextScaled = true
	distLabel.Font = Enum.Font.SourceSansItalic
	distLabel.Name = "DistLabel"
	distLabel.Parent = billboard
end

local function updateTag(model, defaultColor)
	local tag = model:FindFirstChild("ESPNameTag")
	if not tag then return end
	local head = model:FindFirstChild("Head") or model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart")
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if not head then return end

	local hpLabel = tag:FindFirstChild("HPLabel")
	local distLabel = tag:FindFirstChild("DistLabel")
	local nameLabel = tag:FindFirstChild("NameLabel")
	local color = ESPConfig.rainbow and getRainbowColor() or defaultColor

	if nameLabel then nameLabel.TextColor3 = color end
	if hpLabel then
		if humanoid then
			local hp = math.floor(humanoid.Health)
			local maxHp = math.floor(humanoid.MaxHealth)
			hpLabel.Text = tostring(hp) .. "/" .. tostring(maxHp)
		else
			hpLabel.Text = ""
		end
		hpLabel.TextColor3 = color
	end
	if distLabel then
		local char = LocalPlayer.Character
		if model ~= char and char and char:FindFirstChild("HumanoidRootPart") then
			distLabel.Text = ESPConfig.showstuds and string.format("%.0fm away", (char.HumanoidRootPart.Position - head.Position).Magnitude) or ""
		else
			distLabel.Text = ""
		end
		distLabel.TextColor3 = color
	end
end

local function espAll()
	if ESPConfig.survivors then
		for _, model in pairs(SurvivorsFolder:GetChildren()) do
			attachNameTag(model, model.Name)
			updateTag(model, Color3.fromRGB(255, 255, 255))
		end
	end

	if ESPConfig.killers then
		for _, model in pairs(KillersFolder:GetChildren()) do
			attachNameTag(model, model.Name)
			updateTag(model, Color3.fromRGB(255, 0, 0))
		end
	end

	local itemFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
	if itemFolder then
		if ESPConfig.items then
			for _, obj in pairs(itemFolder:GetChildren()) do
				if obj.Name == "BloxyCola" or obj.Name == "Medkit" then
					attachNameTag(obj, obj.Name)
					updateTag(obj, Color3.fromRGB(255, 255, 255))
				end
			end
		end
		if ESPConfig.projectiles then
			for _, obj in pairs(itemFolder:GetChildren()) do
				if obj.Name == "shockwave" then
					attachNameTag(obj, "Mass Infection")
					updateTag(obj, Color3.fromRGB(255, 255, 255))
				elseif obj.Name == "Swords" then
					attachNameTag(obj, "Entanglement")
					updateTag(obj, Color3.fromRGB(255, 255, 255))
				end
			end
		end
		if ESPConfig.minions then
			for _, obj in pairs(itemFolder:GetChildren()) do
				if obj.Name == "1x1x1x1Zombie" then
					attachNameTag(obj, "1x1x1x1 Zombie")
					updateTag(obj, Color3.fromRGB(0, 255, 0))
				end
			end
		end
		if ESPConfig.generators then
			local mapFolder = itemFolder:FindFirstChild("Map")
			if mapFolder then
				for _, gen in pairs(mapFolder:GetChildren()) do
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
	task.delay(1, function()
		dot:Remove()
	end)
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

local screenSize = Camera.ViewportSize
local screenW = screenSize.X
local screenH = screenSize.Y
local spacing = 100

local function popupClickSpam()
	while popupLoop do
		if isSwordsNear() then
			for y = 0, screenH, spacing do
				for x = 0, screenW, spacing do
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
-- RETURN BOTH AS MODULE
--------------------------------------------------

return {
	ESPConfig = ESPConfig,
	setPopupEnabled = setPopupEnabled,
	popupClickSpam = popupClickSpam
}
