local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local username = lp.Name
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local character
local hum
local root

local chaseSound
local activeTween

local function uCR(char)
    character = char
    root = character:WaitForChild("HumanoidRootPart", 5)
    hum = character:WaitForChild("Humanoid", 5)
    if chaseSound then
       chaseSound:Stop()
	chaseSound:Destroy()
	chaseSound = nil
    end
end

uCR(lp.Character or lp.CharacterAdded:Wait())
lp.CharacterAdded:Connect(function(newChar)
    uCR(newChar)
end)

local blacklist = {
    [1834326225] = true,
    [396125889] = true,
    [98750775] = true,
    [3808251668] = true,
    [160224394] = true,
    [49706510] = true,
    [115342213] = true,
    [1806115340] = true,
    [1260363902] = true,
    [64656085] = true,
    [271036866] = true,
    [3137137279] = true
}
local premium_users = { "Tgpeek1", "Technique12_12", "Vbn_bountyhunter", "Waiteronewater", "iruzruz", "731niic", "RRQLEMONNl", "pedro377637", "blorospo", "flespos83", "prexos837", "polop7365"}
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local function getTag(name)
    for _, v in ipairs(premium_users) do
        if v == name then
            return "[ PREMIUM ]"
        end
    end
    return "[ FREEMIUM ]"
end

local discordLink = "https://discord.gg/QmvpbPdw9J"

if blacklist[lp.UserId] then
    lp:Kick("Exploiting")
    return
end

local gid = 8818124
local bannedRanks = {
    ["contributors"] = true,
    ["Smiling Friends"] = true,
    ["rick"] = true
}
local rankName = lp:GetRoleInGroup(8818124)
if bannedRanks[rankName] then
    lp:Kick("Exploiting")
end

print("Loaded!\nAzureHub By Cat\nDiscord: https://discord.gg/QmvpbPdw9J")

