-- GUI Variables
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Sidebar = Instance.new("Frame")
local HomeButton = Instance.new("TextButton")
local MainButton = Instance.new("TextButton")
local AutoButton = Instance.new("TextButton")
local InventoryButton = Instance.new("TextButton")
local ShopButton = Instance.new("TextButton")
local TeleportButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- Parent to PlayerGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Bar
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Speed Hub X | Version 5.1.8"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- Sidebar
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sidebar.Size = UDim2.new(0, 120, 1, -30)
Sidebar.Position = UDim2.new(0, 0, 0, 30)

-- Buttons Function
local function createButton(name, position, parent)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, position)
    button.Font = Enum.Font.SourceSansBold
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    return button
end

-- Sidebar Buttons
HomeButton = createButton("Home", 5, Sidebar)
MainButton = createButton("Main", 40, Sidebar)
AutoButton = createButton("Automatically", 75, Sidebar)
InventoryButton = createButton("Inventory", 110, Sidebar)
ShopButton = createButton("Shop", 145, Sidebar)
TeleportButton = createButton("Teleport", 180, Sidebar)

-- Close Button
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

-- Close Button Function
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
