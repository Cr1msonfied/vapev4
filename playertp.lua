local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local getClosestEnemy = function()
    local closestPlayer = nil
    local closestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.TeamColor ~= LocalPlayer.TeamColor and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

local targetPlayer = getClosestEnemy()
assert(targetPlayer, "No enemy players found!")

pcall(function()
    LocalPlayer.Character.Humanoid.Health = 0
end)

local connection
connection = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    connection:Disconnect()
    task.wait(0.2)

    local targetPosition = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
    TweenService:Create(newCharacter.PrimaryPart, TweenInfo.new(0.75), {CFrame = targetPosition}):Play()
end)
