-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Variables
local AutoFarm = false
local WalkCircle = false
local AutoJump = false

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,200,0,170)
Frame.Position = UDim2.new(0,20,0,20)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Active = true
Frame.Draggable = true

local function CreateButton(text,y,callback)

    local btn = Instance.new("TextButton",Frame)
    btn.Size = UDim2.new(0,180,0,40)
    btn.Position = UDim2.new(0,10,0,y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)

    btn.MouseButton1Click:Connect(callback)
end

-- Auto Farm
CreateButton("Auto Farm",10,function()
    AutoFarm = not AutoFarm
end)

-- Walk Circle
CreateButton("Walk Circle",60,function()
    WalkCircle = not WalkCircle
end)

-- Auto Jump
CreateButton("Auto Jump",110,function()
    AutoJump = not AutoJump
end)

-- Loop
RunService.RenderStepped:Connect(function()

    if AutoJump then
        Humanoid.Jump = true
    end

    if WalkCircle then
        local t = tick()*2
        local radius = 30
        HRP.CFrame = CFrame.new(
            math.cos(t)*radius,
            HRP.Position.Y,
            math.sin(t)*radius
        )
    end

    if AutoFarm then
        for _,orb in pairs(workspace:GetDescendants()) do
            if orb.Name == "Orb" then
                HRP.CFrame = orb.CFrame
                wait(0.1)
            end
        end
    end

end)
