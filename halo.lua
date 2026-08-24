local players = game:GetService("Players")
local player = players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Buat ScreenGui utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AudioControllerGui"
screenGui.Parent = playerGui

-- 2. Buat UI Kotak (Background Frame)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 130) -- Ukuran kotak
frame.Position = UDim2.new(0.8, 0, 0.7, 0) -- Posisi di pojok kanan bawah layar
frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Warna abu-abu gelap
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Beri sudut kotak agak melengkung biar estetik (UICorner)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Judul di dalam Kotak
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🎵 Audio Controller"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- 3. Buat Tombol Play (Hijau)
local playButton = Instance.new("TextButton")
playButton.Name = "PlayButton"
playButton.Size = UDim2.new(0.85, 0, 0, 35)
playButton.Position = UDim2.new(0.075, 0, 0, 45)
playButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
playButton.Text = "▶ Play Ulang"
playButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playButton.TextSize = 14
playButton.Font = Enum.Font.GothamBold
playButton.Parent = frame

local playCorner = Instance.new("UICorner")
playCorner.CornerRadius = UDim.new(0, 8)
playCorner.Parent = playButton

-- 4. Buat Tombol Stop (Merah)
local stopButton = Instance.new("TextButton")
stopButton.Name = "StopButton"
stopButton.Size = UDim2.new(0.85, 0, 0, 35)
stopButton.Position = UDim2.new(0.075, 0, 0, 85)
stopButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
stopButton.Text = "⏹ Stop"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.TextSize = 14
stopButton.Font = Enum.Font.GothamBold
stopButton.Parent = frame

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 8)
stopCorner.Parent = stopButton

-- 5. Sistem Audio (ID Baru: 119705891276529)
local soundService = game:GetService("SoundService")
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://119705891276529"
sound.Volume = 1
sound.Parent = soundService

-- 6. Fungsi Tombol Play (Bisa dipencet berulang kali buat restart dari awal)
playButton.MouseButton1Click:Connect(function()
	if sound.IsPlaying then
		sound:Stop()
	end
	sound:Play()
	print("Audio 'adwa' diputar ulang dari awal!")
end)

-- 7. Fungsi Tombol Stop
stopButton.MouseButton1Click:Connect(function()
	if sound.IsPlaying then
		sound:Stop()
		print("Audio dihentikan!")
	end
end)
