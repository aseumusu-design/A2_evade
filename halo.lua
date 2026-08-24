-- // ============================================================
-- // 🔥 EVADE HUB – ORION UI (NO MERCY STYLE)
-- // ============================================================

-- // ========== 1. ICON & SETUP ==========
local ICON = {
    Info     = "rbxassetid://7733964719",
    User     = "rbxassetid://7743875962",
    Eye      = "rbxassetid://7733774602",
    Zap      = "rbxassetid://7733771628",
    Settings = "rbxassetid://7734053495",
    Logo     = "rbxassetid://102609928046926",
}

local function GetHolder()
    return (gethui and gethui()) or game:GetService("CoreGui")
end

local function VD_Notify(title, content, duration)
    pcall(function()
        if OrionLib and OrionLib.MakeNotification then
            OrionLib:MakeNotification({ Name = title, Content = content, Image = ICON.Logo, Time = duration or 3 })
        else
            print("[EVADE HUB] " .. title .. " - " .. content)
        end
    end)
end

local function FindMainWindow()
    local root = GetHolder()
    if not root then return nil end
    local marv = root:FindFirstChild("MarV")
    if not marv then return nil end
    for _, child in ipairs(marv:GetChildren()) do
        if child:IsA("Frame") and child.AbsoluteSize.X > 300 then
            return child
        end
    end
    return nil
end

-- // ========== 2. LOAD ORION UI ==========
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Marpiii/UiLib/refs/heads/main/source.lua"))()
local onCloseRequest

local Window = OrionLib:MakeWindow({
    Name = "🔥 EVADE HUB",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "EvadeHubOrion",
    IntroEnabled = true,
    IntroText = "EVADE HUB",
    IntroIcon = ICON.Logo,
    Icon = ICON.Logo,
    CloseCallback = function()
        if onCloseRequest then onCloseRequest() end
    end,
})

local mainWin = FindMainWindow()
if mainWin then mainWin.Visible = false end

-- // ========== 3. BUBBLE TOGGLE & CONFIRM CLOSE ==========
local bubbleGui = nil
local function makeBubble()
    if bubbleGui then bubbleGui:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "EvadeBubble"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.Parent = GetHolder()
    if syn and syn.protect_gui then pcall(syn.protect_gui, gui) end

    local btn = Instance.new("ImageButton")
    btn.Parent = gui
    btn.BackgroundColor3 = Color3.fromRGB(25, 30, 35)
    btn.Position = UDim2.new(0.02, 0, 0.2, 0)
    btn.Size = UDim2.fromOffset(48, 48)
    btn.Image = ICON.Logo
    btn.ScaleType = Enum.ScaleType.Fit
    btn.Active = true
    btn.Draggable = true
    btn.ZIndex = 10

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 100, 50)
    stroke.Thickness = 2
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local main = FindMainWindow()
        if main then main.Visible = true end
        bubbleGui:Destroy()
        bubbleGui = nil
    end)
    bubbleGui = gui
end

local function closeUI()
    local main = FindMainWindow()
    if main then main.Visible = false end
    makeBubble()
end

local function showUI()
    local main = FindMainWindow()
    if main then main.Visible = true end
end

