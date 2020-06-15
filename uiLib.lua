local flatUi = {}

function flatUi:getStr(len)
	local str = ""
	local letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!£$%^&*)"
	local charsTable = {}
	local len = len
	if not len or len <= 0 then len = 30 end
	for w in string.gmatch(letters, "(%w)") do
		table.insert(charsTable, #charsTable + 1, w)
	end
	for i = 1, len do
		local ranNum = math.random(1, #charsTable)
		local letter = charsTable[ranNum]
		str = str..letter
	end
	return str
end

local UiLibBase = Instance.new("ScreenGui")

UiLibBase.Parent = game:GetService("CoreGui")
UiLibBase.Name = flatUi:getStr(20)

function flatUi:Warn(str)
	if syn then
		rconsolewarn(str .. "\n")
	else
		warn(str)
	end
end

function flatUi:CreateTab(pos, tabTitle)
	if not pos or not tabTitle then
		flatUi:Warn("Missing args for :CreateTab function. Please provide [position, tab title] as your two arguments.")
		return
	end
	local TopBar = Instance.new("Frame")
	local BackFrame = Instance.new("Frame")
	local TabTitle = Instance.new("TextLabel")
	local ItmHolder = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	
	TopBar.Name = flatUi:getStr(30)
	TopBar.Parent = UiLibBase
	TopBar.BackgroundColor3 = Color3.new(0.0235294, 0.0235294, 0.0235294)
	TopBar.BorderSizePixel = 0
	TopBar.Position = pos
	TopBar.Size = UDim2.new(0.100000001, 0, 0.023, 0)
	
	BackFrame.Name = flatUi:getStr(30)
	BackFrame.Parent = TopBar
	BackFrame.BackgroundColor3 = Color3.new(0.0509804, 0.0509804, 0.0509804)
	BackFrame.BorderSizePixel = 0
	BackFrame.Position = UDim2.new(0, 0, 1, 0)
	BackFrame.Size = UDim2.new(1, 0, 0, 0)
	
	TabTitle.Name = flatUi:getStr(30)
	TabTitle.Parent = TopBar
	TabTitle.BackgroundColor3 = Color3.new(1, 1, 1)
	TabTitle.BackgroundTransparency = 1
	TabTitle.Position = UDim2.new(0, 0, 0.100000001, 0)
	TabTitle.Size = UDim2.new(1, 0, 0.800000012, 0)
	TabTitle.Font = Enum.Font.SourceSans
	TabTitle.Text = tabTitle
	TabTitle.TextColor3 = Color3.new(1, 1, 1)
	TabTitle.TextScaled = true
	TabTitle.TextSize = 14
	TabTitle.TextWrapped = true
	
	ItmHolder.Name = flatUi:getStr(30)
	ItmHolder.Parent = TopBar
	ItmHolder.BackgroundColor3 = Color3.new(0.0509804, 0.0509804, 0.0509804)
	ItmHolder.BackgroundTransparency = 1
	ItmHolder.BorderSizePixel = 0
	ItmHolder.Position = UDim2.new(0, 0, 1.29999995, 0)
	ItmHolder.Size = UDim2.new(1, 0, 20, 0)
	
	UIListLayout.Parent = ItmHolder
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 7)
	
	local libFuncs = {}
	
	function libFuncs:CreateButton(buttonText, buttonFunction)
		if not buttonText or not buttonFunction then
			flatUi:Warn("Missing args for :CreateButton function. Please provide [button text, button function] as your two arguments.")			
			return
		end
		local backFrameY = BackFrame.Size.Y.Scale
		local newY = tonumber(backFrameY) + 2
		if newY >= 22 then
			flatUi:Warn("Sorry, there are too many objects in this tab. Max amount of objects in a tab is currently [10].")
			return
		end
		BackFrame.Size = UDim2.new(1, 0, newY, 0)
		
		
		local ExButton = Instance.new("Frame")
		local ButtonObj = Instance.new("TextButton")
		local ButtonTxt = Instance.new("TextLabel")
		
		ExButton.Name = flatUi:getStr(30)
		ExButton.Parent = ItmHolder
		ExButton.BackgroundColor3 = Color3.new(1, 1, 1)
		ExButton.BackgroundTransparency = 1
		ExButton.Size = UDim2.new(1, 0, 0.08, 0)
		
		ButtonObj.Name = flatUi:getStr(30)
		ButtonObj.Parent = ExButton
		ButtonObj.BackgroundColor3 = Color3.new(0.113725, 0.113725, 0.113725)
		ButtonObj.BorderSizePixel = 0
		ButtonObj.Position = UDim2.new(0.05, 0, 0.2, 0)
		ButtonObj.Size = UDim2.new(0.9, 0, 0.6, 0)
		ButtonObj.Font = Enum.Font.SourceSans
		ButtonObj.Text = ""
		ButtonObj.TextColor3 = Color3.new(0, 0, 0)
		ButtonObj.TextSize = 14
		
		ButtonTxt.Name = flatUi:getStr(30)
		ButtonTxt.Parent = ButtonObj
		ButtonTxt.BackgroundColor3 = Color3.new(1, 1, 1)
		ButtonTxt.BackgroundTransparency = 1
		ButtonTxt.Position = UDim2.new(0, 0, 0.0500000007, 0)
		ButtonTxt.Size = UDim2.new(1, 0, 0.899999976, 0)
		ButtonTxt.Font = Enum.Font.SourceSans
		ButtonTxt.Text = buttonText
		ButtonTxt.TextColor3 = Color3.new(1, 1, 1)
		ButtonTxt.TextSize = 14
		
		ButtonObj.Activated:Connect(buttonFunction)
	end
	
	function libFuncs:CreateToggle(style, callback)
		if not style and not callback then
			flatUi:Warn("Missing args for :CreateToggle function. Please provide [style, callback] as your two arguments.")
			return
		end
	end
	
	return libFuncs
end

return flatUi
