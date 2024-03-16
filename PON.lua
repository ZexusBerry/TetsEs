local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera

local function createTracer(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local tracer = Instance.new("Part")
            tracer.Size = Vector3.new(0.1, 0.1, (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude)
            tracer.Anchored = true
            tracer.CanCollide = false
            tracer.Transparency = 0.5
            tracer.Color = Color3.fromRGB(255, 0, 0)
            tracer.Name = "Tracer"
            tracer.Parent = workspace
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = LocalPlayer.Character.HumanoidRootPart
            weld.Part1 = tracer
            weld.Parent = LocalPlayer.Character.HumanoidRootPart
            
            tracer.Position = (rootPart.Position + LocalPlayer.Character.HumanoidRootPart.Position) / 2
            tracer.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, rootPart.Position)
        end
    end
end

local function checkForTracers()
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character and character ~= LocalPlayer.Character then
            createTracer(character)
        end
    end
end

while true do
    checkForTracers()
    wait(0.1)
end
