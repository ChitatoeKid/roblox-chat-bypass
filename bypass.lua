--[[ SETTINGS ]]--
local CHAT_MESSAGE = "the message to send using the bypass"
local CHANNEL = "RBXGeneral" -- don't change this unless you know what you're doing

--[[ DONT CHANGE ANYTHING BELOW HERE ]]--

local separator = string.char(239, 191, 184)

local function insertSeparator(text)
    local result = ""
    for i = 1, #text do
        result = result .. text:sub(i, i)
        if i < #text then
            result = result .. separator
        end
    end
    return result
end

local formattedText = insertSeparator(CHAT_MESSAGE)

-- Create the GUI elements manually
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Background Frame
local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Parent = ScreenGui
BackgroundFrame.Size = UDim2.new(0, 500, 0, 300)
BackgroundFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BackgroundFrame.BorderSizePixel = 0
BackgroundFrame.BackgroundTransparency = 0.2
BackgroundFrame.AnchorPoint = Vector2.new(0.5, 0.5)
BackgroundFrame.ClipsDescendants = true
BackgroundFrame:TweenSize(UDim2.new(0, 500, 0, 300), "Out", "Bounce", 0.5, true)

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = BackgroundFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Send a Message"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 24
TitleLabel.TextStrokeTransparency = 0.6
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextScaled = true

-- Message Input Box
local MessageInput = Instance.new("TextBox")
MessageInput.Parent = BackgroundFrame
MessageInput.Size = UDim2.new(0, 400, 0, 50)
MessageInput.Position = UDim2.new(0.5, -200, 0.3, 0)
MessageInput.Text = CHAT_MESSAGE
MessageInput.PlaceholderText = "Enter your message here..."
MessageInput.ClearTextOnFocus = true
MessageInput.TextSize = 18
MessageInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MessageInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MessageInput.BorderSizePixel = 0
MessageInput.TextStrokeTransparency = 0.7
MessageInput.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
MessageInput.Font = Enum.Font.Gotham
MessageInput.TextScaled = true

-- Send Button
local SendButton = Instance.new("TextButton")
SendButton.Parent = BackgroundFrame
SendButton.Size = UDim2.new(0, 200, 0, 50)
SendButton.Position = UDim2.new(0.5, -100, 0.6, 0)
SendButton.Text = "Send Message"
SendButton.BackgroundColor3 = Color3.fromRGB(50, 200, 255)
SendButton.TextSize = 20
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.Font = Enum.Font.GothamBold
SendButton.BorderSizePixel = 0
SendButton.TextStrokeTransparency = 0.8
SendButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Button Hover Effects
SendButton.MouseEnter:Connect(function()
    SendButton:TweenSize(UDim2.new(0, 210, 0, 52), "Out", "Quad", 0.2, true)
    SendButton.BackgroundColor3 = Color3.fromRGB(60, 220, 255)
end)

SendButton.MouseLeave:Connect(function()
    SendButton:TweenSize(UDim2.new(0, 200, 0, 50), "Out", "Quad", 0.2, true)
    SendButton.BackgroundColor3 = Color3.fromRGB(50, 200, 255)
end)

-- Send the message when the button is clicked
SendButton.MouseButton1Click:Connect(function()
    local messageToSend = MessageInput.Text
    local formattedText = insertSeparator(messageToSend)
    game:GetService("TextChatService").TextChannels:WaitForChild(CHANNEL):SendAsync("</>\r" .. formattedText)
    print("Message Sent: " .. messageToSend)
end)

-- Draggable Window Logic
local dragging = false
local dragInput, dragStart, startPos

-- Function to begin dragging
BackgroundFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = BackgroundFrame.Position
    end
end)

-- Function to update the window's position while dragging
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        BackgroundFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Stop dragging when the mouse button is released
BackgroundFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
