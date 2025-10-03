JunkieProtected = {}
JunkieProtected.API_KEY = "YOUR-API-KEY"
JunkieProtected.PROVIDER = "YOUR-PROVIDER"
JunkieProtected.SERVICE_ID = "YOUR-SERVICE-ID"

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "JunkieKeySystem"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 400, 0, 250)
main.Position = UDim2.new(0.5, -200, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0

local uicorner = Instance.new("UICorner", main)
uicorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🔐 Junkie Key System"
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1

local input = Instance.new("TextBox", main)
input.PlaceholderText = "Enter your key here..."
input.Size = UDim2.new(0.9, 0, 0, 40)
input.Position = UDim2.new(0.05, 0, 0, 60)
input.TextSize = 18
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.Font = Enum.Font.Gotham
input.Text = ""
input.ClearTextOnFocus = false
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

local function notify(message, success)
	local n = Instance.new("TextLabel", gui)
	n.Text = message
	n.Size = UDim2.new(0, 300, 0, 40)
	n.Position = UDim2.new(0.5, -150, 0.85, 0)
	n.BackgroundColor3 = success and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
	n.TextColor3 = Color3.new(1, 1, 1)
	n.Font = Enum.Font.GothamSemibold
	n.TextSize = 16
	n.BackgroundTransparency = 0.1
	Instance.new("UICorner", n).CornerRadius = UDim.new(0, 6)
	task.delay(3, function()
		n:Destroy()
	end)
end

local validateBtn = Instance.new("TextButton", main)
validateBtn.Text = "✅ Validate Key"
validateBtn.Size = UDim2.new(0.9, 0, 0, 40)
validateBtn.Position = UDim2.new(0.05, 0, 0, 120)
validateBtn.TextSize = 18
validateBtn.TextColor3 = Color3.new(1, 1, 1)
validateBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
validateBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", validateBtn).CornerRadius = UDim.new(0, 8)

validateBtn.MouseButton1Click:Connect(function()
	local key = input.Text
	if key == "" then
		notify("Please enter a key!", false)
		return
	end

	local result = JunkieProtected.ValidateKey({ Key = key })
	if result == "valid" then
		notify("Key is valid! Welcome.", true)
		main:Destroy()
		-- You can now run your script logic here
	else
		notify("Invalid key. Try again.", false)
	end
end)

local getKeyBtn = Instance.new("TextButton", main)
getKeyBtn.Text = "🌐 Get Key"
getKeyBtn.Size = UDim2.new(0.9, 0, 0, 40)
getKeyBtn.Position = UDim2.new(0.05, 0, 0, 180)
getKeyBtn.TextSize = 18
getKeyBtn.TextColor3 = Color3.new(1, 1, 1)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 90, 150)
getKeyBtn.Font = Enum.Font.Gotham
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 8)

getKeyBtn.MouseButton1Click:Connect(function()
	local link = JunkieProtected.GetKeyLink()
	if setclipboard then
		setclipboard(link)
		notify("Key link copied to clipboard!", true)
	else
		notify("Copy failed. Unsupported executor.", false)
	end
end)
