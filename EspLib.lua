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

local global = rawget(_G, "_G") or {}
_G._G = global
_G.FullBrightExecuted = _G.FullBrightExecuted or false
_G.FullBrightEnabled = _G.FullBrightEnabled or false
_G.AntiStun = _G.AntiStun or false
_G.ACAG = _G.ACAG or false
_G.ShowInstantFixGUI = _G.ShowInstantFixGUI or true
_G.InstantFixCooldownSpeed = _G.InstantFixCooldownSpeed or 2

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
				local progress = gen:FindFirstChild("Progress")
				if progress and progress:IsA("NumberValue") and progress.Value >= 78 then
					attachNameTag(gen, " ") -- make sure the tag exists

					local tag = gen:FindFirstChild("ESPNameTag")
					if tag then
						local nameLabel = tag:FindFirstChild("NameLabel")
						local hpLabel = tag:FindFirstChild("HPLabel")
						local distLabel = tag:FindFirstChild("DistLabel")
						if nameLabel then nameLabel.Text = " " end
						if hpLabel then hpLabel.Text = " " end
						if distLabel then distLabel.Text = " " end
					end

					continue -- skip updating this gen
				end

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
-- POPUP SPAM SECTION (FIXED)
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
	local swords = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Swords")
	return hrp and swords and swords:IsA("BasePart") and (hrp.Position - swords.Position).Magnitude <= 5
end

