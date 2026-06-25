-- // Example script demonstrating the usage of the Fallen Ultimate V3 UI Library

-- Load the library (Replace with your GitHub raw link once uploaded)
local Library = loadstring(readfile("Source.lua"))() 
-- If loading from GitHub:
-- local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/username/repo/main/Source.lua"))()

-- Create the main window
local Window = Library:CreateWindow({
    Title = "Fallen Ultimate",
    Build = "V3",
    Size = UDim2.new(0, 652, 0, 666)
})

-- Initialize default panels (Settings, Configs, HUD, Theming tab)
Window:InitPanels()

-- Create a new tab
local MainTab = Window:AddTab({
    Text = "Main",
    Icon = "rbxassetid://101410207355204"
})

-- Create a page inside the tab
local CombatPage = MainTab:AddPage({
    Text = "Combat",
    Columns = 2
})

-- Add a section in the left column (Side = 1)
local AimbotSection = CombatPage:AddSection({
    Title = "Aimbot Settings",
    Side = 1
})

-- Add a Toggle
local AimbotToggle = AimbotSection:AddToggle({
    Text = "Enabled",
    Default = false,
    Flag = "Aimbot_Enabled",
    Callback = function(state)
        print("Aimbot state changed:", state)
    end
})

-- Add a Slider
local FovSlider = AimbotSection:AddSlider({
    Text = "Field of View",
    Min = 0,
    Max = 180,
    Default = 90,
    Rounding = 1, -- Can also be Decimal
    Suffix = "°",
    Flag = "Aimbot_FOV",
    Callback = function(value)
        print("FOV set to:", value)
    end
})

-- Add a Dropdown (Single Choice)
local TargetDropdown = AimbotSection:AddDropdown({
    Text = "Target Part",
    Options = {"Head", "Torso", "Left Arm", "Right Arm"},
    Default = "Head",
    Multi = false,
    Flag = "Aimbot_TargetPart",
    Callback = function(selected)
        print("Selected target part:", selected)
    end
})

-- Add a KeyPicker (Keybind)
local AimbotKeybind = AimbotSection:AddKeyPicker({
    Text = "Aimbot Keybind",
    Default = Enum.KeyCode.E,
    Mode = "Hold", -- "Hold", "Toggle", "Always"
    ShowInList = true,
    Flag = "Aimbot_Keybind",
    Callback = function(isActive)
        print("Aimbot keybind state:", isActive)
    end
})

-- Add a section in the right column (Side = 2)
local EspSection = CombatPage:AddSection({
    Title = "ESP Settings",
    Side = 2
})

-- Add a Toggle for ESP
local EspToggle = EspSection:AddToggle({
    Text = "Show Boxes",
    Default = false,
    Flag = "ESP_ShowBoxes",
    Callback = function(state)
        print("ESP Boxes changed:", state)
    end
})

-- Add a ColorPicker for ESP Color
local EspColorPicker = EspSection:AddColorPicker({
    Text = "Box Color",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0, -- opacity / transparency (0-1)
    Flag = "ESP_BoxColor",
    Callback = function(color, transparency)
        print("ESP Color changed to:", color, "Transparency:", transparency)
    end
})

-- Add a Label with Rich Text support
local InfoLabel = EspSection:AddLabel({
    Text = "ESP works best on <font color='rgb(166, 147, 243)'>visible players</font>."
})

-- Programmatically change Label Text after 5 seconds as a demo
task.delay(5, function()
    InfoLabel:ChangeText("ESP Status: <font color='rgb(0, 255, 0)'>Running smoothly</font>")
end)

-- Add a Text Input
local UserInput = EspSection:AddInput({
    Text = "Exclude User",
    PlaceHolder = "Enter username...",
    Default = "",
    FocusLost = true, -- Calls callback only when user clicks away
    Flag = "ESP_ExcludeUser",
    Callback = function(text)
        print("Excluded user:", text)
    end
})

-- Add a List Box
local PlayerList = EspSection:AddList({
    Options = {"Player1", "Player2", "Player3"},
    Default = "Player1",
    Multi = false,
    Flag = "ESP_PlayerList",
    Callback = function(selected)
        print("Selected player in list:", selected)
    end
})

-- Add a Button to clear settings or print debugging
local PrintButton = EspSection:AddButton({
    Text = "Debug Settings",
    Confirmation = true, -- Requires a second click with a countdown
    Callback = function()
        print("--- CURRENT FLAGS DATA ---")
        for flag, value in pairs(Library.Flags) do
            if type(value) == "table" then
                print(flag, "->", "Color/Keybind table")
            else
                print(flag, "->", value)
            end
        end
    end
})

-- Programmatically demonstrating HUD controls
task.spawn(function()
    -- Show keybind list on the screen
    Window.SetKeybindListVisibility(true)
    
    -- Show watermark on the screen
    Window.SetWatermarkVisibility(true)
    
    -- Target stats HUD demo
    Window.SetTargetStatsVisibility(true)
    local localPlayer = game:GetService("Players").LocalPlayer
    Window:UpdateStatsProfile(localPlayer)
    Window:UpdateStats({
        Health = 75,
        MaxHealth = 100,
        Distance = 45
    })
end)
