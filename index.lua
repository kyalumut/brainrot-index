-- Halloween Brainrot GUI Script
-- Manuel indeks takip scripti (hile değildir)

local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Halloween Index Brainrot Listesi
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

-- Manuel sahip olunanları tutan tablo
local owned = {}

-- Ekran GUI oluştur
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "BrainrotTrackerGUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0.45, 0, 0.7, 0)
mainFrame.Position = UDim2.new(0.275, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0

local uicorner = Instance.new("UICorner", mainFrame)
uicorner.CornerRadius = UDim.new(0, 12)

-- Başlık
local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0.12, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🎃 Halloween Brainrot Index"
titleLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true

-- Sayaç
local countLabel = Instance.new("TextLabel", mainFrame)
countLabel.Size = UDim2.new(1, 0, 0.08, 0)
countLabel.Position = UDim2.new(0, 0.12, 0, 0)
countLabel.BackgroundTransparency = 1
countLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
countLabel.Font = Enum.Font.Gotham
countLabel.TextScaled = true

-- Kaydırılabilir liste
local scrollFrame = Instance.new("ScrollingFrame", mainFrame)
scrollFrame.Position = UDim2.new(0, 0, 0.20, 0)
scrollFrame.Size = UDim2.new(1, 0, 0.78, 0)
scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
scrollFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0, 4)

-- Listeyi güncelleyen fonksiyon
local function updateList()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local countOwned = 0

    for _, name in ipairs(brainrotList) do
        local has = false
        for _, v in ipairs(owned) do
            if v == name then
                has = true
                break
            end
        end

        local entryButton = Instance.new("TextButton", scrollFrame)
        entryButton.Size = UDim2.new(1, -10, 0, 32)
        entryButton.BackgroundColor3 = has and Color3.fromRGB(30, 65, 30) or Color3.fromRGB(65, 30, 30)
        entryButton.TextColor3 = has and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 90, 90)
        entryButton.Font = Enum.Font.Gotham
        entryButton.TextScaled = true
        entryButton.Text = (has and "✔ " or "✘ ")..name

        entryButton.MouseButton1Click:Connect(function()
            if has then
                for i,v in ipairs(owned) do
                    if v == name then
                        table.remove(owned, i)
                        break
                    end
                end
            else
                table.insert(owned, name)
            end
            updateList()
        end)

        if has then
            countOwned = countOwned + 1
        end
    end

    countLabel.Text = "Collected: "..countOwned.." / "..#brainrotList
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
end

-- Başlangıçta listeyi göster
updateList()

