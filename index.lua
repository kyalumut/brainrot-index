local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local button = script.Parent
local frame = button.Parent
local flying = false
local speed = 80
local bv

-- Modern Renkler
local OFF_COLOR = Color3.fromRGB(40, 40, 40)
local ON_COLOR = Color3.fromRGB(0, 170, 255)

local function toggleFly()
	flying = not flying
	
	-- Yumuşak Renk Geçişi (Tween)
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint)
	local tween = TweenService:Create(frame, tweenInfo, {BackgroundColor3 = flying and ON_COLOR or OFF_COLOR})
	tween:Play()
	
	if flying then
		button.Text = "FLY: ON"
		
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = Vector3.new(0,0,0)
		bv.Parent = root
		
		task.spawn(function()
			while flying do
				local cam = workspace.CurrentCamera
				bv.Velocity = cam.CFrame.LookVector * speed
				task.wait()
			end
			if bv then bv:Destroy() end
		end)
	else
		button.Text = "FLY: OFF"
		if bv then bv:Destroy() end
	end
end

-- Butonun üzerine gelince hafif parlama efekti
button.MouseEnter:Connect(function()
	TweenService:Create(frame, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
end)

button.MouseLeave:Connect(function()
	TweenService:Create(frame, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
end)

button.MouseButton1Click:Connect(toggleFly)
