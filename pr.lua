local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local Character = lp.Character or lp.CharacterAdded:Wait()
local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local plrUI = lp:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local character
local hum
local root

local function uCR(char)
    character = char
    root = character:WaitForChild("HumanoidRootPart", 5)
    hum = character:WaitForChild("Humanoid", 5)
end

uCR(lp.Character or lp.CharacterAdded:Wait())
lp.CharacterAdded:Connect(function(newChar)
    uCR(newChar)
end)

local premium_users = { "Tgpeek1", "Technique12_12", "Vbn_bountyhunter" }
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local blacklist = {
    [339099301] = true,
    [117931886] = true,
    [352653560] = true,
    [874607648] = true,
    [46912640] = true,
    [1587488348] = true,
    [518216228] = true,
    [4129743305] = true,
    [85090406] = true,
    [2191456] = true,
    [129728670] = true
}


local function getTag(name)
    for _, v in ipairs(premium_users) do
        if v == name then
            return "[ PREMIUM ]"
        end
    end
    return "[ FREEMIUM ]"
end

local discordLink = "https://discord.gg/QmvpbPdw9J"
setclipboard(discordLink)

if blacklist[Players.LocalPlayer.UserId] then
    Players.LocalPlayer:Kick("Exploiting")
    return
end

local gid = 9683893
local bannedRanks = {
    ["Important Members"] = true,
    ["leeches"] = true,
    ["friend buddies smiles"] = true,
    ["Friends"] = true,
    ["Moderators"] = true,
    ["Contributors"] = true,
    ["Devs"] = true,
    ["Composer - Ren"] = true,
    ["Animators - Alti & Rad"] = true,
    ["Programmers - BOSS, Kibo & Veb"] = true,
    ["Modeler - Zeal"] = true
}
local rankName = Players.LocalPlayer:GetRoleInGroup(9683893)
if bannedRanks[rankName] then
    Players.LocalPlayer:Kick("Exploiting")
end

print("Loaded!\nAzureHub By Cat\nDiscord: https://discord.gg/QmvpbPdw9J")

WindUI:SetNotificationLower(true)
local Window = WindUI:CreateWindow({
    Title = "Azure Hub | Pressure ".. getTag(lp.Name),
    Author = "discord.gg/QmvpbPdw9J",
    Folder = "PressureHub",
    Size = UDim2.fromOffset(500, 300),
    Theme = "Dark",
    User = {
        Enabled = false,
        Anonymous = false
    },
    Transparent = true,
    SideBarWidth = 220,
    ScrollBarEnabled = true
})

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Theme Changed",
        Content = "Current theme: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)
Window:SetToggleKey(Enum.KeyCode.K)

local Logs = Window:Tab({ Title = "|  Update Logs", Icon = "scroll-text" })
Window:Divider()

local Tabs = {
    Features = Window:Section({ Title = "Features", Opened = true }),
    Utilities = Window:Section({ Title = "Utilities", Opened = true })
}

local TabHandles = {
     Main = Tabs.Features:Tab({ Title = "|  Main", Icon = "house" }),
     Player = Tabs.Features:Tab({ Title = "|  Player", Icon = "users-round" }),
     Esp = Tabs.Features:Tab({ Title = "|  ESP", Icon = "eye" }),
     Auto = Tabs.Features:Tab({ Title = "|  Auto", Icon = "cpu" }),
     Anti = Tabs.Features:Tab({ Title = "|  Encounters", Icon = "shield" }),
     Misc = Tabs.Features:Tab({ Title = "|  Misc", Icon = "layout-grid" }),
     Config = Tabs.Utilities:Tab({ Title = "|  Configuration", Icon = "settings" })
}

local success = false
local whitelistParts = {
    "HumanoidRootPart",
    "Head",
    "Torso",
    "LeftArm",
    "RightArm",
    "LeftLeg",
    "RightLeg",
    "UpperTorso",
    "LowerTorso"
}

for _, obj in ipairs(Character:GetDescendants()) do
    if obj:IsA("Vector3Value") and obj.Name == "OriginalSize" and obj.Parent == hrp then
        obj.Value = Vector3.new(10, 10, 10)
        success = true
    end
end

if success then
    WindUI:Notify({
        Title = "Azure Hub",
        Content = "Successfully bypassed anti-cheat, enjoy the script.",
        Icon = "info",
        Duration = 3
    })
else
    WindUI:Notify({
        Title = "Azure Hub",
        Content = "Failed to bypass anti-cheat, report bug in our discord server.",
        Icon = "warning",
        Duration = 3
    })
end

local antiAfkToggle = false
local selectedESPTypes = {}
local ESPHighlight = false
local ESPTracers = false
local ESPNames = false
local ESPBoxes = false
local ESPStuds = false
local ESPObjects = {}
local esp = {}
local tracers = {}
local boxes = {}
local names = {}
local studs = {}
local DrawingAvailable = (type(Drawing) == "table" or type(Drawing) == "userdata")
local humanoid = nil
local currentSpeed = 28
local ReachAuraSlider = 10
local ESPToggle = false
local StudsToggle = false
local AuraLootMode = "Turn Off"
local MonsterToggle = false
local MonsterToggleChat = false
local hideToggle = false
local opendoorsToggle = false
local NoclipToggle = false
local WalkToggle = false
local jumpButtonToggle = false
local antiMineToggle = false
local antiParasiteToggle = false
local antiSearchlightToggle = false
local antiEyefestationToggle = false
local teleported = false
local noMonstersToggle = false
local perfomanceToggle = false
local activeMonsters = {}
local scriptConn

local updparagraph = Logs:Paragraph({
    Title = "Update Logs",
    Desc = "6.12.25\n[/] Updated To Latest Data\n[/] Recoded Script\n[+] Reach Aura\n[+] Remove Killables\n\n3.09.25\n[/] Improved Bypass\n\n28.07.25\n[+] No Monsters\n[-] God Mode Patched\n[/] Optimised ESP\n\n10.07.25\n[+] Bypass Anti-Cheat\n[+] No Monsters\n[+] Auto Hide\n\n6.07.25\n[+] Pressure\n[+] God Mode\n[+] No Damage",
    Locked = false,
    Buttons = {
        {
            Icon = "clipboard",
            Title = "Discord Server",
            Callback = function() setclipboard(discordLink) WindUI:Notify({ Title = "Discord Server", Content = "Link Copied!", Icon = "info", Duration = 2 }) end,
        }
    }
})

