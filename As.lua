-- SERVICES

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

------------------------------------------------
-- VARIABLES
------------------------------------------------

local AutoFarm = false
local AutoHoop = false
local WalkCircle = false
local AutoJump = false
local SpeedHack = false

------------------------------------------------
-- ANTI AFK
------------------------------------------------

player.Idled:Connect(function()

VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

end)

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,280,0,260)
main.Position = UDim2.new(0,20,0,20)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.Active = true
main.Draggable = true

Instance.new("UICorner",main)

local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "Legends Speed Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

------------------------------------------------
-- CLOSE
------------------------------------------------

local close = Instance.new("TextButton",main)
close.Size = UDim2.new(0,30,0,25)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,50,50)

close.MouseButton1Click:Connect(function()
gui:Destroy()
end)

------------------------------------------------
-- HIDE SYSTEM
------------------------------------------------

local open = Instance.new("TextButton",gui)
open.Size = UDim2.new(0,70,0,35)
open.Position = UDim2.new(0,20,0,20)
open.Text = "OPEN"
open.Visible = false
open.BackgroundColor3 = Color3.fromRGB(40,40,40)

Instance.new("UICorner",open)

local hide = Instance.new("TextButton",main)
hide.Size = UDim2.new(0,40,0,25)
hide.Position = UDim2.new(1,-80,0,5)
hide.Text = "-"
hide.BackgroundColor3 = Color3.fromRGB(200,150,0)

hide.MouseButton1Click:Connect(function()

main.Visible = false
open.Visible = true

end)

open.MouseButton1Click:Connect(function()

main.Visible = true
open.Visible = false

end)

------------------------------------------------
-- TOGGLE BUTTON
------------------------------------------------

local function Toggle(name,pos,callback)

local holder = Instance.new("Frame",main)
holder.Size = UDim2.new(0,240,0,40)
holder.Position = UDim2.new(0,20,0,pos)
holder.BackgroundTransparency = 1

local btn = Instance.new("TextButton",holder)
btn.Size = UDim2.new(1,0,1,0)
btn.Text = name
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(40,40,40)

Instance.new("UICorner",btn)

local indicator = Instance.new("Frame",holder)
indicator.Size = UDim2.new(0,16,0,16)
indicator.Position = UDim2.new(1,-26,0.5,-8)
indicator.BackgroundColor3 = Color3.fromRGB(200,0,0)

Instance.new("UICorner",indicator)

local state = false

btn.MouseButton1Click:Connect(function()

state = not state

indicator.BackgroundColor3 =
state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)

callback(state)

end)

end

------------------------------------------------
-- BUTTONS
------------------------------------------------

Toggle("Auto Farm",50,function(v)
AutoFarm = v
end)

Toggle("Auto Hoop",95,function(v)
AutoHoop = v
end)

Toggle("Walk Circle",140,function(v)
WalkCircle = v
end)

Toggle("Auto Jump",185,function(v)
AutoJump = v
end)

Toggle("Speed Boost",230,function(v)
SpeedHack = v
end)

------------------------------------------------
-- FEATURES
------------------------------------------------

RunService.RenderStepped:Connect(function()

if AutoJump then
humanoid.Jump = true
end

if SpeedHack then
humanoid.WalkSpeed = 60
else
humanoid.WalkSpeed = 16
end

end)

------------------------------------------------
-- WALK CIRCLE
------------------------------------------------

task.spawn(function()

local angle = 0
local radius = 30

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

------------------------------------------------
-- AUTO FARM
------------------------------------------------

task.spawn(function()

while true do
task.wait(0.15)

if AutoFarm then

for _,v in pairs(workspace:GetDescendants()) do

if v:IsA("Part") then

local n = v.Name:lower()

if string.find(n,"orb")
or string.find(n,"gem")
or string.find(n,"step") then

humanoid:MoveTo(v.Position)
task.wait(0.05)

end

end

end

end

end

end)

------------------------------------------------
-- AUTO HOOP
------------------------------------------------

task.spawn(function()

while true do
task.wait(0.2)

if AutoHoop then

for _,v in pairs(workspace:GetDescendants()) do

if v.Name == "Hoop" then

root.CFrame = v.CFrame + Vector3.new(0,3,0)
task.wait(0.2)

end

end

end

end

end)
