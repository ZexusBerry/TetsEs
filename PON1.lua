while wait(0.1) do
	for i, childrik in ipairs(workspace:GetDescendants()) do
		if childrik:FindFirstChild("Humanoid") then
			if not childrik:FindFirstChild("EspBox") then
				if childrik ~= game.Players.LocalPlayer.Character then
					local esp = Instance.new("BoxHandleAdornment",childrik)
					esp.Adornee = childrik
					esp.ZIndex = 0
					esp.Size = Vector3.new(5, 5, 3)
					esp.Transparency = 0.25
					esp.Color3 = Color3.fromRGB(214, 9, 9)
					esp.AlwaysOnTop = true
					esp.Name = "EspBox"
				end
			end
		end
	end
end