local function confirmClose(fromCloseBtn)
    if fromCloseBtn then showUI() end
    local holder = GetHolder()
    local gui = Instance.new("ScreenGui")
    gui.Name = "EvadeConfirm"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.Parent = holder
    if syn and syn.protect_gui then pcall(syn.protect_gui, gui) end

    local fade = Instance.new("Frame")
    fade.Size = UDim2.new(1, 0, 1, 0)
    fade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    fade.BackgroundTransparency = 0.4
    fade.ZIndex = 99
    fade.Parent = gui

    local box = Instance.new("Frame")
    box.Size = UDim2.fromOffset(280, 150)
    box.Position = UDim2.new(0.5, 0, 0.5, 0)
    box.AnchorPoint = Vector2.new(0.5, 0.5)
    box.BackgroundColor3 = Color3.fromRGB(28, 32, 38)
    box.BorderSizePixel = 0
    box.ZIndex = 100
    box.Parent = gui

    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0, 20, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = "Tutup EVADE HUB?"
    title.TextColor3 = Color3.fromRGB(240, 240, 240)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.ZIndex = 101
    title.Parent = box

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -40, 0, 30)
    desc.Position = UDim2.new(0, 20, 0, 48)
    desc.BackgroundTransparency = 1
    desc.Text = "Klik bubble untuk buka lagi."
    desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    desc.TextSize = 14
    desc.Font = Enum.Font.Gotham
    desc.ZIndex = 101
    desc.Parent = box

    local function destroy() gui:Destroy() end
    local function cancel() destroy(); if fromCloseBtn then showUI() end end

    local btnYa = Instance.new("TextButton")
    btnYa.Size = UDim2.fromOffset(90, 36)
    btnYa.Position = UDim2.new(1, -200, 1, -50)
    btnYa.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
    btnYa.Text = "Ya"
    btnYa.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnYa.Font = Enum.Font.GothamBold
    btnYa.ZIndex = 101
    btnYa.Parent = box
    Instance.new("UICorner", btnYa).CornerRadius = UDim.new(0, 8)
    btnYa.MouseButton1Click:Connect(function() destroy(); closeUI() end)

    local btnTidak = Instance.new("TextButton")
    btnTidak.Size = UDim2.fromOffset(90, 36)
    btnTidak.Position = UDim2.new(1, -100, 1, -50)
    btnTidak.BackgroundColor3 = Color3.fromRGB(40, 45, 52)
    btnTidak.Text = "Tidak"
    btnTidak.TextColor3 = Color3.fromRGB(240, 240, 240)
    btnTidak.Font = Enum.Font.GothamBold
    btnTidak.ZIndex = 101
    btnTidak.Parent = box
    Instance.new("UICorner", btnTidak).CornerRadius = UDim.new(0, 8)
    btnTidak.MouseButton1Click:Connect(cancel)
end

onCloseRequest = function() confirmClose(true) end

task.spawn(function()
    task.wait(0.2)
    local m = FindMainWindow()
    if m then m.Visible = true end
end)

-- // ========== 4. SETUP GAME ==========
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

-- // ========== 5. REMOTE REFERENCES ==========
local ActionRemote = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Action")
local InteractRemote = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Interact")
local CharacterTaskRemote = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("CharacterTask")
local SetPlayerModeRemote = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("SetPlayerMode")
local CollectiblesInvoke = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Collectibles") and ReplicatedStorage.Events.Collectibles:FindFirstChild("Invoke")

-- // ========== 6. VARIABEL FITUR ==========
-- AFK Farm & Auto Item
local AfkFarmEnabled = false
local AutoItemEnabled = false
local originalPosition = nil
local noItemTimer = 0
local savedAfkState = false
local savedCollectState = false

-- Speed & Jump
local SpeedEnabled = false
local JumpEnabled = false
local walkSpeedValue = 50
local jumpPowerValue = 80

-- Fly
local FlyEnabled = false
local flySpeedValue = 80
local flying = false
local bodyVelocity = nil
local bodyGyro = nil

-- Lainnya
local NoClipEnabled = false
local AntiAFKEnabled = false
local AutoRespawnEnabled = false
local GodModeEnabled = false
local FullBrightEnabled = false
local AutoReviveEnabled = false
local AutoCollectEnabled = false
local InfiniteJumpEnabled = false
local InfiniteJumpConnection = nil

-- Auto Heal
local AutoHealEnabled = false
local healThreshold = 40

-- ESP
local ESPEnabled = false
local ESPPlayerEnabled = false
local ESPBotEnabled = false
local ESPObjects = {}

-- // ========== 7. UTILITY FUNCTIONS ==========
local function isPlayerAsset(instance)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and instance:IsDescendantOf(player.Character) then
            return true
        end
    end
    return false
end

local function getAllItems()
    local items = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Model")) then
            local nameLower = string.lower(v.Name)
            if string.find(nameLower, "bubble") or string.find(nameLower, "coconut") then
                local isVisualEffect = v:FindFirstChildWhichIsA("ParticleEmitter") 
                                    or v:FindFirstChildWhichIsA("Trail") 
                                    or v:FindFirstChildWhichIsA("Beam")
                                    or v.ClassName == "Accessory"
                local hasAnimation = v:FindFirstChildWhichIsA("Animation") or v:FindFirstChildWhichIsA("Animator")
                
                if not isVisualEffect and not hasAnimation and not isPlayerAsset(v) then
                    local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")
                    if part then
                        table.insert(items, part)
                    end
                end
            end
        end
    end
    return items
end

local function isNextbotNear(position)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:GetAttribute("Nextbot") == true then
            local root = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
            if root then
                local distance = (position - root.Position).Magnitude
                if distance <= 12 then 
                    return true
                end
            end
        end
    end
    return false
