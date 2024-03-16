local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local Drawing = game:GetService("Drawing")

local line = Drawing.new("Line")
line.Visible = true
line.Thickness = 2
line.Transparency = 0.5
line.Color = Color3.fromRGB(255, 0, 0)

local function createTracer(character)
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart then
		local startPoint = Camera:WorldToViewportPoint(LocalPlayer.Character.HumanoidRootPart.Position)
		local endPoint = Camera:WorldToViewportPoint(humanoidRootPart.Position)
		line.From = Vector2.new(startPoint.X, startPoint.Y)
		line.To = Vector2.new(endPoint.X, endPoint.Y)
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

RunService.RenderStepped:Connect(function()
	checkForTracers()
end)
