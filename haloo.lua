-- ============================================
-- A2 INTRO - SAFE SYNC EDITION (FIXED)
-- StarterGui > ScreenGui > LocalScript
-- ============================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local SoundService = game:GetService("SoundService")

-- ============================================
-- CONFIG
-- ============================================
local CONFIG = {
	AudioId = "rbxassetid://119705891276529",
	LogoId = "rbxassetid://113381647185328",

	BgColor = Color3.fromRGB(3, 3, 10),
	TextColor = Color3.fromRGB(255, 255, 255),
	GlowColor = Color3.fromRGB(0, 220, 255),
	
	LogoShowDuration = 2.0,
	AutoCloseDelay = 7.0,
}

-- ============================================
-- SCREEN GUI (FULLSCREEN)
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "A2SafeIntro"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- ============================================
-- BACKGROUND
-- ============================================
local bg = Instance.new("Frame")
bg.Name = "BG"
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = CONFIG.BgColor
bg.BorderSizePixel = 0
bg.ZIndex = 1
bg.Parent = gui

-- Background Stars
local starContainer = Instance.new("Frame")
starContainer.Name = "Stars"
starContainer.Size = UDim2.new(1, 0, 1, 0)
starContainer.BackgroundTransparency = 1
starContainer.ZIndex = 2
starContainer.Parent = bg

for i = 1, 30 do
	local star = Instance.new("Frame")
	star.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
	star.Position = UDim2.new(math.random(), 0, math.random(), 0)
	star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	star.BackgroundTransparency = math.random() * 0.6 + 0.2
	star.BorderSizePixel = 0
	star.Parent = starContainer
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = star
end

-- ============================================
-- AUDIO
-- ============================================
local success, introSound = pcall(function()
	local sound = Instance.new("Sound")
	sound.Name = "A2IntroAudio"
	sound.SoundId = CONFIG.AudioId
	sound.Volume = 5
	sound.Looped = false
	sound.Parent = SoundService
	return sound
end)

-- ============================================
-- LOGO
-- ============================================
local logoContainer = Instance.new("Frame")
logoContainer.Name = "LogoContainer"
logoContainer.Size = UDim2.new(1, 0, 1, 0)
logoContainer.BackgroundTransparency = 1
logoContainer.ZIndex = 10
logoContainer.Parent = bg

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 180, 0, 180)
logo.Position = UDim2.new(0.5, 0, 0.4, 0)
logo.AnchorPoint = Vector2.new(0.5, 0.5)
logo.BackgroundTransparency = 1
logo.Image = CONFIG.LogoId
logo.ImageTransparency = 1
logo.ZIndex = 10
logo.Parent = logoContainer

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0)
logoCorner.Parent = logo

local glowRing = Instance.new("Frame")
glowRing.Name = "GlowRing"
glowRing.Size = UDim2.new(0, 220, 0, 220)
glowRing.Position = UDim2.new(0.5, 0, 0.4, 0)
glowRing.AnchorPoint = Vector2.new(0.5, 0.5)
glowRing.BackgroundTransparency = 1
glowRing.BorderSizePixel = 0
glowRing.ZIndex = 9
glowRing.Parent = logoContainer

local ringCorner = Instance.new("UICorner")
ringCorner.CornerRadius = UDim.new(1, 0)
ringCorner.Parent = glowRing

local ringStroke = Instance.new("UIStroke")
ringStroke.Color = CONFIG.GlowColor
ringStroke.Thickness = 3
ringStroke.Transparency = 1
ringStroke.Parent = glowRing

-- ============================================
-- TEXT CONTAINER (WELCOME & A2)
-- ============================================
local textContainer = Instance.new("Frame")
textContainer.Name = "TextContainer"
textContainer.Size = UDim2.new(1, 0, 0, 180)
textContainer.Position = UDim2.new(0.5, 0, 0.65, 0)
textContainer.AnchorPoint = Vector2.new(0.5, 0.5)
textContainer.BackgroundTransparency = 1
textContainer.ZIndex = 10
textContainer.Visible = false
textContainer.Parent = bg

