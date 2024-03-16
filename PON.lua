local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Drawing = game:GetService("Drawing")

local lines = {}

local function createTracer(player)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        local startPoint = Camera:WorldToViewportPoint(LocalPlayer.Character.HumanoidRootPart.Position)
        local endPoint = Camera:WorldToViewportPoint(humanoidRootPart.Position)

        if not lines[player] then
            lines[player] = Drawing.new("Line")
            lines[player].Color = Color3.fromRGB(255, 0, 0)
            lines[player].Transparency = 0.5
            lines[player].Thickness = 2
        end

        lines[player].Visible = true
        lines[player].From = Vector2.new(startPoint.X, startPoint.Y)
        lines[player].To = Vector2.new(endPoint.X, endPoint.Y)
    end
end

local function updateTracers()
    for player, line in pairs(lines) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            local startPoint = Camera:WorldToViewportPoint(LocalPlayer.Character.HumanoidRootPart.Position)
            local endPoint = Camera:WorldToViewportPoint(humanoidRootPart.Position)

            line.From = Vector2.new(startPoint.X, startPoint.Y)
            line.To = Vector2.new(endPoint.X, endPoint.Y)
        else
            line.Visible = false
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    updateTracers()
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        character.ChildAdded:Connect(function(child)
            if child:IsA("HumanoidRootPart") then
                createTracer(player)
            end
        end)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if lines[player] then
        lines[player]:Remove()
        lines[player] = nil
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(character)
        character.ChildAdded:Connect(function(child)
            if child:IsA("HumanoidRootPart") then
                createTracer(player)
            end
        end)
    end)
end