WindUI:SetNotificationLower(true)
local Window = WindUI:CreateWindow({
    Title = "Azure Hub | Violence District ".. getTag(lp.Name),
    Author = "discord.gg/QmvpbPdw9J",
    Folder = "ViolenceDistrictHub",
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
Window:SetToggleKey(Enum.KeyCode.K)

Window:EditOpenButton({
    Title = "Open Azure Hub " .. getTag(lp.Name),
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Theme Changed",
        Content = "Current theme: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

local Logs = Window:Tab({ Title = "|  Update Logs", Icon = "scroll-text" })
Window:Divider()

local Tabs = {
    Features = Window:Section({ Title = "Features", Opened = true }),
    Utilities = Window:Section({ Title = "Utilities", Opened = true })
}

local TabHandles = {
Universal = Tabs.Features:Tab({ Title = "|  Universal", Icon = "orbit" }),
Killer = Tabs.Features:Tab({ Title = "|  Killer", Icon = "slice" }),
Survivor = Tabs.Features:Tab({ Title = "|  Survivor", Icon = "user" }),
Esp = Tabs.Features:Tab({ Title = "|  ESP", Icon = "eye" }),
Player = Tabs.Features:Tab({ Title = "|  Player", Icon = "users-round" }),
Misc = Tabs.Features:Tab({ Title = "|  Misc", Icon = "layout-grid" }),
Config = Tabs.Utilities:Tab({ Title = "|  Configuration", Icon = "settings" })
}

local updparagraph = Logs:Paragraph({
    Title = "Update Logs",
    Desc = "20.12.25\n[+] Auto Presents\n[+] ESP: Presents\n[/] Updated To Latest Data\n[/] Fixed New Detections\n[/] Fixed Lot Of Bugs\n\n18.12.25\n[+] Expand Killer Hitboxes (flashlight)\n[/] Improved Auto Attack (revolver)\n[/] Fixed Some Bugs (not desync)\n\n16.12.25\n[/] Fixed Shooting Takes Time\n[-] Expand Survivor Hitboxes (Detected)\n\n12.12.25\nUniversal Tab:\n[+] Desync\n[+] Desync Options\n- Hitbox Improving makes your server-side visualizer sync faster and move forward.\n- Fake Position makes everyone see you at the place you activated Desync.\n\n30.11.25\n[/] Updated To Latest Data\n[-] Grab Nearest Player (Detected)\n[-] Carry Nearest Player (Detected)\n\n14.11.25\n[-] ESP: Pumpkins\n\n8.10.25\n[+] Damage Aura\nDefense:\n[+] Grab Nearest Player (Premium)\n[+] Carry Nearest Player (Premium)\n\n31.10.25\n[+] Updated To Latest Data\n[+] Auto Drop Pallete\n[+] Auto Aim Spear (Veil)\n[+] Remove Veil Clothings\n[+] ESP: Pumpkins\n[/] Bug Fixes\n\n24.09.25\n[+] Hit Sound\n[+] Chase Theme\n[+] In-Built Auto Dodge Slash\n[+] In-Built Fix Carry Bug\n\n23.09.25\n[+] God Mode\n[-] No Damage Patched\n\n3.09.25\n[+] Violence District\n[+] Premium Features",
    Locked = false,
    Buttons = {
        {
            Icon = "clipboard",
            Title = "Discord Server",
            Callback = function() setclipboard(discordLink) WindUI:Notify({ Title = "Discord Server", Content = "Link Copied!", Icon = "info", Duration = 2 }) end,
        }
    }
})

local AutoEventToggle = false
local AntiFlashlight = false
local clicked = false
local WalkToggle = false
local currentSpeed = 28
local Noclip = nil
local Clip = nil
local NoclipToggle = false
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
local Autoshoot = false
local Autoparry = false
local facingLoop = false
local selectedTarget = {}
local AntiGFail = false
local AntiHFail = false
local GodmodeToggle = false
local AntislowToggle = false
local ExpandToggle = false
local InfThingsToggle = false
local chasetheme = "Default"
local noCdEnabled = false
local RemoveClothingsToggle = false
local AutoAimToggle = false
local AutoDropToggle = false
local AutoDropSetToggle = false
local DamageAura = false
local DesyncType = "Hitbox Improving"
local Desync = false

local toggles = {
    JasonPursuit = false,
    JasonMist = false,
    StalkerEvolve = false,
    StalkerStage = false,
    Masked = false
}

local function getKiller()
    local weapon = character:FindFirstChild("Weapon")
    if not weapon then return nil end

    local rightArm = weapon:FindFirstChild("Right Arm")

    if rightArm and rightArm:FindFirstChild("Machete") then
        if rightArm and rightArm.Machete:FindFirstChild("pCube4_knife_0") then
            return "Jeff"
        else
            return "Jason"
        end

    elseif rightArm and rightArm:FindFirstChild("Knife") then
        return "Stalker"

    elseif weapon:FindFirstChild("Chainsaw") then
        return "Masked"
    end

    return nil
end

local function hookButton(btn)
    btn.MouseButton1Down:Connect(function()
        local killer = getKiller()
        if not killer then return end
        
        if btn.Name == "attack" and noCdEnabled then
            game.ReplicatedStorage.Remotes.Attacks.BasicAttack:FireServer()
        end
        
        if killer == "Jason" then
            if btn.Name == "move1" then
                toggles.JasonPursuit = not toggles.JasonPursuit
                game.ReplicatedStorage.Remotes.Killers.Jason.Pursuit:FireServer(toggles.JasonPursuit)
                if toggles.JasonPursuit then
                    local hum = (lp.Character or lp.CharacterAdded:Wait()):WaitForChild("Humanoid")
                    local anim = Instance.new("Animation")
                    anim.AnimationId = "rbxassetid://125224839697689"
                    hum:LoadAnimation(anim):Play()
                end
            elseif btn.Name == "move2" then
                toggles.JasonMist = not toggles.JasonMist
                game.ReplicatedStorage.Remotes.Killers.Jason.LakeMist:FireServer(toggles.JasonMist)
            end

        elseif killer == "Jeff" then
            if btn.Name == "move1" then
                game.ReplicatedStorage.Remotes.Killers.Killer.ActivatePower:FireServer()
            end

        elseif killer == "Stalker" then
            if btn.Name == "move1" then
                toggles.StalkerEvolve = not toggles.StalkerEvolve
                game.ReplicatedStorage.Remotes.Killers.Stalker.EvolveStage:FireServer(toggles.StalkerStage and 2 or false)
            elseif btn.Name == "move2" then
                toggles.StalkerStage = not toggles.StalkerStage
            end

        elseif killer == "Masked" then
            if btn.Name == "move1" then
                if toggles.Masked then
                game.ReplicatedStorage.Remotes.Killers.Masked.Deactivatepower:FireServer()
                    toggles.Masked = false
                    task.wait(2)
                end
                game.ReplicatedStorage.Remotes.Killers.Masked.Activatepower:FireServer(chosenMapped)
                toggles.Masked = true
            end
        end
    end)
end

local function isPlayerObject(obj)
    local child = obj:FindFirstChild("Highlight-forsurvivor")
    return child and child:IsA("LocalScript")
end

local function isKillerObject(obj)
    local killer1 = obj:FindFirstChild("Killerost")
    local killer2 = obj:FindFirstChild("Lookscriptkiller")
    return (killer1 and killer1:IsA("LocalScript")) or (killer2 and killer2:IsA("LocalScript"))
end

local function isGenerator(obj)
    if obj:IsA("Model") and obj.Name == "Generator" then
        local hitbox = obj:FindFirstChild("HitBox")
        return hitbox and hitbox:IsA("BasePart")
    end
    return false
end

local function isPresent(obj)
    if obj:IsA("Model") and obj.Parent.Name == "Gifts" then
        if string.find(obj.Name, "Gift") then
            local hitbox = obj:FindFirstChild("GiftHandle")
            return hitbox and hitbox:IsA("BasePart")
        end
    end
    return false
end

local function contains(tbl, val)
    if not tbl or type(tbl) ~= "table" then return false end
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

local function getObjType(obj)
    if not obj then return nil end
    if obj:FindFirstChild("Highlight-forsurvivor") then return "Players" end
    if obj:FindFirstChild("Killerost") or obj:FindFirstChild("Lookscriptkiller") then return "Killers" end
    if obj.Name == "Generator" or (obj.Parent and obj.Parent.Name == "Gens") then 
        return "Generators" 
    end
    if string.find(obj.Name, "GiftHandle") and obj.Parent then return "Presents" end
    return nil
end

local function passesFilter(obj)
    local t = getObjType(obj)
    return t and contains(selectedESPTypes, t)
end

local function getObjColor(obj)
    local t = getObjType(obj)
    if t == "Killers" then return Color3.fromRGB(255, 0, 0) end
    if t == "Generators" then return Color3.fromRGB(255, 255, 0) end
    if t == "Presents" then return Color3.fromRGB(1, 50, 32) end
    return Color3.fromRGB(0, 255, 0)
end

local function ensureHighlight(obj)
    if not ESPHighlight then
        if esp[obj] and esp[obj].highlight then
            esp[obj].highlight:Destroy()
            esp[obj].highlight = nil
        end
        return
    end
    
    if not esp[obj].highlight then
        local h = Instance.new("Highlight")
        h.Adornee = obj
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.FillColor = getObjColor(obj)
        h.OutlineColor = Color3.new(1, 1, 1)
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = obj
        esp[obj].highlight = h
    end
end

local function ensureBillboard(obj)
    if not (ESPNames or ESPStuds) then
        if esp[obj].billboard then
            esp[obj].billboard:Destroy()
            esp[obj].billboard = nil
        end
        return
    end

    if not esp[obj].billboard then
        local head = obj:FindFirstChild("Head") or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
        if not head then return end

        local b = Instance.new("BillboardGui")
        b.Size = UDim2.new(0, 200, 0, 50)
        b.Adornee = head
        b.AlwaysOnTop = true
        b.Parent = obj
        
        local n = Instance.new("TextLabel", b)
        n.BackgroundTransparency = 1
        n.Size = UDim2.new(1, 0, 0, 16)
        n.Position = UDim2.new(0, 0, 0, -20)
        n.Text = obj.Name
        n.Font = Enum.Font.SourceSansBold
        n.TextSize = 14
        
        local s = Instance.new("TextLabel", b)
        s.BackgroundTransparency = 1
        s.Size = UDim2.new(1, 0, 0, 14)
        s.Position = UDim2.new(0, 0, 0, -5)
        s.Font = Enum.Font.SourceSans
        s.TextSize = 12

        esp[obj].billboard = b
        esp[obj].nameLabel = n
        esp[obj].studsLabel = s
    end
end

local function ensureTracer(obj)
    if not ESPTracers then
        if tracers[obj] then tracers[obj]:Remove() tracers[obj] = nil end
        return
    end
    
    if not tracers[obj] then
        local L = Drawing.new("Line")
        L.Thickness = 1
        L.Transparency = 1
        tracers[obj] = L
    end
end

local function ensureBox(obj)
    if not ESPBoxes then
        if boxes[obj] then
            for _, l in pairs(boxes[obj]) do l:Remove() end
            boxes[obj] = nil
        end
        return
    end

    if not boxes[obj] then
        boxes[obj] = {
            tl = Drawing.new("Line"),
            tr = Drawing.new("Line"),
            bl = Drawing.new("Line"),
            br = Drawing.new("Line")
        }
        for _, line in pairs(boxes[obj]) do
            line.Thickness = 1
            line.Transparency = 1
        end
    end
end

local function ensureAllFor(obj)
    if not esp[obj] then esp[obj] = {} end
    
    ensureHighlight(obj)
    ensureBillboard(obj)
    ensureTracer(obj)
    ensureBox(obj)
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

local lR = 0
local rl = 1.5

RunService.RenderStepped:Connect(function()
    if tick() - lR > rl then
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj ~= lp.Character and passesFilter(obj) then
                ensureAllFor(obj)
            end
        end
        
        local mapf = workspace:FindFirstChild("Map")
        if mapf then
            for _, obj in ipairs(mapf:GetChildren()) do
                if obj ~= lp.Character and passesFilter(obj) then
                    ensureAllFor(obj)
                end
                
                if obj.Name == "Gens" and obj:IsA("Folder") then
                    for _, gen in ipairs(obj:GetChildren()) do
                        if passesFilter(gen) then ensureAllFor(gen) end
                    end
                end
            end

            local chrisFolder = nil
            for _, child in ipairs(mapf:GetChildren()) do
                if string.find(string.lower(child.Name), "chris") then
                    chrisFolder = child
                    break
                end
            end

            local giftsFolder = nil
            if chrisFolder then
                for _, child in ipairs(chrisFolder:GetChildren()) do
                    if string.find(string.lower(child.Name), "gift") then
                        giftsFolder = child
                        break
                    end
                end
            end

            if giftsFolder then
                for _, giftModel in ipairs(giftsFolder:GetChildren()) do
                    local handle = giftModel:FindFirstChild("GiftHandle")
                    if handle and passesFilter(handle) then
                        ensureAllFor(handle)
                    end
                end
            end
        end
        lR = tick()
    end

    local viewportSize = Camera.ViewportSize
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")

    for obj, data in pairs(esp) do
        if not obj or not obj.Parent or not passesFilter(obj) then
            removeESP(obj)
            continue
        end

        local rootPart = (obj.Name == "GiftHandle" and obj) or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("HitBox") or obj:FindFirstChild("HB") or obj.PrimaryPart
        if not rootPart then continue end
        
        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        local isVisible = onScreen and screenPos.Z > 0

        if tracers[obj] then
            tracers[obj].Visible = isVisible and ESPTracers
            if tracers[obj].Visible then
                tracers[obj].Color = getObjColor(obj)
                tracers[obj].From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                tracers[obj].To = Vector2.new(screenPos.X, screenPos.Y)
            end
        end

        if data.billboard then
            data.billboard.Enabled = isVisible and (ESPNames or ESPStuds)
            if data.billboard.Enabled and myRoot then
                if data.studsLabel then
                    local dist = (myRoot.Position - rootPart.Position).Magnitude
                    data.studsLabel.Text = math.floor(dist) .. "m"
                    data.studsLabel.TextColor3 = getObjColor(obj)
                end
                if data.nameLabel then
                    data.nameLabel.Text = (obj.Name == "GiftHandle") and "Present" or obj.Name
                    data.nameLabel.TextColor3 = getObjColor(obj)
                end
            end
        end

        if boxes[obj] then
            local box = boxes[obj]
            local showBox = isVisible and ESPBoxes
            for _, line in pairs(box) do line.Visible = showBox end

            if showBox then
                local size = (1 / screenPos.Z) * 1000 
                local w, h = size * 0.6, size
                if obj.Name == "GiftHandle" then w = size * 0.4; h = size * 0.4 end
                
                local x, y = screenPos.X, screenPos.Y
                local col = getObjColor(obj)

                box.tl.From = Vector2.new(x - w, y - h); box.tl.To = Vector2.new(x + w, y - h)
                box.tr.From = Vector2.new(x + w, y - h); box.tr.To = Vector2.new(x + w, y + h)
                box.br.From = Vector2.new(x + w, y + h); box.br.To = Vector2.new(x - w, y + h)
                box.bl.From = Vector2.new(x - w, y + h); box.bl.To = Vector2.new(x - w, y - h)
                for _, l in pairs(box) do l.Color = col end
            end
        end
    end
end)

Workspace.ChildAdded:Connect(function(child) task.wait(0.5); if passesFilter(child) then ensureAllFor(child) end 
end)
Workspace.ChildRemoved:Connect(function(child) removeESP(child) end)

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

local function applyBypassSpeed()
    task.spawn(function()
        while task.wait(0.2) do
            if WalkToggle and game.Players.LocalPlayer.Character then
                
                if hum then
                    for _, conn in ipairs(getconnections(hum:GetPropertyChangedSignal("WalkSpeed"))) do
                        conn:Disable()
                    end
                    
                    hum.WalkSpeed = currentSpeed
                end
            end
        end
    end)
end
applyBypassSpeed()

local crossUI

local function findFolderByKeyword(parent, keyword)
    if not parent then return nil end
    for _, child in ipairs(parent:GetChildren()) do
        if string.find(string.lower(child.Name), string.lower(keyword)) then
            return child
        end
    end
    return nil
end

local countevent = 0
local function autofarmcurrency()
    task.spawn(function()
        while AutoEventToggle do
            if countevent > 8 then
                warn("[AzureHub] Remote limit. Waiting 15 seconds to avoid detection...")
                WindUI:Notify({ Title = "Azure Hub", Content = "Remote limit. Waiting 15 seconds to avoid detection...", Icon = "info", Duration = 15 })
                task.wait(15)
                countevent = 0
                continue
            end
            local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            local mapf = workspace:FindFirstChild("Map")
            
            if root and mapf then
                local chris = findFolderByKeyword(mapf, "chris")
                local treeFolder = findFolderByKeyword(chris, "tree")
                
                local treePart = nil
                if treeFolder then
                    local model = treeFolder:FindFirstChild("Model")
                    treePart = model and model:FindFirstChild("Part")
                end

                local giftsFolder = findFolderByKeyword(chris, "gift")
                local targetGift = giftsFolder and giftsFolder:FindFirstChild("GiftHandle", true)

                if targetGift and treePart then
                    root.CFrame = targetGift.CFrame
                    task.wait(0.3)
                    
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("gift", true)
                    if remote then
                        remote:FireServer(targetGift)
                        countevent += 1
                    end
                    
                    task.wait(0.1)
                    root.CFrame = treePart.CFrame
                    task.wait(1)
                else
                    task.wait(1)
                end
            else
                task.wait(1)
            end
        end
    end)
end

local function getNearestTarget()
    local nearest, nearestDist

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") then
            local valid = false
            if selectedTarget == "Players" and isPlayerObject(obj) then
                valid = true
            elseif selectedTarget == "Killers" and isKillerObject(obj) then
                valid = true
            end

            if valid and obj ~= lp.Character then
                local targetRoot = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                if targetRoot and root then
                    local dist = (targetRoot.Position - root.Position).Magnitude
                    if not nearest or dist < nearestDist then
                        nearest, nearestDist = obj, dist
                    end
                end
            end
        end
    end

    return nearest
end

local function faceTarget(model)
    if not root then return end

    local arm = model:FindFirstChild("Head")
    if not arm and model.PrimaryPart then
        arm = model.PrimaryPart
    end
    if not arm then return end

    local pos = arm.Position
    local dir = (pos - root.Position).Unit

    root.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(dir.X, 0, dir.Z))

    local cam = workspace.CurrentCamera
    cam.CFrame = CFrame.new(cam.CFrame.Position, pos)
end

local function pressSpecialButton(args)
    local pg = lp:FindFirstChild("PlayerGui")
    if not pg then return end
    local survivor = pg:FindFirstChild("Survivor-mob")
    if not survivor then return end
    local controls = survivor:FindFirstChild("Controls")
    if not controls then return end
    local button = controls:FindFirstChild(args)
    if not button or not (button:IsA("TextButton") or button:IsA("ImageButton")) then return end

    for _, ev in ipairs({"MouseButton1Down", "MouseButton1Up", "MouseButton1Click"}) do
        if button[ev] then
            for _, sig in pairs(getconnections(button[ev])) do
                if sig.Function then
                    sig.Function()
                end
            end
        end
    end
end

local function AutoShoot()
    if not character then return end
    if not UserInputService.TouchEnabled then
        return WindUI:Notify({
            Title = "Auto Attack",
            Content = "Only works in mobile, PC soon.",
            Icon = "info",
            Duration = 3
        })
    end
    local pg = lp:FindFirstChild("PlayerGui")
    if not pg then return end

    local survivor = pg:FindFirstChild("Survivor-mob")
    if not survivor then
        return WindUI:Notify({
            Title = "Auto Attack",
            Content = "You must be survivor for that!",
            Icon = "info",
            Duration = 2
        })
    end
    if not (character:FindFirstChild("Twist of Fate") or character:FindFirstChild("Flashlight")) then
       return WindUI:Notify({
           Title = "Auto Attack",
           Content = "You must have revolver or flashlight to use this feature.",
           Icon = "info",
           Duration = 3
        })
    end

    local controls = survivor:FindFirstChild("Controls")
    if not controls then return end

    local button = controls:FindFirstChild("Gui-mob")
    if not button or not (button:IsA("TextButton") or button:IsA("ImageButton")) then return end
    
    if facingLoop then 
        facingLoop:Disconnect() 
        facingLoop = nil 
    end
    
    facingLoop = RunService.RenderStepped:Connect(function()
        if not Autoshoot then 
            facingLoop:Disconnect()
            facingLoop = nil
            return 
        end
        
        local target = getNearestTarget()
        if target then
            faceTarget(target)
        end
    end)
    
    task.delay(0.5, function()
        if Autoshoot and button and facingLoop then
            pressSpecialButton("Gui-mob")
            facingLoop:Disconnect()
            facingLoop = nil
        end
    end)
end

local function getSoundIdFromTheme()
	if chasetheme == "Mila - Compass" then
		return "rbxassetid://115877769571526"
	elseif chasetheme == "Close To Me" then
		return "rbxassetid://90022574613230"
	end
	return nil
end

local function fadeTo(vol, time)
	if not chaseSound then return end
	if activeTween then activeTween:Cancel() end
	activeTween = TweenService:Create(chaseSound, TweenInfo.new(time, Enum.EasingStyle.Linear), {Volume = vol})
	activeTween:Play()
end

local function setupChaseMusic(soundid)
	if not chaseSound then
		chaseSound = Instance.new("Sound")
		chaseSound.Name = "CCM"
		chaseSound.SoundId = soundid
		chaseSound.Looped = true
		chaseSound.Volume = 0
		chaseSound.Parent = SoundService

		chaseSound.Loaded:Wait()
		if 96.5 < chaseSound.TimeLength then
			if chasetheme == "Mila - Compass" then 
			chaseSound.TimePosition = 96.5
			end
		end
		chaseSound:Play()
	end

	fadeTo(1.2, 0)
end

local function CreateCross()
    if crossUI then return end

    local pg = game:GetService("CoreGui")

    crossUI = Instance.new("ScreenGui")
    crossUI.Name = "CrosshairUI"
    crossUI.ResetOnSpawn = false
    crossUI.Parent = pg

    local button = Instance.new("ImageButton")
    button.Name = "CircleButton"
    button.Size = UDim2.fromOffset(50, 50)
    button.Position = UDim2.new(1, -120, 0, 150)
    button.BackgroundTransparency = 1
    button.AutoButtonColor = false
    button.Active = true
    button.Draggable = true
    button.Parent = crossUI

    local circle = Instance.new("Frame")
    circle.Size = UDim2.fromScale(1, 1)
    circle.BackgroundTransparency = 1
    circle.Parent = button

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = circle

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Transparency = 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = circle

    button.MouseButton1Click:Connect(function()
        AutoShoot()
    end)
end

local aimConn
local aimGui

local function createAimToggle()
    if aimGui then
        aimGui:Destroy()
        aimGui = nil
    end
    if aimConn then
        aimConn:Disconnect()
        aimConn = nil
    end
    
    aimGui = Instance.new("ScreenGui")
    aimGui.Parent = game:GetService("CoreGui")
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 160, 0, 40)
    ToggleButton.Position = UDim2.new(0.68, 0, 0.05, 0)
    ToggleButton.Text = "Auto Aim: OFF"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleButton.TextColor3 = Color3.new(1, 1, 1)
    ToggleButton.Font = Enum.Font.SourceSansBold
    ToggleButton.TextSize = 18
    ToggleButton.Parent = aimGui
    ToggleButton.Active = true
    ToggleButton.Draggable = true

    local function aim()
        if aimConn then return end
        
        aimConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not AutoAimToggle then
                aimConn:Disconnect()
                aimConn = nil
                return
            end
            
            local closestPlayer = nil
            local minDist = math.huge
            
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= lp and player.Character then
                    local head = player.Character:FindFirstChild("Head")
                    
                    if player.Character:GetAttribute("IsHooked") or player.Character:GetAttribute("IsCarried") then
                        continue
                    end
                    
                    if head then
                        local dist = (head.Position - root.Position).Magnitude
                        if dist < minDist then
                            closestPlayer = player
                            minDist = dist
                        end
                    end
                end
            end
            
            if closestPlayer and closestPlayer.Character then
                local head = closestPlayer.Character:FindFirstChild("Head")
                if head then
                    local targetPos = head.Position

                    root.CFrame = CFrame.lookAt(root.Position, Vector3.new(targetPos.X, root.Position.Y, targetPos.Z))
                    workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, targetPos)
                end
            end
        end)
    end

    ToggleButton.MouseButton1Click:Connect(function()
        AutoAimToggle = not AutoAimToggle
        ToggleButton.Text = "Auto Aim: " .. (AutoAimToggle and "ON" or "OFF")
        
        if AutoAimToggle then
            aim()
        else
            if aimConn then
                aimConn:Disconnect()
                aimConn = nil
            end
        end
    end)
    
    return aimGui
