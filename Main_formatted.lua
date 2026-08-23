-- ============================================
-- A2 ROBLOX INTRO UI v2.0 - PHOENIX REBIRTH
-- by Kimi Chat | StarterGui > ScreenGui > LocalScript
-- VISUAL: Phoenix Reveal + Blue Inferno + Audio Reactive
-- BUKAN CYBERPUNK LAGI. INI PHOENIX REBIRTH STYLE.
-- ============================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

-- ============================================
-- CONFIG
-- ============================================
local CONFIG = {
	-- AUDIO (Ganti dengan Asset ID sendiri)
	Audio_Intro = "rbxassetid://9042861406",
	Audio_Whoosh = "rbxassetid://9113083740",
	Audio_Reveal = "rbxassetid://1846368080",
	Audio_Ambient = "rbxassetid://9042370693",

	-- WARNA TEMA PHOENIX BLUE
	PhoenixBlue = Color3.fromRGB(0, 100, 255),
	PhoenixCyan = Color3.fromRGB(0, 255, 255),
	PhoenixWhite = Color3.fromRGB(200, 230, 255),
	PhoenixDark = Color3.fromRGB(0, 20, 60),
	PhoenixGold = Color3.fromRGB(255, 200, 100),
	PhoenixMagenta = Color3.fromRGB(255, 0, 200),

	-- WARNA API BIRU (Blue Inferno)
	InfernoCore = Color3.fromRGB(0, 150, 255),
	InfernoHot = Color3.fromRGB(100, 220, 255),
	InfernoCold = Color3.fromRGB(0, 50, 150),
	InfernoAsh = Color3.fromRGB(50, 100, 180),

	-- TIMING
	Phase1_Duration = 3.0,
	Phase2_Duration = 2.5,
	AutoClose = 7.0,
}

-- ============================================
-- UTILITY
-- ============================================
local function _new(class, props)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do inst[k] = v end
	return inst
end

local function _tween(obj, props, dur, style, dir, delay)
	style = style or Enum.EasingStyle.Quad
	dir = dir or Enum.EasingDirection.Out
	delay = delay or 0
	local info = TweenInfo.new(dur, style, dir, 0, false, delay)
	local tw = TweenService:Create(obj, info, props)
	tw:Play()
	return tw
end

local function _rand(a, b) return math.random() * (b - a) + a end

-- ============================================
-- AUDIO ENGINE
-- ============================================
local Audio = {}
function Audio:Create(name, id, vol, looped)
	local s = _new("Sound", {
		Name = name,
		SoundId = id,
		Volume = vol or 0.5,
		Looped = looped or false,
		Parent = SoundService,
	})
	return s
end

function Audio:Play(s) if s and s.SoundId ~= "" then s:Play() end end
function Audio:Stop(s) if s then s:Stop() end end
function Audio:FadeOut(s, dur)
	if not s then return end
	_tween(s, {Volume = 0}, dur or 1)
	task.delay(dur or 1, function() s:Stop() s.Volume = (s:GetAttribute("BaseVol") or 0.5) end)
end

local sndIntro = Audio:Create("PhoenixIntro", CONFIG.Audio_Intro, 0.4, false)
local sndWhoosh = Audio:Create("PhoenixWhoosh", CONFIG.Audio_Whoosh, 0.6, false)
local sndReveal = Audio:Create("PhoenixReveal", CONFIG.Audio_Reveal, 0.5, false)
local sndAmbient = Audio:Create("PhoenixAmbient", CONFIG.Audio_Ambient, 0.15, true)

-- ============================================
-- SCREEN GUI
-- ============================================
local gui = _new("ScreenGui", {
	Name = "A2PhoenixIntro",
	Parent = playerGui,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 999,
})

-- ============================================
-- LAYER 1: VIGNETTE + PULSE BACKGROUND
-- ============================================
local bg = _new("Frame", {
	Name = "BG",
	Parent = gui,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = CONFIG.PhoenixDark,
	BorderSizePixel = 0,
	ZIndex = 1,
})

