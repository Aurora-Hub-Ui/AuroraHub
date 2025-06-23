local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()

ESP.Players = false
ESP.Boxes = false
ESP.Names = true
ESP:Toggle(true)

ESP:AddObjectListener(Workspace.Players.Killers, {
    Name = "Jason",
    CustomName = "Jason",
    Color = Color3.fromRGB(255, 0, 0),
    IsEnabled = "killerEsp"
})

-- Cookid
ESP:AddObjectListener(Workspace.Players.Killers, {
    Name = "Coolkid",
    CustomName = "Cookid",
    Color = Color3.fromRGB(0, 255, 0),
    IsEnabled = "killerEsp"
})

-- 1x1x1x1
ESP:AddObjectListener(Workspace.Players.Killers, {
    Name = "1x1x1x1",
    CustomName = "1x1x1x1",
    Color = Color3.fromRGB(0, 0, 255),
    IsEnabled = "killerEsp"
})

-- John Doe
ESP:AddObjectListener(Workspace.Players.Killers, {
    Name = "John Doe",
    CustomName = "John Doe",
    Color = Color3.fromRGB(255, 255, 0),
    IsEnabled = "killerEsp"
})
ESP.killerEsp = true