local function teleportTo(obj)
	local part
	if obj:IsA("Model") then
		part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
	elseif obj:IsA("BasePart") then
		part = obj
	end
	if part then
		hrp.CFrame = part.CFrame + Vector3.new(0, 4, 0)
	end
end

local function renameWithIncrement(baseName)
	local i = 1
	return baseName .. i
end

local function firePromptIn(obj)
	for _, d in ipairs(obj:GetDescendants()) do
		if d:IsA("ProximityPrompt") then
			fireproximityprompt(d)
			break
		end
	end
end

local function isNumbered(name)
	return string.match(name, "^.-%d+$") ~= nil
end

local function findKeycard()
	for _, v in ipairs(workspace:GetDescendants()) do
		local name = v.Name
		if (name:match("NormalKeyCard") or name:match("SpawnKeycard") or name:match("PasswordPaper")) and not isNumbered(name) then
			return v
		end
	end
end

local function findDoor()
	local roomsFolder = workspace:FindFirstChild("GameplayFolder")
		and workspace.GameplayFolder:FindFirstChild("Rooms")

	if not roomsFolder then return nil end

	for _, room in ipairs(roomsFolder:GetChildren()) do
		local entrances = room:FindFirstChild("Entrances")
		if entrances then
			for _, v in ipairs(entrances:GetChildren()) do
				if v:IsA("Model") 
				and (v.Name == "NormalDoor" or v.Name == "BigDoor") 
				and not isNumbered(v.Name) then
					return v
				end
			end
		end
	end

	return nil
end

local function runScript()
	local keycard = findKeycard()
	if keycard then
		local newName = renameWithIncrement(keycard.Name:match("^(%a+)"))
		teleportTo(keycard)
		task.wait(0.6)
		firePromptIn(keycard)
		keycard.Name = newName
		task.wait(0.6)
	end

	if opendoorsToggle and next(activeMonsters) == nil then
		local door = findDoor()
		while door do
		       if next(activeMonsters) == nil then
			local newName = renameWithIncrement("NormalDoor")
			teleportTo(door)
			task.wait(0.6)
			firePromptIn(door)
			door.Name = newName

			task.wait(0.2)
			door = findDoor()
			end
		end

		if scriptConn then
			scriptConn:Disconnect()
			scriptConn = nil
		end

		scriptConn = workspace.DescendantAdded:Connect(function(desc)
			if desc:IsA("Model") and (desc.Name == "NormalDoor" or desc.Name == "BigDoor") then
				task.wait(0.25)
				if desc.Parent and not isNumbered(desc.Name) then
					if scriptConn then
						scriptConn:Disconnect()
						scriptConn = nil
					end
					task.wait(0.2)
					runScript()
				end
			end
		end)
	else
		local door = findDoor()
		if door then
			local newName = renameWithIncrement("NormalDoor")
			teleportTo(door)
			task.wait(0.6)
			firePromptIn(door)
			door.Name = newName
		end
	end
end

