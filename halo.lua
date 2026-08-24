-- ============================================
-- A2 INTRO - EXACT TYPEWRITER & AUDIO SYNC
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
	AudioId = "rbxassetid://119705891276529",[span_0](start_span)[span_0](end_span)
	LogoId = "rbxassetid://113381647185328",[span_1](start_span)[span_1](end_span)

	BgColor = Color3.fromRGB(3, 3, 10),
	TextColor = Color3.fromRGB(255, 255, 255),[span_2](start_span)[span_2](end_span)
	GlowColor = Color3.fromRGB(0, 220, 255),
	
	LogoShowDuration = 2.0,[span_3](start_span)[span_3](end_span)
	AutoCloseDelay = 7.0,
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
	SoundId = CONFIG.AudioId,[span_4](start_span)[span_4](end_span)
	Volume = 5,[span_5](start_span)[span_5](end_span)
	Looped = false,[span_6](start_span)[span_6](end_span)
	Parent = SoundService,[span_7](start_span)[span_7](end_span)
})

-- ============================================
-- SCREEN GUI (FULLSCREEN)
-- ============================================
local gui = _new("ScreenGui", {
	Name = "A2ExactIntro",
	Parent = playerGui,[span_8](start_span)[span_8](end_span)
	ResetOnSpawn = false,[span_9](start_span)[span_9](end_span)
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,[span_10](start_span)[span_10](end_span)
	DisplayOrder = 999,[span_11](start_span)[span_11](end_span)
	IgnoreGuiInset = true,
})

-- ============================================
-- BACKGROUND (GALAXY & METEOR SHOWER)
-- ============================================
local bg = _new("Frame", {
	Name = "BG",
	Parent = gui,
	Size = UDim2.new(1, 0, 1, 0),[span_12](start_span)[span_12](end_span)
	BackgroundColor3 = CONFIG.BgColor,
	BorderSizePixel = 0,[span_13](start_span)[span_13](end_span)
	ZIndex = 1,[span_14](start_span)[span_14](end_span)
})

-- Background Stars (Bintang Berkedip)
local starContainer = _new("Frame", {
	Name = "Stars",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 2,
})

for i = 1, 40 do
	local star = _new("Frame", {
		Parent = starContainer,
		Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4)),
		Position = UDim2.new(_rand(0, 1), 0, _rand(0, 1), 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = _rand(0.2, 0.8),
		BorderSizePixel = 0,
	})
	_new("UICorner", {Parent = star, CornerRadius = UDim.new(1, 0)})
	
	task.spawn(function()
		while star.Parent do
			_tween(star, {BackgroundTransparency = _rand(0.1, 0.9)}, _rand(0.8, 2.0))
			task.wait(_rand(0.8, 2.0))
		end
	end)
end

-- Enhanced Meteor Shower
local meteorContainer = _new("Frame", {
	Name = "Meteors",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),[span_15](start_span)[span_15](end_span)
	BackgroundTransparency = 1,[span_16](start_span)[span_16](end_span)
	ZIndex = 3,
})

local meteorColors = {
	Color3.fromRGB(0, 150, 255),[span_17](start_span)[span_17](end_span)
	Color3.fromRGB(100, 220, 255),[span_18](start_span)[span_18](end_span)
	Color3.fromRGB(200, 240, 255)[span_19](start_span)[span_19](end_span)
}

local function spawnMeteor()
	local color = meteorColors[math.random(1, #meteorColors)][span_20](start_span)[span_20](end_span)
	local startX = _rand(-0.2, 1.2)[span_21](start_span)[span_21](end_span)
	local startY = _rand(-0.3, 0.2)[span_22](start_span)[span_22](end_span)
	local length = _rand(80, 250)
	local thickness = _rand(1, 4)
	local dur = _rand(0.6, 1.5)
	local angle = _rand(20, 50)[span_23](start_span)[span_23](end_span)

	local head = _new("Frame", {
		Parent = meteorContainer,
		Size = UDim2.new(0, thickness + 2, 0, thickness + 2),[span_24](start_span)[span_24](end_span)
		Position = UDim2.new(startX, 0, startY, 0),[span_25](start_span)[span_25](end_span)
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0,[span_26](start_span)[span_26](end_span)
		BorderSizePixel = 0,[span_27](start_span)[span_27](end_span)
		ZIndex = 3,
	})
	_new("UICorner", {Parent = head, CornerRadius = UDim.new(1, 0)})[span_28](start_span)[span_28](end_span)

	local tail = _new("Frame", {
		Parent = meteorContainer,
		Size = UDim2.new(0, thickness, 0, length),[span_29](start_span)[span_29](end_span)
		Position = UDim2.new(startX, 0, startY, 0),[span_30](start_span)[span_30](end_span)
		AnchorPoint = Vector2.new(0.5, 0),[span_31](start_span)[span_31](end_span)
		BackgroundColor3 = color,[span_32](start_span)[span_32](end_span)
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,[span_33](start_span)[span_33](end_span)
		Rotation = angle,[span_34](start_span)[span_34](end_span)
		ZIndex = 3,
	})

	_new("UIGradient", {
		Parent = tail,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, color),[span_35](start_span)[span_35](end_span)
			ColorSequenceKeypoint.new(1, Color3.fromRGB(3, 3, 10)),[span_36](start_span)[span_36](end_span)
		}),
		Rotation = 90,[span_37](start_span)[span_37](end_span)
	})

	local endX = startX + _rand(-0.4, 0.4)[span_38](start_span)[span_38](end_span)
	local endY = startY + _rand(1.2, 1.8)[span_39](start_span)[span_39](end_span)

	_tween(head, {Position = UDim2.new(endX, 0, endY, 0), BackgroundTransparency = 1}, dur, Enum.EasingStyle.Linear)[span_40](start_span)[span_40](end_span)
	_tween(tail, {Position = UDim2.new(endX, 0, endY, 0), BackgroundTransparency = 1, Size = UDim2.new(0, thickness, 0, length * 0.4)}, dur, Enum.EasingStyle.Linear)[span_41](start_span)[span_41](end_span)

	game:GetService("Debris"):AddItem(head, dur)[span_42](start_span)[span_42](end_span)
	game:GetService("Debris"):AddItem(tail, dur)[span_43](start_span)[span_43](end_span)
