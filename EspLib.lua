local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()

ESP.Players = false
ESP.Boxes = false
ESP.Names = true
ESP:Toggle(true)

ESP:AddObjectListener(workspace.Players.Killers, {
    Color = Color3.fromRGB(255, 0, 0),
    IsEnabled = "killerEsp",
    PrimaryPart = "HumanoidRootPart",
    CustomName = function(obj)
        return obj.Name -- shows "Jason", "Cookid", etc.
    end
})
ESP.killerEsp = true
