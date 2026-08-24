-- ============================================
-- A2 INTRO - MINIMALIST METEOR EDITION
-- StarterGui > ScreenGui > LocalScript
-- Simple: Logo → "WELCOME A2" + Audio → Auto Close
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
	-- Audio ID milik user
	AudioId = "rbxassetid://119705891276529",

	-- Logo
	LogoId = "rbxassetid://113381647185328",

	-- Warna
	BgColor = Color3.fromRGB(5, 5, 15),
	TextColor = Color3.fromRGB(255, 255, 255),
	GlowColor = Color3.fromRGB(0, 200, 255),
	MeteorColor1 = Color3.fromRGB(0, 150, 255),
	MeteorColor2 = Color3.fromRGB(100, 220, 255),
	MeteorColor3 = Color3.fromRGB(200, 240, 255),

	-- Timing
	LogoShowDuration = 2.0,
	TextShowDuration = 3.0,
	AutoCloseDelay = 6.0,
}

-- ============================================
-- UTILITY
-- ============================================
local function _new(class, props)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do
		inst[k] = v
	end
	return inst
end

local function _tween(obj, props, dur, style, dir, delay)
	if not obj or not obj.Parent then return nil end
	style = style or Enum.EasingStyle.Quad
	dir = dir or Enum.EasingDirection.Out
	delay = delay or 0
	local info = TweenInfo.new(dur, style, dir, 0, false, delay)
	local tw = TweenService:Create(obj, info, props)
	tw:Play()
	return tw
end

local function _rand(a, b)
	return math.random() * (b - a) + a
end

-- ============================================
-- AUDIO
-- ============================================
local introSound = _new("Sound", {
	Name = "A2IntroAudio",
	SoundId = CONFIG.AudioId,
	Volume = 5,
	Looped = false,
	Parent = SoundService,
})

-- ============================================
-- SCREEN GUI
-- ============================================
local gui = _new("ScreenGui", {
	Name = "A2MinimalIntro",
	Parent = playerGui,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 999,
})

-- ============================================
-- BACKGROUND
-- ============================================
local bg = _new("Frame", {
	Name = "BG",
	Parent = gui,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = CONFIG.BgColor,
	BorderSizePixel = 0,
	ZIndex = 1,
})

-- ============================================
-- METEOR SHOWER EFFECT
-- ============================================
local meteorContainer = _new("Frame", {
	Name = "Meteors",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 2,
})

local meteorColors = {CONFIG.MeteorColor1, CONFIG.MeteorColor2, CONFIG.MeteorColor3}

local function spawnMeteor()
	local color = meteorColors[math.random(1, #meteorColors)]
	local startX = _rand(-0.2, 1.2)
	local startY = _rand(-0.3, 0.2)
	local length = _rand(60, 200)
	local thickness = _rand(1, 3)
	local dur = _rand(0.8, 2.0)
	local angle = _rand(15, 45) -- jatuh miring

	-- Meteor head (bright dot)
	local head = _new("Frame", {
		Parent = meteorContainer,
		Size = UDim2.new(0, thickness + 2, 0, thickness + 2),
		Position = UDim2.new(startX, 0, startY, 0),
		BackgroundColor3 = CONFIG.MeteorColor3,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 2,
	})
	_new("UICorner", {Parent = head, CornerRadius = UDim.new(1, 0)})

	-- Meteor tail (line)
	local tail = _new("Frame", {
		Parent = meteorContainer,
		Size = UDim2.new(0, thickness, 0, length),
		Position = UDim2.new(startX, 0, startY, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = color,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Rotation = angle,
		ZIndex = 2,
	})

	-- Gradient tail
	_new("UIGradient", {
		Parent = tail,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, color),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 15)),
		}),
		Rotation = 90,
	})

	-- Animate fall
	local endX = startX + _rand(-0.3, 0.3)
	local endY = startY + _rand(1.0, 1.5)

	_tween(head, {
		Position = UDim2.new(endX, 0, endY, 0),
		BackgroundTransparency = 1,
	}, dur, Enum.EasingStyle.Linear)

	_tween(tail, {
		Position = UDim2.new(endX, 0, endY, 0),
		BackgroundTransparency = 1,
		Size = UDim2.new(0, thickness, 0, length * 0.5),
	}, dur, Enum.EasingStyle.Linear)

	game:GetService("Debris"):AddItem(head, dur)
	game:GetService("Debris"):AddItem(tail, dur)