end

local function getClosestSafeItem(hrp, items)
    local closest, minDst = nil, math.huge
    for _, part in ipairs(items) do
        local dst = (hrp.Position - part.Position).Magnitude
        if dst < minDst and not isNextbotNear(part.Position) then
            closest = part
            minDst = dst
        end
    end
    return closest
end

local function teleportTo(hrp, pos, duration)
    local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

-- // ========== 8. AUTO REVIVE ==========
local function autoRevive()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end

    local isDead = humanoid.Health <= 0
    local isDowned = char:GetAttribute("Downed") == true

    if isDead or isDowned then
        if ActionRemote then
            pcall(function() ActionRemote:FireServer("Revive") end)
            pcall(function() ActionRemote:FireServer("Respawn") end)
        end
        if InteractRemote then
            pcall(function() InteractRemote:FireServer("Revive") end)
        end
        if CharacterTaskRemote then
            pcall(function() CharacterTaskRemote:FireServer("Revive") end)
        end
        if SetPlayerModeRemote then
            pcall(function() SetPlayerModeRemote:FireServer(true) end)
        end

        local reviveGui = LocalPlayer.PlayerGui:FindFirstChild("Game")
        if reviveGui then
            local respawnBtn = reviveGui:FindFirstChild("Respawn")
            if respawnBtn then
                for _, btn in pairs(respawnBtn:GetDescendants()) do
                    if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                        pcall(function() btn:Fire() end)
                        break
                    end
                end
            end
        end

        task.wait(0.5)
        pcall(function() LocalPlayer:LoadCharacter() end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        if AutoReviveEnabled then
            autoRevive()
        end
    end
end)

-- // ========== 9. AUTO HEAL ==========
local function autoHeal()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end

    local health = humanoid.Health
    local maxHealth = humanoid.MaxHealth

    if health <= 0 then return end
    if health / maxHealth * 100 > healThreshold then return end

    -- Coba remote Action dengan "Heal"
    if ActionRemote then
        pcall(function() ActionRemote:FireServer("Heal") end)
        pcall(function() ActionRemote:FireServer("HealMe") end)
        pcall(function() ActionRemote:FireServer("HealSelf") end)
    end

    -- Coba Interact
    if InteractRemote then
        pcall(function() InteractRemote:FireServer("Heal") end)
    end

    -- Cari tombol heal di GUI
    local gameGui = LocalPlayer.PlayerGui:FindFirstChild("Game")
    if gameGui then
        for _, btn in pairs(gameGui:GetDescendants()) do
            if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                local text = string.lower(btn.Text or "")
                if string.find(text, "heal") or string.find(text, "med") then
                    pcall(function() btn:Fire() end)
                    break
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        if AutoHealEnabled then
            autoHeal()
        end
    end
end)

-- // ========== 10. AUTO COLLECT ==========
local function autoCollect()
    if not CollectiblesInvoke then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local items = getAllItems()
    if #items == 0 then return end
    
    local item = getClosestSafeItem(hrp, items)
    if item then
        local startPos = hrp.Position
        hrp.Anchored = false
        teleportTo(hrp, item.Position, 0.2)
        pcall(function()
            local collectId = item.Parent:GetAttribute("Id") or item:GetAttribute("Id") or "a19ac91bff904b7385e826fd6a23dc01"
            CollectiblesInvoke:InvokeServer(LocalPlayer, collectId, "Collect")
        end)
        task.wait(0.3)
        teleportTo(hrp, startPos, 0.2)
    end
end

task.spawn(function()
    while true do
        task.wait(1)
        if AutoCollectEnabled then
            autoCollect()
        end
    end
end)

