local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()

-- config
ESP.Players = false
ESP.Boxes = false
ESP.Names = true
ESP:Toggle(true)

-- items
ESP:AddObjectListener(Workspace.Server.SpawnedItems, {
    Name = "OfudaBox2",
    CustomName = "Box",
    Color = Color3.fromRGB(0, 255, 255),
    IsEnabled = "ofudaEsp"
})
ESP.ofudaEsp = true
