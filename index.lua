-- 🎃 Halloween Brainrot Index
-- Tek Dosya | Sol Menü | Index + Tema | Save | Toggle | Modern UI

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 🎨 THEMES
local THEMES = {
	HALLOWEEN = {
		Background = Color3.fromRGB(18,10,25),
		Sidebar = Color3.fromRGB(28,14,38),
		Accent = Color3.fromRGB(255,140,0),
		Text = Color3.fromRGB(235,235,235),
		SubText = Color3.fromRGB(200,170,255),
		OnBg = Color3.fromRGB(35,80,55),
		OffBg = Color3.fromRGB(60,25,25),
		OnText = Color3.fromRGB(120,255,170),
		OffText = Color3.fromRGB(255,120,120),
		TitleFont = Enum.Font.GothamBlack,
		TextFont = Enum.Font.GothamMedium
	},
	DARK = {
		Background = Color3.fromRGB(20,20,20),
		Sidebar = Color3.fromRGB(30,30,30),
		Accent = Color3.fromRGB(150,150,150),
		Text = Color3.fromRGB(230,230,230),
		SubText = Color3.fromRGB(180,180,180),
		OnBg = Color3.fromRGB(45,45,45),
		OffBg = Color3.fromRGB(35,35,35),
		OnText = Color3.fromRGB(200,255,200),
		OffText = Color3.fromRGB(255,200,200),
		TitleFont = Enum.Font.GothamBold,
		TextFont = Enum.Font.Gotham
	},
	NEON = {
		Background = Color3.fromRGB(10,10,20),
		Sidebar = Color3.fromRGB(15,15,35),
		Accent = Color3.fromRGB(0,255,255),
		Text = Color3.fromRGB(240,240,240),
		SubText = Color3.fromRGB(180,255,255),
		OnBg = Color3.fromRGB(0,90,90),
		OffBg = Color3.fromRGB(60,20,80),
		OnText = Color3.fromRGB(0,255,200),
		OffText = Color3.fromRGB(255,0,200),
		TitleFont = Enum.Font.Arcade,
		TextFont = Enum.Font.Gotham
	}
}

local THEME = THEMES.HALLOWEEN

-- 💾 SAVE
local SAVE_KEY = "BrainrotIndexSave"

-- 🎃 LIST
local brainrotList = {
	"Tartaragno","Pinealotto Fruttarino","Frogato Pirato","Mummio Rappitto",
	"Quackula","Buho de Fuego","Magi Ribbitini","Jacko Jack Jack",
	"Jacko Spaventosa","Mummy Ambalabu","Snailenzo","Cappuccino Clownino",
	"Tentacolo Tecnico","Skull Skull Skull","Jackorilla","Zombie Tralala",
	"Vulturino Skeletono","Pumpkini Spyderini","Frankentteo","Headless Horseman"
}

local owned = {}
local saved = player:GetAttribute(SAVE_KEY)
if saved then
	for n in string.gmatch(saved,"[^|]+") do owned[n]=true end
end

local function save()
	local t={}
	for k in pairs(owned) do table.insert(t,k) end
	player:SetAttribute(SAVE_KEY,table.concat(t,"|"))
end

-- 🧙 GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "HalloweenIndexGUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.74,0,0.76,0)
main.Position = UDim2.new(0.13,0,1.2,0)
main.BackgroundColor3 = THEME.Background
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,22)

TweenService:Create(main,TweenInfo.new(0.6,Enum.EasingStyle.Quint),{
	Position = UDim2.new(0.13,0,0.12,0)
}):Play()

-- 🪟 WINDOW BUTTONS (TOP RIGHT)
local controls = Instance.new("Frame", main)
controls.Size = UDim2.new(0,70,0,28)
controls.Position = UDim2.new(1,-80,0,10)
controls.BackgroundTransparency = 1
controls.ZIndex = 10

local function winBtn(text,x)
	local b = Instance.new("TextButton",controls)
	b.Size = UDim2.new(0,30,0,26)
	b.Position = UDim2.new(0,x,0,0)
	b.Text = text
	b.Font = THEME.TitleFont
	b.TextScaled = true
	b.TextColor3 = THEME.Text
	b.BackgroundColor3 = THEME.OffBg
	b.AutoButtonColor = false
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
	return b
end

local minimize = winBtn("–",0)
local close = winBtn("X",36)

minimize.MouseButton1Click:Connect(function()
	main.Visible = false
end)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- 📂 SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0.22,0,1,0)
sidebar.BackgroundColor3 = THEME.Sidebar
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,22)

local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1,0,0.16,0)
title.BackgroundTransparency = 1
title.Text = "🎃 INDEX"
title.Font = THEME.TitleFont
title.TextScaled = true
title.TextColor3 = THEME.Accent

-- 🎨 THEME MENU (EKLENDİ)
local themeHolder = Instance.new("Frame", sidebar)
themeHolder.Position = UDim2.new(0,0,0.18,0)
themeHolder.Size = UDim2.new(1,0,0.3,0)
themeHolder.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", themeHolder)
layout.Padding = UDim.new(0,8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function themeBtn(text)
	local b = Instance.new("TextButton", themeHolder)
	b.Size = UDim2.new(0.9,0,0,34)
	b.Text = text
	b.Font = THEME.TextFont
	b.TextScaled = true
	b.TextColor3 = THEME.Text
	b.BackgroundColor3 = THEME.OffBg
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
	return b
end

local btnHalloween = themeBtn("🎃 HALLOWEEN")
local btnDark = themeBtn("🌑 DARK")
local btnNeon = themeBtn("💠 NEON")

-- 🎨 APPLY THEME (EKLENDİ)
local function applyTheme(t)
	THEME = t
	main.BackgroundColor3 = t.Background
	sidebar.BackgroundColor3 = t.Sidebar
	title.TextColor3 = t.Accent

	for _,v in ipairs(gui:GetDescendants()) do
		if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
			v.TextColor3 = t.Text
			if v.Font ~= t.TitleFont then
				v.Font = t.TextFont
			end
		end
	end
end

btnHalloween.MouseButton1Click:Connect(function()
	applyTheme(THEMES.HALLOWEEN)
end)

btnDark.MouseButton1Click:Connect(function()
	applyTheme(THEMES.DARK)
end)

btnNeon.MouseButton1Click:Connect(function()
	applyTheme(THEMES.NEON)
end)

-- 📄 DEVAM EDİYOR (INDEX + SAVE + ARAMA vs senin kodların burada devam eder)
