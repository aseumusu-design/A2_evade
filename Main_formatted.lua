--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║              NEXUS UI LIBRARY v2.1 — ROBLOX ICONS            ║
    ║         Modern Glassmorphism UI • rbxassetid Icons           ║
    ╚══════════════════════════════════════════════════════════════╝

    CHANGELOG v2.1:
    - All icons now use rbxassetid:// (ImageLabel) instead of emoji
    - 60 unique icons from Lucide spritesheet + Orion assets
    - ImageRectOffset/ImageRectSize support for spritesheets
    - Fully compatible with Roblox game client (PC & Mobile)
--]]

local NexusUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════
-- THEMES
-- ═══════════════════════════════════════════════════════════════

NexusUI.Themes = {
    Dark = {
        Background = Color3.fromRGB(15, 15, 20),
        BackgroundSecondary = Color3.fromRGB(25, 25, 35),
        Accent = Color3.fromRGB(99, 102, 241),
        AccentLight = Color3.fromRGB(129, 140, 248),
        Text = Color3.fromRGB(245, 245, 245),
        TextDark = Color3.fromRGB(160, 160, 180),
        Border = Color3.fromRGB(40, 40, 55),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(234, 179, 8),
        Error = Color3.fromRGB(239, 68, 68),
        Glass = Color3.fromRGB(30, 30, 45),
        GradientStart = Color3.fromRGB(99, 102, 241),
        GradientEnd = Color3.fromRGB(168, 85, 247),
    },
    Midnight = {
        Background = Color3.fromRGB(10, 10, 18),
        BackgroundSecondary = Color3.fromRGB(20, 20, 32),
        Accent = Color3.fromRGB(56, 189, 248),
        AccentLight = Color3.fromRGB(125, 211, 252),
        Text = Color3.fromRGB(248, 250, 252),
        TextDark = Color3.fromRGB(148, 163, 184),
        Border = Color3.fromRGB(30, 41, 59),
        Success = Color3.fromRGB(52, 211, 153),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(248, 113, 113),
        Glass = Color3.fromRGB(25, 35, 50),
        GradientStart = Color3.fromRGB(56, 189, 248),
        GradientEnd = Color3.fromRGB(168, 85, 247),
    },
    Crimson = {
        Background = Color3.fromRGB(20, 10, 10),
        BackgroundSecondary = Color3.fromRGB(35, 20, 20),
        Accent = Color3.fromRGB(239, 68, 68),
        AccentLight = Color3.fromRGB(252, 165, 165),
        Text = Color3.fromRGB(254, 242, 242),
        TextDark = Color3.fromRGB(200, 160, 160),
        Border = Color3.fromRGB(60, 30, 30),
        Success = Color3.fromRGB(74, 222, 128),
        Warning = Color3.fromRGB(250, 204, 21),
        Error = Color3.fromRGB(239, 68, 68),
        Glass = Color3.fromRGB(45, 25, 25),
        GradientStart = Color3.fromRGB(239, 68, 68),
        GradientEnd = Color3.fromRGB(249, 115, 22),
    },
    Forest = {
        Background = Color3.fromRGB(10, 18, 12),
        BackgroundSecondary = Color3.fromRGB(18, 32, 22),
        Accent = Color3.fromRGB(34, 197, 94),
        AccentLight = Color3.fromRGB(134, 239, 172),
        Text = Color3.fromRGB(240, 253, 244),
        TextDark = Color3.fromRGB(160, 190, 170),
        Border = Color3.fromRGB(25, 50, 30),
        Success = Color3.fromRGB(52, 211, 153),
        Warning = Color3.fromRGB(253, 224, 71),
        Error = Color3.fromRGB(248, 113, 113),
        Glass = Color3.fromRGB(22, 40, 28),
        GradientStart = Color3.fromRGB(34, 197, 94),
        GradientEnd = Color3.fromRGB(20, 184, 166),
    },
    Void = {
        Background = Color3.fromRGB(5, 5, 8),
        BackgroundSecondary = Color3.fromRGB(12, 12, 18),
        Accent = Color3.fromRGB(192, 132, 252),
        AccentLight = Color3.fromRGB(233, 213, 255),
        Text = Color3.fromRGB(250, 245, 255),
        TextDark = Color3.fromRGB(180, 160, 200),
        Border = Color3.fromRGB(30, 25, 40),
        Success = Color3.fromRGB(167, 139, 250),
        Warning = Color3.fromRGB(253, 186, 116),
        Error = Color3.fromRGB(244, 114, 182),
        Glass = Color3.fromRGB(20, 18, 30),
        GradientStart = Color3.fromRGB(168, 85, 247),
        GradientEnd = Color3.fromRGB(236, 72, 153),
    }
}

NexusUI.CurrentTheme = NexusUI.Themes.Dark

