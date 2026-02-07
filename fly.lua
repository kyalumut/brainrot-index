-- Xeno & Exploit Optimized Fly Script
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

-- Eski menü varsa sil (Çakışmaması için)
if CoreGui:FindFirstChild("PenguinFly") then
    CoreGui.PenguinFly:Destroy()
end

-- UI Tasarımı
local screen = Instance.new("ScreenGui")
screen.Name = "PenguinFly"
screen.Parent = CoreGui -- PlayerGui yerine CoreGui (Daha güvenli)

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 140, 0, 45)
main.Position = UDim2.new(0.05, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true -- Menüyü ekranda sürükleyebilirsin
main.Parent = screen

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 8)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, 0, 1, 0)
btn.BackgroundTransparency = 1
btn.Text = "UÇUŞ: KAPALI"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.Parent = main

-- Uçma Ayarları
local flying = false
local speed = 60
local bv = nil

local function toggle()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    
    flying = not flying
    btn.Text = flying and "UÇUŞ: AÇIK" or "UÇUŞ: KAPALI"
    
    -- Renk Geçişi
    TweenService:Create(main, TweenInfo.new(0.3), {
        BackgroundColor3 = flying and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(20, 20, 20)
    }):Play()

    if flying then
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = root
        
        task.spawn(function()
            while flying and task.wait() do
                if bv then
                    bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                end
            end
            if bv then bv:Destroy() end
        end)
    else
        if bv then bv:Destroy() end
    end
end

btn.MouseButton1Click:Connect(toggle)