end

local function RemoveCross()
    if crossUI then
        crossUI:Destroy()
        crossUI = nil
    end
end

local function createDropdown()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DropdownGUI"
    ScreenGui.Parent = game.CoreGui

    local chosenOption = "Select Mask"
    local chosenMapped = "Rooster"
    local options = {"Chainsaw", "Deadly Punches", "Walk Faster", "Further Dash", "Vault Faster", "Complete Stealth", "Default Mask"}

    local optionMap = {
        ["Chainsaw"] = "Alex",
        ["Deadly Punches"] = "Tony",
        ["Walk Faster"] = "Brandon",
        ["Further Dash"] = "Cobra",
        ["Vault Faster"] = "Rabbit",
        ["Complete Stealth"] = "Richter",
        ["Default Mask"] = "Rooster"
    }

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(0, 160, 0, 40)
    DropdownButton.Position = UDim2.new(0.68, 0, 0.05, 0)
    DropdownButton.Text = chosenOption
    DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropdownButton.TextColor3 = Color3.new(1, 1, 1)
    DropdownButton.Font = Enum.Font.SourceSansBold
    DropdownButton.TextSize = 18
    DropdownButton.Parent = ScreenGui
    DropdownButton.Active = true
    DropdownButton.Draggable = true

    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Size = UDim2.new(0, 160, 0, 0)
    OptionsFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    OptionsFrame.BorderSizePixel = 0
    OptionsFrame.Visible = false
    OptionsFrame.ClipsDescendants = true
    OptionsFrame.Parent = DropdownButton

    local optionHeight = 20
    for i, name in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, optionHeight)
        btn.Position = UDim2.new(0, 0, 0, (i-1) * optionHeight)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 16
        btn.Text = name
        btn.Parent = OptionsFrame

        btn.MouseButton1Click:Connect(function()
            chosenOption = name
            chosenMapped = optionMap[name]
            DropdownButton.Text = chosenOption
            OptionsFrame.Visible = false
            OptionsFrame.Size = UDim2.new(0, 160, 0, 0)
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        if OptionsFrame.Visible then
            OptionsFrame.Visible = false
            OptionsFrame.Size = UDim2.new(0, 160, 0, 0)
        else
            OptionsFrame.Visible = true
            OptionsFrame.Size = UDim2.new(0, 160, 0, #options * optionHeight)
        end
    end)

    return {
        getSelection = function()
            return chosenOption, chosenMapped
        end
    }
end

function createDraggableToggle()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NoCdToggleUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0, 130, 0, 35)
    ToggleFrame.Position = UDim2.new(0.5, -65, 0.2, 0)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ToggleFrame.Active = true
    ToggleFrame.Draggable = true
    ToggleFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = ToggleFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.7, 0, 0.7, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "No Cd: OFF"
    Title.Font = Enum.Font.Code
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Parent = ToggleFrame

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(1, 0, 1, 0)
    Toggle.BackgroundTransparency = 1
    Toggle.Text = ""
    Toggle.Parent = ToggleFrame

    local enabled = false
    Toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        Title.Text = "No Cd: " .. (enabled and "ON" or "OFF")

        if enabled then
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
            noCdEnabled = true
        else
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            noCdEnabled = false
        end
    end)
