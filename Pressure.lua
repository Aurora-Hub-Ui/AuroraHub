if getgenv().Rayfield then getgenv().Rayfield = nil end

pcall(function()
	local gui = game:GetService("CoreGui"):FindFirstChild("Rayfield")
	if gui then gui:Destroy() end
end)

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Aurora-Hub-Ui/AuroraHub/main/Script.lua"))()

local correctKey = { "DELIGHT" }
local keyPath = "PressureHub/PressureK.txt"
local discordLink = "https://discord.gg/QmvpbPdw9J"
setclipboard(discordLink)

print("AzureHub By Cat\nDiscord: https://discord.gg/QmvpbPdw9J")

local Window = Rayfield:CreateWindow({
	Name = "Azure Hub | Pressure 0.1",
	LoadingTitle = "Azure Hub",
	LoadingSubtitle = "Initializing...",
	ToggleUIKeybind = Enum.KeyCode.K,
	Theme = "DarkBlue",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "PressureHub",
		FileName = "PressureConfig"
	},
	Discord = { Enabled = false },
	KeySystem = true,
	KeySettings = {
		Title = "Key System",
		Subtitle = "Enter your key below",
		Note = "Get your key from our Discord server. Link has been copied.",
		FileName = "PressureK",
		SaveKey = true,
		Key = correctKey
	}
})

Window.ModifyTheme('Amethyst')

