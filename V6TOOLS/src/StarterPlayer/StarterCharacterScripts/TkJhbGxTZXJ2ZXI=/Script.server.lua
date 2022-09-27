
wait(0.7)

local grav = script.parent:FindFirstChild("BodyForce")

if grav then
	grav.Force = Vector3.new(0, 100, 0)
	c = script.Parent.Touched:Connect(function()
		c:Disconnect()
		wait(.08)
		script.Parent.Velocity = script.Parent.Velocity * 0.4
		script:Destroy()
	end)
end