end

local function startMeteorShower()
	task.spawn(function()
		while meteorContainer.Parent do
			spawnMeteor()
			task.wait(_rand(0.05, 0.2))
		end
	end)
end

-- ============================================
-- LOGO
-- ============================================
local logoContainer = _new("Frame", {
	Name = "LogoContainer",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),[span_44](start_span)[span_44](end_span)
	BackgroundTransparency = 1,[span_45](start_span)[span_45](end_span)
	ZIndex = 10,[span_46](start_span)[span_46](end_span)
})

local logo = _new("ImageLabel", {
	Name = "Logo",
	Parent = logoContainer,
	Size = UDim2.new(0, 180, 0, 180),[span_47](start_span)[span_47](end_span)
	Position = UDim2.new(0.5, 0, 0.4, 0),[span_48](start_span)[span_48](end_span)
	AnchorPoint = Vector2.new(0.5, 0.5),[span_49](start_span)[span_49](end_span)
	BackgroundTransparency = 1,[span_50](start_span)[span_50](end_span)
	Image = CONFIG.LogoId,[span_51](start_span)[span_51](end_span)
	ImageTransparency = 1,[span_52](start_span)[span_52](end_span)
	ZIndex = 10,[span_53](start_span)[span_53](end_span)
})
_new("UICorner", {Parent = logo, CornerRadius = UDim.new(1, 0)})[span_54](start_span)[span_54](end_span)

local glowRing = _new("Frame", {
	Name = "GlowRing",
	Parent = logoContainer,
	Size = UDim2.new(0, 220, 0, 220),[span_55](start_span)[span_55](end_span)
	Position = UDim2.new(0.5, 0, 0.4, 0),[span_56](start_span)[span_56](end_span)
	AnchorPoint = Vector2.new(0.5, 0.5),[span_57](start_span)[span_57](end_span)
	BackgroundTransparency = 1,[span_58](start_span)[span_58](end_span)
	BorderSizePixel = 0,[span_59](start_span)[span_59](end_span)
	ZIndex = 9,[span_60](start_span)[span_60](end_span)
})
_new("UICorner", {Parent = glowRing, CornerRadius = UDim.new(1, 0)})[span_61](start_span)[span_61](end_span)

local ringStroke = _new("UIStroke", {
	Parent = glowRing,
	Color = CONFIG.GlowColor,[span_62](start_span)[span_62](end_span)
	Thickness = 3,[span_63](start_span)[span_63](end_span)
	Transparency = 1,[span_64](start_span)[span_64](end_span)
})

