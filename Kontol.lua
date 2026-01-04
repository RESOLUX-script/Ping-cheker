-- Script Ping Monitor Delta Fix - by Mimin
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")

-- 1. Hapus UI lama biar gak tumpuk
if CoreGui:FindFirstChild("MiminPingUI") then
    CoreGui.MiminPingUI:Destroy()
end

-- 2. Buat UI Baru
local sg = Instance.new("ScreenGui")
sg.Name = "MiminPingUI"
sg.Parent = CoreGui
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local label = Instance.new("TextLabel")
label.Name = "PingDisplay"
label.Parent = sg
label.Size = UDim2.new(0, 160, 0, 45)
label.Position = UDim2.new(0, 60, 0, 60) -- Posisi di layar VIVO Y16 kamu
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.BackgroundTransparency = 0.5
label.BorderSizePixel = 0
label.TextColor3 = Color3.fromRGB(255, 255, 255)

-- 3. Setting Font & Teks Awal
label.Font = Enum.Font.KomikaAxis
label.TextSize = 22
label.Text = "WAITING..." -- Biar gak tulisan "Label" lagi

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = label

-- 4. Fungsi Loop Update yang lebih kuat
spawn(function()
    while task.wait(0.5) do -- Update setiap setengah detik biar gak berat
        pcall(function()
            local pingValue = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            local ping = math.floor(pingValue)
            
            label.Text = "PING: " .. ping .. " MS"
            
            -- Logika Warna Request Miminers
            if ping <= 100 then
                label.TextColor3 = Color3.fromRGB(0, 255, 0) -- Hijau
            elseif ping <= 200 then
                label.TextColor3 = Color3.fromRGB(255, 255, 0) -- Kuning
            else
                label.TextColor3 = Color3.fromRGB(255, 0, 0) -- Merah
            end
        end)
    end
end)