-- // ========== 11. AFK FARM & AUTO ITEM ==========
task.spawn(function()
    while true do
        local items = getAllItems()
        local char = LocalPlayer.Character
        local isDowned = char and char:GetAttribute("Downed")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if #items == 0 then
            noItemTimer = noItemTimer + 0.5
            if noItemTimer >= 20 then
                if AfkFarmEnabled then
                    AfkFarmEnabled = false
                    savedAfkState = false
                    if hrp then hrp.Anchored = false end
                    updateMiniGui()
                end
            end
        else
            if noItemTimer >= 20 and savedAfkState and not isDowned then
                task.wait(1)
                if hrp then
                    AfkFarmEnabled = true
                    originalPosition = hrp.Position + Vector3.new(0, 200, 0)
                    hrp.CFrame = CFrame.new(originalPosition)
                    task.wait(0.1)
                    hrp.Anchored = true
                    updateMiniGui()
                end
            end
            noItemTimer = 0
        end

        if AutoItemEnabled and not isDowned and #items > 0 then
            if hrp then
                local item = getClosestSafeItem(hrp, items)
                if item then
                    local startPos = hrp.Position
                    hrp.Anchored = false
                    
                    teleportTo(hrp, item.Position, 0.2)
                    
                    pcall(function()
                        local collectId = item.Parent:GetAttribute("Id") or item:GetAttribute("Id") or "a19ac91bff904b7385e826fd6a23dc01"
                        CollectiblesInvoke:InvokeServer(LocalPlayer, collectId, "Collect")
                    end)
                    
                    task.wait(1)
                    isDowned = char and char:GetAttribute("Downed")
                    
                    if AutoItemEnabled and not isDowned and noItemTimer < 20 then
                        if AfkFarmEnabled and originalPosition then
                            teleportTo(hrp, originalPosition, 0.2)
                            hrp.Anchored = true
                        else
                            teleportTo(hrp, startPos, 0.2)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        local char = LocalPlayer.Character
        local isDowned = char and char:GetAttribute("Downed")
        
        if AfkFarmEnabled and not AutoItemEnabled and not isDowned and noItemTimer < 20 then
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and hrp.Anchored == false then
                originalPosition = hrp.Position + Vector3.new(0, 200, 0)
                hrp.CFrame = CFrame.new(originalPosition)
                task.wait(0.1)
                hrp.Anchored = true
            end
        end
    end
end)

local function setupCharacter(char)
    char:GetAttributeChangedSignal("Downed"):Connect(function()
        local isDowned = char:GetAttribute("Downed")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if isDowned then
            AutoItemEnabled = false
            AfkFarmEnabled = false
            savedAfkState = false
            savedCollectState = false
            if hrp then hrp.Anchored = false end
            updateMiniGui()
        else
            task.wait(1)
            if hrp then
                originalPosition = hrp.Position + Vector3.new(0, 200, 0)
                hrp.CFrame = CFrame.new(originalPosition)
                task.wait(0.2)
                hrp.Anchored = true
                
                AfkFarmEnabled = savedAfkState
                AutoItemEnabled = savedCollectState
                updateMiniGui()
            end
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    setupCharacter(char)
end)

if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end

-- // ========== 12. FLY ==========
local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    if not root or not humanoid or flying then return end
    flying = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 10^6
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = root
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 10^6
    bodyGyro.CFrame = root.CFrame
    bodyGyro.Parent = root
    humanoid.PlatformStand = true
end

local function stopFly()
    if not flying then return end
    flying = false
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.PlatformStand = false
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if not flying then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        local camera = workspace.CurrentCamera
        if camera and bodyVelocity then
            bodyVelocity.Velocity = camera.CFrame.LookVector * flySpeedValue
        end
        if bodyGyro and camera then
            bodyGyro.CFrame = camera.CFrame
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F and FlyEnabled then
        if flying then stopFly() else startFly() end
    end
end)

-- // ========== 13. SPEED & JUMP ==========
local function applySpeed()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = SpeedEnabled and walkSpeedValue or 16
    end
end

local function applyJump()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = JumpEnabled and jumpPowerValue or 50
    end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        applySpeed()
        applyJump()
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applySpeed()
    applyJump()
end)

-- // ========== 14. NO CLIP ==========
task.spawn(function()
    while true do
        task.wait(0.5)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CanCollide = not NoClipEnabled
        end
    end
end)

-- // ========== 15. ANTI AFK ==========
task.spawn(function()
    while true do
        task.wait(30)
        if AntiAFKEnabled then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0, 0))
            end)
        end
    end
end)

-- // ========== 16. AUTO RESPAWN ==========
task.spawn(function()
    while true do
        task.wait(2)
        if AutoRespawnEnabled then
            local char = LocalPlayer.Character
            if not char or not char.Parent then
                LocalPlayer:LoadCharacter()
            end
        end
    end
end)

-- // ========== 17. GOD MODE ==========
task.spawn(function()
    while true do
        task.wait(0.5)
        if GodModeEnabled then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.MaxHealth = math.huge
                char.Humanoid.Health = math.huge
                char.Humanoid.BreakJointsOnDeath = false
            end
        end
    end
end)