-- ═══════════════════════════════════════════════════════════════
-- 60 UNIQUE ROBLOX ICONS (rbxassetid://)
-- ═══════════════════════════════════════════════════════════════
-- Using Lucide Icons spritesheet (48x48 grid) + individual assets
-- To replace an icon: NexusUI.Icons[N].AssetId = YOUR_ID
-- For individual images: set ImageRectOffset = Vector2.new(0,0)

NexusUI.Icons = {}

-- Lucide Spritesheet (48x48 grid, 16 columns)
local LUCIDE_SHEET = 15269177520
local ICON_SIZE = 48
local COLS = 16

local function GridOffset(index)
    local n = index - 1
    local row = math.floor(n / COLS)
    local col = n % COLS
    return Vector2.new(col * ICON_SIZE, row * ICON_SIZE)
end

-- Individual Orion/Verified Assets for key icons
local ORION_HOME = 4483345998
local ORION_CLOSE = 7072725342
local ORION_MINIMIZE = 7072719338
local ORION_MAXIMIZE = 7072720870
local ORION_LOGO = 8834748103
local ORION_SCROLL = 7445543667
local ORION_AVATAR = 4031889928

-- Build 60 Icons
local iconDefs = {
    -- Navigation & System (1-10)
    {Name = "Home",       Category = "Nav",    AssetId = ORION_HOME,       Rect = Vector2.new(0, 0)},
    {Name = "Settings",   Category = "Nav",    AssetId = LUCIDE_SHEET,     Rect = GridOffset(1)},
    {Name = "Profile",    Category = "Nav",    AssetId = ORION_AVATAR,     Rect = Vector2.new(0, 0)},
    {Name = "Search",     Category = "Nav",    AssetId = LUCIDE_SHEET,     Rect = GridOffset(2)},
    {Name = "Menu",       Category = "Nav",    AssetId = LUCIDE_SHEET,     Rect = GridOffset(3)},
    {Name = "Close",      Category = "Nav",    AssetId = ORION_CLOSE,      Rect = Vector2.new(0, 0)},
    {Name = "Back",       Category = "Nav",    AssetId = LUCIDE_SHEET,     Rect = GridOffset(4)},
    {Name = "Forward",    Category = "Nav",    AssetId = LUCIDE_SHEET,     Rect = GridOffset(5)},
    {Name = "Refresh",    Category = "Nav",    AssetId = LUCIDE_SHEET,     Rect = GridOffset(6)},
    {Name = "Star",       Category = "Nav",    AssetId = LUCIDE_SHEET,     Rect = GridOffset(7)},

    -- Combat & Weapons (11-20)
    {Name = "Sword",      Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(8)},
    {Name = "Dagger",     Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(9)},
    {Name = "Bow",        Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(10)},
    {Name = "Gun",        Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(11)},
    {Name = "Bomb",       Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(12)},
    {Name = "Axe",        Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(13)},
    {Name = "Hammer",     Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(14)},
    {Name = "Pickaxe",    Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(15)},
    {Name = "Shield",     Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(16)},
    {Name = "Target",     Category = "Combat", AssetId = LUCIDE_SHEET,     Rect = GridOffset(17)},

    -- Farming & Resources (21-30)
    {Name = "Farm",       Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(18)},
    {Name = "Tree",       Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(19)},
    {Name = "Rock",       Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(20)},
    {Name = "Fishing",    Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(21)},
    {Name = "Wheat",      Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(22)},
    {Name = "Seed",       Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(23)},
    {Name = "Chest",      Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(24)},
    {Name = "Gem",        Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(25)},
    {Name = "Crystal",    Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(26)},
    {Name = "Potion",     Category = "Farm",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(27)},

    -- Speed & Movement (31-40)
    {Name = "Speed",      Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(28)},
    {Name = "Flight",     Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(29)},
    {Name = "Rocket",     Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(30)},
    {Name = "Teleport",   Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(31)},
    {Name = "Jump",       Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(32)},
    {Name = "Dash",       Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(33)},
    {Name = "Car",        Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(34)},
    {Name = "Ship",       Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(35)},
    {Name = "UFO",        Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(36)},
    {Name = "Portal",     Category = "Speed",  AssetId = LUCIDE_SHEET,     Rect = GridOffset(37)},

    -- Visual & ESP (41-50)
    {Name = "Eye",        Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(38)},
    {Name = "Radar",      Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(39)},
    {Name = "Map",        Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(40)},
    {Name = "Compass",    Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(41)},
    {Name = "Pin",        Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(42)},
    {Name = "Sun",        Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(43)},
    {Name = "Moon",       Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(44)},
    {Name = "Fire",       Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(45)},
    {Name = "Ice",        Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(46)},
    {Name = "Lightning",  Category = "Visual", AssetId = LUCIDE_SHEET,     Rect = GridOffset(47)},

    -- Misc & Utility (51-60)
    {Name = "Money",      Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(48)},
    {Name = "Key",        Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(49)},
    {Name = "Door",       Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(50)},
    {Name = "Ladder",     Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(51)},
    {Name = "Robot",      Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(52)},
    {Name = "Skull",      Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(53)},
    {Name = "Ghost",      Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(54)},
    {Name = "Dragon",     Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(55)},
    {Name = "Wolf",       Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(56)},
    {Name = "Music",      Category = "Misc",   AssetId = LUCIDE_SHEET,     Rect = GridOffset(57)},
}

for i, def in ipairs(iconDefs) do
    NexusUI.Icons[i] = {
        Name = def.Name,
        Category = def.Category,
        AssetId = def.AssetId,
        ImageRectOffset = def.Rect,
        ImageRectSize = Vector2.new(ICON_SIZE, ICON_SIZE),
        GetUrl = function(self)
            return "rbxassetid://" .. self.AssetId
        end
    }
end

-- Helper to create icon ImageLabel
function NexusUI:CreateIcon(parent, iconData, size, position, color)
    size = size or 22
    position = position or UDim2.new(0, 10, 0.5, -size/2)
    color = color or self.CurrentTheme.Text

    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, size, 0, size)
    icon.Position = position
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://" .. iconData.AssetId
    icon.ImageRectOffset = iconData.ImageRectOffset
    icon.ImageRectSize = iconData.ImageRectSize
    icon.ImageColor3 = color
    icon.Parent = parent

    return icon
