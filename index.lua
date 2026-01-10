-- Halloween Brainrot Index
-- GUI Toggle + Tema (Kayit YOK)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Brainrot List
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

-- GUI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "BrainrotGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.45,0,0.7,0)
frame.Position = UDim2.new(0.275,0,0.15,0)
frame.BackgroundColor3 = Color3.fromRGB(18, 10, 25)
frame.BorderSizePixel = 0
frame.Visible = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.1,0)
title.BackgroundTransparency = 1
title.Text = "🎃 Halloween Brainrot Index"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 140, 0)

-- Counter
local counter = Instance.new("TextLabel", frame)
counter.Position = UDim2.new(0,0,0.1,0)
counter.Size = UDim2.new(1,0,0.07,0)
counter.BackgroundTransparency = 1
counter.Font = Enum.Font.Gotham
counter.TextScaled = true
counter.TextColor3 = Color3.fromRGB(200,200,200)

-- List
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0,0,0.17,0)
scroll.Size = UDim2.new(1,0,0.83,0)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarImageTransparency = 0.3
scroll.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,6)

-- Update
local function update()
    for _,v in ipairs(scroll:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    local count = 0

    for _,name in ipairs(brainrotList) do
        local has = table.find(owned, name)

        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1,-12,0,32)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamMedium
        btn.Text = (has and "✔ " or "✘ ") .. name

        btn.BackgroundColor3 = has
            and Color3.fromRGB(45, 90, 45)
            or Color3.fromRGB(70, 30, 70)

        btn.TextColor3 = has
            and Color3.fromRGB(0,255,120)
            or Color3.fromRGB(255,180,255)

        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

        btn.MouseButton1Click:Connect(function()
            if has then
                table.remove(owned, table.find(owned,name))
            else
                table.insert(owned, name)
            end
            update()
        end)

        if has then count += 1 end
    end

    counter.Text = "Collected: "..count.." / "..#brainrotList
    scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end

update()

-- GUI Toggle (RightShift)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
        frame.Visible = not frame.Visible
    end
end)


