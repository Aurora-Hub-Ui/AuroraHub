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
title.Text = "Aurora Hub | Version 1.0.0"
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

local buttons = {"Home", "Main", "Automatically", "Inventory", "Shop", "Teleport"}

for i, name in pairs(buttons) do
    local button = Instance.new("TextButton")
    button.Parent = sidebar
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, 5 + (i - 1) * 45)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.AutoButtonColor = true
end
