-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- Create Top Bar
local topBar = Instance.new("Frame")
topBar.Parent = mainFrame
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

-- Title
local title = Instance.new("TextLabel")
title.Parent = topBar
title.Text = "Aurora Hub | Version 1.0.1"
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Parent = topBar
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Parent = mainFrame
sidebar.Size = UDim2.new(0, 150, 1, -30)
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Main Page
local mainPage = Instance.new("Frame")
mainPage.Parent = mainFrame
mainPage.Size = UDim2.new(1, -150, 1, -30)
mainPage.Position = UDim2.new(0, 150, 0, 30)
mainPage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Troll Page
local trollPage = Instance.new("Frame")
trollPage.Parent = mainFrame
trollPage.Size = UDim2.new(1, -150, 1, -30)
trollPage.Position = UDim2.new(0, 150, 0, 30)
trollPage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
trollPage.Visible = false

-- Sidebar Buttons
local buttons = {
    {Name = "Home", Page = mainPage},
    {Name = "Troll", Page = trollPage}
}

for i, info in pairs(buttons) do
    local button = Instance.new("TextButton")
    button.Parent = sidebar
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, 5 + (i - 1) * 45)
    button.Text = info.Name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.AutoButtonColor = true

    button.MouseButton1Click:Connect(function()
        mainPage.Visible = false
        trollPage.Visible = false
        info.Page.Visible = true
    end)
end

-- Player Dropdown Menu
local dropdown = Instance.new("TextButton")
dropdown.Parent = trollPage
dropdown.Size = UDim2.new(0, 200, 0, 40)
dropdown.Position = UDim2.new(0, 20, 0, 20)
dropdown.Text = "Select Player"
dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dropdown.Font = Enum.Font.GothamBold
dropdown.TextSize = 14

local dropdownMenu = Instance.new("Frame")
dropdownMenu.Parent = dropdown
dropdownMenu.Size = UDim2.new(1, 0, 0, 100)
dropdownMenu.Position = UDim2.new(0, 0, 1, 5)
dropdownMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
dropdownMenu.Visible = false

dropdown.MouseButton1Click:Connect(function()
    dropdownMenu.Visible = not dropdownMenu.Visible
end)

local selectedPlayer = nil

local function updateDropdown()
    for _, v in pairs(dropdownMenu:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local playerButton = Instance.new("TextButton")
            playerButton.Parent = dropdownMenu
            playerButton.Size = UDim2.new(1, 0, 0, 20)
            playerButton.Text = player.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            playerButton.Font = Enum.Font.GothamBold
            playerButton.TextSize = 12
            
            playerButton.MouseButton1Click:Connect(function()
                selectedPlayer = player
                dropdown.Text = "Selected: " .. player.Name
                dropdownMenu.Visible = false
            end)
        end
    end
end

game.Players.PlayerAdded:Connect(updateDropdown)
game.Players.PlayerRemoving:Connect(updateDropdown)
updateDropdown()

-- Freeze Button
local freezeButton = Instance.new("TextButton")
freezeButton.Parent = trollPage
freezeButton.Size = UDim2.new(0, 200, 0, 40)
freezeButton.Position = UDim2.new(0, 20, 0, 70)
freezeButton.Text = "Freeze Player"
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
freezeButton.Font = Enum.Font.GothamBold
freezeButton.TextSize = 14

local frozenPlayers = {}

freezeButton.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character then
        local humanoid = selectedPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if frozenPlayers[selectedPlayer] then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
                frozenPlayers[selectedPlayer] = nil
                freezeButton.Text = "Freeze Player"
            else
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
                frozenPlayers[selectedPlayer] = true
                freezeButton.Text = "Unfreeze Player"
            end
        end
    end
end)