Rayfield:Notify({
	Title = "Logged In",
	Content = "Successfully logged in! Thanks for choosing us.",
	Duration = 2,
	Image = "thumbs-up"
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local lp = Players.LocalPlayer

local humanoid = nil
local currentSpeed = 28
local ESPToggle = false
local StudsToggle = false
local AuraToggle = false
local MonsterToggle = false
local MonsterToggleChat = false
local NoclipToggle = false
local WalkToggle = false
local espLabels = {}

local function applyBypassSpeed()
	RunService.Heartbeat:Connect(function()
		if not WalkToggle then return end
		local char = lp.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		if not hum or not root then return end

		if hum.MoveDirection.Magnitude > 0 then
			root.Velocity = hum.MoveDirection * currentSpeed
			hum.WalkSpeed = currentSpeed
		end
	end)
end

applyBypassSpeed()

local Tab_Main = Window:CreateTab("Main", "home")
local Tab_Player = Window:CreateTab("Player", "users-round")
local Tab_Esp = Window:CreateTab("ESP", "eye")

Tab_Main:CreateSection("Main Settings")
Tab_Main:CreateToggle({
	Name = "Loot Aura",
	CurrentValue = false,
	Flag = "AuraToggle",
	Callback = function(Value)
	       AuraToggle = Value
	end
})

Tab_Main:CreateToggle({
	Name = "Notify About Monster",
	CurrentValue = false,
	Flag = "MonsterToggle",
	Callback = function(Value)
	       MonsterToggle = Value
	end
})

Tab_Main:CreateToggle({
	Name = "Notify About Monster (Chat)",
	CurrentValue = false,
	Flag = "MonsterToggleChat",
	Callback = function(Value)
	       MonsterToggleChat = Value
	end
})

Tab_Main:CreateDivider()
Tab_Main:CreateButton({
	Name = "Remove All Searchlights",
	Callback = function()
		local removed = 0
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and string.find(obj.Name:lower(), "searchlight") then
				obj:Destroy()
				removed += 1
			end
		end
		if removed == 0 then
		   Rayfield:Notify({
			Title = "Not Found",
			Content = "0 Searchlights were found.",
			Duration = 2,
			Image = "x"
		   })
		else
		Rayfield:Notify({
			Title = "Searchlights Removed",
			Content = "Removed " .. removed .. " Searchlights.",
			Duration = 4,
			Image = "check"
		})
		end
	end
})

Tab_Main:CreateButton({
	Name = "God Mode (UI)",
	Callback = function()
	      loadstring(game:HttpGet("https://raw.githubusercontent.com/Aurora-Hub-Ui/AuroraHub/main/GodMode.lua"))()
	end
})

local namecallHooked = false

Tab_Main:CreateButton({
	Name = "No Damage",
	Callback = function()
		local RS = game:GetService("ReplicatedStorage")
		local Events = RS:WaitForChild("Events", 5)

		if not namecallHooked then
			local remote = Events:FindFirstChild("LocalDamage")

			if remote and remote:IsA("RemoteEvent") then
				local mt = getrawmetatable(game)
				setreadonly(mt, false)

				local oldNamecall = mt.__namecall
				mt.__namecall = newcclosure(function(self, ...)
					local method = getnamecallmethod()
					if self == remote and (method == "FireServer" or method == "FireClient") then
						return
					end
					return oldNamecall(self, ...)
				end)

				local Blocked = Instance.new("BoolValue")
				Blocked.Name = "Blocked"
				Blocked.Parent = remote

				namecallHooked = true
			else
			end
		else
		end
	end
})

local Noclip = nil
local Clip = nil
local function noclip()
	Clip = false
	if Noclip then Noclip:Disconnect() end
	Noclip = RunService.Stepped:Connect(function()
		if Clip == false and lp.Character then
			for _, v in ipairs(lp.Character:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide = false
				end
			end
		end
	end)
end

local function clip()
	Clip = true
	if Noclip then
		Noclip:Disconnect()
		Noclip = nil
	end
end

Tab_Player:CreateSection("Player Settings")
Tab_Player:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "NoclipToggle",
	Callback = function(Value)
		NoclipToggle = Value
		if Value then
			noclip()
		else
			clip()
		end
	end
})

Tab_Player:CreateToggle({
	Name = "Walk Speed",
	CurrentValue = false,
	Flag = "WalkToggle",
	Callback = function(Value)
		WalkToggle = Value
		local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = Value and 0 or 16
		end
	end
})

Tab_Player:CreateSlider({
	Name = "Walk Speed (Bypass)",
	Range = {28, 100},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = currentSpeed,
	Flag = "SpeedSlider",
	Callback = function(Value)
		currentSpeed = Value
	end
})

local handledParts = {}
local function clearESP()
    for _, gui in ipairs(espLabels) do
        if gui and gui.Parent then gui:Destroy() end
    end
    table.clear(espLabels)
    table.clear(handledParts)
end

Tab_Esp:CreateSection("ESP Settings")
Tab_Esp:CreateToggle({
	Name = "ESP (Doors, Keys, Lockers)",
	CurrentValue = false,
	Flag = "ESPToggle",
	Callback = function(Value)
		ESPToggle = Value
		if not Value then clearESP() end
	end
})

Tab_Esp:CreateToggle({
	Name = "Show Studs (ESP)",
	CurrentValue = false,
	Flag = "StudsToggle",
	Callback = function(Value)
	       StudsToggle = Value
	end
})

local function createESP(part, labelText, color)
    if not part:IsA("BasePart") then return end
    if part:FindFirstChild("ESP_Billboard") then return end

    local bb = Instance.new("BillboardGui", part)
    bb.Name = "ESP_Billboard"
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 100, 0, 20)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)

    local label = Instance.new("TextLabel", bb)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.TextSize = 10
    label.Font = Enum.Font.SourceSansBold
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not bb.Parent or not label or not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then
            if connection then connection:Disconnect() end
            if bb and bb.Parent then bb:Destroy() end
            return
        end

        local distance = (lp.Character.HumanoidRootPart.Position - part.Position).Magnitude

        if distance > 150 then
            if connection then connection:Disconnect() end
            if bb and bb.Parent then bb:Destroy() end
            return
        end

        if StudsToggle then
            label.Text = string.format("%s\n%.1fm away", labelText, distance)
        else
            label.Text = labelText
        end
    end)

    table.insert(espLabels, bb)
    handledParts[part] = true
end

local Whitelist = {
	["Angler"] = true,
	["Froger"] = true,
	["Pinkie"] = true,
	["Blitz"] = true,
	["Pandemonium"] = true,
	["Chainsmoker"] = true,
	["Eyefestation"] = true,
	["WallDwellers"] = true,
	["CandleBrute"] = true,
	["A60"] = true,
	["Finale"] = true,
	["Ambuscade"] = true,
	["Runner"] = true,
	["Stan"] = true,
	["Harbinger"] = true,
	["Pipsqu"] = true
}