local function popupClickSpam()
	local spacing = 100
	while popupLoop do
		if isSwordsNear() then
			local screenSize = Camera.ViewportSize
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

	task.spawn(function()
		while true do
			if _G.FullBrightEnabled then
				forceFullBright()
			end
			task.wait(3)
		end
	end)

	task.spawn(function()
		local last = _G.FullBrightEnabled
		while true do
			task.wait(1)
			if _G.FullBrightEnabled ~= last then
				last = _G.FullBrightEnabled
				if last then
					forceFullBright()
				else
					restoreLighting()
				end
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
-- AUTO COMPLETE AUTO GENERATOR (ACAG) SYSTEM
--------------------------------------------------

local ran = false
local isTriggered = false

local function waitForGenerator()
	while true do
		if not global.ACAG then return end
		local map = workspace:FindFirstChild("Map")
		local ingame = map and map:FindFirstChild("Ingame")
		local nested = ingame and ingame:FindFirstChild("Map")
		if nested then
			for _, gen in pairs(nested:GetChildren()) do
				if gen.Name == "Generator" then
					return gen
				end
			end
		end
		task.wait(0.5)
	end
end

local function getFreePosition(generator)
	local positions = generator:FindFirstChild("Positions")
	if not positions then return nil end

	local center = positions:FindFirstChild("Center")
	local left = positions:FindFirstChild("Left")
	local right = positions:FindFirstChild("Right")

	if not center or not left or not right then return nil end

	local occupied = {
		Center = false,
		Left = false,
		Right = false
	}

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local pos = plr.Character.HumanoidRootPart.Position
			if (pos - center.Position).Magnitude <= 1 then
				occupied.Center = true
			elseif (pos - left.Position).Magnitude <= 1 then
				occupied.Left = true
			elseif (pos - right.Position).Magnitude <= 1 then
				occupied.Right = true
			end
		end
	end

	if not occupied.Center then return center end
	if not occupied.Left then return left end
	if not occupied.Right then return right end

	return nil
end

local function startRepairLoop(generator)
	if not isTriggered then return end

	local remotes = generator:FindFirstChild("Remotes")
	local remoteBE = remotes and remotes:FindFirstChild("BE")
	local remoteRE = remotes and remotes:FindFirstChild("RE")
	local progress = generator:FindFirstChild("Progress")
	local center = generator:FindFirstChild("Positions") and generator.Positions:FindFirstChild("Center")

	task.spawn(function()
		while generator.Parent and global.ACAG do
			local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
			if root and center and (root.Position - center.Position).Magnitude <= 10 then
				if progress and progress.Value >= 80 then
					local gui = generator:FindFirstChild("GUI")
					if gui then gui:Destroy() end
					generator:Destroy()
					isTriggered = false
					task.wait(0.5)
					local nextGen = waitForGenerator()
					if nextGen then
						teleportAndInteract(nextGen)
					end
					break
				end
				if remoteBE then pcall(function() remoteBE:FireServer() end) end
				if remoteRE then pcall(function() remoteRE:FireServer() end) end
				task.wait(2)
			end
			task.wait(0.5)
		end
	end)
end

function teleportAndInteract(generator)
	if isTriggered then return end
	local prompt = generator:FindFirstChildWhichIsA("ProximityPrompt", true)
	local targetPos = getFreePosition(generator)
	if not targetPos then
		generator:Destroy()
		isTriggered = false
		task.wait(0.5)
		local nextGen = waitForGenerator()
		if nextGen then
			teleportAndInteract(nextGen)
		end
		return
	end

	task.spawn(function()
		task.wait(0.5)
		local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if not root then return end

		root.CFrame = targetPos.CFrame + Vector3.new(0, 3, 0)
		task.wait(0.25)
		if prompt then
			pcall(function() fireproximityprompt(prompt) end)
		end
		isTriggered = true
		startRepairLoop(generator)
	end)
end

task.spawn(function()
	local lastState = false
	while true do
		task.wait(0.25)
		local currentState = global.ACAG
		if currentState ~= lastState then
			lastState = currentState

			if currentState then
				print("[ACAG] Enabled.")
				ran = false
				isTriggered = false
				task.spawn(function()
					while global.ACAG and not ran do
						local generator = waitForGenerator()
						if generator then
							ran = true
							teleportAndInteract(generator)
						end
						task.wait(0.5)
					end
				end)
			else
				print("[ACAG] Disabled.")
				ran = true
				isTriggered = false
			end
		end
	end
end)
-- INSTANT FIX GUI + LOGIC

local function createInstantFixGUI()
	local gui = Instance.new("ScreenGui")
	gui.Name = "InstantFixUI"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.Parent = lp:WaitForChild("PlayerGui")

	local button = Instance.new("TextButton")
	button.Name = "InstantFixButton"
	button.Size = UDim2.new(0, 120, 0, 40)
	button.Position = UDim2.new(1, -160, 0, 60)
	button.AnchorPoint = Vector2.new(0.5, 0.5)
	button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.GothamBold
	button.TextScaled = true
	button.Text = "Instant Fix"
	button.BorderSizePixel = 0
	button.Visible = _G.ShowInstantFixGUI
	button.Parent = gui

	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
	Instance.new("UIStroke", button).Thickness = 1.5

	local isCooldown = false

	local function findNearbyGenerator()
		local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return nil
		end

		local map = workspace:FindFirstChild("Map")
		local ingame = map and map:FindFirstChild("Ingame")
		local nested = ingame and ingame:FindFirstChild("Map")
		if not nested then return nil end

		for _, gen in pairs(nested:GetChildren()) do
			if gen.Name == "Generator" then
				local pos = gen:FindFirstChild("Positions")
				local center = pos and pos:FindFirstChild("Center")
				if center and (hrp.Position - center.Position).Magnitude <= 10 then
					return gen
				end
			end
		end

		return nil
	end

	local function repairGenerator(generator)
		if not generator then return end
		local remotes = generator:FindFirstChild("Remotes")
		local remoteBE = remotes and remotes:FindFirstChild("BE")
		local remoteRE = remotes and remotes:FindFirstChild("RE")
		local progress = generator:FindFirstChild("Progress")

		task.spawn(function()
			if remoteBE then pcall(function() remoteBE:FireServer() end) end
			if remoteRE then pcall(function() remoteRE:FireServer() end) end
		end)
	end

	button.MouseButton1Click:Connect(function()
		if isCooldown then return end
		isCooldown = true

		local gen = findNearbyGenerator()
		if gen then
			repairGenerator(gen)
		end

		local cooldown = tonumber(_G.InstantFixCooldownSpeed) or 2
		local t = cooldown
		while t > 0 do
			button.Text = string.format("%.1fs", t)
			button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			task.wait(0.1)
			t -= 0.1
		end

		button.Text = "Instant Fix"
		button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		isCooldown = false
	end)

	-- Visibility toggle
	task.spawn(function()
		while true do
			task.wait(0.5)
			pcall(function()
				button.Visible = _G.ShowInstantFixGUI
			end)
		end
	end)
end

createInstantFixGUI()

--------------------------------------------------
-- EXPORT MODULE
--------------------------------------------------

return {
	ESPConfig = ESPConfig,
	setPopupEnabled = setPopupEnabled,
	popupClickSpam = popupClickSpam,
	_G = global
}