-- Baris Atas: WELCOME
local welcomeText = Instance.new("TextLabel")
welcomeText.Name = "WelcomeText"
welcomeText.Size = UDim2.new(1, 0, 0, 60)
welcomeText.Position = UDim2.new(0, 0, 0, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = ""
welcomeText.Font = Enum.Font.Arcade
welcomeText.TextSize = 56
welcomeText.TextColor3 = CONFIG.TextColor
welcomeText.TextTransparency = 1
welcomeText.ZIndex = 10
welcomeText.Parent = textContainer

local welcomeStroke = Instance.new("UIStroke")
welcomeStroke.Color = CONFIG.GlowColor
welcomeStroke.Thickness = 2
welcomeStroke.Transparency = 1
welcomeStroke.Parent = welcomeText

-- Baris Bawah: A2
local a2Text = Instance.new("TextLabel")
a2Text.Name = "A2Text"
a2Text.Size = UDim2.new(1, 0, 0, 70)
a2Text.Position = UDim2.new(0, 0, 0, 65)
a2Text.BackgroundTransparency = 1
a2Text.Text = "A2"
a2Text.Font = Enum.Font.Arcade
a2Text.TextSize = 72
a2Text.TextColor3 = CONFIG.GlowColor
a2Text.TextTransparency = 1
a2Text.ZIndex = 10
a2Text.Parent = textContainer

local a2Stroke = Instance.new("UIStroke")
a2Stroke.Color = CONFIG.TextColor
a2Stroke.Thickness = 3
a2Stroke.Transparency = 1
a2Stroke.Parent = a2Text

-- ============================================
-- ANIMATION RUNNER
-- ============================================
task.spawn(function()
	-- Fade-in logo awal
	TweenService:Create(logo, TweenInfo.new(1.0), {ImageTransparency = 0}):Play()
	TweenService:Create(logo, TweenInfo.new(1.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 180, 0, 180)}):Play()
	TweenService:Create(ringStroke, TweenInfo.new(1.0), {Transparency = 0.5}):Play()

	task.wait(CONFIG.LogoShowDuration)

	-- Hilangkan logo
	TweenService:Create(logo, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
	TweenService:Create(ringStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()

	-- Putar audio & tampilkan teks bersamaan
	if success and introSound then
		pcall(function() introSound:Play() end)
	end
	
	textContainer.Visible = true
	welcomeText.TextTransparency = 0
	welcomeStroke.Transparency = 0.2

	-- Efek Ketik "WELCOME ┃"
	local targetMsg = "WELCOME"
	for i = 1, #targetMsg do
		welcomeText.Text = string.sub(targetMsg, 1, i) .. " ┃"
		task.wait(0.1)
	end
	welcomeText.Text = targetMsg

	-- Munculkan teks "A2" di bawahnya
	TweenService:Create(a2Text, TweenInfo.new(0.5, Enum.EasingStyle.Back), {TextTransparency = 0}):Play()
	TweenService:Create(a2Stroke, TweenInfo.new(0.5), {Transparency = 0.1}):Play()

	-- Auto Close
	task.delay(CONFIG.AutoCloseDelay, function()
		TweenService:Create(bg, TweenInfo.new(1.0), {BackgroundTransparency = 1}):Play()
		for _, v in ipairs(bg:GetDescendants()) do
			if v:IsA("TextLabel") then
				TweenService:Create(v, TweenInfo.new(1.0), {TextTransparency = 1}):Play()
			elseif v:IsA("ImageLabel") then
				TweenService:Create(v, TweenInfo.new(1.0), {ImageTransparency = 1}):Play()
			elseif v:IsA("UIStroke") then
				TweenService:Create(v, TweenInfo.new(1.0), {Transparency = 1}):Play()
			end
		end
		task.wait(1.2)
		gui:Destroy()
	end)
end)

print("[A2 Intro] Loaded Successfully!")
