-- Script Ping Monitor Real-time by Mimin
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")

-- 1. Setup UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PingMonitorCustom"
screenGui.ResetOnSpawn = false -- Agar tidak hilang saat karakter mati
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "PingLabel"
pingLabel.Size = UDim2.new(0, 160, 0, 45)
pingLabel.Position = UDim2.new(0, 15, 0, 15)
pingLabel.BackgroundTransparency = 0.6
pingLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
pingLabel.BorderSizePixel = 2
pingLabel.TextColor3 = Color3.new(1, 1, 1)

-- Menggunakan Font Komika Axis
pingLabel.Font = Enum.Font.KomikaAxis 
pingLabel.TextSize = 20
pingLabel.Parent = screenGui

-- 2. Logika Update Warna & Ping
RunService.RenderStepped:Connect(function()
    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    pingLabel.Text = "PING: " .. ping .. " MS"
    
    -- Logika Warna sesuai permintaan Miminers
    if ping <= 100 then
        pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Hijau
    elseif ping <= 200 then
        pingLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Kuning
    else
        pingLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Merah
    end
end)