-- Vignette (gelap di pinggir)
local vignette = _new("Frame", {
	Name = "Vignette",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 2,
})

local vignetteGradient = _new("UIGradient", {
	Parent = vignette,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 10, 30)),
		ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 20, 60)),
		ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 20, 60)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 10, 30)),
	}),
	Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.3),
		NumberSequenceKeypoint.new(0.3, 0.8),
		NumberSequenceKeypoint.new(0.7, 0.8),
		NumberSequenceKeypoint.new(1, 0.3),
	}),
})

-- Pulse glow di tengah
local pulseGlow = _new("Frame", {
	Name = "PulseGlow",
	Parent = bg,
	Size = UDim2.new(0, 600, 0, 600),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	ZIndex = 2,
})

local pulseGradient = _new("UIGradient", {
	Parent = pulseGlow,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, CONFIG.PhoenixBlue),
		ColorSequenceKeypoint.new(0.5, CONFIG.PhoenixCyan),
		ColorSequenceKeypoint.new(1, CONFIG.PhoenixBlue),
	}),
	Rotation = 90,
})

local pulseCorner = _new("UICorner", {
	Parent = pulseGlow,
	CornerRadius = UDim.new(1, 0),
})

-- ============================================
-- LAYER 2: BLUE INFERNO (API BIRU V2)
-- ============================================
local inferno = _new("Frame", {
	Name = "Inferno",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 3,
})

-- Ember system (partikel api yang melayang)
local emberColors = {CONFIG.InfernoCore, CONFIG.InfernoHot, CONFIG.InfernoCold, CONFIG.InfernoAsh}

