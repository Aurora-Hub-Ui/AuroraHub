local placeId = game.PlaceId

if placeId == 12411473842 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Aurora-Hub-Ui/AuroraHub/main/Pressure.lua"))()
elseif placeId == 99567941238278 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Aurora-Hub-Ui/AuroraHub/main/InkGame.lua"))()
elseif placeId == 18687417158 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Aurora-Hub-Ui/AuroraHub/main/Forsaken.lua"))()
else
    game:GetService("Players").LocalPlayer:Kick("Game not supported.")
end
