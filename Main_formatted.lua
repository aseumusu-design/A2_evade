local part = script.Parent

-- 1. Buat objek Sound di dalam Part
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://137477060563101"
sound.Volume = 1
sound.Parent = part

-- 2. Event saat Part disentuh pemain (Play Audio)
part.Touched:Connect(function(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	
	-- Pastikan yang menyentuh adalah pemain dan audio belum diputar
	if humanoid and not sound.IsPlaying then
		sound:Play()
		print("Audio diputar!")
	end
end)

-- 3. (Opsional) Contoh fungsi untuk Stop Audio setelah beberapa detik
task.delay(10, function()
	if sound.IsPlaying then
		sound:Stop()
		print("Audio dihentikan!")
	end
end)