-- // ========== 18. FULL BRIGHT ==========
task.spawn(function()
    while true do
        task.wait(0.5)
        if FullBrightEnabled then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 12
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
        else
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").FogEnd = 1000
            game:GetService("Lighting").GlobalShadows = true
        end
    end
end)

-- // ========== 19. SERVER HOP ==========
local function hopServer()
    local placeId = game.PlaceId
    local servers = {}
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(servers, v)
        end
    end
    if #servers > 0 then
        local server = servers[math.random(1, #servers)]
        if server and server.Team then
            TeleportService:TeleportToPlaceInstance(placeId, server.Team, LocalPlayer)
        end
    end
end

-- // ========== 20. REDEEM CODES ==========
local function redeemAllCodes()
    local redeemGui = LocalPlayer.PlayerGui:FindFirstChild("RedeemGui") or LocalPlayer.PlayerGui:FindFirstChild("CodeGui")
    if redeemGui then
        for _, btn in pairs(redeemGui:GetDescendants()) do
            if btn:IsA("TextButton") and string.find(string.lower(btn.Text or ""), "redeem") then
                pcall(function() btn:Fire() end)
                return
            end
        end
    end
end

-- // ========== 21. ESP (PLAYER & BOT) ==========
local function clearESP()
    for _, obj in ipairs(ESPObjects) do
        pcall(function()
            if obj.Box then obj.Box:Destroy() end
            if obj.Billboard then obj.Billboard:Destroy() end
        end)
    end
    ESPObjects = {}
end

local function updateESP()
    clearESP()
    if not ESPEnabled then return end

    if ESPPlayerEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local box = Instance.new("BoxHandleAdornment")
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Size = Vector3.new(4, 6, 2)
                    box.Adornee = root
                    box.Color3 = Color3.fromRGB(0, 255, 0)
                    box.Transparency = 0.5
                    box.Parent = root

                    local bill = Instance.new("BillboardGui")
                    bill.AlwaysOnTop = true
                    bill.Size = UDim2.new(0, 200, 0, 30)
                    bill.Adornee = root
                    bill.Parent = root
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = player.Name
                    label.TextColor3 = Color3.fromRGB(0, 255, 0)
                    label.Font = Enum.Font.GothamBold
                    label.TextSize = 14
                    label.TextStrokeTransparency = 0.5
                    label.Parent = bill

                    table.insert(ESPObjects, {Box = box, Billboard = bill})
                end
            end
        end
    end

    if ESPBotEnabled then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:GetAttribute("Nextbot") == true then
                local root = v:FindFirstChild("HumanoidRootPart")
                if root then
                    local box = Instance.new("BoxHandleAdornment")
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Size = Vector3.new(4, 6, 2)
                    box.Adornee = root
                    box.Color3 = Color3.fromRGB(255, 0, 0)
                    box.Transparency = 0.5
                    box.Parent = root

                    local bill = Instance.new("BillboardGui")
                    bill.AlwaysOnTop = true
                    bill.Size = UDim2.new(0, 200, 0, 30)
                    bill.Adornee = root
                    bill.Parent = root
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = "🤖 BOT"
                    label.TextColor3 = Color3.fromRGB(255, 100, 100)
                    label.Font = Enum.Font.GothamBold
                    label.TextSize = 14
                    label.TextStrokeTransparency = 0.5
                    label.Parent = bill

                    table.insert(ESPObjects, {Box = box, Billboard = bill})
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(updateESP)
Players.PlayerRemoving:Connect(updateESP)
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    updateESP()
end)

task.spawn(function()
    while true do
        task.wait(2)
        if ESPEnabled then
            updateESP()
        end
    end
end)

-- // ========== 22. MINI GUI ==========
local miniGui = nil
local function createMiniGui()
    if miniGui then return end
    local sg = Instance.new("ScreenGui")
    sg.Name = "MiniStatusGui"
    sg.Parent = LocalPlayer:WaitForChild("PlayerGui")
    sg.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 210, 0, 95)
    frame.Position = UDim2.new(0.85, 0, 0.5, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 100, 50)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = sg
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Text = "📦 Status Farm"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 25)
    statusLabel.Position = UDim2.new(0, 0, 0, 28)
    statusLabel.Text = "AFK: OFF | Auto: OFF"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextSize = 12
    statusLabel.Parent = frame

    local itemCount = Instance.new("TextLabel")
    itemCount.Size = UDim2.new(1, 0, 0, 25)
    itemCount.Position = UDim2.new(0, 0, 0, 56)
    itemCount.Text = "Item: 0"
    itemCount.TextColor3 = Color3.fromRGB(255, 200, 0)
    itemCount.BackgroundTransparency = 1
    itemCount.Font = Enum.Font.GothamMedium
    itemCount.TextSize = 12
    itemCount.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -25, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function()
        sg:Destroy()
        miniGui = nil
    end)

    miniGui = {
        ScreenGui = sg,
        Frame = frame,
        StatusLabel = statusLabel,
        ItemCount = itemCount
    }

    task.spawn(function()
        while miniGui and miniGui.ScreenGui.Parent do
            task.wait(1)
            local items = getAllItems()
            local count = #items
            local afk = AfkFarmEnabled and "ON" or "OFF"
            local auto = AutoItemEnabled and "ON" or "OFF"
            miniGui.StatusLabel.Text = "AFK: " .. afk .. " | Auto: " .. auto
            miniGui.ItemCount.Text = "Item: " .. count
        end
    end)
