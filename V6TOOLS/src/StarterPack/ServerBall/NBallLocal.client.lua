--[[
	New ServerBall script remade by IcedVapour 1/11/2018
--]]

local Tool = script.Parent
local enabled = true
local human = nil 
local shooting = false
local headDebounce = false
local kick = nil
local hstand = nil
local hjump = nil
local userInput = game:GetService("UserInputService")
local event = script.Parent:WaitForChild("BridgeEvent")
local player = game.Players.LocalPlayer
repeat wait() until player.Character
local character = player.Character
local driven_shot = false
local holdMax = 3
local edown = false
local rdown = false
local torso = character:WaitForChild("Torso")
local variables = game:GetService("ReplicatedStorage"):WaitForChild("Variables")



function driven(power)
	enabled = false	
	local UDVector = mouse.UnitRay.Direction
	
	kick:Play()
	if torso:FindFirstChild("BallWeld") then
		event:FireServer('DrivenShot',UDVector,rLeg,power,character)
	end
	
	wait(0.1)
	enabled = true
	driven_shot = false
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
end

function onMouse1ButtonDown(mouse)
	--power calculation
	local driventoggle = variables:FindFirstChild("DrivenToggle")
	if held2 and driventoggle and driventoggle.Value then
		driven_shot = true
		return
	end
	if held1 or held2 or held3 or header_down then return end
	local power = 0
	held1 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(200, 200, 0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1.5, true)
	while held1 do
		if power < 3 then
			power = power + .2
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/3)
		wait(.1)
	end
	
	--shoot
	
	held1 = false
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	if driven_shot == true then
		driven(power)
		return
	end
	
	local UDVector = mouse.UnitRay.Direction
	
	enabled = false
	kick:Play()
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	
	if torso:FindFirstChild("BallWeld") then
		event:FireServer('LClick',UDVector,rLeg,power,character)
	end
	
	wait(0.1)
	enabled = true
	driven_shot = false
end

function onMouse2ButtonDown(mouse)
	local driventoggle = variables:FindFirstChild("DrivenToggle")
	if held1 and driventoggle and driventoggle.Value then
		driven_shot = true
		return
	end
	if held1 or held2 or held3 or header_down then return end
	--power calculation
	local power = 0
	held2 = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1.5, true)
	while held2 do
		if power < 3 then
			power = power + .2
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/3)
		wait(.1)
	end
	
	--shoot
	
	held2 = false
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	if driven_shot == true then
		driven(power)
		return
	end
	
	local UDVector = mouse.UnitRay.Direction
	
	enabled = false
	kick:Play()
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	
	if torso:FindFirstChild("BallWeld") then
		event:FireServer('RClick',UDVector,rLeg,power,character)
	end
	
	wait(0.1)
	enabled = true
	driven_shot = false
end

function onScrollButtonDown(mouse)
	local super_kick_max = 5
	if held1 or held2 or header_down then return end
	--power calculation
	local power = 0
	held3 = true
	character.Humanoid.WalkSpeed = 0
	speed_enforce = character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			character.Humanoid.WalkSpeed = 0
	end)
	charge:Play()
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",5.5, true)
	while held3 do
		if power < 5.1 then
			power = power + .1
		else
			power = 5
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/5)
		wait(.1)
	end
	--shoot only if power >= 5
	if power < 5 then 
		held3 = false
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
		player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
		return
	end
	
	held3 = false
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	enabled = false
	local UDVector = mouse.UnitRay.Direction
	
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	kick:Play()
	
	if torso:FindFirstChild("BallWeld") then
		event:FireServer('MClick',UDVector,rLeg,power,character)
	end
	
	wait(0.1)
	enabled = true
end



