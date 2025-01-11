local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local InputService = game:GetService("UserInputService")

local BlackBypass
local isMoving = false
local speedState = 26.5
local speedStateTime = 0.35
local lastSwitchTime = tick()

run(function()
    BlackBypass = vape.Categories.Combat:CreateModule({
        Name = "BlackBypass",
        Function = function(callback)
            print(callback, "This should be working, according to my calculations!")

            local StandPart = Instance.new("Part")
            BlackBypass:Clean(StandPart)

            InputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    local key = input.KeyCode
                    if key == Enum.KeyCode.W or key == Enum.KeyCode.A or key == Enum.KeyCode.S or key == Enum.KeyCode.D then
                        isMoving = true
                    end
                end
            end)

            InputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    local key = input.KeyCode
                    if key == Enum.KeyCode.W or key == Enum.KeyCode.A or key == Enum.KeyCode.S or key == Enum.KeyCode.D then
                        isMoving = false
                    end
                end
            end)

            RunService.RenderStepped:Connect(function()
                if isMoving and BlackBypass.Enabled then
                    local Character = LocalPlayer.Character
                    if Character and Character:FindFirstChild("HumanoidRootPart") then
                        local HumanoidRootPart = Character.HumanoidRootPart
                        local movementVector = Vector3.zero

                        if tick() - lastSwitchTime >= speedStateTime then
                            if speedState == 26.5 then
                                speedState = 10
                                speedStateTime = 0.4
                            else
                                speedState = 26.5
                                speedStateTime = 0.35
                            end
                            lastSwitchTime = tick()
                        end

                        if InputService:IsKeyDown(Enum.KeyCode.W) then
                            movementVector += Vector3.new(0, 0, -1)
                        end
                        if InputService:IsKeyDown(Enum.KeyCode.S) then
                            movementVector += Vector3.new(0, 0, 1)
                        end
                        if InputService:IsKeyDown(Enum.KeyCode.A) then
                            movementVector += Vector3.new(-1, 0, 0)
                        end
                        if InputService:IsKeyDown(Enum.KeyCode.D) then
                            movementVector += Vector3.new(1, 0, 0)
                        end

                        if movementVector.Magnitude > 0 then
                            movementVector = movementVector.Unit * speedState
                            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + movementVector
                        end
                    end
                end
            end)

            repeat
                task.wait(1)
            until not BlackBypass.Enabled
        end,
        Tooltip = "BlackBypass, Uses colored people to push you and make you go faster!"
    })
end)