end

function updateMiniGui()
    local anyActive = AfkFarmEnabled or AutoItemEnabled
    if anyActive then
        if not miniGui then
            createMiniGui()
        end
    else
        if miniGui then
            miniGui.ScreenGui:Destroy()
            miniGui = nil
        end
    end
end

-- // ========== 23. TAB ==========
local InfoTab     = Window:MakeTab({ Name = "Info", Icon = ICON.Info, PremiumOnly = false })
local MainTab     = Window:MakeTab({ Name = "Main", Icon = ICON.Zap, PremiumOnly = false })
local ReviveTab   = Window:MakeTab({ Name = "💉 Revive", Icon = ICON.User, PremiumOnly = false })
local CollectTab  = Window:MakeTab({ Name = "🎯 Collect", Icon = ICON.User, PremiumOnly = false })
local PlayerTab   = Window:MakeTab({ Name = "🧑 Player", Icon = ICON.User, PremiumOnly = false })
local GenTab      = Window:MakeTab({ Name = "⚙️ Generator", Icon = ICON.Zap, PremiumOnly = false })
local VisualTab   = Window:MakeTab({ Name = "👁️ Visual", Icon = ICON.Eye, PremiumOnly = false })
local SpeedTab    = Window:MakeTab({ Name = "🏃 Speed", Icon = ICON.Zap, PremiumOnly = false })
local UtilityTab  = Window:MakeTab({ Name = "🛠️ Utility", Icon = ICON.Settings, PremiumOnly = false })
local MiscTab     = Window:MakeTab({ Name = "🎮 Misc", Icon = ICON.Settings, PremiumOnly = false })
local SettingsTab = Window:MakeTab({ Name = "Pengaturan", Icon = ICON.Settings, PremiumOnly = false })

-- // ========== 24. TAB INFO ==========
local InfoSec = InfoTab:AddSection({ Name = "Tentang" })
InfoSec:AddLabel("🔥 EVADE HUB")
InfoSec:AddLabel("Script by: No Mercy Team")
InfoSec:AddLabel("Fitur: AFK Farm, Auto Item, Auto Revive, Auto Collect, Auto Heal, Speed, Jump, Fly, NoClip, Anti AFK, Auto Respawn, God Mode, Full Bright, ESP, Server Hop, Redeem Codes")
InfoSec:AddButton({
    Name = "Copy Link Discord",
    Callback = function()
        if setclipboard then setclipboard("https://discord.gg/pbg6g79Hp") end
        VD_Notify("EVADE HUB", "Link Discord di-copy!", 3)
    end,
})

-- // ========== 25. TAB MAIN (Speed & Jump) ==========
local MainSec = MainTab:AddSection({ Name = "⚡ Speed & Jump" })
MainSec:AddToggle({
    Name = "⚡ Speed Boost",
    Default = false,
    Callback = function(Value)
        SpeedEnabled = Value
        applySpeed()
    end
})

MainSec:AddSlider({
    Name = "🏃 Kecepatan",
    Min = 16,
    Max = 200,
    Default = 50,
    Increment = 1,
    ValueName = "speed",
    Callback = function(v)
        walkSpeedValue = v
        if SpeedEnabled then applySpeed() end
    end
})

MainSec:AddToggle({
    Name = "⬆ Jump Boost",
    Default = false,
    Callback = function(Value)
        JumpEnabled = Value
        applyJump()
    end
})