task.spawn(function()
    while true do
        task.wait(1)
        if not ESPToggle then
            clearESP()
            continue
        end

        local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        local gameplay = Workspace:FindFirstChild("GameplayFolder")
        local rooms = gameplay and gameplay:FindFirstChild("Rooms")
        if not rooms then continue end

        for _, folder in ipairs(rooms:GetChildren()) do
            local cf = folder:GetBoundingBox()
if (root.Position - cf.Position).Magnitude > 200 then continue end
            for _, obj in ipairs(folder:GetDescendants()) do
                if handledParts[obj] then continue end

                if obj:IsA("Model") and obj.Name == "NormalDoor" and obj:FindFirstChild("Root") then
                    createESP(obj.Root, "Door", Color3.fromRGB(0, 255, 0))
                elseif obj.Name == "NormalKeyCard" and (obj:IsA("Folder") or obj:IsA("Model")) then
                    local proxy = obj:FindFirstChild("ProxyPart", true)
                    if proxy and proxy:IsA("BasePart") then
                        createESP(proxy, "Key card", Color3.fromRGB(0, 255, 255))
                    end
                elseif obj:IsA("BasePart") and obj.Name == "SpawnKeyCard" then
                    createESP(obj, "Key card", Color3.fromRGB(0, 255, 255))
                elseif obj:IsA("BasePart") and obj.Name == "LockerCollision" and obj.Parent and obj.Parent.Name == "Locker" then
                    createESP(obj, "Locker", Color3.fromRGB(255, 0, 255))
                elseif obj:IsA("BasePart") and obj.Name == "Locker" and obj.Parent and obj.Parent.Name == "highlight" then
                    createESP(obj, "Monster Locker", Color3.fromRGB(128, 0, 128))
                end
            end
        end

        local main = rooms:FindFirstChild("Start")
            and rooms.Start:FindFirstChild("Tutorials")
            and rooms.Start.Tutorials:FindFirstChild("Main")
        if main then
            local partToESP = main:IsA("BasePart") and main or main:FindFirstChildWhichIsA("BasePart", true)
            if partToESP and not handledParts[partToESP] then
                createESP(partToESP, "Key Card", Color3.fromRGB(0, 255, 255))
            end
        end

        for _, obj in ipairs(gameplay:GetChildren()) do
            if obj.Name == "PasswordPaper" and obj:IsA("Model") then
                local codePart = obj:FindFirstChild("Code")
                if codePart and codePart:IsA("BasePart") and not handledParts[codePart] then
                    createESP(codePart, "Key Code", Color3.fromRGB(255, 255, 0))
                end
            end
        end
    end
end)

task.spawn(function()
	while true do
		task.wait(0.2)
		if not AuraToggle then continue end

		local char = lp.Character
		if not char then continue end

		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then continue end

		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("ProximityPrompt") and obj.Parent and obj.Parent:IsA("BasePart") then
				local skip = false

				if obj.Parent.Name == "Locker" or obj.Parent.Name == "MonsterLocker" then
					skip = true
				end

				local current = obj.Parent
				while current and current ~= Workspace do
					if current.Name:lower():find("door") then
						skip = true
						break
					end
					current = current.Parent
				end

				if skip then continue end

				local distance = (obj.Parent.Position - root.Position).Magnitude
				if distance <= 15 and obj.Enabled and obj.HoldDuration <= 1 then
					pcall(function()
						fireproximityprompt(obj)
					end)
				end
			end
		end
	end
end)

local notified = {}
local TextChatService = game:GetService("TextChatService")

local function SendChatMessage(message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local textChannel = TextChatService.TextChannels.RBXGeneral
        textChannel:SendAsync(message)
    else
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end

local function isWhitelisted(name)
	for allowed, _ in pairs(Whitelist) do
		if string.find(name:lower(), allowed:lower()) then
			return true
		end
	end
	return false
end

Workspace.ChildAdded:Connect(function(child)
	if not child:IsA("BasePart") then return end
	if not isWhitelisted(child.Name) then return end
	if notified[child] then return end

	notified[child] = true
	local name = child.Name

	if MonsterToggle then
		Rayfield:Notify({
			Title = "Entity Spawned",
			Content = "Detected: " .. name,
			Duration = 4,
			Image = "info"
		})
	end

	if MonsterToggleChat then
		SendChatMessage(name)
	end

	child.AncestryChanged:Connect(function(_, parent)
		if not parent then
			notified[child] = nil
		end
	end)
end)

Rayfield:LoadConfiguration()