end

-- ═══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function Create(className, properties, children)
    local instance = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        instance[prop] = value
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = instance
        end
    end
    return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection, callback)
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(
            duration or 0.3,
            easingStyle or Enum.EasingStyle.Quart,
            easingDirection or Enum.EasingDirection.Out
        ),
        properties
    )
    if callback then
        tween.Completed:Connect(callback)
    end
    tween:Play()
    return tween
end

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, dragStart, startPos
    handle = handle or frame

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function AddCorner(instance, radius)
    return Create("UICorner", {CornerRadius = UDim.new(0, radius or 8), Parent = instance})
end

local function AddStroke(instance, color, thickness)
    return Create("UIStroke", {Color = color or NexusUI.CurrentTheme.Border, Thickness = thickness or 1, Transparency = 0.5, Parent = instance})
end

local function AddShadow(instance, offset)
    return Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, offset or 4),
        Size = UDim2.new(1, 20, 1, 20),
        ZIndex = instance.ZIndex - 1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.6,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
        Parent = instance
    })
end

local function AddGradient(instance, startColor, endColor, rotation)
    return Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, startColor or NexusUI.CurrentTheme.GradientStart),
            ColorSequenceKeypoint.new(1, endColor or NexusUI.CurrentTheme.GradientEnd)
        }),
        Rotation = rotation or 45,
        Parent = instance
    })
end

local function AddPadding(instance, padding)
    return Create("UIPadding", {
        PaddingLeft = UDim.new(0, padding or 10),
        PaddingRight = UDim.new(0, padding or 10),
        PaddingTop = UDim.new(0, padding or 10),
        PaddingBottom = UDim.new(0, padding or 10),
        Parent = instance
    })
end

local function AddListLayout(instance, padding, alignment)
    return Create("UIListLayout", {
        Padding = UDim.new(0, padding or 8),
        HorizontalAlignment = alignment or Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = instance
    })
end

-- ═══════════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════════

