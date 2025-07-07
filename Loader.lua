-- sneaky ass new anticheat pressure devs
if getgenv().PressureBallsLoaded then return end
getgenv().PressureBallsLoaded = true

-- Cached services
local Players = cloneref(game:GetService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local Workspace = cloneref(game:GetService("Workspace"))
local TextService = cloneref(game:GetService("TextService"))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
local ttLabel = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

local function protectUI(sGui)
	sGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	sGui.DisplayOrder = 999999999
	sGui.ResetOnSpawn = false
	sGui.IgnoreGuiInset = true

	local function hideName(inst)
		if inst then
			inst.Name = "\0"
			inst.Archivable = false
		end
	end

	if gethui then
		hideName(sGui)
		sGui.Parent = gethui()
	elseif CoreGui:FindFirstChild("RobloxGui") then
		hideName(sGui)
		sGui.Parent = CoreGui.RobloxGui
	else
		hideName(sGui)
		sGui.Parent = CoreGui
	end
end

protectUI(ScreenGui)

ttLabel.Name = "\0"
ttLabel.Parent = ScreenGui
ttLabel.BackgroundColor3 = Color3.fromRGB(4, 4, 4)
ttLabel.BackgroundTransparency = 0.14
ttLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ttLabel.Position = UDim2.new(0.5, 0, 0.05, 0)
ttLabel.Size = UDim2.new(0, 100, 0, 33)
ttLabel.Font = Enum.Font.SourceSansBold
ttLabel.Text = "God Mode (click)"
ttLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ttLabel.TextSize = 20
ttLabel.ZIndex = 9999
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ttLabel

ttLabel.Active = true
ttLabel.Draggable = true

-- Only one connection
local isConnected = false

local function removeKillables(eye)
	if eye.Parent == Workspace:FindFirstChild("deathModel") then return end
	local name = eye.Name:lower()
	if (eye:IsA("BasePart") and name == "pandemonium") or name == "monsterlocker" then
		task.defer(function()
			if eye then eye:Destroy() end
		end)
	end
end

local debounce = false
local function perform()
	if debounce then return end
	debounce = true

	local char = LocalPlayer.Character
	if not char then return end

	local oldPos = char:GetPivot()
	local foundLocker, enterFunction

	for _, v in ipairs(Workspace:GetDescendants()) do
		if v:IsA("Model") and v.Name:lower() == "locker" then
			for _, obj in ipairs(v:GetDescendants()) do
				if obj:IsA("RemoteFunction") and obj.Name:lower() == "enter" then
					enterFunction = obj
					foundLocker = v
					break
				end
			end
		end
		if enterFunction then break end
	end

	if enterFunction and foundLocker then
		for i = 1, 5 do
			char:PivotTo(foundLocker:GetPivot())
			pcall(function()
				enterFunction:InvokeServer("true")
			end)
			task.wait(0.1)
		end
	end

	char:PivotTo(oldPos)

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		pcall(function()
			humanoid.WalkSpeed = 20
		end)
	end

	local eBorder = PlayerGui:FindFirstChild("EntityBorder", true)
	if eBorder then
		eBorder:GetPropertyChangedSignal("Visible"):Connect(function()
			if eBorder.Visible then eBorder.Visible = false end
		end)
	end

	for _, obj in ipairs(Workspace:GetDescendants()) do
		removeKillables(obj)
	end

	if not isConnected then
		isConnected = true
		Workspace.DescendantAdded:Connect(removeKillables)
	end
end

-- Initialize UI just once
local function initializeUI()
	local txtlabel = ttLabel
	local textWidth = TextService:GetTextSize(txtlabel.Text, txtlabel.TextSize, txtlabel.Font, Vector2.new(math.huge, math.huge)).X
	local newSize = UDim2.new(0, textWidth + 69, 0, 33)
	txtlabel:TweenSize(newSize, "Out", "Quint", 1, true)

	txtlabel.MouseButton1Click:Connect(function()
		task.spawn(perform)
	end)
end

initializeUI()
-[[if getgenv().PressureBallsLoaded then return end

pcall(function() getgenv().PressureBallsLoaded = true end)

local function ClonedService(name)
    local Service = (game.GetService);
	local Reference = (cloneref) or function(reference) return reference end
	return Reference(Service(game, name));
end

local ScreenGui = Instance.new("ScreenGui")
local ttLabel = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local plrUI = ClonedService("Players").LocalPlayer:WaitForChild("PlayerGui")
local isRan = false
--local modulesToRestore = {}

--[[local function restoreModule(module)
    if module then
        for _, child in pairs(module:GetChildren()) do
            restoreModule(child)
        end
        modulesToRestore[#modulesToRestore + 1] = {module, module.Parent}
        module:Remove()
    end
end]]

local function protectUI(sGui)
    if sGui:IsA("ScreenGui") then
        sGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
		sGui.DisplayOrder = 999999999
		sGui.ResetOnSpawn = false
		sGui.IgnoreGuiInset = true
    end
    local cGUI = ClonedService("CoreGui")
    local lPlr = ClonedService("Players").LocalPlayer

    local function NAProtection(inst, var)
        if inst then
            if var then
                inst[var] = "\0"
                inst.Archivable = false
            else
                inst.Name = "\0"
                inst.Archivable = false
            end
        end
    end

    if gethui then
		NAProtection(sGui)
		sGui.Parent = gethui()
		return sGui
	elseif cGUI and cGUI:FindFirstChild("RobloxGui") then
		NAProtection(sGui)
		sGui.Parent = cGUI:FindFirstChild("RobloxGui")
		return sGui
	elseif cGUI then
		NAProtection(sGui)
		sGui.Parent = cGUI
		return sGui
	elseif lPlr and lPlr:FindFirstChildWhichIsA("PlayerGui") then
		NAProtection(sGui)
		sGui.Parent = lPlr:FindFirstChildWhichIsA("PlayerGui")
		sGui.ResetOnSpawn = false
		return sGui
	else
		return nil
	end
end

--[[local success, errorMsg = pcall(function()
    restoreModule(rep:FindFirstChild("PermanentEyefestation", true))
    restoreModule(rep:FindFirstChild("Searchlight", true))
    restoreModule(plrUI:FindFirstChild("LocalParasites", true))
    restoreModule(plrUI:FindFirstChild("LocalSquiddles", true))
    restoreModule(plrUI:FindFirstChild("LocalEntities", true))
end)

ClonedService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Died:Connect(function()
    task.spawn(function()
        for _, moduleInfo in pairs(modulesToRestore) do
            task.spawn(function()
                moduleInfo[1].Parent = moduleInfo[2]
            end)
        end
    end)
end)]]

protectUI(ScreenGui)
ttLabel.Name = "\0"
ttLabel.Parent = ScreenGui
ttLabel.BackgroundColor3 = Color3.fromRGB(4, 4, 4)
ttLabel.BackgroundTransparency = 1.0
ttLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ttLabel.Position = UDim2.new(0.5, 0, 0.05, 0)
ttLabel.Size = UDim2.new(0, 32, 0, 33)
ttLabel.Font = Enum.Font.SourceSansBold
ttLabel.Text = "God Mode (click)"
ttLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ttLabel.TextSize = 20.0
ttLabel.TextWrapped = true
ttLabel.ZIndex = 9999

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ttLabel

local function draggable(frame)
    frame.Active = true
    frame.Draggable = true
end

local function removeKillables(eye)
    if eye.Parent == ClonedService("Workspace"):FindFirstChild("deathModel") then return end

    local lowerName = eye.Name:lower()
    if (lowerName == "pandemonium" and eye:IsA("BasePart")) or lowerName == "monsterlocker" then
        task.defer(function()
            eye:Destroy()
        end)
    end
end

local function perform()
    local oldPivot = ClonedService("Players").LocalPlayer.Character:GetPivot()
    local enterFunction = nil

    for _, v in ipairs(ClonedService("Workspace"):GetDescendants()) do
        if v.Name:lower() == "locker" and (v:IsA("Model") or v:IsA("BasePart")) then
            local success, errorMsg = pcall(function()
                for _, rem in ipairs(v:GetDescendants()) do
                    if rem.Name:lower() == "enter" and rem:IsA("RemoteFunction") then
                        enterFunction = rem
                    end
                end
                if enterFunction then
                    for i = 1, 5 do
                        ClonedService("Players").LocalPlayer.Character:PivotTo(v:GetPivot())
                        enterFunction:InvokeServer("true")
                        task.wait(0.1)
                    end
                end
            end)

            if not success then
                warn("Error invoking Remote: " .. errorMsg)
            end
            ClonedService("Players").LocalPlayer.Character:PivotTo(oldPivot)
            if enterFunction then break end
        end
    end

    task.wait(0.5)

    local success, errorMsg = pcall(function()
        ClonedService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 20
    end)
    if not success then warn("No humanoid") end

    local eBorder = plrUI:FindFirstChild("EntityBorder", true)
    if eBorder then
        eBorder:GetPropertyChangedSignal("Visible"):Connect(function()
            if eBorder.Visible then eBorder.Visible = false end
        end)
    end

    for _, g in ipairs(ClonedService("Workspace"):GetDescendants()) do
        removeKillables(g)
    end

    if not isRan then
        isRan = true
        ClonedService("Workspace").DescendantAdded:Connect(removeKillables)
    end
end

local function initializeUI()
    local txtlabel = ttLabel
    txtlabel.Size = UDim2.new(0, 32, 0, 33)
    txtlabel.BackgroundTransparency = 0.14
    local textWidth = ClonedService("TextService"):GetTextSize(txtlabel.Text, txtlabel.TextSize, txtlabel.Font, Vector2.new(math.huge, math.huge)).X
    local newSize = UDim2.new(0, textWidth + 69, 0, 33)
    txtlabel:TweenSize(newSize, "Out", "Quint", 1, true)
    txtlabel.MouseButton1Click:Connect(function()
        spawn(perform)
    end)
    draggable(txtlabel)
end

coroutine.wrap(initializeUI)()
]]
