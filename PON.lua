local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera

local tracers = {}

local function createTracer(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local tracer = Instance.new("Part")
            tracer.Size = Vector3.new(0.1, 0.1, 1) -- Начальная длина, может быть изменена
            tracer.Anchored = true
            tracer.CanCollide = false
            tracer.Transparency = 0.5
            tracer.Color = Color3.fromRGB(255, 0, 0)
            tracer.Name = "Tracer"
            tracer.Parent = workspace

            local connection
            connection = rootPart:GetPropertyChangedSignal("Position"):Connect(function()
                if rootPart and tracer and tracer.Parent then
                    tracer.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, rootPart.Position)
                    tracer.Size = Vector3.new(0.1, 0.1, (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude)
                else
                    connection:Disconnect()
                end
            end)

            tracers[character] = tracer
        end
    end
end

local function updateTracers()
    for character, tracer in pairs(tracers) do
        if character.Parent and character:FindFirstChild("HumanoidRootPart") then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            tracer.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, rootPart.Position)
            tracer.Size = Vector3.new(0.1, 0.1, (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude)
        else
            tracer:Destroy()
            tracers[character] = nil
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        createTracer(character)
    end)
end

local function onPlayerRemoving(player)
    if tracers[player.Character] then
        tracers[player.Character]:Destroy()
        tracers[player.Character] = nil
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

game:GetService("RunService").RenderStepped:Connect(function()
    updateTracers()
end)