end

local lastAnim
RunService.Heartbeat:Connect(function()
    if not root then return end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and isKillerObject(obj) and obj.PrimaryPart then
            local dist = (obj.PrimaryPart.Position - root.Position).Magnitude
            local killerHum = obj:FindFirstChildOfClass("Humanoid")

            if dist <= 20 and killerHum then
                for _, track in ipairs(killerHum:GetPlayingAnimationTracks()) do
                local animId = track.Animation.AnimationId or ""
                local trackName = track.Name
                local key = animId ~= "" and animId or trackName
                
                if string.find(animId, "80411309607666") or trackName:lower() == "slash" then
                        if lastAnim ~= key then
                            pressSpecialButton("crouch")
                            lastAnim = key
                            task.delay(5, function()
                               lastAnim = ""
                            end)
                        end
                        return
                    end
                end
            end

            if Autoparry and dist <= 10 and character:FindFirstChild("Parrying Dagger") then
                local rightArm = obj:FindFirstChild("Right Arm")
                if rightArm then
                    local sound = rightArm:FindFirstChildWhichIsA("Sound")
                    if sound then
                        game.ReplicatedStorage.Remotes.Items["Parrying Dagger"].parry:FireServer()
                        pressSpecialButton("Gui-mob")
                        return
                    end
                end
            end
        end
    end
end)

