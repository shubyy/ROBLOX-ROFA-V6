--[[
	Remake to work with the old legacy code so therefore is scrappy at places
	--IcedVapour
--]]
local player = game.Players.LocalPlayer
repeat wait() until player.Character
local character = player.Character
local rLeg = character:FindFirstChild("Right Leg")
local cam = workspace.CurrentCamera
local Humanoid = character:WaitForChild("Humanoid")
local hr = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local gyroconn
local uis = game:GetService("UserInputService")
local frame = script.Parent:WaitForChild("Frame")
local shiftbutton = frame:WaitForChild("Shiftlock")
local lshoot = frame:WaitForChild("LShoot")
local rshoot = frame:WaitForChild("RShoot")
local dshoot = frame:WaitForChild("DShoot")
local sprintbutton = frame:WaitForChild("Sprint")
local leftImage = 'rbxassetid://982594859'
local rightImage = 'rbxassetid://982596117'
local leftleg = true

local humanoidbool = true
local maxJump = 100

local maxstam = 70
local stamdepscale = 1
local stamina = maxstam

local jumping = false
local entered = false
local execcounter = 0

local runspeed = 31
local normspeed = 24
local normjumppower = 50

local PlayerGui = script.Parent.Parent

local held1 = false
local held2 = false
local held3 = false
local empty = false
local hum = character:WaitForChild("Humanoid")
local sprinting = false
local recharging = false
local isprinting = false
local shifton = false
local kick = hum:LoadAnimation(character:WaitForChild("soccerkick"))
local gui = player:WaitForChild("PlayerGui")

local rs = game:GetService("RunService")
local event = character:WaitForChild("BridgeEvent")

if not uis.TouchEnabled then
	script:Destroy()
else
	frame.Visible = true
end


function sprinty(a,b,c)
--	print(tostring(a)..'-'..tostring(b)..'-'..tostring(c))
	while sprinting do
		stamina = stamina - stamdepscale
		player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new( stamina/maxstam * 0.46 ,0, 0.05, 0),"In","Linear", .09,true)
		wait(.1)
		if stamina <= 0 then
		    hum.WalkSpeed = normspeed
			sprinting = false
			empty = true
		end
	end
	recharge()
end

shiftbutton.Activated:Connect(function()
	if shifton == false then
		shifton = true
		local bg = Instance.new("BodyGyro")
		bg.Name = "Diving"
		bg.Parent = character:WaitForChild("HumanoidRootPart")
		bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bg.P = 14000
		gyroconn = rs.RenderStepped:Connect(function()
			local campos = cam.CFrame.Position
			local lookvec = cam.CFrame.LookVector
			bg.CFrame = CFrame.new(campos, campos + Vector3.new(lookvec.X, 0, lookvec.Z))
		end)
	else
		gyroconn:Disconnect()
		if character:WaitForChild("HumanoidRootPart"):FindFirstChild("Diving") then
			character.HumanoidRootPart.Diving:Destroy()
		end
		shifton = false
	end
end)


lshoot.MouseButton1Down:Connect(function()
	if character:FindFirstChild("Keeper") then
		return
	end
	if held1 == true or held2 == true or held3 == true then return end
	held1 = true
	local power = 0
	held1 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1, true)
	while held1 do
		if power < 3 then
			power = power + .3
		end
		wait(.1)
	end
	held1 = false
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0,0,0.05,0),"In","Linear",0.1,true)
	local UDVector = camera.CFrame.LookVector
	
	kick:Play()
	event:FireServer('LClick',UDVector,rLeg,power,character)
	wait(0.1)
end)

rshoot.MouseButton1Down:Connect(function()
	if character:FindFirstChild("Keeper") then
		return
	end
	if held2 == true or held2 == true or held3 == true then return end
	local power = 0
	held2 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1, true)
	while held2 do
		if power < 3 then
			power = power + .3
		end
		wait(.1)
	end
	held2 = false
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0,0,0.05,0),"In","Linear",0.1,true)
	local UDVector = camera.CFrame.LookVector
	
	kick:Play()
	event:FireServer('RClick',UDVector,rLeg,power,character)
	wait(0.1)
end)

dshoot.MouseButton1Down:Connect(function()
	if character:FindFirstChild("Keeper") then
		return
	end
	if held1 == true or held2 == true or held3 == true then return end
	held3 = true
	local power = 0
	held3 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1, true)
	while held3 do
		if power < 3 then
			power = power + .3
		end
		wait(.1)
	end
	held3 = false
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0,0,0.05,0),"In","Linear",0.1,true)
	local UDVector = camera.CFrame.LookVector

	
	kick:Play()
	event:FireServer('DrivenShot',UDVector,rLeg,power,character)
	wait(0.1)
end)


lshoot.MouseButton1Up:Connect(function()
	held1 = false
end)

rshoot.MouseButton1Up:Connect(function()
	held2 = false
end)

dshoot.MouseButton1Up:Connect(function()
	held3 = false
end)


function recharge()
	if recharging == true then return end
	
	execcounter = execcounter + 1
	wait(.3)
	execcounter = execcounter - 1
	if execcounter > 0 then
		return
	end
	
	if recharging == true then return end
	recharging = true
	while stamina < maxstam do
			--gui.InfoGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		if sprinting then 
			recharging = false 
			return 
		end
		
		if stamina > 8 then
			empty = false
		end
		
		stamina = stamina + 1.5
		player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new( stamina/maxstam * 0.46 ,0, 0.05, 0),"In","Linear", .09,true)
		wait(.1)
	end
	recharging = false
	empty = false
end

function sprint(b)
	if b == false then --
		hum.WalkSpeed = normspeed
		sprinting = false
		recharge()
	else --	
		if stamina > 0 and hum.WalkSpeed ~= 0 then
			if empty == true then
				if stamina < 15 then
					return
				end
			end
			sprinting = true
			hum.WalkSpeed = runspeed
			sprinty()	
		end
	end
end

sprintbutton.Activated:Connect(function()
	if isprinting == false then
		sprintbutton.Image = 'rbxassetid://987790167'
		isprinting = true
	else
		sprintbutton.Image = 'rbxassetid://987789884'
		isprinting = false
	end
	sprint(isprinting)
end)



