-- Script by Mimin
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

-- Hapus UI lama jika ada biar tidak tumpuk
if pGui:FindFirstChild("PingMonitorGui") then
    pGui.PingMonitorGui:Destroy()
end

-- 1. Membuat UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PingMonitorGui"
screenGui.IgnoreGuiInset = true -- Supaya tidak terpotong notch HP
screenGui.Parent = pGui

local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "PingLabel"
pingLabel.Size = UDim2.new(0, 180, 0, 50)
pingLabel.Position = UDim2.new(0, 20, 0, 40) -- Posisi agak kebawah biar gak kena UI bawaan
pingLabel.BackgroundColor3 = Color3.new(0, 0, 0)
pingLabel.BackgroundTransparency = 0.5
pingLabel.BorderSizePixel = 0

-- 2. Mengatur Font & Teks
pingLabel.Font = Enum.Font.KomikaAxis
pingLabel.TextSize = 25
pingLabel.TextColor3 = Color3.new(1, 1, 1)
pingLabel.Parent = screenGui

-- 3. Fungsi Update Loop
RunService.Heartbeat:Connect(function()
    -- Cara ambil ping yang lebih stabil
    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    pingLabel.Text = "PING: " .. ping .. " MS"
    
    -- Update Warna sesuai request Miminers
    if ping <= 100 then
        pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Hijau
    elseif ping <= 200 then
        pingLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Kuning
    else
        pingLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Merah
    end
end)
