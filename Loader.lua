local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local SliderFrame = Instance.new("Frame")
local Slider = Instance.new("TextButton")
local SpeedText = Instance.new("TextLabel")

local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- UI Setup
ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 250, 0, 120)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)

SpeedText.Parent = Frame
SpeedText.Text = "Speed: 16"
SpeedText.Size = UDim2.new(1, 0, 0.3, 0)
SpeedText.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedText.BackgroundTransparency = 1

SliderFrame.Parent = Frame
SliderFrame.Size = UDim2.new(0.8, 0, 0.15, 0)
SliderFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

Slider.Parent = SliderFrame
Slider.Size = UDim2.new(0.1, 0, 1, 0)
Slider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- Slider Dragging
local dragging = false

Slider.MouseButton1Down:Connect(function()
    dragging = true
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseX = math.clamp(input.Position.X, SliderFrame.AbsolutePosition.X, SliderFrame.AbsolutePosition.X + SliderFrame.AbsoluteSize.X - Slider.AbsoluteSize.X)
        local newPosition = UDim2.new((mouseX - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 0, 0)
        Slider.Position = newPosition
        
        local newSpeed = math.floor(16 + ((mouseX - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X) * 84) -- Speed 16 to 100
        humanoid.WalkSpeed = newSpeed
        SpeedText.Text = "Speed: " .. newSpeed
    end
end)
