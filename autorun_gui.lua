--[[  
     ⚡ Auto Run Script (Camera Direction)  
     اللاعب يجري لوحده حسب اتجاه الكاميرا  
     زر تشغيل / إيقاف  
     GUI محمية  
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- GUI حماية اسم
local guiName = "AR_" .. tostring(math.random(100000,999999))

local screen = Instance.new("ScreenGui")
screen.Name = guiName
screen.Parent = PlayerGui
screen.ResetOnSpawn = false

-- إطار
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0.5, -110, 0.7, -60)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true
frame.Parent = screen

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Text = "⚡ Auto Run"
title.Parent = frame

-- زر تشغيل
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.8,0,0,40)
btn.Position = UDim2.new(0.1,0,0.45,0)
btn.BackgroundColor3 = Color3.fromRGB(40,140,255)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
btn.Font = Enum.Font.SourceSansBold
btn.Text = "Start"
btn.Parent = frame

-- زر إخفاء GUI
local hide = Instance.new("TextButton")
hide.Size = UDim2.new(0,25,0,25)
hide.Position = UDim2.new(1, -30, 0, 5)
hide.BackgroundColor3 = Color3.fromRGB(255,50,50)
hide.Text = "X"
hide.TextColor3 = Color3.new(1,1,1)
hide.Font = Enum.Font.SourceSansBold
hide.TextScaled = true
hide.Parent = frame

hide.MouseButton1Click:Connect(function()
    screen.Enabled = not screen.Enabled
end)

---------------------------------------------------------------------

local running = false
local connection

btn.MouseButton1Click:Connect(function()
    running = not running

    if running then
        btn.Text = "Stop"
        btn.BackgroundColor3 = Color3.fromRGB(255,60,60)

        connection = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end

            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera

            if hum and hrp and cam then
                -- اتجاه الكاميرا
                local forward = cam.CFrame.LookVector
                -- نخلي اللاعب يجري لقدام حسب اتجاه الكاميرا
                hrp.Velocity = Vector3.new(forward.X, 0, forward.Z) * 35  -- السرعة 35
            end
        end)

    else
        btn.Text = "Start"
        btn.BackgroundColor3 = Color3.fromRGB(40,140,255)

        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)