end

-- Spawner meteor
local meteorSpawner
local function startMeteorShower()
	meteorSpawner = task.spawn(function()
		while meteorContainer.Parent do
			spawnMeteor()
			task.wait(_rand(0.1, 0.4))
		end
	end)
end

-- ============================================
-- LOGO
-- ============================================
local logoContainer = _new("Frame", {
	Name = "LogoContainer",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 10,
})

local logo = _new("ImageLabel", {
	Name = "Logo",
	Parent = logoContainer,
	Size = UDim2.new(0, 180, 0, 180),
	Position = UDim2.new(0.5, 0, 0.4, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	Image = CONFIG.LogoId,
	ImageTransparency = 1,
	ZIndex = 10,
})

_new("UICorner", {Parent = logo, CornerRadius = UDim.new(1, 0)})

-- Glow ring around logo
local glowRing = _new("Frame", {
	Name = "GlowRing",
	Parent = logoContainer,
	Size = UDim2.new(0, 220, 0, 220),
	Position = UDim2.new(0.5, 0, 0.4, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 9,
})
_new("UICorner", {Parent = glowRing, CornerRadius = UDim.new(1, 0)})

local ringStroke = _new("UIStroke", {
	Parent = glowRing,
	Color = CONFIG.GlowColor,
	Thickness = 3,
	Transparency = 1,
})

-- ============================================
-- WELCOME A2 TEXT
-- ============================================
local textContainer = _new("Frame", {
	Name = "TextContainer",
	Parent = bg,
	Size = UDim2.new(1, 0, 0, 100),
	Position = UDim2.new(0.5, 0, 0.65, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	ZIndex = 10,
	Visible = false,
})

-- Glow shadow
local textGlow = _new("TextLabel", {
	Parent = textContainer,
	Name = "TextGlow",
	Size = UDim2.new(1, 0, 1, 0),
	Position = UDim2.new(0, 4, 0, 4),
	BackgroundTransparency = 1,
	Text = "WELCOME A2",
	Font = Enum.Font.Arcade,
	TextSize = 72,
	TextColor3 = CONFIG.GlowColor,
	TextTransparency = 1,
	ZIndex = 9,
})

-- Main text
local mainText = _new("TextLabel", {
	Parent = textContainer,
	Name = "MainText",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Text = "WELCOME A2",
	Font = Enum.Font.Arcade,
	TextSize = 72,
	TextColor3 = CONFIG.TextColor,
	TextTransparency = 1,
	ZIndex = 10,
})

local textStroke = _new("UIStroke", {
	Parent = mainText,
	Color = CONFIG.GlowColor,
	Thickness = 3,
	Transparency = 1,
})

-- Subtitle
local subtitle = _new("TextLabel", {
	Parent = textContainer,
	Name = "Subtitle",
	Size = UDim2.new(1, 0, 0, 30),
	Position = UDim2.new(0, 0, 1, 10),
	BackgroundTransparency = 1,
	Text = "",
	Font = Enum.Font.Code,
	TextSize = 14,
	TextColor3 = CONFIG.GlowColor,
	TextTransparency = 1,
	ZIndex = 10,
})

-- ============================================
-- CLOSE FUNCTION
-- ============================================
local function closeIntro()
	_tween(bg, {BackgroundTransparency = 1}, 1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	for _, child in ipairs(bg:GetDescendants()) do
		if child:IsA("Frame") and child ~= bg then
			_tween(child, {BackgroundTransparency = 1}, 1.0)
		elseif child:IsA("TextLabel") or child:IsA("TextButton") then
			_tween(child, {TextTransparency = 1}, 1.0)
		elseif child:IsA("ImageLabel") then
			_tween(child, {ImageTransparency = 1}, 1.0)
		elseif child:IsA("UIStroke") then
			_tween(child, {Transparency = 1}, 1.0)
		end
	end

	task.delay(1.2, function()
		if gui.Parent then
			gui:Destroy()
			print("[A2 Intro] Selesai.")
		end
	end)
end

-- ============================================
-- MAIN ANIMATION
-- ============================================
local function playIntro()
	-- Reset
	logo.ImageTransparency = 1
	logo.Size = UDim2.new(0, 120, 0, 120)
	glowRing.Size = UDim2.new(0, 140, 0, 140)
	ringStroke.Transparency = 1

	textContainer.Visible = false
	mainText.Text = ""
	mainText.TextTransparency = 0
	textGlow.TextTransparency = 1
	textStroke.Transparency = 1
	subtitle.Text = ""
	subtitle.TextTransparency = 1

	-- Hapus cursor lama kalau ada
	for _, child in ipairs(textContainer:GetChildren()) do
		if child.Name == "Cursor" then
			child:Destroy()
		end
	end

	-- Start meteor shower
	startMeteorShower()

	-- PHASE 1: Logo muncul
	_tween(logo, {ImageTransparency = 0}, 1.0)
	_tween(logo, {Size = UDim2.new(0, 180, 0, 180)}, 1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

	_tween(glowRing, {Size = UDim2.new(0, 260, 0, 260)}, 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.2)
	_tween(ringStroke, {Transparency = 0.5}, 1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.3)

	task.wait(CONFIG.LogoShowDuration)

	-- PHASE 2: Logo fade out, text + audio muncul BERSAMAAN
	_tween(logo, {ImageTransparency = 1, Size = UDim2.new(0, 250, 0, 250)}, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	_tween(glowRing, {Size = UDim2.new(0, 350, 0, 350)}, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	_tween(ringStroke, {Transparency = 1}, 0.6)

	-- Play audio BERSAMAAN dengan text muncul
	pcall(function() introSound:Play() end)

	textContainer.Visible = true

	-- TYPEWRITER "WELCOME A2" + cursor
	local fullText = "WELCOME A2"
	local cursor = _new("TextLabel", {
		Parent = textContainer,
		Name = "Cursor",
		Size = UDim2.new(0, 20, 0, 72),
		Position = UDim2.new(0.5, 0, 0, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Text = "|",
		Font = Enum.Font.Code,
		TextSize = 72,
		TextColor3 = CONFIG.GlowColor,
		TextTransparency = 1,
		ZIndex = 11,
	})

	-- Glow & stroke muncul dulu (transparan)
	_tween(textGlow, {TextTransparency = 0.5}, 0.3)
	_tween(textStroke, {Transparency = 0.1}, 0.3)

	-- Typewriter effect
	for i = 1, #fullText do
		if not mainText.Parent then break end
		mainText.Text = string.sub(fullText, 1, i)
		mainText.TextTransparency = 0

		-- Update cursor position
		local textWidth = mainText.TextBounds.X
		cursor.Position = UDim2.new(0.5, -400 + textWidth + 10, 0.5, 0)
		cursor.TextTransparency = 0

		task.wait(0.12)
	end

	-- Cursor blink setelah selesai ngetik
	task.spawn(function()
		while cursor.Parent do
			_tween(cursor, {TextTransparency = 1}, 0.3)
			task.wait(0.3)
			if not cursor.Parent then break end
			_tween(cursor, {TextTransparency = 0}, 0.3)
			task.wait(0.3)
		end
	end)

	-- Typewriter subtitle
	task.delay(0.5, function()
		local msg = "Experience Loading..."
		for i = 1, #msg do
			if not subtitle.Parent then break end
			subtitle.Text = string.sub(msg, 1, i)
			_tween(subtitle, {TextTransparency = 0}, 0.05)
			task.wait(0.05)
		end
	end)

	-- Glow breathing
	task.delay(2.0, function()
		while mainText.Parent and mainText.TextTransparency < 0.5 do
			_tween(textGlow, {TextTransparency = 0.2}, 1.5)
			_tween(textStroke, {Transparency = 0}, 1.5)
			task.wait(1.5)
			if not mainText.Parent then break end
			_tween(textGlow, {TextTransparency = 0.6}, 1.5)
			_tween(textStroke, {Transparency = 0.2}, 1.5)
			task.wait(1.5)
		end
	end)

	-- Auto close
	task.delay(CONFIG.AutoCloseDelay, function()
		if gui.Parent then closeIntro() end
	end)
end

-- ============================================
-- START
-- ============================================
playIntro()

print("[A2 Intro] Minimalist Meteor Edition Loaded!")
print("[A2 Intro] Audio ID: " .. CONFIG.AudioId)