local function noMonsters(chainsmoker, hrp)
    local rooms = workspace:WaitForChild("GameplayFolder"):WaitForChild("Rooms")
    local prompts = {}

    while chainsmoker and noMonsterToggle do
        if not hrp then break end

        local a = hrp.Position
        local b = chainsmoker.Position
        local dist = (Vector3.new(a.X, 0, a.Z) - Vector3.new(b.X, 0, b.Z)).Magnitude

        if dist <= 100 then
            runScript()
        end

        prompts = {}
        for _, inst in ipairs(rooms:GetDescendants()) do
            if inst:IsA("Model") and inst.Name == "NormalDoor" then
                for _, obj in ipairs(inst:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        table.insert(prompts, obj)
                    end
                end
            end
        end

        if dist > 400 then
            for _, prompt in ipairs(prompts) do
                if prompt and prompt:IsDescendantOf(workspace) then
                    prompt.Enabled = false
                end
            end
        else
            for _, prompt in ipairs(prompts) do
                if prompt and prompt:IsDescendantOf(workspace) then
                    prompt.Enabled = true
                end
            end
        end
        task.wait(0.5)
    end
end

local function isHostile(name)
	name = name:lower()
	return name ~= "dwellerspawn" and not name:find("wall dweller")
end

local function playHideSound()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://115179084080017"
	sound.Volume = 3
	sound.PlayOnRemove = true
	sound.Parent = lp:WaitForChild("PlayerGui")
	sound:Destroy()
end

local function removeKillables(eye)
	if eye:IsDescendantOf(Workspace:FindFirstChild("deathModel")) then return end
	local lowerName = eye.Name:lower()
	if (lowerName == "pandemonium" and eye:IsA("BasePart")) or lowerName == "monsterlocker" then
		task.defer(function()
			if eye:IsDescendantOf(Workspace) then
				eye:Destroy()
			end
		end)
	end
end

local function enableJump()
	local char = lp.Character or lp.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = 50
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
	end

	if lp:FindFirstChild("PlayerGui"):FindFirstChild("Jump") then return end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "Jump"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.Parent = lp:WaitForChild("PlayerGui")

	local jumpButton = Instance.new("TextButton")
	jumpButton.Size = UDim2.new(0, 120, 0, 50)
	jumpButton.Position = UDim2.new(0.5, -60, 0.8, 0)
	jumpButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
	jumpButton.Text = "Jump"
	jumpButton.TextColor3 = Color3.new(1, 1, 1)
	jumpButton.TextScaled = true
	jumpButton.AutoButtonColor = true
	jumpButton.BorderSizePixel = 0
	jumpButton.Parent = screenGui

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = jumpButton

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 6)
	padding.PaddingBottom = UDim.new(0, 6)
	padding.PaddingLeft = UDim.new(0, 6)
	padding.PaddingRight = UDim.new(0, 6)
	padding.Parent = jumpButton

	jumpButton.MouseButton1Click:Connect(function()
		local character = lp.Character
		local hum = character and character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

local function disableJump()
	local char = lp.Character or lp.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = 0
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
	end

	local gui = lp:FindFirstChild("PlayerGui"):FindFirstChild("Jump")
	if gui then
		gui:Destroy()
	end
end
local isHidden = false
local function applyBypassSpeed()
    while true do
        task.wait(0.2)
        if not WalkToggle or isHidden then continue end

        local char = lp.Character or lp.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then continue end

        for _, conn in ipairs(getconnections(hum:GetPropertyChangedSignal("WalkSpeed"))) do
            conn:Disable()
        end

        hum.WalkSpeed = currentSpeed
    end
end

task.spawn(applyBypassSpeed)

local colors = {
    player = Color3.fromRGB(0, 255, 0),
    door = Color3.fromRGB(0, 255, 0),
    locker = Color3.fromRGB(255, 192, 203),
    key = Color3.fromRGB(176, 224, 230),
    monster = Color3.fromRGB(255, 0, 0)
}

local function contains(tbl, val)
    if not tbl then return false end
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

local function isDoorObject(obj)
    if obj:IsA("Model") and obj.Name == "NormalDoor" and obj:FindFirstChild("Root") then
        return obj
    end
    return false
end

local function isKeyObject(obj)
    if obj.Name == "NormalKeyCard" and (obj:IsA("Folder") or obj:IsA("Model")) then
        return obj
    elseif obj:IsA("BasePart") and obj.Name == "SpawnKeycard" then
        return obj
    elseif obj.Name == "PasswordPaper" and obj:IsA("Model") then
        return obj
    end
    return false
end

local function isLockerObject(obj)
    if obj:IsA("BasePart") and obj.Name == "LockerCollision" and obj.Parent and obj.Parent.Name == "Locker" then
        return obj
    elseif obj:IsA("BasePart") and obj.Name == "Locker" and obj.Parent and obj.Parent.Name == "highlight" then
        return obj.Parent.Parent
    end
    return false
end

local function isMonsterObject(obj)
    if obj:IsA("BasePart") and string.lower(obj.Name):find("dwellerspawn") then
        return obj
    end
    return false
end

local function passesDropdownFilter(obj)
    if not selectedESPTypes or #selectedESPTypes == 0 then
        return false
    end
    if contains(selectedESPTypes, "Doors") and isDoorObject(obj) then return true end
    if contains(selectedESPTypes, "Lockers") and isLockerObject(obj) then return true end
    if contains(selectedESPTypes, "Keys") and isKeyObject(obj) then return true end
    if contains(selectedESPTypes, "Monsters") and isMonsterObject(obj) then return true end
    return false
end

local function getObjColor(obj)
    if isDoorObject(obj) then return colors.door end
    if isLockerObject(obj) then return colors.locker end
    if isKeyObject(obj) then return colors.key end
    if isMonsterObject(obj) then return colors.monster end
    return colors.player
end

local function removeESP(obj)
    local d = esp[obj]
    if d then
        if d.highlight then pcall(function() d.highlight:Destroy() end) end
        if d.billboard then pcall(function() d.billboard:Destroy() end) end
        esp[obj] = nil
    end
    if tracers[obj] then pcall(function() tracers[obj]:Remove() end) tracers[obj] = nil end
    if boxes[obj] then
        for _, l in pairs(boxes[obj]) do pcall(function() l:Remove() end) end
        boxes[obj] = nil
    end
end

local function ensureHighlight(obj)
    if not ESPHighlight then
        if esp[obj] and esp[obj].highlight then
            pcall(function() esp[obj].highlight:Destroy() end)
            esp[obj].highlight = nil
        end
        return
    end
    if not esp[obj] then esp[obj] = {} end
    if esp[obj].highlight then
        esp[obj].highlight.FillColor = getObjColor(obj)
        esp[obj].highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        return
    end
    local ok, hl = pcall(function()
        local h = Instance.new("Highlight")
        h.Adornee = obj
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.FillColor = getObjColor(obj)
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = obj
        return h
    end)
    if ok and hl then esp[obj].highlight = hl end
end

local function ensureBillboard(obj)
    if not (ESPNames or ESPStuds) then
        if esp[obj] and esp[obj].billboard then
            pcall(function() esp[obj].billboard:Destroy() end)
            esp[obj].billboard = nil
            esp[obj].nameLabel = nil
            esp[obj].studsLabel = nil
        end
        return
    end

    if not esp[obj] then esp[obj] = {} end
    local head = obj:FindFirstChild("Head") or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
    if not head then return end

    if not esp[obj].billboard then
        local b = Instance.new("BillboardGui")
        b.Size = UDim2.new(0, 200, 0, 50)
        b.Adornee = head
        b.AlwaysOnTop = true
        b.Parent = obj
        esp[obj].billboard = b
    end

    if ESPNames then
        if not esp[obj].nameLabel then
            local n = Instance.new("TextLabel")
            n.BackgroundTransparency = 1
            n.Size = UDim2.new(1,0,0,16)
            n.Position = UDim2.new(0,0,0,-20)
            n.Text = obj.Name
            n.TextColor3 = getObjColor(obj)
            n.Font = Enum.Font.SourceSansBold
            n.TextSize = 14
            n.Parent = esp[obj].billboard
            esp[obj].nameLabel = n
        else
            esp[obj].nameLabel.Text = obj.Name
            esp[obj].nameLabel.TextColor3 = getObjColor(obj)
            esp[obj].nameLabel.Visible = true
        end
    else
        if esp[obj].nameLabel then
            esp[obj].nameLabel:Destroy()
            esp[obj].nameLabel = nil
        end
    end

    if ESPStuds then
        if not esp[obj].studsLabel then
            local s = Instance.new("TextLabel")
            s.BackgroundTransparency = 1
            s.Size = UDim2.new(1,0,0,14)
            s.Position = UDim2.new(0,0,0,-5)
            s.TextColor3 = getObjColor(obj)
            s.Font = Enum.Font.SourceSans
            s.TextSize = 12
            s.Parent = esp[obj].billboard
            esp[obj].studsLabel = s
        else
            esp[obj].studsLabel.TextColor3 = getObjColor(obj)
            esp[obj].studsLabel.Visible = true
        end
    else
        if esp[obj].studsLabel then
            esp[obj].studsLabel:Destroy()
            esp[obj].studsLabel = nil
        end
    end
end

local function ensureTracer(obj)
    if not DrawingAvailable or not ESPTracers then
        if tracers[obj] then pcall(function() tracers[obj]:Remove() end) tracers[obj] = nil end
        return
    end
    if tracers[obj] then
        tracers[obj].Color = getObjColor(obj)
        return
    end
    local ok, line = pcall(function()
        local L = Drawing.new("Line")
        L.Color = getObjColor(obj)
        L.Thickness = 1
        L.Transparency = 1
        L.Visible = false
        return L
    end)
    if ok and line then tracers[obj] = line end
end

local function ensureBox(obj)
    if not DrawingAvailable or not ESPBoxes then
        if boxes[obj] then
            for _, l in pairs(boxes[obj]) do pcall(function() l:Remove() end) end
            boxes[obj] = nil
        end
        return
    end
    if boxes[obj] then
        for _, l in pairs(boxes[obj]) do l.Color = getObjColor(obj) end
        return
    end
    local ok, b = pcall(function()
        return {
            tl = Drawing.new("Line"),
            tr = Drawing.new("Line"),
            bl = Drawing.new("Line"),
            br = Drawing.new("Line")
        }
    end)
    if not ok or not b then return end
    for _, line in pairs(b) do
        line.Color = getObjColor(obj)
        line.Thickness = 1
        line.Transparency = 1
        line.Visible = false
    end
    boxes[obj] = b
end

local function ensureAllFor(obj)
    if not esp[obj] then esp[obj] = {} end
    if not passesDropdownFilter(obj) then
        removeESP(obj)
        return
    end
    ensureHighlight(obj)
    ensureBillboard(obj)
    ensureTracer(obj)
    ensureBox(obj)
end

local function refreshAll()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == lp.Name then continue end
        if passesDropdownFilter(obj) then
            ensureAllFor(obj)
        else
            removeESP(obj)
        end
    end
end

local lR = 0
local rl = 1

RunService.RenderStepped:Connect(function()
    local now = tick()
    if now - lR > rl then
        refreshAll()
        lR = now
    end

    local camPos = Camera.CFrame.Position
    local viewportSize = Camera.ViewportSize

    for obj, data in pairs(esp) do
        if not obj or not obj.Parent then
            removeESP(obj)
            continue
        end

        local primary = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
        if not primary then
            if tracers[obj] then tracers[obj].Visible = false end
            if boxes[obj] then
                for _, l in pairs(boxes[obj]) do l.Visible = false end
            end
            if data.studsLabel then data.studsLabel.Visible = false end
            if data.nameLabel then data.nameLabel.Visible = false end
            continue
        end

        local worldPos = primary.Position
        local screenPos, onScreen = Camera:WorldToViewportPoint(worldPos)

        -- if object is behind camera
        if screenPos.Z < 0 then
            if tracers[obj] then tracers[obj].Visible = false end
            if data.studsLabel then data.studsLabel.Visible = false end
            if data.nameLabel then data.nameLabel.Visible = false end
            if boxes[obj] then
                for _, l in pairs(boxes[obj]) do l.Visible = false end
            end
            continue
        end

        -- tracers
        if tracers[obj] then
            local t = tracers[obj]
            t.Color = getObjColor(obj)
            t.Visible = ESPTracers and onScreen
            if t.Visible then
                t.From = Vector2.new(viewportSize.X/2, viewportSize.Y)
                t.To   = Vector2.new(screenPos.X, screenPos.Y)
            end
        end

        -- Distance + Studs Label (attached to object)
if data.studsLabel and ESPStuds then
    local head = obj:FindFirstChild("Head") 
        or obj:FindFirstChild("HumanoidRootPart") 
        or obj:FindFirstChildWhichIsA("BasePart")
    local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")

    if head and root then
        -- proper distance calc (lp vs target, NOT camera)
        local distance = (root.Position - head.Position).Magnitude
        data.studsLabel.Text = string.format("%.0fm", distance)
        data.studsLabel.TextColor3 = getObjColor(obj)
        data.studsLabel.Visible = true

        -- attach BillboardGui once and keep it
        if not esp[obj].billboard then
            local bb = Instance.new("BillboardGui")
            bb.Adornee = head
            bb.AlwaysOnTop = true
            bb.Size = UDim2.new(0, 200, 0, 50)
            bb.Parent = head

            data.studsLabel.Parent = bb
            esp[obj].billboard = bb
        elseif esp[obj].billboard.Adornee ~= head then
            esp[obj].billboard.Adornee = head
            esp[obj].billboard.Parent = head
        end
    else
        data.studsLabel.Visible = false
    end
end

        -- name label
        if data.nameLabel then
            data.nameLabel.TextColor3 = getObjColor(obj)
            data.nameLabel.Visible = ESPNames
        end

        -- boxes
        if boxes[obj] and ESPBoxes then
            local ok, cf, size = pcall(function() return obj:GetBoundingBox() end)
            if ok and cf and size then
                local half = size * 0.5
                local corners = {
                    cf:PointToWorldSpace(Vector3.new(-half.X,  half.Y, -half.Z)),
                    cf:PointToWorldSpace(Vector3.new( half.X,  half.Y, -half.Z)),
                    cf:PointToWorldSpace(Vector3.new(-half.X, -half.Y, -half.Z)),
                    cf:PointToWorldSpace(Vector3.new( half.X, -half.Y, -half.Z)),
                    cf:PointToWorldSpace(Vector3.new(-half.X,  half.Y,  half.Z)),
                    cf:PointToWorldSpace(Vector3.new( half.X,  half.Y,  half.Z)),
                    cf:PointToWorldSpace(Vector3.new(-half.X, -half.Y,  half.Z)),
                    cf:PointToWorldSpace(Vector3.new( half.X, -half.Y,  half.Z))
                }

                local minX, minY = math.huge, math.huge
                local maxX, maxY = -math.huge, -math.huge
                local anyOn = false

                for _, w in ipairs(corners) do
                    local v2, on = Camera:WorldToViewportPoint(w)
                    if on then
                        anyOn = true
                        minX = math.min(minX, v2.X)
                        minY = math.min(minY, v2.Y)
                        maxX = math.max(maxX, v2.X)
                        maxY = math.max(maxY, v2.Y)
                    end
                end

                local b = boxes[obj]
                if anyOn then
                    b.tl.From = Vector2.new(minX, minY); b.tl.To = Vector2.new(maxX, minY)
                    b.tr.From = Vector2.new(maxX, minY); b.tr.To = Vector2.new(maxX, maxY)
                    b.br.From = Vector2.new(maxX, maxY); b.br.To = Vector2.new(minX, maxY)
                    b.bl.From = Vector2.new(minX, maxY); b.bl.To = Vector2.new(minX, minY)
                    for _, l in pairs(b) do
                        l.Color = getObjColor(obj)
                        l.Visible = true
                    end
                else
                    for _, l in pairs(b) do l.Visible = false end
                end
            else
                for _, l in pairs(boxes[obj]) do l.Visible = false end
            end
        elseif boxes[obj] then
            for _, l in pairs(boxes[obj]) do l.Visible = false end
        end
    end
end)

Workspace.ChildAdded:Connect(function(child) task.wait(0.5); refreshAll() end)
Workspace.ChildRemoved:Connect(function(child) removeESP(child) end)

local MainSection = TabHandles.Main:Section({ 
    Title = "Gameplay",
    Icon = "gamepad-2"
})

local lootAuraHandle = MainSection:Dropdown({
    Title = "Loot Aura",
    Values = { "Everything", "No Light Sources", "Turn Off" },
    Value = "",
    Multi = false,
    AllowNone = true,
    Callback = function(option)
        if typeof(option) == "table" then
            AuraLootMode = option.option or option[1] or ""
        else
            AuraLootMode = option
        end
    end
})

local noMonstersHandle = MainSection:Toggle({
       Title = "No Monsters",
       Desc = "When chainsmoker spawns you will get a guide on method.",
       Value = false,
       Callback = function(state)
             noMonstersToggle = state
       end
})

local ReachAuraHandle = MainSection:Slider({
	Title = "Reach Aura",
	Desc = "The distance you will open doors. Works only on normal doors without passcode.",
	Value = { Min = 10, Max = 30, Default = 10},
	Step = 1,
	Callback = function(Value)
		ReachAuraSlider = tonumber(Value)
	end
})

local notifyAbtHandle = MainSection:Toggle({
	Title = "Notify About Monster",
	Desc = "Notifies you when monster somewhere spawns.",
	Value = false,
	Callback = function(state)
	       MonsterToggle = state
	end
})

local notifyChaHandle = MainSection:Toggle({
	Title = "Notify About Monster (Chat)",
	Desc = "Types in chat when monster somewhere spawns.",
	Value = false,
	Callback = function(state)
	       MonsterToggleChat = state
	end
})

local perfomanceHandle = TabHandles.Main:Toggle({
        Title = "Improve Perfomance",
        Desc = "Deletes old rooms, highly improves perfomance.",
        Value = false,
        Callback = function(state)
              perfomanceToggle = state
        end
})

TabHandles.Main:Button({
	Title = "Instant Interact",
	Callback = function()
		for _, prom in ipairs(workspace:GetDescendants()) do
			if prom:IsA("ProximityPrompt") then
				pcall(function()
					prom.PromptButtonHoldBegan:Connect(function()
						if prom.HoldDuration <= 0 then return end
						fireproximityprompt(prom, 0)
					end)
				end)
			end
		end
		workspace.DescendantAdded:Connect(function(class)
			if class:IsA("ProximityPrompt") then
				pcall(function()
					class.PromptButtonHoldBegan:Connect(function()
						if class.HoldDuration <= 0 then return end
						fireproximityprompt(class, 0)
					end)
				end)
			end
		end)
	end
})
local namecallHooked = false

TabHandles.Main:Button({
        Title = "No Damage",
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

local jumpHandle = TabHandles.Player:Toggle({
	Title = "Jump Button",
	Desc = "Adds button that allows you to jump.",
	Value = false,
	Callback = function(state)
		if state then
			enableJump()

			lp.CharacterAdded:Connect(function()
				enableJump()
			end)
		else
		       disableJump()
		end
	end
})

local NoclipHandle = TabHandles.Player:Toggle({
	Title = "Noclip",
	Desc = "Pass through walls with this toggle on.",
	Value = false,
	Callback = function(state)
		NoclipToggle = state
		if state then
			noclip()
		else
			clip()
		end
	end
})

local WsToggleHandle = TabHandles.Player:Toggle({
       Title = "WalkSpeed Changer",
       Desc = "Set your speed to your preference.",
	Value = false,
	Callback = function(state)
		WalkToggle = state
		local hum = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = state and 0 or 16
		end
	end
})

local WsSliderHandle = TabHandles.Player:Slider({
	Title = "WalkSpeed",
	Value = { Min = 28, Max = 100, Default = 28},
	Step = 1,
	Callback = function(Value)
		currentSpeed = Value
	end
})

TabHandles.Esp:Button({
	Title = "Full Bright",
	Callback = function()
	       local Lighting = game:GetService("Lighting")
	       Lighting.Ambient = Color3.fromRGB(255, 255, 255)
	       Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
	       Lighting.Brightness = 2
	       Lighting.ShadowSoftness = 0
	       Lighting.GlobalShadows = false
	end
})

local dropdownHandle = TabHandles.Esp:Dropdown({
        Title = "ESP's",
        Values = { "Doors", "Lockers", "Keys", "Monsters" },
        Value = { "" },
        Multi = true,
        AllowNone = true,
        Callback = function(option)
              selectedESPTypes = option
        end
})

local ESPHighlightHandle = TabHandles.Esp:Toggle({
       Title = "Highlight objects",
       Desc = "Highlights objects, most useful feature.",
       Value = false,
       Callback = function(state)
             ESPHighlight = state
       end
})
local ESPTracersHandle = TabHandles.Esp:Toggle({
       Title = "Show Tracers",
       Desc = "Adds line pointing to your ESP object.",
       Value = false,
       Callback = function(state)
             ESPTracers = state
       end
})
local ESPBoxesHandle = TabHandles.Esp:Toggle({
       Title = "Show Boxes",
       Desc = "Adds box showing the hitbox of your ESP object.",
       Value = false,
       Callback = function(state)
             ESPBoxes = state
       end
})
local ESPNamesHandle = TabHandles.Esp:Toggle({
       Title = "Show Names",
       Desc = "Adds name of object above ur object's head.",
       Value = false,
       Callback = function(state)
             ESPNames = state
       end
})
local ESPStudsHandle = TabHandles.Esp:Toggle({
       Title = "Show Studs",
       Desc = "Adds studs above ur objects head, shows how far you're away from the object.",
       Value = false,
       Callback = function(state)
             ESPStuds = state
       end
})

local autoDoorsHandle = TabHandles.Auto:Toggle({
	Title = "Auto Open Doors (BETA)",
	Desc = "Automatically teleports to next door and opens it. Not recommended for slow-end devices.",
	Value = false,
	Callback = function(state)
		opendoorsToggle = state
		if state then
			runScript()
			for _, obj in ipairs(Character:GetDescendants()) do
    if obj:IsA("ObjectValue") then
        obj:Destroy()
        success = true

    elseif obj:IsA("BasePart") and not table.find(whitelistParts, obj.Name) then
        obj:Destroy()
        success = true

    elseif obj:IsA("LinearVelocity") and obj.Parent == hrp then
        obj:Destroy()
        success = true

    elseif obj:IsA("Vector3Value") and obj.Name == "OriginalSize" and obj.Parent == hrp then
        obj.Value = Vector3.new(10, 10, 10)
        success = true
    end
end

local playerScripts = lp:FindFirstChild("PlayerScripts")
if playerScripts then
    for _, obj in ipairs(playerScripts:GetDescendants()) do
        obj:Destroy()
    end
end
		end
	end
})

local autoHideHandle = TabHandles.Auto:Toggle({
        Title = "Auto Hide (BETA)",
        Desc = "Automatically hides from monsters, could help you get lockerless badge.",
	Value = false,
	Callback = function(state)
	       hideToggle = state
	end
})

local antiKillablesHandle = TabHandles.Anti:Toggle({
	Title = "Remove Killables",
	Desc = "Removes pandemonium, monster lockers and etc.",
	Value = false,
	Callback = function(state)
	       if state then
	           Workspace.ChildAdded:Connect(function(child) removeKillables(child) end)
	       end
	end
})

local antiSlHandle = TabHandles.Anti:Toggle({
	Title = "Anti Searchlights",
	Value = false,
	Callback = function(state)
	       antiSearchlightToggle = state
	end
})

local antiEfHandle = TabHandles.Anti:Toggle({
	Title = "Anti Eyefestation",
	Value = false,
	Callback = function(state)
	       antiEyefestationToggle = state
	end
})

local antiLmHandle = TabHandles.Anti:Toggle({
	Title = "Anti LandMines",
	Value = false,
	Callback = function(state)
	       antiMineToggle = state
	end
})

local FlingToggle = false
local antiFlingToggle = false
local flingThread

local function fling()
    local movel = 0.1
    while FlingToggle do
        RunService.Heartbeat:Wait()
        local c = lp.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then
            local vel = hrp.Velocity
            hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            RunService.RenderStepped:Wait()
            hrp.Velocity = vel
            RunService.Stepped:Wait()
            hrp.Velocity = vel + Vector3.new(0, movel, 0)
            movel = -movel
        end
    end
end

local antiAfkHandle = TabHandles.Misc:Toggle({
    Title = "Anti AFK",
    Desc = "If enabled, jumps every minute so you wouldn't get kicked out for AFK.",
    Value = false,
    Callback = function(state)
        antiAfkToggle = state
    end
})

local antiFlingHandle = TabHandles.Misc:Toggle({
    Title = "Anti Fling",
    Desc = "If enabled, no one could fling you off map.",
    Value = false,
    Callback = function(state)
        antiFlingToggle = state
        if not state then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= lp and plr.Character then
                    for _, part in ipairs(plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end
        end
    end
})

local FlingHandle = TabHandles.Misc:Toggle({
    Title = "Touch Fling",
    Desc = "If enabled, you could fling anyone in map by touching them.",
    Value = false,
    Callback = function(state)
        FlingToggle = state
    end
})

local antiAdminToggle = false
local antiAdminHandle = TabHandles.Misc:Toggle({
    Title = "Anti Admin",
    Desc = "If enabled, kicks you out if there's admin in your experience.",
    Value = false,
    Callback = function(state)
        antiAdminToggle = state
    end
})

task.spawn(function()
	while task.wait(1) do
		if antiAdminToggle then
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= lp and (table.find(blacklist, plr.UserId) or bannedRanks[plr:GetRoleInGroup(gid)]) then
					lp:Kick("Admin detected: " .. plr.Name)
				end
			end
		end
	end
end)

local configName = "Config Name"
TabHandles.Config:Input({
    Title = "Config Name",
    Value = configName,
    Callback = function(value)
        configName = value
        if ConfigManager then
            configFile = ConfigManager:CreateConfig(configName)
            configFile:Register("lootAuraHandle", lootAuraHandle)
            configFile:Register("antiKillablesHandle", antiKillablesHandle)
                configFile:Register("ReachAuraHandle", ReachAuraHandle)
                configFile:Register("notifyAbtHandle", notifyAbtHandle)
                configFile:Register("notifyChaHandle", notifyChaHandle)
                configFile:Register("jumpHandle", jumpHandle)
                configFile:Register("dropdownHandle", dropdownHandle)
                configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
            configFile:Register("ESPTracersHandle", ESPTracersHandle)
            configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
            configFile:Register("ESPStudsHandle", ESPStudsHandle)
                configFile:Register("autoDoorsHandle", autoDoorsHandle)
                configFile:Register("autoHideHandle", autoHideHandle)
                configFile:Register("antiSlHandle", antiSlHandle)
                configFile:Register("antiEfHandle", antiEfHandle)
                configFile:Register("antiLmHandle", antiLmHandle)
                configFile:Register("NoclipHandle", NoclipHandle)
                configFile:Register("WsToggleHandle", WsToggleHandle)
                configFile:Register("WsSliderHandle", WsSliderHandle)
                configFile:Register("antiAfkHandle", antiAfkHandle)
                configFile:Register("antiFlingHandle", antiFlingHandle)
                configFile:Register("FlingHandle", FlingHandle)
                configFile:Register("noMonstersHandle", noMonstersHandle)
                configFile:Register("antiAdminHandle", antiAdminHandle)
        end
    end
})

local ConfigManager = Window.ConfigManager
local configFile
local autoLoadFile = "AZUREHUB_ALC_PR.txt"
local ALC = false

if ConfigManager then
    ConfigManager:Init(Window)
    
    configFile = ConfigManager:CreateConfig(configName)
    configFile:Register("lootAuraHandle", lootAuraHandle)
    configFile:Register("antiKillablesHandle", antiKillablesHandle)
                configFile:Register("ReachAuraHandle", ReachAuraHandle)
                configFile:Register("notifyAbtHandle", notifyAbtHandle)
                configFile:Register("notifyChaHandle", notifyChaHandle)
                configFile:Register("jumpHandle", jumpHandle)
                configFile:Register("dropdownHandle", dropdownHandle)
                configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
            configFile:Register("ESPTracersHandle", ESPTracersHandle)
            configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
            configFile:Register("ESPStudsHandle", ESPStudsHandle)
                configFile:Register("autoDoorsHandle", autoDoorsHandle)
                configFile:Register("autoHideHandle", autoHideHandle)
                configFile:Register("antiSlHandle", antiSlHandle)
                configFile:Register("antiEfHandle", antiEfHandle)
                configFile:Register("antiLmHandle", antiLmHandle)
                configFile:Register("NoclipHandle", NoclipHandle)
                configFile:Register("WsToggleHandle", WsToggleHandle)
                configFile:Register("WsSliderHandle", WsSliderHandle)
                configFile:Register("antiAfkHandle", antiAfkHandle)
                configFile:Register("antiFlingHandle", antiFlingHandle)
                configFile:Register("FlingHandle", FlingHandle)
                configFile:Register("noMonstersHandle", noMonstersHandle)
                configFile:Register("antiAdminHandle", antiAdminHandle)
    
    TabHandles.Config:Button({
        Title = "Save Config",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
            configFile:Save()
            WindUI:Notify({ 
                Title = "Saved Config", 
                Content = "Saved as: "..configName,
                Icon = "check",
                Duration = 3
            })
        end
    })

    TabHandles.Config:Button({
        Title = "Load Config",
        Icon = "folder",
        Callback = function()
           if not configFile then
                configFile = ConfigManager:CreateConfig(configName)
                configFile:Register("antiKillablesHandle", antiKillablesHandle)
                configFile:Register("ReachAuraHandle", ReachAuraHandle)
                configFile:Register("lootAuraHandle", lootAuraHandle)
                configFile:Register("notifyAbtHandle", notifyAbtHandle)
                configFile:Register("notifyChaHandle", notifyChaHandle)
                configFile:Register("jumpHandle", jumpHandle)
                configFile:Register("dropdownHandle", dropdownHandle)
                configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
            configFile:Register("ESPTracersHandle", ESPTracersHandle)
            configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
            configFile:Register("ESPStudsHandle", ESPStudsHandle)
                configFile:Register("autoDoorsHandle", autoDoorsHandle)
                configFile:Register("autoHideHandle", autoHideHandle)
                configFile:Register("antiSlHandle", antiSlHandle)
                configFile:Register("antiEfHandle", antiEfHandle)
                configFile:Register("antiLmHandle", antiLmHandle)
                configFile:Register("NoclipHandle", NoclipHandle)
                configFile:Register("WsToggleHandle", WsToggleHandle)
                configFile:Register("WsSliderHandle", WsSliderHandle)
                configFile:Register("antiAfkHandle", antiAfkHandle)
                configFile:Register("antiFlingHandle", antiFlingHandle)
                configFile:Register("FlingHandle", FlingHandle)
                configFile:Register("noMonstersHandle", noMonstersHandle)
                configFile:Register("antiAdminHandle", antiAdminHandle)
            end

            local loadedData = configFile:Load()

            if loadedData then
                WindUI:Notify({ 
                    Title = "Load Config", 
                    Content = "Loaded: "..configName.."\nLast save: "..(loadedData.lastSave or "Unknown"),
                    Icon = "refresh-cw",
                    Duration = 5
                })
            else
                WindUI:Notify({ 
                    Title = "Load Config", 
                    Content = "Failed to load config: "..configName,
                    Icon = "x",
                    Duration = 5
                })
            end
        end
    })
    local autoloadconfig
    autoloadconfig = TabHandles.Config:Toggle({
        Title = "Auto Load Config",
        Desc = "Automatically load the last used config on execute.",
        Callback = function(state)
            ALC = state
            writefile(autoLoadFile, tostring(state))
        end
    })

    if isfile(autoLoadFile) and readfile(autoLoadFile) == "true" then
        local success, err = pcall(function()
            if not configFile then
                configFile = ConfigManager:CreateConfig(configName)
            end

            local loadedData = configFile:Load()
            if loadedData then
                autoloadconfig:Set(true)
                WindUI:Notify({
                    Title = "Auto Load Config",
                    Content = "Automatically loaded config: " .. configName,
                    Icon = "refresh-ccw",
                    Duration = 2
                })
            end
        end)
    end
end

local Whitelist = {
	["Angler"] = true,
	["Froger"] = true,
	["Pinkie"] = true,
	["Blitz"] = true,
	["Pandemonium"] = true,
	["Chainsmoker"] = true,
	["DwellerSpawn"] = true,
	["A60"] = true,
	["Finale"] = true,
	["Ambuscade"] = true,
	["Stairwell"] = true,
	["Witching"] = true,
	["Runner"] = true,
	["Stan"] = true,
	["Harbinger"] = true,
	["Pipsqueak"] = true,
	["Educator"] = true
}

local gbl = { "Currency", "NormalKeyCard", "SpawnKeycard", "PasswordPaper", "Medkit", "Sprint", "Code", "Cocktail", "Toy", "Defibrilator", "Batter", "Perithesene", "BL1", "Neloprephine" }
local ebl = { "Lantern", "Flashlight", "Gravelight", "Flashbeacon", "Necrobloxicon", "Blacklight", }
local lbl = { "AzureHubByCat"  }

local function hasInAncestry(instance, terms)
	local current = instance
	while current do
		local name = current.Name:lower()
		for _, word in ipairs(terms) do
			if name:find(word:lower()) then
				return true
			end
		end
		current = current.Parent
	end
	return false
end

task.spawn(function()
	while task.wait(0.2) do
		local modeRaw = AuraLootMode
		if typeof(modeRaw) == "table" then
			modeRaw = modeRaw.Option or modeRaw[1] or ""
		end

		local mode = tostring(modeRaw):lower():gsub("%s+", "")
		if mode == "turnoff" or mode == "" then continue end

		local char = lp.Character
		if not char then continue end

		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then continue end

		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("ProximityPrompt") and obj.Parent and obj.Parent:IsA("BasePart") then
				local allowed = false

				if hasInAncestry(obj.Parent, gbl) then
					allowed = true
				elseif mode == "everything" and hasInAncestry(obj.Parent, ebl) then
					allowed = true
				elseif mode == "nolightsources" and hasInAncestry(obj.Parent, lbl) then
					allowed = true
				end

				if not allowed then continue end

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
local lastPosition = nil
local TextChatService = game:GetService("TextChatService")
local excludedMonster = "Wall Dweller"

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

local hum = Character:WaitForChild("Humanoid")

game.DescendantAdded:Connect(function(child)
	if not child:IsA("BasePart") then return end
	if child.Name == "NoDweller" or child.Name == "AnglerTrigger" or child.Name == "Stain" then return end

	local lowerName = child.Name:lower()
	if lowerName:find("pandemonium") and nameCallHooked then
	    playHideSound()
	    WindUI:Notify({
		Title = "Azure Hub (No Damage)",
		Content = "You can't die from pandemonium while nodamage is on.",
		Icon = "info",
		Duration = 2
	    })
	    return
	end
	if lowerName:find("chainsmoker") and noMonsterToggle then
	   noMonsters(child)
	   playHideSound()
	   WindUI:Notify({
		Title = "Azure Hub (No Monsters)",
		Content = "If you get close to chainsmoker, script will make you teleport to next door, if door can't open, wait until chainsmoker gets close.",
		Icon = "info",
		Duration = 5
	    })
	end
	if lowerName:find("meshes") then return end
	if not isWhitelisted(child.Name) then return end
	if notified[child] then return end

	notified[child] = true

	local rawName = child.Name
	local name = rawName == "DwellerSpawn" and "Wall Dweller" or rawName
	local isFroger = (child.Name == "Froger" or child.Name == "RidgeFroger")

	if hideToggle and name ~= excludedMonster then
		task.spawn(function()
			while child and child.Parent do
				task.wait(0.15)
				local a = hrp.Position
				local b = child.Position
				local dist = (Vector3.new(a.X, 0, a.Z) - Vector3.new(b.X, 0, b.Z)).Magnitude

				if dist <= 100 then
					if not activeMonsters[child] then
						activeMonsters[child] = name
					end

					if not teleported then
						lastPosition = hrp.Position
						teleported = true
						isHidden = true
						local baseY = lastPosition.Y + 100
						local safeBlock = Instance.new("Part")
						safeBlock.Anchored = true
						safeBlock.Size = Vector3.new(15, 1, 15)
						safeBlock.Position = Vector3.new(lastPosition.X, baseY, lastPosition.Z)
						safeBlock.CanCollide = true
						safeBlock.Name = "SafePlatform"
						safeBlock.Transparency = 1
						safeBlock.BrickColor = BrickColor.new("Back")
						safeBlock.Parent = workspace
						hrp.CFrame = CFrame.new(lastPosition.X, baseY + 1.5, lastPosition.Z)
						hum.WalkSpeed = 0
						playHideSound()
						WindUI:Notify({
							Title = "Auto Hide",
							Content = "Teleported to Safe Spot.",
							Icon = "info",
							Duration = 1
						})
					end
				else
					if teleported then
					local platform = workspace:FindFirstChild("SafePlatform")
					if platform then platform:Destroy() end
						hrp.CFrame = CFrame.new(lastPosition)
						lastPosition = nil
						teleported = false
						isHidden = false
						hum.WalkSpeed = currentSpeed or 16
						playHideSound()
						WindUI:Notify({
							Title = "Auto Hide",
							Content = "Teleported back.",
							Icon = "info",
							Duration = 1
						})
					end
				end
			end
		end)
	end

	if MonsterToggle then
		WindUI:Notify({
			Title = "Entity Spawned",
			Content = "Detected: " .. name,
			Icon = "info",
			Duration = 3
		})
	end

	if MonsterToggleChat then
		SendChatMessage(name)
	end

	child.AncestryChanged:Connect(function(_, parent)
	if not parent then
		notified[child] = nil
		if activeMonsters[child] then
			activeMonsters[child] = nil

			if not next(activeMonsters) and lastPosition and teleported then
				task.delay(0.25, function()
					local platform = workspace:FindFirstChild("SafePlatform")
					if platform then platform:Destroy() end

					hrp.CFrame = CFrame.new(lastPosition)
					lastPosition = nil
					teleported = false
					isHidden = false
					hum.WalkSpeed = currentSpeed or 16
					playHideSound()

					WindUI:Notify({
						Title = "Auto Hide",
						Content = "Teleported Back.",
						Icon = "info",
						Duration = 1
					})
				end)
			end
		end
	end
end)
end)

task.spawn(function()
	while task.wait(1) do
		if not antiMineToggle and not antiSearchlightToggle and not antiEyefestationToggle then
			continue
		end

		for _, obj in ipairs(game:GetDescendants()) do
			if obj:IsA("Instance") and obj.Name then
				local name = obj.Name:lower()

				if antiMineToggle and name:find("tripmine") then
					pcall(function() obj:Destroy() end)
				end
			end
		end

		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") or obj:IsA("Sound") and obj.Name then
				local name = obj.Name:lower()

				if antiSearchlightToggle and name:find("searchlight") then
					pcall(function() obj:Destroy() end)

				elseif antiEyefestationToggle and name:find("eyefestation") then
					pcall(function() obj:Destroy() end)
				end
			end
		end
	end
end)

task.spawn(function()
    while task.wait(1) do
        if perfomanceToggle and hrp then
            local roomsFolder = workspace:WaitForChild("GameplayFolder"):WaitForChild("Rooms")
            local playerPosXZ = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
            local safeRooms = {}

            for _, room in ipairs(roomsFolder:GetChildren()) do
                if room:IsA("Model") and room.PrimaryPart then
                    local roomPosXZ = Vector3.new(room.PrimaryPart.Position.X, 0, room.PrimaryPart.Position.Z)
                    local dist = (playerPosXZ - roomPosXZ).Magnitude

                    if dist <= 500 then
                        table.insert(safeRooms, room)
                    end
                end
            end

            for _, room in ipairs(roomsFolder:GetChildren()) do
                if not table.find(safeRooms, room) then
                    local size = room:GetExtentsSize()
                    local center = room:GetBoundingBox()
                    local min = center.Position - (size / 2)
                    local max = center.Position + (size / 2)
                    local pos = hrp.Position

                    if not (pos.X >= min.X and pos.X <= max.X and
                            pos.Y >= min.Y and pos.Y <= max.Y and
                            pos.Z >= min.Z and pos.Z <= max.Z) then
                        room:Destroy()
                    end
                end
            end

            --[[for _, safeRoom in ipairs(safeRooms) do
                for _, door in ipairs(safeRoom:GetDescendants()) do
                    if door:IsA("Model") and door.Name == "NormalDoor" then
                        if not openDoorsToggle then
                            door.Name = "NormalDoor1"
                        end
                    end
                end
            end]]
        end
    end
end)

task.spawn(function()
    while task.wait(0.01) do
        if ReachAuraSlider ~= 10 then
            local playerPos = root.Position
		for _, prom in ipairs(workspace.GameplayFolder.Rooms:GetDescendants()) do
			if prom:IsA("ProximityPrompt") and prom.Enabled then
				local parent = prom.Parent
				if parent and parent:IsA("BasePart") and parent.Name == "Root" then
					local distance = (parent.Position - playerPos).Magnitude
					if distance <= ReachAuraSlider then
						fireproximityprompt(prom, 999)
					end
				end
			end
		end
        end
    end
end)

while task.wait(0.02) do
  if antiFlingToggle then
     for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
     end
  end
end