local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local FishCast = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/FishingRod.Cast")
local FishClick = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/FishingRod.MinigameClick")
local lp = Players.LocalPlayer

local targetModels = {
    "Boatito Auratito", "Graipuss Medussi", "Squalanana", "Las Tralaleritas", "Extinct Tralalero",
    "Los Tralaleritos", "Zombie Tralala", "Tentacolo Tecnico", "Belula Beluga", "Granchiello Spiritell",
    "Crabbo Limonetta", "Los Orcalitos", "Orcalero Orcala", "Trippi Troppi Troppa Trippa", "Orcalita Orcala",
    "Tralalita Tralala", "Tralalero Tralala", "Puffaball", "Blueberrinni Octopusini", "Bananita Dolphinita", "Trippi Troppi", "Noobini Pizzanini", "Trulimero Trulicina"
}

task.spawn(function()
    while task.wait() do
        local pg = lp:FindFirstChild("PlayerGui")
        local tg = pg and pg:FindFirstChild("ToolGuis")
        local fh = tg and tg:FindFirstChild("Fishing")
        local fb = fh and fh:FindFirstChild("Fillbar")
        if fb and fb.Visible then
            FishClick:FireServer()
        else
            FishCast:FireServer(1)
        end
        
        for _, yourBase in pairs(Workspace.Plots:GetDescendants()) do
            if yourBase.Name == "YourBase" and yourBase.Enabled == true then
                local baseModel = yourBase.Parent.Parent
                if baseModel and baseModel:IsA("Model") then
                    local animalPodiums = baseModel:FindFirstChild("AnimalPodiums")
                    if animalPodiums then
                        for _, hitbox in pairs(animalPodiums:GetDescendants()) do
                            if hitbox:IsA("BasePart") and hitbox.Name == "Hitbox" and hitbox.Parent.Name == "Claim" then
                                local claim = hitbox.Parent
                                
                                for _, modelName in pairs(targetModels) do
                                    local model = baseModel:FindFirstChild(modelName)
                                    if model and model:IsA("Model") then
                                        local rootPart = model:FindFirstChild("RootPart") or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("VfxInstance")
                                        if rootPart then
                                            local distance = (hitbox.Position - rootPart.Position).Magnitude
                                            if distance < 8 then
                                                local claimRemote = ReplicatedStorage:FindFirstChild("Packages"):FindFirstChild("Net"):FindFirstChild("RE/PlotService/Sell")
                                                if claimRemote and claimRemote:IsA("RemoteEvent") then
                                                    claimRemote:FireServer(tonumber(claim.Parent.Name))
                                                    print("[DEBUG] Sold", modelName, "at claim", claim.Parent.Name, "Distance:", distance)
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
        end
    end
end)