MainSec:AddSlider({
    Name = "💪 Kekuatan Lompat",
    Min = 20,
    Max = 300,
    Default = 80,
    Increment = 1,
    ValueName = "jump",
    Callback = function(v)
        jumpPowerValue = v
        if JumpEnabled then applyJump() end
    end
})

-- // ========== 26. TAB REVIVE ==========
local ReviveSec = ReviveTab:AddSection({ Name = "💉 Auto Revive" })
ReviveSec:AddToggle({
    Name = "🔄 Auto Revive",
    Default = false,
    Callback = function(Value)
        AutoReviveEnabled = Value
        VD_Notify("Auto Revive", Value and "✅ Aktif" or "❌ Nonaktif", 2)
    end
})

ReviveSec:AddButton({
    Name = "🧪 Test Revive (Paksa Mati)",
    Callback = function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = 0
            VD_Notify("Test", "Health di-set 0", 2)
        end
    end
})

-- // ========== 27. TAB COLLECT ==========
local CollectSec = CollectTab:AddSection({ Name = "🎯 Auto Collect" })
CollectSec:AddToggle({
    Name = "🎯 Auto Collect",
    Default = false,
    Callback = function(Value)
        AutoCollectEnabled = Value
        VD_Notify("Auto Collect", Value and "✅ Aktif" or "❌ Nonaktif", 2)
    end
})

CollectSec:AddButton({
    Name = "🧪 Test Collect (Ambil 1 Item)",
    Callback = function()
        autoCollect()
        VD_Notify("Test", "Mencoba ambil item...", 2)
    end
})

-- // ========== 28. TAB PLAYER (Auto Heal) ==========
local PlayerSec = PlayerTab:AddSection({ Name = "🧑 Player Settings" })
PlayerSec:AddToggle({
    Name = "🩹 Auto Heal",
    Description = "Heal otomatis saat health di bawah threshold",
    Default = false,
    Callback = function(Value)
        AutoHealEnabled = Value
        VD_Notify("Auto Heal", Value and "✅ Aktif" or "❌ Nonaktif", 2)
    end
})

PlayerSec:AddSlider({
    Name = "💚 Health Threshold (%)",
    Min = 10,
    Max = 80,
    Default = 40,
    Increment = 5,
    ValueName = "%",
    Callback = function(v)
        healThreshold = v
    end
})

-- // ========== 29. TAB GENERATOR (AFK Farm + Auto Item) ==========
local GenSec = GenTab:AddSection({ Name = "⚙️ Generator Farm" })
GenSec:AddToggle({
    Name = "🚀 AFK Farm",
    Description = "Naik ke posisi aman dan farming item",
    Default = false,
    Callback = function(Value)
        local char = LocalPlayer.Character
        local isDowned = char and char:GetAttribute("Downed")
        if isDowned then
            VD_Notify("Error", "Karakter sedang down!", 3)
            return
        end
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        AfkFarmEnabled = Value
        savedAfkState = Value
        if Value then
            originalPosition = hrp.Position + Vector3.new(0, 200, 0)
            hrp.CFrame = CFrame.new(originalPosition)
            task.wait(0.1)
            hrp.Anchored = true
        else
            hrp.Anchored = false
        end
        updateMiniGui()
    end
})

GenSec:AddToggle({
    Name = "🎯 Auto Item",
    Description = "Mengambil item terdekat secara otomatis",
    Default = false,
    Callback = function(Value)
        local char = LocalPlayer.Character
        local isDowned = char and char:GetAttribute("Downed")
        if isDowned then
            VD_Notify("Error", "Karakter sedang down!", 3)
            return
        end
        AutoItemEnabled = Value
        savedCollectState = Value
        updateMiniGui()
    end
})

-- // ========== 30. TAB VISUAL (ESP + Full Bright + God Mode) ==========
local VisualSec = VisualTab:AddSection({ Name = "👁️ ESP" })
VisualSec:AddToggle({
    Name = "🔍 Master ESP",
    Default = false,
    Callback = function(Value)
        ESPEnabled = Value
        if not Value then clearESP() else updateESP() end
    end
})

VisualSec:AddToggle({
    Name = "👤 ESP Player",
    Default = false,
    Callback = function(Value)
        ESPPlayerEnabled = Value
        if ESPEnabled then updateESP() end
    end
})

VisualSec:AddToggle({
    Name = "🤖 ESP Bot (Nextbot)",
    Default = false,
    Callback = function(Value)
        ESPBotEnabled = Value
        if ESPEnabled then updateESP() end
    end
})