local function autodrop()
    spawn(function()
        while AutoDropToggle do
            task.wait(0.01)
            
            local nearestPallet = nil
            local shortestDistance = 10
            local rootPos = root.Position
            
            for _, obj in pairs(workspace.Map:GetDescendants()) do
                if obj.Name == "Palletwrong" then
                    local distance = (obj:GetPivot().Position - rootPos).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestPallet = obj
                    end
                end
            end
            
            if nearestPallet then
                local nearestPalletPoint = nil
                local closestPointDistance = math.huge
                
                for _, point in pairs(nearestPallet:GetDescendants()) do
                    if point:IsA("BasePart") and point.Name == "PalletPoint" then
                        local distance = (point.Position - rootPos).Magnitude
                        if distance < closestPointDistance then
                            closestPointDistance = distance
                            nearestPalletPoint = point
                        end
                    end
                end
                
                if nearestPalletPoint then
                    for _, obj in pairs(workspace:GetChildren()) do
                        if isKillerObject(obj) and obj ~= character then
                            for _, killerPart in pairs(obj:GetDescendants()) do
                                if killerPart:IsA("BasePart") then
                                    for _, palletPart in pairs(nearestPallet:GetDescendants()) do
                                        if palletPart:IsA("BasePart") then
                                            local localPos = palletPart.CFrame:PointToObjectSpace(killerPart.Position)
                                            local partSize = palletPart.Size
                                            
                                            if math.abs(localPos.X) <= partSize.X/2 and
                                               math.abs(localPos.Y) <= partSize.Y/2 and
                                               math.abs(localPos.Z) <= partSize.Z/2 then
                                               
                                                if not AutoDropSetToggle and character:GetAttribute("IsCarried") then
                                                else
                                                    game.ReplicatedStorage.Remotes.Pallet.PalletDropEvent:FireServer(nearestPalletPoint)
                                                end
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

local desyncT = {enabled = false, loc = CFrame.new()}
local prevLookVector = nil
local isSpinning = false
local spinThreshold = 15
local desynchook = nil
local heartbeatConn, charConn = nil, nil

local function getOffsetCFrame()
    local ping = game:GetService("Players").LocalPlayer:GetNetworkPing() * 1000
    if ping < 100 then 
        return CFrame.new(0, 0, -2)
    elseif ping <= 170 then 
        return CFrame.new(0, 0, -2.7)
    else 
        return CFrame.new(0, 0, -3.7)
    end
end

local function enableHitboxDesync()
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    
    heartbeatConn = RunService.Heartbeat:Connect(function()
        if not desyncT.enabled or not LocalPlayer.Character then return end
        
        local character = LocalPlayer.Character
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local currentLook = root.CFrame.LookVector
        if prevLookVector then
            local dot = math.clamp(prevLookVector:Dot(currentLook), -1, 1)
            local angleDiff = math.deg(math.acos(dot))
            isSpinning = angleDiff > spinThreshold
        end
        prevLookVector = currentLook
        
        if isSpinning then return end 
        
        desyncT.loc = root.CFrame
        local offset = getOffsetCFrame()
        local newCFrame = desyncT.loc * offset
        root.CFrame = newCFrame
        
        root.CFrame = desyncT.loc
    end)
    
    desynchook = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if desyncT.enabled and not checkcaller() and 
           key == "CFrame" and 
           LocalPlayer.Character and 
           self == LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
           not isSpinning then
            return desyncT.loc
        end
        return desynchook(self, key)
    end))
    
    charConn = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        prevLookVector = nil
        isSpinning = false
    end)
