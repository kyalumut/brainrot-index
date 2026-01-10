local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 🎨 THEME (1)
local THEME = {
	Background = Color3.fromRGB(18,10,25),
	Accent = Color3.fromRGB(255,140,0),
	Text = Color3.fromRGB(230,230,230),
	SubText = Color3.fromRGB(200,170,255),
	OnBg = Color3.fromRGB(30,70,45),
	OffBg = Color3.fromRGB(55,25,25),
	OnText = Color3.fromRGB(120,255,170),
	OffText = Color3.fromRGB(255,120,120),

	-- 🖋️ FONT (2)
	TitleFont = Enum.Font.GothamBlack,
	TextFont = Enum.Font.GothamBold
}

-- 💾 Save (Attribute)
local SAVE_KEY = "BrainrotIndexSave"

-- 🎃 Brainrot List
local brainrotList = {
	"Tartaragno","Pinealotto Fruttarino","Frogato Pirato","Mummio Rappitto",
	"Quackula","Buho de Fuego","Magi Ribbitini","Jacko Jack Jack",
	"Jacko Spaventosa","Mummy Ambalabu","Snailenzo","Cappuccino Clownino",
	"Tentacolo Tecnico","Skull Skull Skull","Jackorilla","Zombie Tralala",
	"Vulturino Skeletono","Pumpkini Spyderini","Frankentteo",
	"La Vacca Jacko Linterino","Trickolino","Telemorte","Pot Pumpkin",
	"Quesadillo Vampiro","Noo my Candy","Los Spooky Combanasionias",
	"Los Mobilis","La Spooky Grande","Mieteteira Bicicleteira",
	"Eviledon","Spooky and Pumpky","La Casa Boo","Headless Horseman"
}

local owned = {}

-- LOAD
local saved = player:GetAttribute(SAVE_KEY)
if saved then
	for name in string.gmatch(saved, "[^|]+") do
		owned[name] = true
	end
end

local function save()
	local t = {}
	for k,_ in pairs(owned) do table.insert(t,k) end
	player:SetAttribute(SAVE_KEY, table.concat(t,"|"))
end

-- 🧙 GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "HalloweenIndexGUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.46,0,0.72,0)
main.Position = UDim2.new(0.27,0,1.2,0)
main.BackgroundColor3 = THEME.Background
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

TweenService:Create(
	main,
	TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	{Position = UDim2.new(0.27,0,0.14,0)}
):Play()

-- 🎃 Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0.1,0)
title.BackgroundTransparency = 1
title.Text = "🎃 Halloween Brainrot Index"
title.Font = THEME.TitleFont
title.TextScaled = true
title.TextColor3 = THEME.Accent

-- 🔢 Counter
local counter = Instance.new("TextLabel", main)
counter.Position = UDim2.new(0,0,0.1,0)
counter.Size = UDim2.new(1,0,0.08,0)
counter.BackgroundTransparency = 1
counter.Font = THEME.TextFont
counter.TextScaled = true
counter.TextColor3 = THEME.SubText

-- 📜 Scroll
local scroll = Instance.new("ScrollingFrame", main)
scroll.Position = UDim2.new(0,0,0.18,0)
scroll.Size = UDim2.new(1,0,0.82,0)
scroll.ScrollBarImageColor3 = THEME.Accent
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,6)

-- 🔄 UPDATE
local function refresh()
	for _,c in ipairs(scroll:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end

	local count = 0

	for _,name in ipairs(brainrotList) do
		local has = owned[name]

		local btn = Instance.new("TextButton", scroll)
		btn.Size = UDim2.new(1,-12,0,34)
		btn.Text = (has and "✔ " or "✖ ")..name
		btn.Font = THEME.TextFont
		btn.TextScaled = true
		btn.TextColor3 = has and THEME.OnText or THEME.OffText
		btn.BackgroundColor3 = has and THEME.OnBg or THEME.OffBg
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

		btn.MouseButton1Click:Connect(function()
			if has then owned[name] = nil else owned[name] = true end
			save()
			refresh()
		end)

		if has then count += 1 end
	end

	counter.Text = "Collected: "..count.." / "..#brainrotList
	scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end

refresh()

-- ⌨️ Aç / Kapa (RightShift)
local open = true
UserInputService.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		open = not open
		main.Visible = open
	end
end)
