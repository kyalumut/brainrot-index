-- 🎃 Halloween Brainrot Index
-- Tek Dosya | Sol Menü | Index + Tema | Save | Modern UI

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

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
	for n in string.gmatch(saved,"[^|]+") do
		owned[n] = true
	end
end

local function save()
	local t = {}
	for k in pairs(owned) do table.insert(t,k) end
	player:SetAttribute(SAVE_KEY, table.concat(t,"|"))
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

-- 🪟 WINDOW BUTTONS
local controls = Instance.new("Frame", main)
controls.Size = UDim2.new(0,70,0,28)
controls.Position = UDim2.new(1,-80,0,10)
controls.BackgroundTransparency = 1

local function winBtn(text,x)
	local b = Instance.new("TextButton",controls)
	b.Size = UDim2.new(0,30,0,26)
	b.Position = UDim2.new(0,x,0,0)
	b.Text = text
	b.Font = THEME.TitleFont
	b.TextScaled = true
	b.TextColor3 = THEME.Text
	b.BackgroundColor3 = THEME.OffBg
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
	return b
end

winBtn("–",0).MouseButton1Click:Connect(function()
	main.Visible = false
end)

winBtn("X",36).MouseButton1Click:Connect(function()
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

-- 📄 CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0.23,0,0,0)
content.Size = UDim2.new(0.77,0,1,0)
content.BackgroundTransparency = 1

-- 🔍 SEARCH
local searchBox = Instance.new("TextBox", content)
searchBox.Size = UDim2.new(0.9,0,0,36)
searchBox.Position = UDim2.new(0.05,0,0.04,0)
searchBox.PlaceholderText = "Ara... (örn: Jacko)"
searchBox.Text = ""
searchBox.Font = THEME.TextFont
searchBox.TextScaled = true
searchBox.TextColor3 = THEME.Text
searchBox.PlaceholderColor3 = THEME.SubText
searchBox.BackgroundColor3 = THEME.OffBg
searchBox.ClearTextOnFocus = false
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0,12)

-- 📜 LIST
local scroll = Instance.new("ScrollingFrame", content)
scroll.Position = UDim2.new(0,0,0.13,0)
scroll.Size = UDim2.new(1,0,0.87,0)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarImageColor3 = THEME.Accent
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,6)

-- 🔄 REFRESH
local function refresh()
	for _,c in ipairs(scroll:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end

	local filter = string.lower(searchBox.Text)

	for _,name in ipairs(brainrotList) do
		if filter == "" or string.find(string.lower(name), filter) then
			local has = owned[name]

			local b = Instance.new("TextButton", scroll)
			b.Size = UDim2.new(1,-12,0,36)
			b.Text = (has and "✔ " or "✖ ") .. name
			b.Font = THEME.TextFont
			b.TextScaled = true
			b.TextColor3 = has and THEME.OnText or THEME.OffText
			b.BackgroundColor3 = has and THEME.OnBg or THEME.OffBg
			Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

			b.MouseButton1Click:Connect(function()
				if owned[name] then
					owned[name] = nil
				else
					owned[name] = true
				end
				save()
				refresh()
			end)
		end
	end

	scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(refresh)
refresh()