end

local function disableHitboxDesync()
    desyncT.enabled = false
    if heartbeatConn then
        heartbeatConn:Disconnect()
        heartbeatConn = nil
    end
    if charConn then
        charConn:Disconnect()
        charConn = nil
    end
    if desynchook then
        desynchook = nil
    end
    prevLookVector = nil
    isSpinning = false
end

local DesyncHandle = TabHandles.Universal:Toggle({
    Title = "Desync",
    Desc = "Use for better hitboxes or for faking position.",
    Value = false,
    Callback = function(state)
      task.spawn(function()
        if not setfflag then
            warn("DESYNC NOT SUPPORTED IN YOUR EXECUTOR.")
            return
        end
        Desync = state
        
        if DesyncType == "Fake Position" then
            setfflag('NextGenReplicatorEnabledWrite4', tostring(state))
        elseif DesyncType == "Hitbox Improving" then
            desyncT.enabled = state
            
            if state then
                enableHitboxDesync()
            else
                Window:Close()
                task.wait(0.1)
                disableHitboxDesync()
            end
        end
      end)
    end
})

local DesyncTypeHandle = TabHandles.Universal:Dropdown({
       Title =  "Desync Type",
       Values = { "Hitbox Improving", "Fake Position" },
       Value = "Hitbox Improving",
       Multi = false,
       AllowNone = false,
       Callback = function(option)
             DesyncType = option
       end
})
local AutoEventHandle = TabHandles.Universal:Toggle({
       Title =  "Auto Farm Event",
       Desc = "Farms existing event, current event: 🎄",
       Value = false,
       Callback = function(state)
             AutoEventToggle = state
             if state then
                 autofarmcurrency()
             end
       end
})

local KillerSection = TabHandles.Killer:Section({ 
    Title = "Combat",
    Icon = "axe"
})
local InfThingsHandle
InfThingsHandle = KillerSection:Toggle({
    Title = "Infinite Abilities " .. (getTag(lp.Name) == "[ FREEMIUM ]" and "(PREMIUM)" or ""),
    Desc = "Includes no attack cooldown. Supported killers for inf abillities: Slasher, Masked, Jeff, Stalker.",
    Value = false,
    Callback = function(state)
        if state then
            local isPremium = false
            for _, name in ipairs(premium_users) do
                if lp.Name == name then
                    isPremium = true
                    break
                end
            end

            if isPremium then
                InfThingsToggle = true
            else
                InfThingsToggle = false
                WindUI:Notify({
                    Title = "Premium Feature",
                    Content = "This feature is only for premium users, get premium in our discord server.",
                    Icon = "info",
                    Duration = 3
                })
                if InfThingsHandle then
                    InfThingsHandle:Set(false)
                end
            end
        else
            InfThingsToggle = false
        end
    end
})
local OneTapHandle = KillerSection:Toggle({
       Title = "Damage Aura",
       Desc = "Throws cycles of hits at the location you're facing.",
       Value = false,
       Callback = function(state)
             DamageAura = state
             while DamageAura do
                 task.wait(0.01)
                 game.ReplicatedStorage.Remotes.Attacks.BasicAttack:FireServer()
             end
       end
})
local AutoAimHandle = KillerSection:Toggle({
       Title = "Auto Aim Spear (Veil)",
       Desc = "Automatically aims spear to the closest survivor.",
       Value = false,
       Callback = function(state)
             AutoAimToggle = state
             if state then 
                 createAimToggle() 
             else
                 if aimGui then
                     aimGui:Destroy()
                     aimGui = nil
                 end
                 if aimConn then
                     aimConn:Disconnect()
                     aimConn = nil
                 end
             end
       end
})
local KillerMiscSection = TabHandles.Killer:Section({ 
    Title = "Misc",
    Icon = "layout-grid"
})
local AntiFlashlightHandle = KillerMiscSection:Toggle({
       Title = "Anti Flashlight",
       Desc = "Removes flashlight brightness.",
       Value = false,
       Callback = function(state)
             AntiFlashlight = state
       end
})
local AntiSlowHandle = KillerMiscSection:Toggle({
       Title = "Anti Slow Down",
       Desc = "Removes negative walk speed effects.",
       Value = false,
       Callback = function(state)
             AntislowToggle = state
       end
})
KillerMiscSection:Button({
	Title = "Enable Emotes",
	Callback = function()
	      local pg = lp:FindFirstChild("PlayerGui")
	      if pg then
                local emotesGui = pg:FindFirstChild("Emotes")
                if emotesGui then
                   emotesGui.Enabled = true
                end
             end
	end
})

local SurvSection = TabHandles.Survivor:Section({ 
    Title = "Combat",
    Icon = "axe"
})
local GodModeHandle
GodModeHandle = SurvSection:Toggle({
    Title = "God Mode " .. (getTag(lp.Name) == "[ FREEMIUM ]" and "(PREMIUM)" or ""),
    Desc = "Prevents you from being attacked, makes you invincible.",
    Value = false,
    Callback = function(state)
        if state then
            for _, name in ipairs(premium_users) do
                if lp.Name == name then
                    GodmodeToggle = true
                    return
                end
            end

            GodmodeToggle = false
            WindUI:Notify({
                Title = "Premium Feature",
                Content = "This feature is only for premium users, get premium in our discord server.",
                Icon = "info",
                Duration = 3
            })
            if GodModeHandle then
                GodModeHandle:Set(false)
            end
        else
            GodmodeToggle = false
        end
    end
})
local ExpandHitboxesHandle = SurvSection:Toggle({
       Title = "Expand Killer Hitboxes",
       Desc = "Expands killer hitboxes, useful with flashlight.",
       Value = false,
       Callback = function(state)
             ExpandToggle = state
       end
})
local AutoShootHandle = SurvSection:Toggle({
       Title = "Auto Attack",
       Desc = "Automatically aims to target and shoots him, must have revolver/flashlight and target must be in FOV.",
       Value = false,
       Callback = function(state)
             Autoshoot = state
             if Autoshoot then
            CreateCross()
            else
            RemoveCross()
            end
       end
})
local ShootTargetHandle = SurvSection:Dropdown({
       Title =  "Auto Attack Target",
       Values = { "Killers", "Players" },
       Value = "",
       Multi = false,
       AllowNone = true,
       Callback = function(option)
             selectedTarget = option
       end
})

