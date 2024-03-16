local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Drawing = game:GetService("Drawing")

local lines = {}

local function createTracer(player)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local startPoint = Camera:WorldToViewportPoint(LocalPlayer.Character.HumanoidRootPart.Position)
        local endPoint = Camera:WorldToViewportPoint(character.HumanoidRootPart.Position)

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
            local endPoint = Camera:WorldToViewportPoint(character.HumanoidRootPart.Position)
            lines[player].To = Vector2.new(endPoint.X, endPoint.Y)
            lines[player].Visible = true
        else
            lines[player].Visible = false
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        createTracer(player)
    end)
end

local function onPlayerRemoving(player)
    if lines[player] then
        lines[player]:Remove()
        lines[player] = nil
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
