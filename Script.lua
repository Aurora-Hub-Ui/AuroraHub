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

-- Troll Page Content
local function createToggle(text, position, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = trollPage
    toggleFrame.Size = UDim2.new(0, 200, 0, 40)
    toggleFrame.Position = position
    toggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    local toggleText = Instance.new("TextLabel")
    toggleText.Parent = toggleFrame
    toggleText.Size = UDim2.new(1, -40, 1, 0)
    toggleText.Position = UDim2.new(0, 10, 0, 0)
    toggleText.Text = text
    toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleText.BackgroundTransparency = 1
    toggleText.Font = Enum.Font.GothamBold
    toggleText.TextSize = 14
    toggleText.TextXAlignment = Enum.TextXAlignment.Left

    local toggleButton = Instance.new("TextButton")
    toggleButton.Parent = toggleFrame
    toggleButton.Size = UDim2.new(0, 30, 1, 0)
    toggleButton.Position = UDim2.new(1, -30, 0, 0)
    toggleButton.Text = "->"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 14

    local toggled = false

    toggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        toggleButton.Text = toggled and "<-" or "->"
        callback(toggled)
    end)
end

-- Freeze Players Function
local function freezePlayers(enable)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = enable and 0 or 16
                    humanoid.JumpPower = enable and 0 or 50
                end
            end
        end
    end
end

-- Fling Players Function
local function flingPlayers(enable)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local character = player.Character
            if character then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    if enable then
                        root.Velocity = Vector3.new(math.random(-500, 500), math.random(500, 1000), math.random(-500, 500))
                    else
                        root.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
    end
end

-- Create Toggles for Troll Page
createToggle("Freeze Players", UDim2.new(0, 20, 0, 20), freezePlayers)
createToggle("Fling Players", UDim2.new(0, 20, 0, 70), flingPlayers)
