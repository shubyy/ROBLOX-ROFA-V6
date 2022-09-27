local enabled = true

script.Parent.Activated:connect(function()
	if enabled then
		script.Parent.RemoteEvent:FireServer('Spawn')
		enabled = false
		wait(1)
		enabled = true
	else
		return
	end
end)

local uis = game:GetService("UserInputService")

function passOn(I,O)
	if I.KeyCode.Value == 116 then
		script.Parent.RemoteEvent:FireServer('DestroyAll')
	end
end

script.Parent.Equipped:connect(function()
	conn = uis.InputBegan:connect(passOn)	
end)

script.Parent.Unequipped:connect(function()
	conn:Disconnect()
end)
