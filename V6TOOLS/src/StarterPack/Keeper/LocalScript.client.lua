local plr = game.Players.LocalPlayer

local tool = script.Parent
local mouse = plr:GetMouse()
repeat wait() until plr.Character
local char = plr.Character
local hr = char:WaitForChild("HumanoidRootPart")
local Humanoid = char:WaitForChild("Humanoid")
local uis = game:GetService("UserInputService")
local db = false
local debris = game:GetService("Debris")


function dive(side)
	if db == true then return end
	if script.Parent.Parent ~= char then return end
	if Humanoid.Health <= 0 or Humanoid.PlatformStand == true then return end
	if hr:FindFirstChild("BodyVelocity") then return end
	local finished = false --local to this thread so when next thread is called wont intefere
	--with the previous one
	
	--calculate force direction
	local forcecalc
	if side == 'right' then
		local rightvec = hr.CFrame.rightVector
		forcecalc = rightvec * 1700
		hr.CFrame = hr.CFrame * CFrame.Angles(0, 0, -math.pi/3)
	elseif side == 'left' then
		local rightvec = -hr.CFrame.rightVector
		forcecalc = rightvec * 1700
		hr.CFrame = hr.CFrame * CFrame.Angles(0, 0, math.pi/3)
	end
	
	--print("torso lv ", char.Torso.CFrame.lookVector)
	db = true
	Humanoid.PlatformStand = true
	Humanoid.JumpPower = 0
	local bv = Instance.new("BodyForce")
	bv.Parent = hr
	bv.Force = forcecalc
	debris:AddItem(bv, 0.35)
	
	local getting_up = uis.InputBegan:Connect(function(input, gp)
		if gp then return end
		if (input.KeyCode == Enum.KeyCode.Backspace and Humanoid.PlatformStand == true) or (input.KeyCode == Enum.KeyCode.R and Humanoid.PlatformStand == true) then
			if finished == false then
				db = true
				if hr:FindFirstChild("BodyForce") then
					hr:FindFirstChild("BodyForce"):Destroy()
				end
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				hr.Velocity = hr.Velocity * 0
				finished = true
				Humanoid.JumpPower = 50
				wait(0.5)
				db = false
			end
		end
	end)
	
	wait(2)
	if Humanoid.PlatformStand == true and finished == false then
		finished = true
		getting_up:Disconnect()
		Humanoid.JumpPower = 50
		db = false
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

end

uis.InputBegan:Connect(function(input, gp)
	if gp == true then return end
	if input.KeyCode == Enum.KeyCode.E then
		dive('right')
	elseif input.KeyCode == Enum.KeyCode.Q then
		dive('left')
	end
end)

--[[
mouse.KeyDown:connect(function(keyy)
	local key = string.lower(keyy)
	if key == 'q' then
		dive('left')
	elseif key == 'e' then
		
	end
end)
]]--


mouse.Button1Down:Connect(function()
	dive('left')
end)

mouse.Button2Down:Connect(function()
	dive('right')
end)