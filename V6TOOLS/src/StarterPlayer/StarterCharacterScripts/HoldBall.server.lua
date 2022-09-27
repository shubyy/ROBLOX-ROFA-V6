local char = script.Parent
local torso = char:WaitForChild("Torso")
local weld1
local weld2

local function Equip()
	weld1 = Instance.new("ManualWeld")
	weld1.Name = "Weld"
	weld1.Part0 = torso
	weld1.Parent = torso
	weld1.Part1 = char:WaitForChild("Left Arm")
	weld1.C1 = CFrame.new(1.5,0,0) * CFrame.fromEulerAnglesXYZ(0,0,0)
	torso:WaitForChild("Left Shoulder").Part1 = nil
	
	weld2 = Instance.new("ManualWeld")
	weld2.Name = "Weld"
	weld2.Part0 = torso
	weld2.Parent = torso
	weld2.Part1 = char:WaitForChild("Right Arm")
	weld2.C1 = CFrame.new(-1.5,0,0) * CFrame.fromEulerAnglesXYZ(0,0,0)
	torso:WaitForChild("Right Shoulder").Part1 = nil
end

local function unEquip()
	if char:FindFirstChild("Head") then
		if char.Head:FindFirstChild("BillboardGui") then
			char.Head.BillboardGui:Destroy()
		end
	end
	weld1:Destroy()
	weld2:Destroy()
	char:WaitForChild("Torso"):WaitForChild("Left Shoulder").Part1 = char:FindFirstChild("Left Arm")
	char:WaitForChild("Torso"):WaitForChild("Right Shoulder").Part1 = char:FindFirstChild("Right Arm")
end

script.Parent:WaitForChild("Torso").ChildAdded:Connect(function(des)
	if des.Name == "BallWeld" then
		Equip()
		if game.Players:GetPlayerFromCharacter(char):FindFirstChild("Mobile") then
			script.Parent.Humanoid.AutoJumpEnabled = false
		end
	end 
end)

script.Parent:WaitForChild("Torso").ChildRemoved:Connect(function(des)
	if des.Name == "BallWeld" then
		unEquip()
		if game.Players:GetPlayerFromCharacter(char):FindFirstChild("Mobile") then
			script.Parent.Humanoid.AutoJumpEnabled = true
		end
	end
end)