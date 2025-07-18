local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local plrUI = LocalPlayer:WaitForChild("PlayerGui") -- or wherever your UI lives

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

local function perform()
	local oldPivot = Character:GetPivot()
	local enterFunction

	for _, v in ipairs(Workspace:GetDescendants()) do
		if v.Name:lower() == "locker" and (v:IsA("Model") or v:IsA("BasePart")) then
			for _, rem in ipairs(v:GetDescendants()) do
				if rem:IsA("RemoteFunction") and rem.Name:lower() == "enter" then
					enterFunction = rem
					break
				end
			end

			if enterFunction then
				for i = 1, 5 do
					pcall(function()
						Character:PivotTo(v:GetPivot())
						enterFunction:InvokeServer(true) -- boolean, not string
					end)
					task.wait(0.1)
				end
				break -- don't continue looping after first locker
			end
		end
	end

	-- Restore position
	Character:PivotTo(oldPivot)

	-- Set WalkSpeed
	local success, humanoid = pcall(function()
		return Character:FindFirstChildWhichIsA("Humanoid")
	end)
	if success and humanoid then
		humanoid.WalkSpeed = 20
	else
		warn("Humanoid not found")
	end

	-- Kill annoying UI
	local eBorder = plrUI:FindFirstChild("EntityBorder", true)
	if eBorder then
		eBorder:GetPropertyChangedSignal("Visible"):Connect(function()
			if eBorder.Visible then eBorder.Visible = false end
		end)
	end

	-- Destroy killables
	for _, g in ipairs(Workspace:GetDescendants()) do
		removeKillables(g)
	end

	-- Only connect once
	if not _G.KillablesHooked then
		_G.KillablesHooked = true
		Workspace.DescendantAdded:Connect(removeKillables)
	end
end

task.spawn(perform)
