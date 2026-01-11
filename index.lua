-- 🎃 Halloween Brainrot Index
-- Tek Dosya | Sol Menü | Index + Tema | Save | Toggle

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
		Accent = Color3.fromRGB(255,140,0),
		Text = Color3.fromRGB(230,230,230),
		SubText = Color3.fromRGB(200,170,255),
		OnBg = Color3.fromRGB(30,70,45),
		OffBg = Color3.fromRGB(55,25,25),
		OnText = Color3.fromRGB(120,255,170),
		OffText = Color3.fromRGB(255,120,120),
		TitleFont = Enum.Font.GothamBlack,
		TextFont = Enum.Font.GothamBold
	},
	DARK = {
		Background = Color3.fromRGB(20,20,20),
		Accent = Color3.fromRGB(150,150,150),
		Text = Color3.fromRGB(230,230,230),
		SubText = Color3.fromRGB(180,180,180),
		OnBg = Color3.fromRGB(40,40,40),
		OffBg = Color3.fromRGB(30,30,30),
		OnText = Color3.fromRGB(200,255,200),
		OffText = Color3.fromRGB(255,200,200),
		TitleFont = Enum.Font.GothamBold,
		TextFont = Enum.Font.Gotham
	},
	NEON = {
		Background = Color3.fromRGB(10,10,20),
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

-- 🎃 BRAINROT LIST
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
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.7,0,0.75,0)
main.Position = UDim2.new(0.15,0,1.2,0)
main.BackgroundColor3 = THEME.Background
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

TweenService:Create(
	main,
	TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	{Position = UDim2.new(0.15,0,0.12,0)}
):Play()

-- 📂 SIDEBAR
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0.22,0,1,0)
sidebar.BackgroundColor3 = THEME.Sidebar
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,16)

-- 🔍 SEARCH BOX (BOZMAYAN SÜRÜM)
local searchBox = Instance.new("TextBox", sidebar)
searchBox.Size = UDim2.new(0.9,0,0,36)
searchBox.Position = UDim2.new(0.05,0,0.18,0)
searchBox.BackgroundColor3 = THEME.OffBg
searchBox.TextColor3 = THEME.Text
searchBox.PlaceholderColor3 = THEME.SubText
searchBox.PlaceholderText = "Ara..."
searchBox.ClearTextOnFocus = false
searchBox.Font = THEME.TextFont
searchBox.TextScaled = true
searchBox.BorderSizePixel = 0
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,12)



-- 📄 CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0.23,0,0,0)
content.Size = UDim2.new(0.77,0,1,0)
content.BackgroundTransparency = 1

-- TITLE
local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1,0,0.15,0)
title.BackgroundTransparency = 1
title.Text = "🎃 INDEX"
title.Font = THEME.TitleFont
title.TextScaled = true
title.TextColor3 = THEME.Accent

-- MENU BUTTONS
local indexBtn = Instance.new("TextButton", sidebar)
indexBtn.Size = UDim2.new(0.9,0,0,40)
indexBtn.Position = UDim2.new(0.05,0,0.2,0)
indexBtn.Text = "📜 Index"
indexBtn.Font = THEME.TextFont
indexBtn.TextScaled = true
indexBtn.BackgroundColor3 = THEME.OnBg
indexBtn.TextColor3 = THEME.OnText
Instance.new("UICorner", indexBtn).CornerRadius = UDim.new(0,8)

local themeBtn = Instance.new("TextButton", sidebar)
themeBtn.Size = UDim2.new(0.9,0,0,40)
themeBtn.Position = UDim2.new(0.05,0,0.3,0)
themeBtn.Text = "🎨 Tema"
themeBtn.Font = THEME.TextFont
themeBtn.TextScaled = true
themeBtn.BackgroundColor3 = THEME.OffBg
themeBtn.TextColor3 = THEME.OffText
Instance.new("UICorner", themeBtn).CornerRadius = UDim.new(0,8)

-- 📜 INDEX PAGE
local indexPage = Instance.new("Frame", content)
indexPage.Size = UDim2.new(1,0,1,0)
indexPage.BackgroundTransparency = 1

local counter = Instance.new("TextLabel", indexPage)
counter.Size = UDim2.new(1,0,0.08,0)
counter.BackgroundTransparency = 1
counter.Font = THEME.TextFont
counter.TextScaled = true
counter.TextColor3 = THEME.SubText

local scroll = Instance.new("ScrollingFrame", indexPage)
scroll.Position = UDim2.new(0,0,0.08,0)
scroll.Size = UDim2.new(1,0,0.92,0)
scroll.ScrollBarImageColor3 = THEME.Accent
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,6)

-- 🎨 THEME PAGE
local themePage = Instance.new("Frame", content)
themePage.Size = UDim2.new(1,0,1,0)
themePage.BackgroundTransparency = 1
themePage.Visible = false

local function createThemeButton(text, y)
	local b = Instance.new("TextButton", themePage)
	b.Size = UDim2.new(0.6,0,0,40)
	b.Position = UDim2.new(0.2,0,y,0)
	b.Text = text
	b.Font = THEME.TextFont
	b.TextScaled = true
	b.BackgroundColor3 = THEME.OffBg
	b.TextColor3 = THEME.Text
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local halloweenBtn = createThemeButton("🎃 Halloween", 0.25)
local darkBtn = createThemeButton("🌑 Dark", 0.38)
local neonBtn = createThemeButton("⚡ Neon", 0.51)

-- 🔄 REFRESH
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

-- 🎨 APPLY THEME
local function applyTheme(t)
	THEME = t
	main.BackgroundColor3 = THEME.Background
	sidebar.BackgroundColor3 = THEME.OffBg
	title.TextColor3 = THEME.Accent
	counter.TextColor3 = THEME.SubText
	refresh()
end

halloweenBtn.MouseButton1Click:Connect(function() applyTheme(THEMES.HALLOWEEN) end)
darkBtn.MouseButton1Click:Connect(function() applyTheme(THEMES.DARK) end)
neonBtn.MouseButton1Click:Connect(function() applyTheme(THEMES.NEON) end)

-- 🔁 MENU SWITCH
indexBtn.MouseButton1Click:Connect(function()
	indexPage.Visible = true
	themePage.Visible = false
end)

themeBtn.MouseButton1Click:Connect(function()
	indexPage.Visible = false
	themePage.Visible = true
end)

-- ⌨️ TOGGLE
UserInputService.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		main.Visible = not main.Visible
	end
end)
