-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Variables
local AutoFarm = false
local WalkCircle = false
local AutoJump = false

-------------------------------------------------
-- GUI
-------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "SpeedHub"
gui.Parent = game.CoreGui

local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,260,0,220)
main.Position = UDim2.new(0,20,0,20)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

Instance.new("UICorner",main).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "Legends Of Speed Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Close Button
local close = Instance.new("TextButton",main)
close.Size = UDim2.new(0,30,0,25)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
close.TextColor3 = Color3.new(1,1,1)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Hide Button
local hide = Instance.new("TextButton",main)
hide.Size = UDim2.new(0,30,0,25)
hide.Position = UDim2.new(1,-70,0,5)
hide.Text = "-"
hide.BackgroundColor3 = Color3.fromRGB(200,150,0)
hide.TextColor3 = Color3.new(1,1,1)

local hidden = false
hide.MouseButton1Click:Connect(function()

    hidden = not hidden

    for _,v in pairs(main:GetChildren()) do
        if v:IsA("TextButton") and v ~= hide and v ~= close then
            v.Visible = not hidden
        end
    end

end)

-------------------------------------------------
-- Button creator
-------------------------------------------------

local function Button(text,pos,callback)

    local b = Instance.new("TextButton",main)

    b.Size = UDim2.new(0,220,0,40)
    b.Position = UDim2.new(0,20,0,pos)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)

    Instance.new("UICorner",b)

    b.MouseButton1Click:Connect(callback)

end

-------------------------------------------------
-- Buttons
-------------------------------------------------

Button("Auto Farm",50,function()
    AutoFarm = not AutoFarm
end)

Button("Walk Circle",100,function()
    WalkCircle = not WalkCircle
end)

Button("Auto Jump",150,function()
    AutoJump = not AutoJump
end)

-------------------------------------------------
-- Features
-------------------------------------------------

RunService.RenderStepped:Connect(function()

    if AutoJump then
        Humanoid.Jump = true
    end

end)

-- Circle movement (REAL WALK)
task.spawn(function()

    local angle = 0
    local radius = 30

    while true do
        task.wait()

        if WalkCircle then

            angle += 0.05

            local target = HRP.Position + Vector3.new(
                math.cos(angle)*radius,
                0,
                math.sin(angle)*radius
            )

            Humanoid:MoveTo(target)

        end

    end

end)

-- Auto Farm
task.spawn(function()

    while true do
        task.wait(0.2)

        if AutoFarm then

            for _,v in pairs(workspace:GetDescendants()) do

                if v:IsA("Part") and string.find(v.Name,"Orb") then

                    Humanoid:MoveTo(v.Position)
                    task.wait(0.05)

                end

            end

        end

    end

end)