-- ============================================
-- TEXT CONTAINER (WELCOME & A2)
-- ============================================
local textContainer = _new("Frame", {
	Name = "TextContainer",
	Parent = bg,
	Size = UDim2.new(1, 0, 0, 180),
	Position = UDim2.new(0.5, 0, 0.65, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	ZIndex = 10,
	Visible = false,
})

-- 1. Baris Atas: WELCOME (Efek Ketik + Kursor ┃)
local welcomeText = _new("TextLabel", {
	Parent = textContainer,
	Name = "WelcomeText",
	Size = UDim2.new(1, 0, 0, 60),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundTransparency = 1,
	Text = "",
	Font = Enum.Font.Arcade,
	TextSize = 56,
	TextColor3 = CONFIG.TextColor,
	TextTransparency = 1,
	ZIndex = 10,
})

local welcomeStroke = _new("UIStroke", {
	Parent = welcomeText,
	Color = CONFIG.GlowColor,
	Thickness = 2,
	Transparency = 1,
})

-- 2. Baris Bawah: A2
local a2Text = _new("TextLabel", {
	Parent = textContainer,
	Name = "A2Text",
	Size = UDim2.new(1, 0, 0, 70),
	Position = UDim2.new(0, 0, 0, 65),
	BackgroundTransparency = 1,
	Text = "A2",
	Font = Enum.Font.Arcade,
	TextSize = 72,
	TextColor3 = CONFIG.GlowColor,
	TextTransparency = 1,
	ZIndex = 10,
})

local a2Stroke = _new("UIStroke", {
	Parent = a2Text,
	Color = CONFIG.TextColor,
	Thickness = 3,
	Transparency = 1,
})

-- ============================================
-- CLOSE FUNCTION
-- ============================================
local function closeIntro()
	_tween(bg, {BackgroundTransparency = 1}, 1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In)[span_65](start_span)[span_65](end_span)

	for _, child in ipairs(bg:GetDescendants()) do
		if child:IsA("Frame") and child ~= bg then
			_tween(child, {BackgroundTransparency = 1}, 1.0)[span_66](start_span)[span_66](end_span)
		elseif child:IsA("TextLabel") or child:IsA("TextButton") then
			_tween(child, {TextTransparency = 1}, 1.0)[span_67](start_span)[span_67](end_span)
		elseif child:IsA("ImageLabel") then
			_tween(child, {ImageTransparency = 1}, 1.0)[span_68](start_span)[span_68](end_span)
		elseif child:IsA("UIStroke") then
			_tween(child, {Transparency = 1}, 1.0)[span_69](start_span)[span_69](end_span)
		end
	end

	task.delay(1.2, function()
		if gui.Parent then
			gui:Destroy()[span_70](start_span)[span_70](end_span)
			print("[A2 Intro] Selesai.")[span_71](start_span)[span_71](end_span)
		end
	end)
end

-- ============================================
-- MAIN ANIMATION SEQUENCE
-- ============================================
local function playIntro()
	logo.ImageTransparency = 1[span_72](start_span)[span_72](end_span)
	logo.Size = UDim2.new(0, 120, 0, 120)[span_73](start_span)[span_73](end_span)
	glowRing.Size = UDim2.new(0, 140, 0, 140)[span_74](start_span)[span_74](end_span)
	ringStroke.Transparency = 1[span_75](start_span)[span_75](end_span)

	textContainer.Visible = false[span_76](start_span)[span_76](end_span)

	-- Jalankan background meteor & bintang
	startMeteorShower()

	-- PHASE 1: Logo muncul
	_tween(logo, {ImageTransparency = 0}, 1.0)[span_77](start_span)[span_77](end_span)
	_tween(logo, {Size = UDim2.new(0, 180, 0, 180)}, 1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)[span_78](start_span)[span_78](end_span)
	_tween(glowRing, {Size = UDim2.new(0, 260, 0, 260)}, 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.2)[span_79](start_span)[span_79](end_span)
	_tween(ringStroke, {Transparency = 0.5}, 1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.3)[span_80](start_span)[span_80](end_span)

	task.wait(CONFIG.LogoShowDuration)[span_81](start_span)[span_81](end_span)

	-- PHASE 2: Logo hilang, Audio & Teks Ketik dimulai BERSAMAAN
	_tween(logo, {ImageTransparency = 1, Size = UDim2.new(0, 250, 0, 250)}, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In)[span_82](start_span)[span_82](end_span)
	_tween(glowRing, {Size = UDim2.new(0, 350, 0, 350)}, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In)[span_83](start_span)[span_83](end_span)
	_tween(ringStroke, {Transparency = 1}, 0.6)[span_84](start_span)[span_84](end_span)

	-- **Audio & Container Teks Muncul Bersamaan**
	pcall(function() introSound:Play() end)[span_85](start_span)[span_85](end_span)
	textContainer.Visible = true[span_86](start_span)[span_86](end_span)

	_tween(welcomeText, {TextTransparency = 0}, 0.2)
	_tween(welcomeStroke, {Transparency = 0.2}, 0.2)

	-- Efek Ketik Baris Atas: "WELCOME" dengan kursor "┃"
	task.spawn(function()
		local targetMsg = "WELCOME"
		for i = 1, #targetMsg do
			if not welcomeText.Parent then break end
			welcomeText.Text = string.sub(targetMsg, 1, i) .. " ┃"
			task.wait(0.1)
		end
		-- Setelah selesai mengetik WELCOME, hapus kursornya
		if welcomeText.Parent then
			welcomeText.Text = targetMsg
		end

		-- Sesaat setelah WELCOME selesai, teks "A2" di bawahnya muncul dengan efek fade-in yang mantap
		_tween(a2Text, {TextTransparency = 0}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		_tween(a2Stroke, {Transparency = 0.1}, 0.5)
	end)

	-- Auto Close
	task.delay(CONFIG.AutoCloseDelay, function()
		if gui.Parent then closeIntro() end[span_87](start_span)[span_87](end_span)
	end)
end

-- ============================================
-- START SCRIPT
-- ============================================
playIntro()[span_88](start_span)[span_88](end_span)

print("[A2 Intro] Sync Typewriter Edition Loaded!")[span_89](start_span)[span_89](end_span)
