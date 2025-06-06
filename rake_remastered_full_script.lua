
-- Rake: Remastered Exploit Loader by Fuli (for educational purposes only)
-- Features: Insta Kill Rake, Stun Aura, Walkspeed, Fullbright, ESP (Rake + Players), Wall Remover, Auto Farm, Teleport, Flee, Insta Kill Player

-- ✅ SETTINGS
local walkSpeed = 50
local targetPlayer = "PlayerNameHere"

-- 📌 UTILITIES
function getRake()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Rake" and v:FindFirstChild("Humanoid") then
            return v
        end
    end
    return nil
end

function killRake()
    local rake = getRake()
    if rake then
        rake.Humanoid.Health = 0
    end
end

function esp(targetName)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name == targetName then
            local billboard = Instance.new("BillboardGui", v)
            billboard.Size = UDim2.new(0, 100, 0, 40)
            billboard.Adornee = v:FindFirstChild("Head") or v:FindFirstChildWhichIsA("Part")
            billboard.AlwaysOnTop = true

            local label = Instance.new("TextLabel", billboard)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = v.Name
            label.TextColor3 = Color3.new(1, 0, 0)
            label.BackgroundTransparency = 1
        end
    end
end

function fullbright()
    game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
    game:GetService("Lighting").Brightness = 5
    game:GetService("Lighting").TimeOfDay = "14:00:00"
end

function removeWalls()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Part") and v.Name:lower():find("wall") then
            v:Destroy()
        end
    end
end

function autoFarm()
    while true do
        task.wait(1)
        local rake = getRake()
        if rake then
            rake.Humanoid.Health = 0
        end
    end
end

function stunAura()
    while true do
        task.wait(0.5)
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Rake" and v:FindFirstChild("HumanoidRootPart") then
                if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                    v.Humanoid.Health = 0
                end
            end
        end
    end
end

function teleportTo(pos)
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(pos) end
end

function runFromRake()
    local rake = getRake()
    if rake and rake:FindFirstChild("HumanoidRootPart") then
        local dir = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - rake.HumanoidRootPart.Position).Unit
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = dir * 100
    end
end

function killPlayerByName(name)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name == name and v.Character and v.Character:FindFirstChild("Humanoid") then
            v.Character.Humanoid.Health = 0
        end
    end
end

-- 🚀 ACTIVATION
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
fullbright()
esp("Rake")
for _, p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer then esp(p.Name) end end
removeWalls()

-- 💥 ENABLED FEATURES
spawn(stunAura)
spawn(autoFarm)
spawn(runFromRake)
killPlayerByName(targetPlayer)
killRake()
