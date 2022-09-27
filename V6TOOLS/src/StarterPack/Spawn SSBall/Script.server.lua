local ball = game.ServerStorage:WaitForChild("SSBall")

script.Parent.RemoteEvent.OnServerEvent:connect(function(plr,arg)
	if arg == "Spawn" then
		local c = ball:Clone()
		c.Parent = workspace
		c.Position = plr.Character.Head.Position	
	elseif arg == "DestroyAll" then
		for i, part in pairs(workspace:GetChildren()) do
			if part.Name == "SSBall" then
				part:Destroy()
			end
		end
		for _,each in pairs(game.Players:GetPlayers()) do
			if each.Character then
				if each.Character:FindFirstChild("Torso") then
					if each.Character.Torso:FindFirstChild("BallWeld") then
						each.Character.Torso.BallWeld.Part1:Destroy()
						each.Character.Torso.BallWeld:Destroy()
					end
				end
			end
		end
	end
end)