local VisualSec2 = VisualTab:AddSection({ Name = "☀️ Visual & Power" })
VisualSec2:AddToggle({
    Name = "☀️ Full Bright",
    Default = false,
    Callback = function(Value)
        FullBrightEnabled = Value
    end
})

VisualSec2:AddToggle({
    Name = "🛡️ God Mode",
    Default = false,
    Callback = function(Value)
        GodModeEnabled = Value
    end
})

-- // ========== 31. TAB SPEED (Khusus WalkSpeed) ==========
local SpeedSec = SpeedTab:AddSection({ Name = "🏃 WalkSpeed" })
SpeedSec:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    ValueName = "speed",
    Callback = function(v)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end
})

-- // ========== 32. TAB UTILITY ==========
local UtilitySec = UtilityTab:AddSection({ Name = "🛠️ Utility" })
UtilitySec:AddToggle({
    Name = "🛡️ Anti AFK",
    Default = false,
    Callback = function(Value)
        AntiAFKEnabled = Value
    end
})

UtilitySec:AddToggle({
    Name = "🔄 Auto Respawn",
    Default = false,
    Callback = function(Value)
        AutoRespawnEnabled = Value
    end
})

UtilitySec:AddToggle({
    Name = "✈️ Fly Mode (F)",
    Default = false,
    Callback = function(Value)
        FlyEnabled = Value
        if not Value and flying then stopFly() end
    end
})

UtilitySec:AddSlider({
    Name = "🚀 Kecepatan Terbang",
    Min = 20,
    Max = 200,
    Default = 80,
    Increment = 1,
    ValueName = "speed",
    Callback = function(v)
        flySpeedValue = v
    end
})

UtilitySec:AddToggle({
    Name = "👻 No Clip",
    Default = false,
    Callback = function(Value)
        NoClipEnabled = Value
    end
})

UtilitySec:AddToggle({
    Name = "🦘 Infinite Jump",
    Default = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
        if Value then
            InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.Jump = true
                end
            end)
        else
            if InfiniteJumpConnection then
                InfiniteJumpConnection:Disconnect()
                InfiniteJumpConnection = nil
            end
        end
    end
})

UtilitySec:AddButton({
    Name = "📌 Teleport ke Item Terdekat",
    Callback = function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local items = getAllItems()
        if #items == 0 then
            VD_Notify("Teleport", "Tidak ada item!", 2)
            return
        end
        local item = getClosestSafeItem(hrp, items)
        if item then
            teleportTo(hrp, item.Position, 0.3)
            VD_Notify("Teleport", "Berhasil ke item terdekat", 2)
        end
    end
})

-- // ========== 33. TAB MISC ==========
local MiscSec = MiscTab:AddSection({ Name = "🎮 Lain-lain" })
MiscSec:AddButton({
    Name = "🔄 Server Hop",
    Callback = function()
        hopServer()
        VD_Notify("Server Hop", "Mencari server lain...", 2)
    end
})

MiscSec:AddButton({
    Name = "🎁 Redeem Codes",
    Callback = function()
        redeemAllCodes()
        VD_Notify("Redeem Codes", "Mencoba klaim kode...", 2)
    end
})

-- // ========== 34. TAB PENGATURAN ==========
local SettingsSec = SettingsTab:AddSection({ Name = "Pengaturan" })
SettingsSec:AddButton({
    Name = "💾 Save Config",
    Callback = function()
        OrionLib:SaveConfig()
        VD_Notify("Config", "Config disimpan!", 2)
    end
})

SettingsSec:AddButton({
    Name = "📂 Load Config",
    Callback = function()
        OrionLib:LoadConfig()
        VD_Notify("Config", "Config dimuat!", 2)
    end
})

SettingsSec:AddButton({
    Name = "❌ Tutup UI (Close)",
    Callback = function()
        confirmClose()
    end
})

-- // ========== 35. NOTIFIKASI LOAD ==========
VD_Notify("🔥 EVADE HUB", "Semua fitur siap digunakan!", 4)
print("[EVADE HUB] Loaded — Orion UI + ESP + Auto Heal")
print("📌 Buka menu dan aktifkan fitur yang diinginkan!")
print("📌 Klik bubble logo untuk buka UI lagi")
print("📌 ESP Player & Bot aktif di tab Visual")
print("📌 Auto Heal aktif di tab Player")
print("📌 AFK Farm & Auto Item aktif di tab Generator")
