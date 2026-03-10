-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-------------------------------------------------
-- Variables
-------------------------------------------------

local AutoFarm = false
local AutoJump = false
local WalkCircle = false

-------------------------------------------------
-- GUI
-------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,270,0,200)
main.Position = UDim2.new(0,20,0,20)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

Instance.new("UICorner",main)

local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "Legends Of Speed Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-------------------------------------------------
-- CLOSE
-------------------------------------------------

local close = Instance.new("TextButton",main)
close.Size = UDim2.new(0,30,0,25)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,60,60)

close.MouseButton1Click:Connect(function()
gui:Destroy()
end)

-------------------------------------------------
-- HIDE SYSTEM
-------------------------------------------------

local openBtn = Instance.new("TextButton",gui)
openBtn.Size = UDim2.new(0,60,0,35)
openBtn.Position = UDim2.new(0,20,0,20)
openBtn.Text = "OPEN"
openBtn.Visible = false
openBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)

Instance.new("UICorner",openBtn)

local hide = Instance.new("TextButton",main)
hide.Size = UDim2.new(0,40,0,25)
hide.Position = UDim2.new(1,-80,0,5)
hide.Text = "-"
hide.BackgroundColor3 = Color3.fromRGB(200,150,0)

hide.MouseButton1Click:Connect(function()

main.Visible = false
openBtn.Visible = true

end)

openBtn.MouseButton1Click:Connect(function()

main.Visible = true
openBtn.Visible = false

end)

-------------------------------------------------
-- Button creator
-------------------------------------------------

local function ToggleButton(text,pos,callback)

local holder = Instance.new("Frame",main)
holder.Size = UDim2.new(0,230,0,40)
holder.Position = UDim2.new(0,20,0,pos)
holder.BackgroundTransparency = 1

local btn = Instance.new("TextButton",holder)
btn.Size = UDim2.new(1,0,1,0)
btn.Text = text
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)

Instance.new("UICorner",btn)

local indicator = Instance.new("Frame",holder)
indicator.Size = UDim2.new(0,15,0,15)
indicator.Position = UDim2.new(1,-25,0.5,-7)
indicator.BackgroundColor3 = Color3.fromRGB(200,0,0)

Instance.new("UICorner",indicator)

local state = false

btn.MouseButton1Click:Connect(function()

state = not state

if state then
indicator.BackgroundColor3 = Color3.fromRGB(0,200,0)
else
indicator.BackgroundColor3 = Color3.fromRGB(200,0,0)
end

callback(state)

end)

end

-------------------------------------------------
-- Buttons
-------------------------------------------------

ToggleButton("Auto Farm",50,function(v)
AutoFarm = v
end)

ToggleButton("Walk Circle",100,function(v)
WalkCircle = v
end)

ToggleButton("Auto Jump",150,function(v)
AutoJump = v
end)

-------------------------------------------------
-- Auto Jump
-------------------------------------------------

RunService.RenderStepped:Connect(function()

if AutoJump then
humanoid.Jump = true
end

end)

-------------------------------------------------
-- Walk Circle
-------------------------------------------------

task.spawn(function()

local angle = 0
local radius = 25

while true do
task.wait()

if WalkCircle then

angle += 0.05

local pos = root.Position + Vector3.new(
math.cos(angle)*radius,
0,
math.sin(angle)*radius
)

humanoid:MoveTo(pos)

end

end

end)

-------------------------------------------------
-- Auto Farm
-------------------------------------------------

task.spawn(function()

while true do
task.wait(0.2)

if AutoFarm then

for _,v in pairs(workspace:GetDescendants()) do

if v:IsA("Part") then

local name = v.Name:lower()

if string.find(name,"orb") 
or string.find(name,"gem") 
or string.find(name,"step") then

humanoid:MoveTo(v.Position)
task.wait(0.05)

end

end

end

end

end

end)
