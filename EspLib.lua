local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()

ESP.Players = false
ESP.Boxes = false
ESP.Names = true
ESP:Toggle(true)

ESP:AddObjectListener(Workspace, { -- Object Path, For example: Workspace.ThisFolder
    Name = "", --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
    CustomName = "", -- Name you want to be displayed
    Color = Color3.fromRGB(0, 0, 0), -- Color
    IsEnabled = "whatever" -- Any name, has to be the same as the last line: ESP.TheNameYouWant
})
ESP.whatever = true