function onHeaderDown(mouse)
	if held1 or held2 or held3 then return end
	local power = 0
	header_down = true
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.Size = UDim2.new(0,0,0.05,0)
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0.46, 0, 0.05, 0),"In","Linear",1.5, true)
	while header_down do
		if power < 3 then
			power = power + .2
		end
		--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0):lerp(Color3.fromRGB(255,0,0),power/3)
		wait(.1)
	end
	
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	--shoot
	local UDVector = mouse.UnitRay.Direction
	enabled = false
	event:FireServer('Header',UDVector,rLeg,power,character)
	
	if power > 0.7 * 2 then
		hjump:Play()
	else
		hstand:Play()		
	end
	
	if torso:FindFirstChild("BallWeld") then
		player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	end
	
	wait(0.1)
	enabled = true
end

function onButton1Up()
	if held1 then
		held1 = false
	end
end



function onButton2Up()
	if held2 then
		held2 = false
	end
end

function onButton3Up()
	if held3 then
		held3 = false
	end
	charge:Stop()
	if speed_enforce then
		speed_enforce:Disconnect()
		character.Humanoid.WalkSpeed = 21
	end
end

function onHeaderUp()
	if header_down then
		header_down = false
	end
end

function inputChanged(IO,gPE,mouse)
--	print(tostring(IO.UserInputState).." : "..tostring(IO.UserInputType))
	if IO.UserInputType == Enum.UserInputType.MouseButton1 then -- LeftClick
		if IO.UserInputState == Enum.UserInputState.Begin then
			onMouse1ButtonDown(mouse);
		else
			onButton1Up(mouse);
		end
	elseif IO.UserInputType == Enum.UserInputType.MouseButton2 then -- RightClick
		if IO.UserInputState == Enum.UserInputState.Begin then
			onMouse2ButtonDown(mouse);
		else
			onButton2Up(mouse);
		end	
	elseif IO.UserInputType == Enum.UserInputType.MouseButton3 then -- MiddleClick
		if IO.UserInputState == Enum.UserInputState.Begin then
			onScrollButtonDown(mouse);
		else
			onButton3Up(mouse);
		end
	elseif IO.KeyCode == Enum.KeyCode.Q then -- Q
		if IO.UserInputState == Enum.UserInputState.Begin then
			onHeaderDown(mouse)
		else
			onHeaderUp(mouse)
		end
	end
end

function loadTool()
	mouse = player:GetMouse()
	if mouse == nil then
		return
	end
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.05, 0),"In","Linear",0.1, true)
	--player.PlayerGui.ScreenGui.ImageLabel.PowerCharge.BackgroundColor3 = Color3.fromRGB(0,255,0)
	conn1 = userInput.InputBegan:Connect(function(I,G) inputChanged(I,G,mouse)end)
	conn2 = userInput.InputEnded:Connect(function(I,G) inputChanged(I,G,mouse)end)
	mouse.Icon = "rbxasset://textures\\GunCursor.png"
	rLeg = character:FindFirstChild("Right Leg")
	human = character:WaitForChild("Humanoid")
	kick = human:LoadAnimation(Tool.soccerkick)
	charge = human:LoadAnimation(Tool.chargekick)
	hstand = human:LoadAnimation(Tool.headerstand)
	hstand.Priority = Enum.AnimationPriority.Action
	hjump = human:LoadAnimation(Tool.headerjump)
	hjump.Priority = Enum.AnimationPriority.Action	
end


--[[
function onTouched(part)
	if human then
	human.WalkSpeed = 16
	end
	if shooting then
		local pos = Tool.Handle.Position
		Tool.Parent = game.Workspace
		Tool.Handle.Position = pos
		return
	end
end]]--

function unloadTool()
	held1 = false
	held2 = false
	held3 = false
	header_down = false
	conn1:Disconnect()
	conn2:Disconnect()
	mouse.Icon = "rbxasset://textures\\advancedMove.png"
	player.PlayerGui.ScreenGui.ImageLabel.PowerCharge:TweenSize(UDim2.new(0, 0,0.08, 0),"In","Linear",0.1, true)	
end

--Tool.Handle.Touched:connect(onTouched)
Tool.Equipped:connect(loadTool)
Tool.Unequipped:connect(unloadTool)
--Tool.Unequipped:connect(onUnequippedLocal)