wait(1)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
repeat wait() until player.Character and player.Character:FindFirstChild("Humanoid")
local repstorage = game:GetService("ReplicatedStorage")
local char = player.Character

local hum = char.Humanoid
local recharging = false
--local coro = true
local gui = player:WaitForChild("PlayerGui")
local empty = false
local contextAction = game:GetService("ContextActionService")
local num = 0
local connection = nil
local humanoidbool = true
local walkSpeed = 21
local runSpeed = 32
local staminaCapacity = 40

if repstorage:FindFirstChild("CharacterRunSpeed") then
	runSpeed = repstorage.CharacterRunSpeed.Value
end

if repstorage:FindFirstChild("CharacterWalkSpeed") then
	walkSpeed = repstorage.CharacterRunSpeed.Value
end

if repstorage:FindFirstChild("StaminaCapacity") then
	staminaCapacity = repstorage.StaminaCapacity.Value
end

local stamina = staminaCapacity

function sprinty(a,b,c)
--	print(tostring(a)..'-'..tostring(b)..'-'..tostring(c))
	while sprinting do
		stamina = stamina - 1
		wait(.1)
		if stamina <= 0 then
		    hum.WalkSpeed = walkSpeed
			sprinting = false
			empty = true
			recharge()
		end
	end
end

function sprint(a,b,c)
	if b == Enum.UserInputState.End then --
		hum.WalkSpeed = walkSpeed
		sprinting = false
		player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",((staminaCapacity-stamina)/staminaCapacity) * 2,true)
		if empty then return end
		if recharging == true then return end
		recharge()
	else --	
		if stamina > 0 and hum.WalkSpeed ~= 0 then
			if empty then return end
			sprinting = true
			player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new(0 , 0, 0.05, 0),"In","Linear",stamina/staminaCapacity * 4,true)
			hum.WalkSpeed = runSpeed
			sprinty()	
		end
	end
end

contextAction:BindAction(
    'SprintButton',
    sprint,
    true,
    'f'
)

contextAction:BindAction(
    'SprintButton2',
    sprint,
    false,
    Enum.KeyCode.LeftControl
)	
local udimX = UDim.new(2,0)
local udimY = UDim.new(2,0)
contextAction:SetPosition('SprintButton',UDim2.new(udimX,udimY))


function recharge()
	player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",((staminaCapacity-stamina)/staminaCapacity) * 2,true)
	while stamina < staminaCapacity do
		if empty == true then
			--player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.new(120, 0, 0)
			if sprinting then recharging = false return end
			recharging = true
			stamina = stamina + 2
		elseif empty == false then
			--player.PlayerGui.ScreenGui.ImageLabel.StaminaCharge.BackgroundColor3 = Color3.fromRGB(120, 0, 0)	
			if sprinting then recharging = false return end
			recharging = true
			stamina = stamina + 2
		end
		wait(.1)
	end
	recharging = false
	empty = false
end

