-- Basitleştirilmiş ve Güçlendirilmiş Versiyon
local player = game:GetService("Players").LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Eğer eski menü varsa temizle
if pgui:FindFirstChild("ModernFly") then pgui.ModernFly:Destroy() end

print("Script başlatılıyor...") -- Console'da kontrol et

-- UI Oluşturma
local sg = Instance.new("ScreenGui")
sg.Name = "ModernFly"
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999 -- En üstte görünmesi için
sg.Parent = pgui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 150, 0, 50)
frame.Position = UDim2.new(0.5, -75, 0.2, 0) -- Ekranın üst-orta kısmı
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true -- Menüyü tut sürükle
frame.Parent = sg

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, 0, 1, 0)
btn.BackgroundTransparency = 1
btn.Text = "UÇUŞ: KAPALI"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.TextSize = 18
btn.Font = Enum.Font.SourceSansBold
btn.Parent = frame

print("MENÜ OLUŞTURULDU!") -- Burayı görüyorsan buton ekrandadır

-- Uçma Mantığı
local flying = false
local speed = 50
local bv = nil

btn.MouseButton1Click:Connect(function()
    flying = not flying
    btn.Text = flying and "UÇUŞ: AÇIK" or "UÇUŞ: KAPALI"
    frame.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(40, 40, 40)
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if flying then
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = char.HumanoidRootPart
        
        task.spawn(function()
            while flying do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                task.wait()
            end
            if bv then bv:Destroy() end
        end)
    else
        if bv then bv:Destroy() end
    end
end)
