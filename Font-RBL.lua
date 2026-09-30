local TARGET_FONT = Enum.Font.Cartoon

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local function changeFont(object)
    if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
        pcall(function()
            object.Font = TARGET_FONT
        end)
    end
end

local function applyFontSystem(parentContainer)
    if not parentContainer then return end

    for _, child in pairs(parentContainer:GetDescendants()) do
        changeFont(child)
    end

    parentContainer.DescendantAdded:Connect(function(child)
        task.wait()
        changeFont(child)
    end)
end

local playerGui = player:WaitForChild("PlayerGui", 10)
if playerGui then
    applyFontSystem(playerGui)
end

pcall(function()
    applyFontSystem(CoreGui)
end)

if gethui then
    pcall(function()
        applyFontSystem(gethui())
    end)
end
