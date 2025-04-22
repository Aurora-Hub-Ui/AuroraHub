-- Object names to ESP
local targets = {
    "FindCode",
    "FindSafe",
    "OpenSafe",
    "GetKey",
    "FindBox"
}

local function createESP(obj)
    if obj:IsA("BasePart") and not obj:FindFirstChild("ESP") then
        local esp = Instance.new("BoxHandleAdornment")
        esp.Name = "ESP"
        esp.Adornee = obj
        esp.Size = obj.Size
        esp.Color3 = Color3.fromRGB(0, 255, 0)
        esp.AlwaysOnTop = true
        esp.ZIndex = 10
        esp.Transparency = 0.5
        esp.Parent = obj
    end
end

local function scan()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if table.find(targets, obj.Name) then
            createESP(obj)
        end
    end
end

scan()

workspace.DescendantAdded:Connect(function(obj)
    if table.find(targets, obj.Name) then
        task.wait(0.2)
        createESP(obj)
    end
end)
