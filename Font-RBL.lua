local TARGET_FONT=Enum.Font.Cartoon

local Players=game:GetService("Players")
local player=Players.LocalPlayer

local function IsLikelyIcon(obj)
	if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then
		return true
	end

	local text=obj.Text or ""
	if text=="" then return true end

	local clean=text:gsub("%s+","")
	if #clean<=2 then
		return true
	end

	local name=obj.Name:lower()

	local IconNames={
		"icon",
		"logo",
		"image",
		"menuicon",
		"closeicon",
		"settingsicon",
		"robloxicon",
		"topbaricon"
	}

	for _,v in ipairs(IconNames) do
		if name:find(v,1,true) then
			return true
		end
	end

	return false
end

local function ChangeFont(object)
	if IsLikelyIcon(object) then
		return
	end

	if object:IsA("TextLabel")
	or object:IsA("TextButton")
	or object:IsA("TextBox") then
		pcall(function()
			object.Font=TARGET_FONT
		end)
	end
end

local function ApplyFontSystem(parentContainer)
	if not parentContainer then return end

	for _,object in ipairs(parentContainer:GetDescendants()) do
		ChangeFont(object)
	end

	parentContainer.DescendantAdded:Connect(function(object)
		task.defer(function()
			ChangeFont(object)
		end)
	end)
end

local PlayerGui=player:WaitForChild("PlayerGui",10)

if PlayerGui then
	ApplyFontSystem(PlayerGui)
end

if gethui then
	pcall(function()
		local hui=gethui()
		if hui then
			ApplyFontSystem(hui)
		end
	end)
end



local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local TargetFont = Enum.Font.Cartoon

local function changeFontOfUI(object)

    if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
        object.Font = TargetFont
    end

    for _, child in ipairs(object:GetChildren()) do
        changeFontOfUI(child)
    end
end

changeFontOfUI(PlayerGui)

PlayerGui.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
        descendant.Font = TargetFont
    end
end)