function NexusUI:Notify(data)
    data = data or {}
    local title = data.Title or "Notification"
    local message = data.Message or ""
    local duration = data.Duration or 3
    local notifType = data.Type or "Info"
    local iconData = data.Icon or NexusUI.Icons[1] -- default home icon

    local notifGui = Create("ScreenGui", {
        Name = "NexusNotifications",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local theme = self.CurrentTheme
    local typeColors = {
        Info = theme.Accent,
        Success = theme.Success,
        Warning = theme.Warning,
        Error = theme.Error
    }

    local notifFrame = Create("Frame", {
        Name = "Notification",
        Size = UDim2.new(0, 320, 0, 80),
        Position = UDim2.new(1, -340, 1, -100),
        BackgroundColor3 = theme.Glass,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Parent = notifGui
    })
    AddCorner(notifFrame, 12)
    AddStroke(notifFrame, theme.Border, 1)

    local accentBar = Create("Frame", {
        Name = "AccentBar",
        Size = UDim2.new(0, 4, 1, 0),
        BackgroundColor3 = typeColors[notifType],
        BorderSizePixel = 0,
        Parent = notifFrame
    })
    AddCorner(accentBar, 2)

    -- Icon using rbxassetid
    local iconLabel = Create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(0, 14, 0, 14),
        BackgroundTransparency = 1,
        Image = "rbxassetid://" .. iconData.AssetId,
        ImageRectOffset = iconData.ImageRectOffset,
        ImageRectSize = iconData.ImageRectSize,
        ImageColor3 = typeColors[notifType],
        Parent = notifFrame
    })

    local titleLabel = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 220, 0, 20),
        Position = UDim2.new(0, 50, 0, 12),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notifFrame
    })

    local messageLabel = Create("TextLabel", {
        Name = "Message",
        Size = UDim2.new(0, 250, 0, 40),
        Position = UDim2.new(0, 50, 0, 32),
        BackgroundTransparency = 1,
        Text = message,
        TextColor3 = theme.TextDark,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = notifFrame
    })

    local closeBtn = Create("TextButton", {
        Name = "Close",
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -28, 0, 8),
        BackgroundTransparency = 1,
        Text = "✕",
        TextColor3 = theme.TextDark,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = notifFrame
    })

    notifFrame.Position = UDim2.new(1, 20, 1, -100)
    Tween(notifFrame, {Position = UDim2.new(1, -340, 1, -100)}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    closeBtn.MouseButton1Click:Connect(function()
        Tween(notifFrame, {Position = UDim2.new(1, 20, 1, -100), BackgroundTransparency = 1}, 0.3)
        task.wait(0.3)
        notifGui:Destroy()
    end)

    task.delay(duration, function()
        if notifGui and notifGui.Parent then
            Tween(notifFrame, {Position = UDim2.new(1, 20, 1, -100), BackgroundTransparency = 1}, 0.3)
            task.wait(0.3)
            if notifGui and notifGui.Parent then notifGui:Destroy() end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN WINDOW CREATION
-- ═══════════════════════════════════════════════════════════════

function NexusUI:CreateWindow(config)
    config = config or {}
    local title = config.Title or "Nexus Hub"
    local subtitle = config.SubTitle or "v2.1"
    local theme = config.Theme or "Dark"
    local size = config.Size or UDim2.new(0, 750, 0, 500)

    if self.Themes[theme] then
        self.CurrentTheme = self.Themes[theme]
    end
    local currentTheme = self.CurrentTheme

    local gui = Create("ScreenGui", {
        Name = "NexusUI_" .. HttpService:GenerateGUID(false),
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local mainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = size,
        Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2),
        BackgroundColor3 = currentTheme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = gui
    })
    AddCorner(mainFrame, 16)
    AddStroke(mainFrame, currentTheme.Border, 1)
    AddShadow(mainFrame, 8)

    -- Background Gradient Orb
    local bgGradient = Create("Frame", {
        Name = "BgGradient",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })
    Create("Frame", {
        Name = "GradientOrb",
        Size = UDim2.new(0, 400, 0, 400),
        Position = UDim2.new(0.8, -200, 0.2, -200),
        BackgroundColor3 = currentTheme.Accent,
        BackgroundTransparency = 0.9,
        BorderSizePixel = 0,
        Parent = bgGradient
    }, {AddCorner(_, 200)})

    -- Title Bar
    local titleBar = Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = currentTheme.BackgroundSecondary,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, currentTheme.BackgroundSecondary),
            ColorSequenceKeypoint.new(1, currentTheme.Background)
        }),
        Parent = titleBar
    })

    Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 20, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = currentTheme.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })

    Create("TextLabel", {
        Name = "SubTitle",
        Size = UDim2.new(0, 100, 1, 0),
        Position = UDim2.new(0, 130, 0, 0),
        BackgroundTransparency = 1,
        Text = subtitle,
        TextColor3 = currentTheme.Accent,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = titleBar
    })

    -- Window Controls
    local minimizeBtn = Create("TextButton", {
        Name = "Minimize",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -80, 0, 8),
        BackgroundColor3 = currentTheme.BackgroundSecondary,
        Text = "−",
        TextColor3 = currentTheme.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = titleBar
    })
    AddCorner(minimizeBtn, 6)

    local closeBtn = Create("TextButton", {
        Name = "Close",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 8),
        BackgroundColor3 = currentTheme.Error,
        BackgroundTransparency = 0.8,
        Text = "✕",
        TextColor3 = currentTheme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        Parent = titleBar
    })
    AddCorner(closeBtn, 6)

    -- Sidebar
    local sidebar = Create("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 180, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = currentTheme.BackgroundSecondary,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    AddListLayout(sidebar, 4)
    AddPadding(sidebar, 10)

    -- Content Area
    local contentFrame = Create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -180, 1, -45),
        Position = UDim2.new(0, 180, 0, 45),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })

    local tabContainer = Create("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Parent = contentFrame
    })

    MakeDraggable(mainFrame, titleBar)

    -- Window Controls Logic
    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(mainFrame, {Size = UDim2.new(0, size.X.Offset, 0, 45)}, 0.3)
            sidebar.Visible = false; contentFrame.Visible = false
            minimizeBtn.Text = "+"
        else
            Tween(mainFrame, {Size = size}, 0.3)
            task.delay(0.3, function()
                sidebar.Visible = true; contentFrame.Visible = true
            end)
            minimizeBtn.Text = "−"
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        task.wait(0.3); gui:Destroy()
    end)

    -- Window Object
    local Window = {}
    Window.GUI = gui
    Window.MainFrame = mainFrame
    Window.Sidebar = sidebar
    Window.Content = contentFrame
    Window.TabContainer = tabContainer
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.Flags = {}

    -- ═══════════════════════════════════════════════════════════
    -- TAB CREATION (with rbxassetid icons)
    -- ═══════════════════════════════════════════════════════════

    function Window:Tab(tabData)
        tabData = tabData or {}
        local tabName = tabData.Name or "Tab"
        local tabIcon = tabData.Icon or NexusUI.Icons[1] -- default icon object
        local tabDesc = tabData.Description or ""

        -- Sidebar Button with ImageLabel Icon
        local tabBtn = Create("TextButton", {
            Name = tabName .. "_Btn",
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = currentTheme.BackgroundSecondary,
            BackgroundTransparency = 1,
            Text = "",
            Parent = Window.Sidebar
        })
        AddCorner(tabBtn, 8)

        -- rbxassetid Icon (ImageLabel)
        local iconImage = Create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 22, 0, 22),
            Position = UDim2.new(0, 10, 0.5, -11),
            BackgroundTransparency = 1,
            Image = "rbxassetid://" .. tabIcon.AssetId,
            ImageRectOffset = tabIcon.ImageRectOffset,
            ImageRectSize = tabIcon.ImageRectSize,
            ImageColor3 = currentTheme.TextDark,
            Parent = tabBtn
        })

        local nameLabel = Create("TextLabel", {
            Name = "Name",
            Size = UDim2.new(1, -42, 1, 0),
            Position = UDim2.new(0, 38, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = currentTheme.TextDark,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabBtn
        })

        -- Tab Content Frame
        local tabFrame = Create("ScrollingFrame", {
            Name = tabName .. "_Frame",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = currentTheme.Accent,
            Visible = false,
            Parent = Window.TabContainer
        })
        AddPadding(tabFrame, 12)

        local tabLayout = AddListLayout(tabFrame, 10)
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabFrame.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 24)
        end)

        -- Tab Logic
        local Tab = {}
        Tab.Name = tabName
        Tab.Button = tabBtn
        Tab.Frame = tabFrame
        Tab.Elements = {}

        function Tab:Select()
            if Window.CurrentTab then
                Window.CurrentTab.Frame.Visible = false
                Tween(Window.CurrentTab.Button, {BackgroundTransparency = 1}, 0.2)
                Window.CurrentTab.Button.NameLabel.TextColor3 = currentTheme.TextDark
                Window.CurrentTab.Button.Icon.ImageColor3 = currentTheme.TextDark
                local ind = Window.CurrentTab.Button:FindFirstChild("Indicator")
                if ind then ind:Destroy() end
            end

            Window.CurrentTab = Tab
            Tab.Frame.Visible = true
            Tween(tabBtn, {BackgroundTransparency = 0.3}, 0.2)
            nameLabel.TextColor3 = currentTheme.Text
            iconImage.ImageColor3 = currentTheme.Text

            local indicator = Create("Frame", {
                Name = "Indicator",
                Size = UDim2.new(0, 3, 0, 20),
                Position = UDim2.new(0, 0, 0.5, -10),
                BackgroundColor3 = currentTheme.Accent,
                BorderSizePixel = 0,
                Parent = tabBtn
            })
            AddCorner(indicator, 2)
        end

        tabBtn.MouseButton1Click:Connect(function() Tab:Select() end)
        tabBtn.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                Tween(tabBtn, {BackgroundTransparency = 0.5}, 0.2)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                Tween(tabBtn, {BackgroundTransparency = 1}, 0.2)
            end
        end)

        -- ═══════════════════════════════════════════════════════
        -- UI COMPONENTS
        -- ═══════════════════════════════════════════════════════

        function Tab:Section(sectionName)
            local sectionFrame = Create("Frame", {
                Name = sectionName .. "_Section",
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1,
                Parent = Tab.Frame
            })
            Create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = currentTheme.Accent,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = sectionFrame
            })
            Create("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 0, 22),
                BackgroundColor3 = currentTheme.Border,
                BorderSizePixel = 0,
                Parent = sectionFrame
            })
            return sectionFrame
        end

        -- Button with rbxassetid Icon
        function Tab:Button(data)
            data = data or {}
            local btnText = data.Text or "Button"
            local btnCallback = data.Callback or function() end
            local btnIcon = data.Icon or NexusUI.Icons[1]

            local btnFrame = Create("Frame", {
                Name = btnText .. "_Btn",
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = currentTheme.BackgroundSecondary,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                Parent = Tab.Frame
            })
            AddCorner(btnFrame, 8)
            AddStroke(btnFrame, currentTheme.Border, 1)

            local btn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                Parent = btnFrame
            })

            -- rbxassetid Icon
            Create("ImageLabel", {
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 10, 0.5, -9),
                BackgroundTransparency = 1,
                Image = "rbxassetid://" .. btnIcon.AssetId,
                ImageRectOffset = btnIcon.ImageRectOffset,
                ImageRectSize = btnIcon.ImageRectSize,
                ImageColor3 = currentTheme.Text,
                Parent = btnFrame
            })

            Create("TextLabel", {
                Size = UDim2.new(1, -50, 1, 0),
                Position = UDim2.new(0, 34, 0, 0),
                BackgroundTransparency = 1,
                Text = btnText,
                TextColor3 = currentTheme.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = btnFrame
            })

            local arrow = Create("TextLabel", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -28, 0.5, -10),
                BackgroundTransparency = 1,
                Text = "›",
                TextColor3 = currentTheme.TextDark,
                TextSize = 18,
                Font = Enum.Font.GothamBold,
                Parent = btnFrame
            })

            btn.MouseEnter:Connect(function()
                Tween(btnFrame, {BackgroundTransparency = 0.2}, 0.2)
                arrow.TextColor3 = currentTheme.Accent
            end)
            btn.MouseLeave:Connect(function()
                Tween(btnFrame, {BackgroundTransparency = 0.5}, 0.2)
                arrow.TextColor3 = currentTheme.TextDark
            end)
            btn.MouseButton1Down:Connect(function()
                Tween(btnFrame, {Size = UDim2.new(0.98, 0, 0, 36)}, 0.1)
            end)
            btn.MouseButton1Up:Connect(function()
                Tween(btnFrame, {Size = UDim2.new(1, 0, 0, 38)}, 0.1)
            end)
            btn.MouseButton1Click:Connect(function()
                btnCallback()
                NexusUI:Notify({Title = "Button Clicked", Message = btnText .. " activated!", Type = "Success", Duration = 2})
            end)
            return btnFrame
        end

        function Tab:Toggle(data)
            data = data or {}
            local toggleText = data.Text or "Toggle"
            local toggleDefault = data.Default or false
            local toggleFlag = data.Flag or nil
            local toggleCallback = data.Callback or function() end

            local toggleFrame = Create("Frame", {
                Name = toggleText .. "_Toggle",
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = currentTheme.BackgroundSecondary,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                Parent = Tab.Frame
            })
            AddCorner(toggleFrame, 8)
            AddStroke(toggleFrame, currentTheme.Border, 1)

            local label = Create("TextLabel", {
                Size = UDim2.new(1, -70, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = toggleText,
                TextColor3 = currentTheme.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = toggleFrame
            })

            local toggleBg = Create("Frame", {
                Name = "ToggleBg",
                Size = UDim2.new(0, 44, 0, 22),
                Position = UDim2.new(1, -56, 0.5, -11),
                BackgroundColor3 = currentTheme.Border,
                BorderSizePixel = 0,
                Parent = toggleFrame
            })
            AddCorner(toggleBg, 11)

            local toggleCircle = Create("Frame", {
                Name = "Circle",
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 2, 0.5, -9),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Parent = toggleBg
            })
            AddCorner(toggleCircle, 9)

            local state = toggleDefault
            local function UpdateToggle()
                if state then
                    Tween(toggleBg, {BackgroundColor3 = currentTheme.Accent}, 0.2)
                    Tween(toggleCircle, {Position = UDim2.new(0, 24, 0.5, -9)}, 0.2)
                    label.TextColor3 = currentTheme.AccentLight
                else
                    Tween(toggleBg, {BackgroundColor3 = currentTheme.Border}, 0.2)
                    Tween(toggleCircle, {Position = UDim2.new(0, 2, 0.5, -9)}, 0.2)
                    label.TextColor3 = currentTheme.Text
                end
                toggleCallback(state)
                if toggleFlag then Window.Flags[toggleFlag] = state end
            end

            if state then
                toggleBg.BackgroundColor3 = currentTheme.Accent
                toggleCircle.Position = UDim2.new(0, 24, 0.5, -9)
                label.TextColor3 = currentTheme.AccentLight
            end

            local clickArea = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                Parent = toggleFrame
            })
            clickArea.MouseButton1Click:Connect(function()
                state = not state; UpdateToggle()
            end)
            clickArea.MouseEnter:Connect(function()
                Tween(toggleFrame, {BackgroundTransparency = 0.2}, 0.2)
            end)
            clickArea.MouseLeave:Connect(function()
                Tween(toggleFrame, {BackgroundTransparency = 0.5}, 0.2)
            end)

            if toggleFlag then Window.Flags[toggleFlag] = state end

            local ToggleObj = {}
            function ToggleObj:Set(value) state = value; UpdateToggle() end
            function ToggleObj:Get() return state end
            return ToggleObj
        end

        function Tab:Slider(data)
            data = data or {}
            local sliderText = data.Text or "Slider"
            local sliderMin = data.Min or 0
            local sliderMax = data.Max or 100
            local sliderDefault = data.Default or sliderMin
            local sliderIncrement = data.Increment or 1
            local sliderFlag = data.Flag or nil
            local sliderSuffix = data.Suffix or ""
            local sliderCallback = data.Callback or function() end

            local sliderFrame = Create("Frame", {
                Name = sliderText .. "_Slider",
                Size = UDim2.new(1, 0, 0, 55),
                BackgroundColor3 = currentTheme.BackgroundSecondary,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                Parent = Tab.Frame
            })
            AddCorner(sliderFrame, 8)
            AddStroke(sliderFrame, currentTheme.Border, 1)

            Create("TextLabel", {
                Size = UDim2.new(0.5, 0, 0, 20),
                Position = UDim2.new(0, 12, 0, 5),
                BackgroundTransparency = 1,
                Text = sliderText,
                TextColor3 = currentTheme.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = sliderFrame
            })

            local valueLabel = Create("TextLabel", {
                Size = UDim2.new(0, 60, 0, 20),
                Position = UDim2.new(1, -68, 0, 5),
                BackgroundColor3 = currentTheme.Background,
                BackgroundTransparency = 0.5,
                Text = tostring(sliderDefault) .. sliderSuffix,
                TextColor3 = currentTheme.Accent,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                Parent = sliderFrame
            })
            AddCorner(valueLabel, 4)

            local sliderBg = Create("Frame", {
                Name = "SliderBg",
                Size = UDim2.new(1, -24, 0, 6),
                Position = UDim2.new(0, 12, 0, 32),
                BackgroundColor3 = currentTheme.Border,
                BorderSizePixel = 0,
                Parent = sliderFrame
            })
            AddCorner(sliderBg, 3)

            local sliderFill = Create("Frame", {
                Name = "SliderFill",
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = currentTheme.Accent,
                BorderSizePixel = 0,
                Parent = sliderBg
            })
            AddCorner(sliderFill, 3)
            AddGradient(sliderFill, currentTheme.GradientStart, currentTheme.GradientEnd)

            local sliderKnob = Create("Frame", {
                Name = "Knob",
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(0, -7, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Parent = sliderFill
            })
            AddCorner(sliderKnob, 7)
            AddShadow(sliderKnob, 2)

            local value = sliderDefault
            local dragging = false

            local function UpdateSlider(input)
                local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                local calcValue = sliderMin + (pos * (sliderMax - sliderMin))
                calcValue = math.floor(calcValue / sliderIncrement + 0.5) * sliderIncrement
                calcValue = math.clamp(calcValue, sliderMin, sliderMax)
                value = calcValue
                local percent = (value - sliderMin) / (sliderMax - sliderMin)
                sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                valueLabel.Text = tostring(value) .. sliderSuffix
                sliderCallback(value)
                if sliderFlag then Window.Flags[sliderFlag] = value end
            end

            local initPercent = (sliderDefault - sliderMin) / (sliderMax - sliderMin)
            sliderFill.Size = UDim2.new(initPercent, 0, 1, 0)

            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; UpdateSlider(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            if sliderFlag then Window.Flags[sliderFlag] = value end

            local SliderObj = {}
            function SliderObj:Set(val)
                value = math.clamp(val, sliderMin, sliderMax)
                local percent = (value - sliderMin) / (sliderMax - sliderMin)
                sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                valueLabel.Text = tostring(value) .. sliderSuffix
                sliderCallback(value)
            end
            function SliderObj:Get() return value end
            return SliderObj
        end

        function Tab:Dropdown(data)
            data = data or {}
            local dropText = data.Text or "Dropdown"
            local dropOptions = data.Options or {}
            local dropDefault = data.Default or nil
            local dropFlag = data.Flag or nil
            local dropCallback = data.Callback or function() end

            local dropFrame = Create("Frame", {
                Name = dropText .. "_Dropdown",
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = currentTheme.BackgroundSecondary,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Parent = Tab.Frame
            })
            AddCorner(dropFrame, 8)
            AddStroke(dropFrame, currentTheme.Border, 1)

            Create("TextLabel", {
                Size = UDim2.new(1, -50, 0, 38),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = dropText,
                TextColor3 = currentTheme.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = dropFrame
            })

            local selectedLabel = Create("TextLabel", {
                Size = UDim2.new(0, 120, 0, 24),
                Position = UDim2.new(1, -140, 0, 7),
                BackgroundColor3 = currentTheme.Background,
                BackgroundTransparency = 0.5,
                Text = dropDefault or "Select...",
                TextColor3 = currentTheme.Accent,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                Parent = dropFrame
            })
            AddCorner(selectedLabel, 4)

            local arrow = Create("TextLabel", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -24, 0, 9),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = currentTheme.TextDark,
                TextSize = 10,
                Font = Enum.Font.GothamBold,
                Parent = dropFrame
            })

            local optionsFrame = Create("Frame", {
                Name = "Options",
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 38),
                BackgroundTransparency = 1,
                Parent = dropFrame
            })
            AddListLayout(optionsFrame, 2)
            AddPadding(optionsFrame, 12)
            optionsFrame.Padding.Bottom = UDim.new(0, 8)

            local selected = dropDefault
            local open = false

            for _, option in ipairs(dropOptions) do
                local optBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundColor3 = currentTheme.Background,
                    BackgroundTransparency = 0.8,
                    Text = option,
                    TextColor3 = currentTheme.TextDark,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    Parent = optionsFrame
                })
                AddCorner(optBtn, 4)
                optBtn.MouseEnter:Connect(function()
                    Tween(optBtn, {BackgroundTransparency = 0.5, TextColor3 = currentTheme.Text}, 0.15)
                end)
                optBtn.MouseLeave:Connect(function()
                    Tween(optBtn, {BackgroundTransparency = 0.8, TextColor3 = currentTheme.TextDark}, 0.15)
                end)
                optBtn.MouseButton1Click:Connect(function()
                    selected = option; selectedLabel.Text = option
                    dropCallback(option)
                    if dropFlag then Window.Flags[dropFlag] = option end
                    open = false
                    Tween(dropFrame, {Size = UDim2.new(1, 0, 0, 38)}, 0.2)
                    arrow.Text = "▼"
                end)
            end

            local clickArea = Create("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundTransparency = 1,
                Text = "",
                Parent = dropFrame
            })
            clickArea.MouseButton1Click:Connect(function()
                open = not open
                if open then
                    local optsHeight = #dropOptions * 30 + 10
                    Tween(dropFrame, {Size = UDim2.new(1, 0, 0, 38 + optsHeight)}, 0.2)
                    arrow.Text = "▲"
                else
                    Tween(dropFrame, {Size = UDim2.new(1, 0, 0, 38)}, 0.2)
                    arrow.Text = "▼"
                end
            end)

            if dropFlag then Window.Flags[dropFlag] = selected end
            local DropdownObj = {}
            function DropdownObj:Set(value) selected = value; selectedLabel.Text = value; dropCallback(value) end
            function DropdownObj:Get() return selected end
            return DropdownObj
        end

        function Tab:Input(data)
            data = data or {}
            local inputText = data.Text or "Input"
            local inputDefault = data.Default or ""
            local inputPlaceholder = data.Placeholder or "Type here..."
            local inputFlag = data.Flag or nil
            local inputCallback = data.Callback or function() end

            local inputFrame = Create("Frame", {
                Name = inputText .. "_Input",
                Size = UDim2.new(1, 0, 0, 65),
                BackgroundColor3 = currentTheme.BackgroundSecondary,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                Parent = Tab.Frame
            })
            AddCorner(inputFrame, 8)
            AddStroke(inputFrame, currentTheme.Border, 1)

            Create("TextLabel", {
                Size = UDim2.new(1, -20, 0, 20),
                Position = UDim2.new(0, 10, 0, 5),
                BackgroundTransparency = 1,
                Text = inputText,
                TextColor3 = currentTheme.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = inputFrame
            })

            local textBox = Create("TextBox", {
                Size = UDim2.new(1, -20, 0, 28),
                Position = UDim2.new(0, 10, 0, 30),
                BackgroundColor3 = currentTheme.Background,
                BackgroundTransparency = 0.5,
                Text = inputDefault,
                PlaceholderText = inputPlaceholder,
                PlaceholderColor3 = currentTheme.TextDark,
                TextColor3 = currentTheme.Text,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                ClearTextOnFocus = false,
                Parent = inputFrame
            })
            AddCorner(textBox, 6)

            textBox.Focused:Connect(function()
                Tween(textBox, {BackgroundTransparency = 0.2}, 0.2)
                AddStroke(textBox, currentTheme.Accent, 1)
            end)
            textBox.FocusLost:Connect(function()
                Tween(textBox, {BackgroundTransparency = 0.5}, 0.2)
                local stroke = textBox:FindFirstChildOfClass("UIStroke")
                if stroke then stroke:Destroy() end
                inputCallback(textBox.Text)
                if inputFlag then Window.Flags[inputFlag] = textBox.Text end
            end)

            if inputFlag then Window.Flags[inputFlag] = inputDefault end
            local InputObj = {}
            function InputObj:Set(text) textBox.Text = text; inputCallback(text) end
            function InputObj:Get() return textBox.Text end
            return InputObj
        end

        function Tab:Keybind(data)
            data = data or {}
            local bindText = data.Text or "Keybind"
            local bindDefault = data.Default or "None"
            local bindFlag = data.Flag or nil
            local bindCallback = data.Callback or function() end

            local bindFrame = Create("Frame", {
                Name = bindText .. "_Keybind",
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = currentTheme.BackgroundSecondary,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                Parent = Tab.Frame
            })
            AddCorner(bindFrame, 8)
            AddStroke(bindFrame, currentTheme.Border, 1)

            Create("TextLabel", {
                Size = UDim2.new(1, -100, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = bindText,
                TextColor3 = currentTheme.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = bindFrame
            })

            local bindBtn = Create("TextButton", {
                Size = UDim2.new(0, 80, 0, 26),
                Position = UDim2.new(1, -92, 0.5, -13),
                BackgroundColor3 = currentTheme.Background,
                BackgroundTransparency = 0.5,
                Text = bindDefault,
                TextColor3 = currentTheme.Accent,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                Parent = bindFrame
            })
            AddCorner(bindBtn, 6)

            local listening = false
            bindBtn.MouseButton1Click:Connect(function()
                listening = true
                bindBtn.Text = "..."
                bindBtn.TextColor3 = currentTheme.Warning
            end)

            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if listening and not gameProcessed then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        local keyName = input.KeyCode.Name
                        bindBtn.Text = keyName
                        bindBtn.TextColor3 = currentTheme.Accent
                        listening = false
                        bindCallback(keyName)
                        if bindFlag then Window.Flags[bindFlag] = keyName end
                    end
                elseif not listening and not gameProcessed then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode.Name == bindBtn.Text then
                            bindCallback(bindBtn.Text)
                        end
                    end
                end
            end)

            if bindFlag then Window.Flags[bindFlag] = bindDefault end
            local BindObj = {}
            function BindObj:Set(key) bindBtn.Text = key; bindCallback(key) end
            function BindObj:Get() return bindBtn.Text end
            return BindObj
        end

        function Tab:ColorPicker(data)
            data = data or {}
            local pickerText = data.Text or "Color"
            local pickerDefault = data.Default or Color3.fromRGB(99, 102, 241)
            local pickerFlag = data.Flag or nil
            local pickerCallback = data.Callback or function() end

            local pickerFrame = Create("Frame", {
                Name = pickerText .. "_Color",
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = currentTheme.BackgroundSecondary,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                Parent = Tab.Frame
            })
            AddCorner(pickerFrame, 8)
            AddStroke(pickerFrame, currentTheme.Border, 1)

            Create("TextLabel", {
                Size = UDim2.new(1, -60, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                BackgroundTransparency = 1,
                Text = pickerText,
                TextColor3 = currentTheme.Text,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = pickerFrame
            })

            local colorPreview = Create("Frame", {
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(1, -42, 0.5, -15),
                BackgroundColor3 = pickerDefault,
                BorderSizePixel = 0,
                Parent = pickerFrame
            })
            AddCorner(colorPreview, 6)
            AddStroke(colorPreview, currentTheme.Border, 1)

            local colorBtn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                Parent = pickerFrame
            })

            local currentColor = pickerDefault
            local colors = {
                Color3.fromRGB(99, 102, 241),
                Color3.fromRGB(239, 68, 68),
                Color3.fromRGB(34, 197, 94),
                Color3.fromRGB(234, 179, 8),
                Color3.fromRGB(168, 85, 247),
                Color3.fromRGB(56, 189, 248),
            }

            colorBtn.MouseButton1Click:Connect(function()
                for i, c in ipairs(colors) do
                    if c == currentColor then
                        currentColor = colors[i % #colors + 1]
                        break
                    end
                end
                if currentColor == pickerDefault then currentColor = colors[2] end
                Tween(colorPreview, {BackgroundColor3 = currentColor}, 0.3)
                pickerCallback(currentColor)
                if pickerFlag then Window.Flags[pickerFlag] = currentColor end
            end)

            if pickerFlag then Window.Flags[pickerFlag] = pickerDefault end
            local PickerObj = {}
            function PickerObj:Set(color) currentColor = color; colorPreview.BackgroundColor3 = color; pickerCallback(color) end
            function PickerObj:Get() return currentColor end
            return PickerObj
        end

        function Tab:Label(data)
            data = data or {}
            local labelText = data.Text or "Label"
            local labelColor = data.Color or currentTheme.TextDark

            local labelFrame = Create("Frame", {
                Name = labelText .. "_Label",
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Parent = Tab.Frame
            })

            local label = Create("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = labelText,
                TextColor3 = labelColor,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Parent = labelFrame
            })

            local LabelObj = {}
            function LabelObj:Set(text) label.Text = text end
            function LabelObj:Get() return label.Text end
            return LabelObj
        end

        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then Tab:Select() end
        return Tab
    end

    -- Window Methods
    function Window:SelectTab(tabName)
        for _, tab in pairs(self.Tabs) do
            if tab.Name == tabName then tab:Select(); return end
        end
    end
    function Window:GetFlag(flag) return self.Flags[flag] end
    function Window:SetFlag(flag, value) self.Flags[flag] = value end
    function Window:Destroy() self.GUI:Destroy() end
    function Window:ToggleVisibility() self.MainFrame.Visible = not self.MainFrame.Visible end

    return Window
end

return NexusUI