local SurvDefSection = TabHandles.Survivor:Section({ 
    Title = "Defense",
    Icon = "shield"
})
local AutoParryHandle = SurvDefSection:Toggle({
       Title = "Auto Parry Killer (BETA)",
       Desc = "Automatically stuns killer parrying him, must have parrying dagger as survivor.",
       Value = false,
       Callback = function(state)
             Autoparry = state
       end
})
SurvDefSection:Divider()
local AutoDropHandle = SurvDefSection:Toggle({
       Title = "Auto Drop Pallete",
       Desc = "Drops pallete right to killer, must be near.",
       Value = false,
       Callback = function(state)
             AutoDropToggle = state
             if state then autodrop() end
       end
})
local AutoDropSetHandle = SurvDefSection:Toggle({
       Title = "Pallet Works On Carry?",
       Desc = "Drops pallete even if killer is carrying you and passing after pallet.",
       Value = false,
       Callback = function(state)
             AutoDropSetToggle = state
       end
})

local SurvMiscSection = TabHandles.Survivor:Section({ 
    Title = "Misc",
    Icon = "layout-grid"
})
local AntiGFailHandle = SurvMiscSection:Toggle({
       Title = "Anti Fail Generator",
       Desc = "Failing generator skill check will not do anything.",
       Value = false,
       Callback = function(state)
             AntiGFail = state
       end
})
local AntiHFailHandle = SurvMiscSection:Toggle({
       Title = "Perfect Heal Check",
       Desc = "Perfects heal check on appearing you still have to click not to fail.",
       Value = false,
       Callback = function(state)
             AntiHFail = state
       end
})
local RemoveClothingsHandle = SurvMiscSection:Toggle({
       Title = "Remove Veil Clothings",
       Desc = "Nakes veil killer.",
       Value = false,
       Callback = function(state)
             RemoveClothingsToggle = state
       end
})
SurvMiscSection:Button({
	Title = "Instant Escape",
	Callback = function()
	       local gate = workspace.Map:FindFirstChild("Gate")
	       if gate then
	           local box = gate:FindFirstChild("Box")
	           if box and box:IsA("BasePart") then
		        local backCFrame = box.CFrame * CFrame.new(0, 0, -50)
		        root.CFrame = CFrame.new(backCFrame.Position, box.Position)
	           end
	       end
	end
})
SurvMiscSection:Button({
    Title = "Destroy Gates",
    Callback = function()
        local map = workspace:FindFirstChild("Map")
        if not map then return end

        for _, gate in ipairs(map:GetChildren()) do
            if gate.Name == "Gate" and gate:IsA("Model") then
                gate:Destroy()
            end
        end
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
local ESPDropdownHandle = TabHandles.Esp:Dropdown({
       Title =  "ESP's",
       Values = { "Killers", "Players", "Generators", "Presents" },
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
	end
})
local WsSliderHandle = TabHandles.Player:Slider({
       Title = "WalkSpeed",
	Value = { Min = 16, Max = 100, Default = 16 },
	Callback = function(Value)
		currentSpeed = Value
	end
})

local antiAfkToggle = false
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

task.spawn(function()
	while task.wait(60) do
		if antiAfkToggle then
			root.CFrame = root.CFrame + Vector3.new(0, 3, 0)
		end
	end
end)

local HitSoundHandle = TabHandles.Misc:Input({
    Title = "Hit Sound",
    Type = "Input",
    Placeholder = "rbxassetid://",
    Callback = function(input) 
    end
})

local chaseThemeHandle = TabHandles.Misc:Dropdown({
       Title = "Chase Theme",
       Values = { "Mila - Compass", "Close To Me" },
       Value = "",
       AllowNone = true,
       Callback = function(option)
       chasetheme = option
       end
})

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

task.spawn(function()
    while task.wait(0.1) do
        if GodmodeToggle then
           hum.Health = 100
           character:SetAttribute("IsCarried", false);
           character:SetAttribute("IsHooked", false);
        end
        if FlingToggle then
            fling()
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
            configFile:Register("AutoEventHandle", AutoEventHandle)
            configFile:Register("ExpandHitboxesHandle", ExpandHitboxesHandle)
            configFile:Register("DesyncHandle", DesyncHandle)
            configFile:Register("DesyncTypeHandle", DesyncTypeHandle)
            configFile:Register("AutoDropHandle", AutoDropHandle)
            configFile:Register("AutoDropSetHandle", AutoDropSetHandle)
            configFile:Register("InfThingsHandle", InfThingsHandle)
            configFile:Register("OneTapHandle", OneTapHandle)
            configFile:Register("AntiSlowHandle", AntiSlowHandle)
            configFile:Register("GodModeHandle", GodModeHandle)
            configFile:Register("AntiGFailHandle", AntiGFailHandle)
            configFile:Register("AntiHFailHandle", AntiHFailHandle)
            configFile:Register("AutoParryHandle", AutoParryHandle)
            configFile:Register("AutoShootHandle", AutoShootHandle)
            configFile:Register("ShootTargetHandle", ShootTargetHandle)
            configFile:Register("AntiFlashlightHandle", AntiFlashlightHandle)
            configFile:Register("ESPDropdownHandle", ESPDropdownHandle)
            configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
            configFile:Register("ESPTracersHandle", ESPTracersHandle)
            configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
            configFile:Register("ESPStudsHandle", ESPStudsHandle)
            configFile:Register("NoclipHandle", NoclipHandle)
            configFile:Register("WsToggleHandle", WsToggleHandle)
            configFile:Register("WsSliderHandle", WsSliderHandle)
            configFile:Register("antiAfkHandle", antiAfkHandle)
            configFile:Register("antiFlingHandle", antiFlingHandle)
            configFile:Register("FlingHandle", FlingHandle)
            configFile:Register("antiAdminHandle", antiAdminHandle)
        end
    end
})

local ConfigManager = Window.ConfigManager
local configFile
local autoLoadFile = "AZUREHUB_ALC_VD.txt"
local ALC = false

if ConfigManager then
    ConfigManager:Init(Window)
    
    configFile = ConfigManager:CreateConfig(configName)
    configFile:Register("AutoEventHandle", AutoEventHandle)
    configFile:Register("ExpandHitboxesHandle", ExpandHitboxesHandle)
    configFile:Register("DesyncHandle", DesyncHandle)
    configFile:Register("DesyncTypeHandle", DesyncTypeHandle)
    configFile:Register("AutoDropHandle", AutoDropHandle)
    configFile:Register("AutoDropSetHandle", AutoDropSetHandle)
    configFile:Register("InfThingsHandle", InfThingsHandle)
    configFile:Register("OneTapHandle", OneTapHandle)
    configFile:Register("AntiSlowHandle", AntiSlowHandle)
    configFile:Register("GodModeHandle", GodModeHandle)
    configFile:Register("AntiGFailHandle", AntiGFailHandle)
    configFile:Register("AntiHFailHandle", AntiHFailHandle)
    configFile:Register("AutoAimHandle", AutoAimHandle)
                configFile:Register("RemoveClothingsHandle", RemoveClothingsHandle)
    configFile:Register("AutoParryHandle", AutoParryHandle)
    configFile:Register("AutoShootHandle", AutoShootHandle)
    configFile:Register("ShootTargetHandle", ShootTargetHandle)
    configFile:Register("AntiFlashlightHandle", AntiFlashlightHandle)
    configFile:Register("ESPDropdownHandle", ESPDropdownHandle)
            configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
            configFile:Register("ESPTracersHandle", ESPTracersHandle)
            configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
            configFile:Register("ESPStudsHandle", ESPStudsHandle)
    configFile:Register("NoclipHandle", NoclipHandle)
    configFile:Register("WsToggleHandle", WsToggleHandle)
    configFile:Register("WsSliderHandle", WsSliderHandle)
    configFile:Register("antiAfkHandle", antiAfkHandle)
    configFile:Register("antiFlingHandle", antiFlingHandle)
    configFile:Register("FlingHandle", FlingHandle)
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
                configFile:Register("AutoEventHandle", AutoEventHandle)
                configFile:Register("ExpandHitboxesHandle", ExpandHitboxesHandle)
                configFile:Register("DesyncHandle", DesyncHandle)
                configFile:Register("DesyncTypeHandle", DesyncTypeHandle)
                configFile:Register("AutoDropHandle", AutoDropHandle)
                configFile:Register("AutoDropSetHandle", AutoDropSetHandle)
                configFile:Register("InfThingsHandle", InfThingsHandle)
                configFile:Register("OneTapHandle", OneTapHandle)
                configFile:Register("AntiSlowHandle", AntiSlowHandle)
                configFile:Register("GodModeHandle", GodModeHandle)
                configFile:Register("AntiGFailHandle", AntiGFailHandle)
                configFile:Register("AntiHFailHandle", AntiHFailHandle)
                configFile:Register("AutoAimHandle", AutoAimHandle)
                configFile:Register("RemoveClothingsHandle", RemoveClothingsHandle)
                configFile:Register("AutoParryHandle", AutoParryHandle)
                configFile:Register("AutoShootHandle", AutoShootHandle)
                configFile:Register("ShootTargetHandle", ShootTargetHandle)
                configFile:Register("AntiFlashlightHandle", AntiFlashlightHandle)
                configFile:Register("ESPDropdownHandle", ESPDropdownHandle)
            configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
            configFile:Register("ESPTracersHandle", ESPTracersHandle)
            configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
            configFile:Register("ESPStudsHandle", ESPStudsHandle)
                configFile:Register("NoclipHandle", NoclipHandle)
                configFile:Register("WsToggleHandle", WsToggleHandle)
                configFile:Register("WsSliderHandle", WsSliderHandle)
                configFile:Register("antiAfkHandle", antiAfkHandle)
                configFile:Register("antiFlingHandle", antiFlingHandle)
                configFile:Register("FlingHandle", FlingHandle)
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

local uicreated = false

task.spawn(function()
	while task.wait(1) do
		local gui = lp:FindFirstChild("PlayerGui")
		if RemoveClothingsToggle then
		    for _, pl in ipairs(game.Workspace:GetChildren()) do
		        if pl:FindFirstChild("spearmanager") then
		            for _, item in ipairs(pl:GetDescendants()) do
		                if item:IsA("BasePart") and string.lower(item.Name):find("hat") then item:Destroy() end
		            end
		        end
		    end
		end

		if AntiFlashlight and gui then
			for _, obj in ipairs(gui:GetDescendants()) do
				if obj.Name == "Blind" then
					pcall(function()
					        obj:Destroy()
					end)
				end
			end
		end

		if AntislowToggle and hum then
			hum:SetAttribute("speedboost", 1)
			hum.WalkSpeed = hum.WalkSpeed + hum:GetAttribute("speedboost")
		end

		if ExpandToggle then
		    if not antiFlingToggle then antiFlingToggle = true end
			for _, model in ipairs(workspace:GetChildren()) do
				if model:IsA("Model") and model:FindFirstChild("Killerost") then
					for _, partName in ipairs({"HumanoidRootPart", "Head", "Right Arm", "Left Arm", "Torso"}) do
						local part = model:FindFirstChild(partName)
						if part and part:IsA("BasePart") then
							pcall(function()
								part.Size = Vector3.new(50, 50, 50)
								part.Transparency = 1
								part.Material = Enum.Material.Neon
								part.CanCollide = false
							end)
						end
					end
				end
			end
		end

		if InfThingsToggle and gui then
			local mob = gui:FindFirstChild("Slasher-mob") or gui:FindFirstChild("Masked-mob") or gui:FindFirstChild("Hidden-mob")
			if mob then
				local controls = mob:FindFirstChild("Controls")
				if controls then
					local powerOne = controls:FindFirstChild("move1")
					local powerTwo = controls:FindFirstChild("move2")
					local attack = controls:FindFirstChild("attack")

					if powerOne then hookButton(powerOne) end
					if powerTwo then hookButton(powerTwo) end
					if attack then hookButton(attack) end

					if not uicreated then
						task.defer(function()
							createDraggableToggle()
						end)
						uicreated = true
					end
				end
			end
		end
	end
end)

task.spawn(function()
	while task.wait(0.2) do
	       for _, obj in ipairs(SoundService:GetChildren()) do
			if obj:IsA("Sound") and obj ~= chaseSound and (chasetheme == "Mila - Compass" or chasetheme == "Close To Me") then
				if string.lower(obj.Name) == "chasemusic" then
					obj.Volume = 0
					obj.Playing = false
				end
			end
		end
	end
end)

local SkillCheckEvent = game.ReplicatedStorage.Remotes.Healing:WaitForChild("SkillCheckEvent")
local SkillCheckResultEvent = game.ReplicatedStorage.Remotes.Healing:WaitForChild("SkillCheckResultEvent")

SkillCheckEvent.OnClientEvent:Connect(function(context)
    if not AntiHFail then return end
    SkillCheckResultEvent:FireServer("success", 1, context)
end)

ReplicatedStorage.Remotes.Generator.SkillCheckEvent.OnClientEvent:Connect(function(generator, point, context)
    if not AntiGFail then return end
    ReplicatedStorage.Remotes.Generator.SkillCheckResultEvent:FireServer("success", 1, generator, point)
end)

ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Chase"):WaitForChild("ChaseMusicEvent").OnClientEvent:Connect(function(action)
       if chasetheme == "Default" or (chasetheme ~= "Mila - Compass" and chasetheme ~= "Close To Me") then return end
	local soundid = getSoundIdFromTheme()

	if action == "StartImmediate" then
		setupChaseMusic(soundid)

	elseif action == "FadeOut" then
		fadeTo(0, 10)

	elseif action == "FadeIn" then
		if chaseSound then
			fadeTo(1.2, 0)
		else
			setupChaseMusic(soundid)
		end
	end
end)

task.spawn(function()
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
end)