local function spawnEmber()
	local color = emberColors[math.random(1, #emberColors)]
	local size = _rand(3, 12)
	local startX = _rand(0, 1)
	local startY = _rand(0.7, 1.1)
	local dur = _rand(2, 5)
	local drift = _rand(-0.15, 0.15)

	local ember = _new("Frame", {
		Parent = inferno,
		Size = UDim2.new(0, size, 0, size),
		Position = UDim2.new(startX, 0, startY, 0),
		BackgroundColor3 = color,
		BackgroundTransparency = _rand(0.2, 0.6),
		BorderSizePixel = 0,
		ZIndex = 3,
	})

	-- Ember gradient (hot center)
	local eg = _new("UIGradient", {
		Parent = ember,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.5, color),
			ColorSequenceKeypoint.new(1, CONFIG.InfernoCold),
		}),
	})

	_ new("UICorner", {Parent = ember, CornerRadius = UDim.new(1, 0)})

	-- Ember trail (duplikat yang lebih transparan di belakang)
	local trail = _new("Frame", {
		Parent = inferno,
		Size = UDim2.new(0, size * 0.6, 0, size * 0.6),
		Position = UDim2.new(startX, 0, startY, 0),
		BackgroundColor3 = color,
		BackgroundTransparency = 0.8,
		BorderSizePixel = 0,
		ZIndex = 2,
	})
	_new("UICorner", {Parent = trail, CornerRadius = UDim.new(1, 0)})

	-- Animate ember
	_tween(ember, {
		Position = UDim2.new(startX + drift, 0, _rand(-0.1, 0.2), 0),
		BackgroundTransparency = 1,
		Size = UDim2.new(0, size * 0.3, 0, size * 0.3),
		Rotation = _rand(0, 360),
	}, dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	_tween(trail, {
		Position = UDim2.new(startX + drift * 0.5, 0, _rand(-0.05, 0.15), 0),
		BackgroundTransparency = 1,
		Size = UDim2.new(0, size * 0.2, 0, size * 0.2),
	}, dur * 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	game:GetService("Debris"):AddItem(ember, dur)
	game:GetService("Debris"):AddItem(trail, dur * 1.2)
end

-- Fire columns (tiang api biru dari bawah)
local fireColumns = _new("Frame", {
	Name = "FireColumns",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 2,
})

for i = 1, 12 do
	local col = _new("Frame", {
		Parent = fireColumns,
		Name = "Col" .. i,
		Size = UDim2.new(0, _rand(3, 8), 0, _rand(100, 300)),
		Position = UDim2.new(_rand(0, 1), 0, 1, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundColor3 = i % 2 == 0 and CONFIG.InfernoCore or CONFIG.InfernoHot,
		BackgroundTransparency = 0.85,
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	local colGrad = _new("UIGradient", {
		Parent = col,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, CONFIG.InfernoCold),
			ColorSequenceKeypoint.new(0.5, CONFIG.InfernoCore),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
		}),
		Rotation = 90,
	})

	-- Animate column
	task.spawn(function()
		while col.Parent do
			local h = _rand(150, 400)
			_tween(col, {
				Size = UDim2.new(col.Size.X.Scale, col.Size.X.Offset, 0, h),
				BackgroundTransparency = _rand(0.7, 0.9),
				Position = UDim2.new(col.Position.X.Scale, 0, 1, _rand(-20, 20)),
			}, _rand(1, 2.5), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
			task.wait(_rand(1, 2.5))
		end
	end)
end

-- ============================================
-- LAYER 3: RIPPLE / WAVE RINGS
-- ============================================
local rippleContainer = _new("Frame", {
	Name = "Ripples",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 4,
})

local function spawnRipple()
	local ripple = _new("Frame", {
		Parent = rippleContainer,
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 4,
	})

	local stroke = _new("UIStroke", {
		Parent = ripple,
		Color = CONFIG.PhoenixCyan,
		Thickness = 2,
		Transparency = 0.6,
	})

	_new("UICorner", {Parent = ripple, CornerRadius = UDim.new(1, 0)})

	_tween(ripple, {Size = UDim2.new(0, 800, 0, 800)}, 3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	_tween(stroke, {Transparency = 1, Thickness = 0.5}, 3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	game:GetService("Debris"):AddItem(ripple, 3)
end

-- ============================================
-- LAYER 4: CHROMATIC ABERRATION LINES
-- ============================================
local chromatic = _new("Frame", {
	Name = "Chromatic",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 5,
})

local chromLines = {}
for i = 1, 20 do
	local line = _new("Frame", {
		Parent = chromatic,
		Name = "ChLine" .. i,
		Size = UDim2.new(1, 0, 0, _rand(1, 3)),
		Position = UDim2.new(0, 0, _rand(0, 1), 0),
		BackgroundColor3 = i % 2 == 0 and CONFIG.PhoenixBlue or CONFIG.PhoenixMagenta,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 5,
	})
	table.insert(chromLines, line)
end

-- ============================================
-- LAYER 5: SPLIT REVEAL MASKS
-- ============================================
local splitLeft = _new("Frame", {
	Name = "SplitLeft",
	Parent = bg,
	Size = UDim2.new(0.5, 0, 1, 0),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundColor3 = CONFIG.PhoenixDark,
	BorderSizePixel = 0,
	ZIndex = 50,
})

local splitRight = _new("Frame", {
	Name = "SplitRight",
	Parent = bg,
	Size = UDim2.new(0.5, 0, 1, 0),
	Position = UDim2.new(0.5, 0, 0, 0),
	BackgroundColor3 = CONFIG.PhoenixDark,
	BorderSizePixel = 0,
	ZIndex = 50,
})

-- Garis tengah neon
local splitLine = _new("Frame", {
	Name = "SplitLine",
	Parent = bg,
	Size = UDim2.new(0, 4, 1, 0),
	Position = UDim2.new(0.5, 0, 0, 0),
	AnchorPoint = Vector2.new(0.5, 0),
	BackgroundColor3 = CONFIG.PhoenixCyan,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 51,
})

-- ============================================
-- LAYER 6: A2 TEXT - PHOENIX STYLE
-- ============================================
local textContainer = _new("Frame", {
	Name = "TextContainer",
	Parent = bg,
	Size = UDim2.new(0, 800, 0, 300),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	ZIndex = 10,
	Visible = false,
	ClipsDescendants = true,
})

-- Shadow layers (phoenix trail effect)
local shadowColors = {
	{col = CONFIG.InfernoCold, off = 20, trans = 0.85, size = 160},
	{col = CONFIG.PhoenixBlue, off = 14, trans = 0.7, size = 150},
	{col = CONFIG.PhoenixCyan, off = 8, trans = 0.5, size = 140},
	{col = CONFIG.InfernoHot, off = 4, trans = 0.3, size = 132},
}

for i, sh in ipairs(shadowColors) do
	local shadow = _new("TextLabel", {
		Parent = textContainer,
		Name = "Shadow" .. i,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, sh.off, 0, sh.off),
		BackgroundTransparency = 1,
		Text = "A2",
		Font = Enum.Font.Arcade,
		TextSize = sh.size,
		TextColor3 = sh.col,
		TextTransparency = 1,
		ZIndex = 10 - i,
	})
end

local mainText = _new("TextLabel", {
	Parent = textContainer,
	Name = "MainText",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Text = "A2",
	Font = Enum.Font.Arcade,
	TextSize = 128,
	TextColor3 = CONFIG.PhoenixWhite,
	TextTransparency = 1,
	ZIndex = 10,
})

local textStroke = _new("UIStroke", {
	Parent = mainText,
	Color = CONFIG.PhoenixCyan,
	Thickness = 4,
	Transparency = 1,
})

local textGlow = _new("UIStroke", {
	Parent = mainText,
	Color = CONFIG.PhoenixBlue,
	Thickness = 20,
	Transparency = 1,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
})

-- Subtitle
local subText = _new("TextLabel", {
	Parent = textContainer,
	Name = "Subtitle",
	Size = UDim2.new(1, 0, 0, 40),
	Position = UDim2.new(0, 0, 1, 20),
	BackgroundTransparency = 1,
	Text = "",
	Font = Enum.Font.Code,
	TextSize = 16,
	TextColor3 = CONFIG.PhoenixGold,
	TextTransparency = 1,
	ZIndex = 10,
})

-- ============================================
-- LAYER 7: HEXAGON GRID (Futuristic)
-- ============================================
local hexContainer = _new("Frame", {
	Name = "HexGrid",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 2,
})

local hexagons = {}
for row = 0, 8 do
	for col = 0, 12 do
		local hex = _new("Frame", {
			Parent = hexContainer,
			Size = UDim2.new(0, 30, 0, 30),
			Position = UDim2.new(0, col * 80 + (row % 2) * 40, 0, row * 70),
			BackgroundColor3 = CONFIG.PhoenixBlue,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 2,
		})
		_new("UICorner", {Parent = hex, CornerRadius = UDim.new(0, 6)})

		-- Only show some hexagons
		if math.random() > 0.7 then
			hex.BackgroundTransparency = _rand(0.9, 0.97)
			table.insert(hexagons, hex)
		end
	end
end

-- Animate hexagons randomly
for _, hex in ipairs(hexagons) do
	task.spawn(function()
		while hex.Parent do
			task.wait(_rand(2, 6))
			if not hex.Parent then break end
			_tween(hex, {BackgroundTransparency = _rand(0.7, 0.9)}, 0.5)
			task.wait(0.5)
			if not hex.Parent then break end
			_tween(hex, {BackgroundTransparency = _rand(0.9, 0.97)}, 0.5)
		end
	end)
end

-- ============================================
-- LAYER 8: PARTICLE BURST SYSTEM
-- ============================================
local burstContainer = _new("Frame", {
	Name = "BurstContainer",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 15,
})

local function particleBurst(count, centerX, centerY)
	for i = 1, count do
		local angle = (math.pi * 2 / count) * i + _rand(-0.2, 0.2)
		local dist = _rand(100, 400)
		local size = _rand(3, 10)
		local color = emberColors[math.random(1, #emberColors)]

		local p = _new("Frame", {
			Parent = burstContainer,
			Size = UDim2.new(0, size, 0, size),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = color,
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = 15,
		})
		_new("UICorner", {Parent = p, CornerRadius = UDim.new(1, 0)})

		_tween(p, {
			Position = UDim2.new(0.5, math.cos(angle) * dist, 0.5, math.sin(angle) * dist),
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 0, 0, 0),
		}, _rand(0.8, 1.5), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		game:GetService("Debris"):AddItem(p, 1.5)
	end
end

-- ============================================
-- LAYER 9: SCANLINE CRT EFFECT
-- ============================================
local crt = _new("Frame", {
	Name = "CRT",
	Parent = bg,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	ZIndex = 100,
})

for i = 0, 60 do
	_new("Frame", {
		Parent = crt,
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 0, i * 12),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.92,
		BorderSizePixel = 0,
	})
end

-- ============================================
-- LAYER 10: INFO PANEL (Audio Status)
-- ============================================
local infoPanel = _new("Frame", {
	Name = "InfoPanel",
	Parent = bg,
	Size = UDim2.new(0, 350, 0, 60),
	Position = UDim2.new(0.5, 0, 0, 20),
	AnchorPoint = Vector2.new(0.5, 0),
	BackgroundColor3 = Color3.fromRGB(0, 10, 30),
	BackgroundTransparency = 0.3,
	BorderSizePixel = 0,
	ZIndex = 200,
})
_new("UICorner", {Parent = infoPanel, CornerRadius = UDim.new(0, 8)})
_new("UIStroke", {Parent = infoPanel, Color = CONFIG.PhoenixCyan, Thickness = 1, Transparency = 0.5})

local infoLabel = _new("TextLabel", {
	Parent = infoPanel,
	Size = UDim2.new(1, -20, 1, -10),
	Position = UDim2.new(0, 10, 0, 5),
	BackgroundTransparency = 1,
	Text = "[PHOENIX v2.0] Memuat sistem...",
	Font = Enum.Font.Code,
	TextSize = 11,
	TextColor3 = CONFIG.PhoenixCyan,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 200,
})

-- Audio visualizer bars (fake)
local vizContainer = _new("Frame", {
	Parent = infoPanel,
	Size = UDim2.new(0, 60, 0, 20),
	Position = UDim2.new(1, -70, 0.5, -10),
	BackgroundTransparency = 1,
	ZIndex = 200,
})

local vizBars = {}
for i = 1, 5 do
	local bar = _new("Frame", {
		Parent = vizContainer,
		Size = UDim2.new(0, 6, 0, 4),
		Position = UDim2.new(0, (i-1) * 12, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = CONFIG.PhoenixCyan,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		ZIndex = 200,
	})
	_new("UICorner", {Parent = bar, CornerRadius = UDim.new(0, 2)})
	table.insert(vizBars, bar)
end

-- Animate visualizer
for _, bar in ipairs(vizBars) do
	task.spawn(function()
		while bar.Parent do
			_tween(bar, {Size = UDim2.new(0, 6, 0, _rand(4, 18))}, 0.15)
			task.wait(0.15)
		end
	end)
end

-- ============================================
-- REPLAY BUTTON
-- ============================================
local replayBtn = _new("TextButton", {
	Parent = bg,
	Name = "ReplayBtn",
	Size = UDim2.new(0, 140, 0, 40),
	Position = UDim2.new(0.5, 0, 1, -60),
	AnchorPoint = Vector2.new(0.5, 1),
	BackgroundColor3 = Color3.fromRGB(0, 15, 40),
	BackgroundTransparency = 0,
	Text = "↻ REPLAY",
	Font = Enum.Font.Code,
	TextSize = 13,
	TextColor3 = CONFIG.PhoenixWhite,
	ZIndex = 30,
	Visible = false,
	AutoButtonColor = true,
})
_new("UIStroke", {Parent = replayBtn, Color = CONFIG.PhoenixCyan, Thickness = 2})
_new("UICorner", {Parent = replayBtn, CornerRadius = UDim.new(0, 10)})

replayBtn.MouseEnter:Connect(function()
	_tween(replayBtn, {BackgroundColor3 = CONFIG.PhoenixBlue}, 0.2)
	_tween(replayBtn, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
end)
replayBtn.MouseLeave:Connect(function()
	_tween(replayBtn, {BackgroundColor3 = Color3.fromRGB(0, 15, 40)}, 0.2)
	_tween(replayBtn, {TextColor3 = CONFIG.PhoenixWhite}, 0.2)
end)

-- ============================================
-- CLOSE FUNCTION
-- ============================================
local function closeAll()
	Audio:FadeOut(sndAmbient, 1)
	Audio:FadeOut(sndReveal, 0.5)

	_tween(infoPanel, {BackgroundTransparency = 1}, 0.5)
	_tween(infoLabel, {TextTransparency = 1}, 0.5)
	for _, bar in ipairs(vizBars) do _tween(bar, {BackgroundTransparency = 1}, 0.5) end

	_tween(bg, {BackgroundTransparency = 1}, 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	for _, child in ipairs(bg:GetDescendants()) do
		if child:IsA("Frame") and child ~= bg then
			_tween(child, {BackgroundTransparency = 1}, 1.2)
		elseif child:IsA("TextLabel") or child:IsA("TextButton") then
			_tween(child, {TextTransparency = 1}, 1.2)
		elseif child:IsA("UIStroke") then
			_tween(child, {Transparency = 1}, 1.2)
		elseif child:IsA("UIGradient") then
			-- handled by parent
		end
	end

	task.delay(1.4, function()
		if gui.Parent then
			gui:Destroy()
			print("[A2 Phoenix v2.0] Intro selesai. Sistem dimatikan.")
		end
	end)
end

-- ============================================
-- MAIN ANIMATION - PHOENIX REBIRTH SEQUENCE
-- ============================================
local function playSequence()
	-- RESET
	splitLeft.Visible = true
	splitRight.Visible = true
	splitLine.Visible = true
	textContainer.Visible = false
	mainText.TextTransparency = 1
	textStroke.Transparency = 1
	textGlow.Transparency = 1
	subText.Text = ""
	subText.TextTransparency = 1
	replayBtn.Visible = false

	for _, sh in ipairs(textContainer:GetChildren()) do
		if sh:IsA("TextLabel") and sh.Name:find("Shadow") then
			sh.TextTransparency = 1
		end
	end

	-- PHASE 0: Setup
	infoLabel.Text = "[PHOENIX v2.0] Blue Inferno + Audio System Active"
	Audio:Play(sndAmbient)

	-- Start ember spawner
	task.spawn(function()
		while inferno.Parent do
			spawnEmber()
			task.wait(_rand(0.03, 0.1))
		end
	end)

	-- Pulse glow animation
	task.spawn(function()
		while pulseGlow.Parent do
			_tween(pulseGlow, {BackgroundTransparency = _rand(0.85, 0.95), Size = UDim2.new(0, _rand(500, 700), 0, _rand(500, 700))}, 2)
			task.wait(2)
		end
	end)

	-- PHASE 1: SPLIT SCREEN OPENING (0-2s)
	task.wait(0.5)
	Audio:Play(sndIntro)

	-- Split line appears
	_tween(splitLine, {BackgroundTransparency = 0}, 0.3)
	task.wait(0.3)

	-- Chromatic lines flash
	for _, line in ipairs(chromLines) do
		_tween(line, {BackgroundTransparency = _rand(0.7, 0.9)}, 0.1)
	end
	task.wait(0.1)
	for _, line in ipairs(chromLines) do
		_tween(line, {BackgroundTransparency = 1}, 0.3)
	end

	-- Split opens
	_tween(splitLeft, {Position = UDim2.new(-0.5, 0, 0, 0)}, 1.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	_tween(splitRight, {Position = UDim2.new(1, 0, 0, 0)}, 1.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	_tween(splitLine, {Size = UDim2.new(0, 4, 0, 0), BackgroundTransparency = 1}, 1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0.5)

	task.wait(1.0)
	splitLeft.Visible = false
	splitRight.Visible = false

	-- PHASE 2: RIPPLE + LOGO REVEAL (2-4s)
	spawnRipple()
	Audio:Play(sndWhoosh)

	infoLabel.Text = "[PHOENIX v2.0] Revealing A2 Identity..."

	-- PHASE 3: A2 TEXT REVEAL (4-6s)
	textContainer.Visible = true
	textContainer.Size = UDim2.new(0, 0, 0, 0)

	_tween(textContainer, {Size = UDim2.new(0, 800, 0, 300)}, 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

	-- Shadow layers appear with delay
	for i, sh in ipairs(textContainer:GetChildren()) do
		if sh:IsA("TextLabel") and sh.Name:find("Shadow") then
			_tween(sh, {TextTransparency = 0.4}, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.1 + (i * 0.1))
		end
	end

	_tween(mainText, {TextTransparency = 0}, 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.3)
	_tween(textStroke, {Transparency = 0.1}, 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.4)
	_tween(textGlow, {Transparency = 0.6}, 1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.5)

	-- Particle burst
	task.delay(0.5, function()
		particleBurst(30, 0.5, 0.5)
		Audio:Play(sndReveal)
	end)

	-- Text breathing effect
	task.delay(1.5, function()
		while mainText.Parent and mainText.TextTransparency < 0.5 do
			_tween(textGlow, {Transparency = 0.3}, 1.5)
			_tween(textStroke, {Transparency = 0}, 1.5)
			task.wait(1.5)
			if not mainText.Parent then break end
			_tween(textGlow, {Transparency = 0.7}, 1.5)
			_tween(textStroke, {Transparency = 0.2}, 1.5)
			task.wait(1.5)
		end
	end)

	-- Typewriter subtitle
	task.delay(2.5, function()
		local msg = "Phoenix Rebirth Protocol Initiated..."
		for i = 1, #msg do
			if not subText.Parent then break end
			subText.Text = string.sub(msg, 1, i)
			_tween(subText, {TextTransparency = 0}, 0.1)
			task.wait(0.06)
		end
	end)

	-- Show replay button
	task.delay(4, function()
		if replayBtn.Parent then
			replayBtn.Visible = true
			_tween(replayBtn, {TextTransparency = 0}, 0.5)
		end
	end)

	-- Fade info
	task.delay(5, function()
		_tween(infoPanel, {BackgroundTransparency = 1}, 1)
		_tween(infoLabel, {TextTransparency = 1}, 1)
		for _, bar in ipairs(vizBars) do
			_tween(bar, {BackgroundTransparency = 1}, 1)
		end
	end)

	-- Auto close
	task.delay(CONFIG.AutoClose, function()
		if gui.Parent then closeAll() end
	end)
end

-- ============================================
-- START
-- ============================================
playSequence()

replayBtn.MouseButton1Click:Connect(function()
	replayBtn.Visible = false
	infoPanel.BackgroundTransparency = 0.3
	infoLabel.TextTransparency = 0
	infoLabel.Text = "[PHOENIX v2.0] Replay dimulai..."
	for _, bar in ipairs(vizBars) do bar.BackgroundTransparency = 0.3 end

	-- Reset split
	splitLeft.Position = UDim2.new(0, 0, 0, 0)
	splitRight.Position = UDim2.new(0.5, 0, 0, 0)
	splitLine.Size = UDim2.new(0, 4, 1, 0)
	splitLine.BackgroundTransparency = 1

	playSequence()
end)

print("[A2 Phoenix v2.0] LOADED!")
print("[A2 Phoenix v2.0] Style: Phoenix Rebirth + Blue Inferno + Audio Reactive")
print("[A2 Phoenix v2.0] Ganti Audio ID di CONFIG.Audio_Intro / Whoosh / Reveal / Ambient")
