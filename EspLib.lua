local PlayersFolder = workspace:WaitForChild("Players")
local SurvivorsFolder = PlayersFolder:WaitForChild("Survivors")
local KillersFolder = PlayersFolder:WaitForChild("Killers")
local LocalPlayer = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- CONFIG
local ESPConfig = {
	killers = true,
	survivors = true,
	showstuds = true,
	rainbow = true
}

-- Rainbow function
local function getRainbowColor()
	local t = tick()
	local r = math.sin(t * 2) * 0.5 + 0.5
	local g = math.sin(t * 2 + 2) * 0.5 + 0.5
	local b = math.sin(t * 2 + 4) * 0.5 + 0.5
	return Color3.new(r, g, b)
end

local function attachNameTag(model, text)
	if not model:FindFirstChild("Head") then return end
	if model:FindFirstChild("ESPNameTag") then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESPNameTag"
	billboard.Adornee = model.Head
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

	local head = model:FindFirstChild("Head")
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if not (head and humanoid) then return end

	local hpLabel = tag:FindFirstChild("HPLabel")
	local distLabel = tag:FindFirstChild("DistLabel")
	local nameLabel = tag:FindFirstChild("NameLabel")

	local color = ESPConfig.rainbow and getRainbowColor() or defaultColor

	if nameLabel then
		nameLabel.TextColor3 = color
	end
	if hpLabel then
		local hp = math.floor(humanoid.Health)
		local maxHp = math.floor(humanoid.MaxHealth)
		hpLabel.Text = tostring(hp) .. "/" .. tostring(maxHp)
		hpLabel.TextColor3 = color
	end
	if distLabel then
		local char = LocalPlayer.Character
		if model ~= char and char and char:FindFirstChild("HumanoidRootPart") then
			if ESPConfig.showstuds then
				local dist = (char.HumanoidRootPart.Position - head.Position).Magnitude
				distLabel.Text = string.format("%.0fm away", dist)
			else
				distLabel.Text = ""
			end
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
end

espAll()

task.spawn(function()
	while true do
		task.wait(0.1)
		espAll()
	end
end)

return {
	ESPConfig = ESPConfig
}
