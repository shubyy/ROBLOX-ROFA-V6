local player = game.Players:GetPlayerFromCharacter(script.Parent)
player.CharacterAppearanceLoaded:connect(function(char)
	for i, child in pairs(char:GetChildren()) do
		if child:IsA("CharacterMesh") then 
			child:Destroy()
		end
	end
end)