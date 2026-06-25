-- Variables
        local ServiceCache = {};     -- Cloneref bypass
        getgenv().Services = setmetatable({}, {
            __index = function(Self, Index)
                if not ServiceCache[Index] then
                    ServiceCache[Index] = cloneref(game:GetService(Index));
                end;
    
                return ServiceCache[Index];
            end
        });
        
        local Keys = {
            [Enum.KeyCode.LeftShift] = "Left Shift",
            [Enum.KeyCode.RightShift] = "Right Shift",
            [Enum.KeyCode.LeftControl] = "Left Ctrl",
            [Enum.KeyCode.RightControl] = "Right Ctrl",
            [Enum.KeyCode.Insert] = "Insert",
            [Enum.KeyCode.Backspace] = "Backspace",
            [Enum.KeyCode.Return] = "Return",
            [Enum.KeyCode.LeftAlt] = "Left Alt",
            [Enum.KeyCode.RightAlt] = "Right Alt",
            [Enum.KeyCode.CapsLock] = "Capslock",
            [Enum.KeyCode.One] = "1",
            [Enum.KeyCode.Two] = "2",
            [Enum.KeyCode.Three] = "3",
            [Enum.KeyCode.Four] = "4",
            [Enum.KeyCode.Five] = "5",
            [Enum.KeyCode.Six] = "6",
            [Enum.KeyCode.Seven] = "7",
            [Enum.KeyCode.Eight] = "8",
            [Enum.KeyCode.Nine] = "9",
            [Enum.KeyCode.Zero] = "0",
            [Enum.KeyCode.KeypadOne] = "Num1",
            [Enum.KeyCode.KeypadTwo] = "Num2",
            [Enum.KeyCode.KeypadThree] = "Num3",
            [Enum.KeyCode.KeypadFour] = "Num4",
            [Enum.KeyCode.KeypadFive] = "Num5",
            [Enum.KeyCode.KeypadSix] = "Num6",
            [Enum.KeyCode.KeypadSeven] = "Num7",
            [Enum.KeyCode.KeypadEight] = "Num8",
            [Enum.KeyCode.KeypadNine] = "Num9",
            [Enum.KeyCode.KeypadZero] = "Num0",
            [Enum.KeyCode.Minus] = "-",
            [Enum.KeyCode.Equals] = "=",
            [Enum.KeyCode.Tilde] = "~",
            [Enum.KeyCode.LeftBracket] = "[",
            [Enum.KeyCode.RightBracket] = "]",
            [Enum.KeyCode.RightParenthesis] = ")",
            [Enum.KeyCode.LeftParenthesis] = "(",
            [Enum.KeyCode.Semicolon] = ",",
            [Enum.KeyCode.Quote] = "'",
            [Enum.KeyCode.BackSlash] = "\\",
            [Enum.KeyCode.Comma] = ",",
            [Enum.KeyCode.Period] = ".",
            [Enum.KeyCode.Slash] = "/",
            [Enum.KeyCode.Asterisk] = "*",
            [Enum.KeyCode.Plus] = "+",
            [Enum.KeyCode.Period] = ".",
            [Enum.KeyCode.Backquote] = "`",
            [Enum.UserInputType.MouseButton1] = "MouseButton1",
            [Enum.UserInputType.MouseButton2] = "MouseButton2",
            [Enum.UserInputType.MouseButton3] = "MouseButton3",
            [Enum.KeyCode.Escape] = "Escape",
            [Enum.KeyCode.Space] = "Space",
        }
    
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Services.Players.LocalPlayer
        local GuiInset = Services.GuiService:GetGuiInset().Y
        local Mouse = LocalPlayer:GetMouse()
    
        local NumSeq = NumberSequence.new
        local ColorSeq = ColorSequence.new
    
        local NumKey = NumberSequenceKeypoint.new
        local ColorKey = ColorSequenceKeypoint.new
    
        local function Color3ToRGB(color3)
            local r = math.round(color3.R * 255)
            local g = math.round(color3.G * 255)
            local b = math.round(color3.B * 255)
            return r, g, b
        end
    
        local Pos = UDim2.new
        local Rgb = Color3.fromRGB
        local Size = UDim2.new
        local Offset = UDim2.fromOffset 
        local Vec = Vector2.new
        local Scale = UDim2.fromScale
    --
    
    if getgenv().Library and getgenv().Library.Unload then
        getgenv().Library:Unload()
    end
    
    local Library; do
        Library = {
            Directory = "UltimateV3",
            Folders = {
                "/Fonts",
                "/Configs",
                "/Themes",
            },
    
            Flags = {},
            ConfigFlags = {},
            FlagCount = 0;
            Connections = {},
            Threads = {},
            Blurs = {},
            Elements = {},
            Notifications = {},
    
            OpenElement = {},
            Moderators = {},
            Keybinds = {},
            Guis = {},
            Glows = {}, 
    
            EasingDirection = Enum.EasingDirection.InOut,
            EasingStyle = Enum.EasingStyle.Exponential,
            TweeningSpeed = .4,
            DraggingSpeed = .05,
            Tweening = false,
        };
    
        Library.__index = Library;
        getgenv().Library = Library
    
        for _, path in Library.Folders do
            makefolder(Library.Directory .. path)
        end
    
        if not isfile(Library.Directory .. "/Autoload.txt") then
            writefile(Library.Directory .. "/Autoload.txt", "")
        end
    
        local Flags = Library.Flags
        local ConfigFlags = Library.ConfigFlags
        local Notifications = Library.Notifications
        local Elements = Library.Elements
    
        local Themes = {
            Preset = {
                ["TextEnabled"] = Color3.fromRGB(234, 221, 221),
                ["TextDisabled"] = Color3.fromRGB(141, 135, 135),
                
                ["PageElementBackground"] = Color3.fromRGB(9, 9, 9),
                ["PageElementOutline"] = Color3.fromRGB(19, 18, 18),
                ["PageBackground"] = Color3.fromRGB(0, 0, 0),
    
                ["KeypickerBackground"] = Color3.fromRGB(16, 16, 16),
    
                ["Accent"] = Color3.fromRGB(166, 147, 243),
    
                ["OtherBackground"] = Color3.fromRGB(16, 16, 16),
                ["OtherInline"] = Color3.fromRGB(25, 24, 24),
            },
            Utility = {},
            GradientsThemes = {}, 
        }; do
            for Theme, Color in Themes.Preset do
                Themes.Utility[Theme] = {
                    BackgroundColor3 = {},
                    TextColor3 = {},
                    ImageColor3 = {},
                    ScrollBarImageColor3 = {},
                    Color = {},
                    PlaceholderColor3 = {},
                }
            end
    
            Library.Themify = function(self, Theme, Property)
                table.insert(Themes.Utility[Theme][Property], self.Instance)
                
                return self 
            end
    
            Library.GradientCheck = function(self, Keypoint, NewColor, Theme)
                if Color3ToRGB(Keypoint.Value) == Color3ToRGB(Themes.Preset[Theme]) then 
                    return {Time = Keypoint.Time, Value = NewColor}    
                end
            end
    
            Library.ConstructGradient = function(self, Constructor)
                local Returner = {} 
                
                for Index, Value in Constructor do
                    Returner[Index] = ColorSequenceKeypoint.new(Value.Time, Value.Value)
                end
    
                return ColorSequence.new(Returner)
            end 
    
            Library.SameColor = function(self, Color, CheckedTheme)
                for Name,Theme in Themes.Preset do 
                    if Name == CheckedTheme then 
                        continue 
                    end 
    
                    if Color3ToRGB(Color) == Color3ToRGB(Theme) then 
                        return true
                    end 
                end
    
                return false
            end
    
            Library.Refresh = function(self, Theme, Color)
                if self:SameColor(Color, Theme) then 
                    return 
                end 
    
                for Property, Data in Themes.Utility[Theme] do
                    for _, Object in Data do
                        if (property == "Transparency") and not (Object:IsA("UIStroke")) then
                            continue
                        end
    
                        if Object:IsA("UIGradient") then
                            local Constructor = {}
    
                            for Index,Keypoint in Object.Color.Keypoints do 
                                local Return = self:GradientCheck(Keypoint, Color, Theme)
    
                                if Return then 
                                    Constructor[Index] = Return
                                else 
                                    Constructor[Index] = {Time = Keypoint.Time, Value = Keypoint.Value} 
                                end 
                            end
    
                            local NewColor = self:ConstructGradient(Constructor)
                            Object.Color = NewColor
                        else 
                            if (Object[Property] == Themes.Preset[Theme]) then
                                Object[Property] = Color
                            end
                        end 
                    end
                end
    
                Themes.Preset[Theme] = Color
            end
    
            Library.ThemeListener = function(self, Theme, Statement, Property, Dumper)
                local Instance = self.Instance 
    
                Dumper = Dumper or "BackgroundColor3"
                Property = Property or "TextColor3"
                Theme = Theme or "Accent"
    
                Instance[Dumper] = Themes.Preset[Theme]   
                self:Themify(Theme, Dumper)
                
                Instance:GetPropertyChangedSignal(Dumper):Connect(function()
                    if Statement() then 
                        Instance[Property] = Themes.Preset[Theme]
                    end 
                end)
    
                return self
            end
    
            Library.GetTheme = function(self)
                local Config = {}
    
                for Idx, Value in Themes.Preset do
                    if Idx == "Font" then
                        continue
                    end
    
                    Config[Idx] = { Transparency = 1, Color = Value:ToHex() }
                end
    
                for Idx, Value in { "Blur Intensity", "Misc Transparency", "Main Transparency" } do
                    Config[Value] = Library.Flags[Value]
                end
    
                return Services.HttpService:JSONEncode(Config)
            end
    
            Library.SaveTheme = function(self, Config)
                if Config == "" then
                    return
                end
    
                local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Themes", Config)
                writefile(Path, self:GetTheme())
            end
    
            Library.DeleteTheme = function(self, Config)
                local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Themes", Config)
    
                if isfile(Path) then
                    delfile(Path)
                end
            end
    
            Library.UpdateThemingList = function(self)
                local List = {}
    
                for _, File in listfiles(Library.Directory .. "/Themes") do
                    local Name = File:gsub(Library.Directory .. "/Themes\\", ""):gsub(".Cfg", ""):gsub(
                    Library.Directory .. "\\Themes\\", "")
                    List[#List + 1] = Name
                end
    
                self:RefreshDropdown(List)
            end
        end Library.Themes = Themes
    
        local Fonts = {}; do
            function Fonts:New(Name, Weight, Style, Data)
                if not isfile(Library.Directory .. "/Fonts/" .. Data.Id) then
                    writefile(Library.Directory .. "/Fonts/" .. Data.Id, game:HttpGet(Data.Url))
                end
    
                local Data = {
                    name = Name,
                    faces = {
                        {
                            name = Name,
                            weight = Weight,
                            style = Style,
                            assetId = getcustomasset(Library.Directory .. "/Fonts/" .. Data.Id)
                        }
                    }
                }
    
                writefile(Library.Directory .. "/Fonts/" .. Name .. ".font", Services.HttpService:JSONEncode(Data))
                return Font.new(getcustomasset(Library.Directory .. "/Fonts/" .. Name .. ".font"))
            end
    
            Fonts.Main = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            Font2 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        end
    
        local EasingStyleNames = {"Linear", "Cubic", "Quad", "Quart", "Quint", "Sine", "Exponential", "Back", "Bounce", "Elastic", "Circular"}
    
        -- // Element Side functions
        do
            -- // Window    
            Library.SetMenuVisible = function(self, Bool)
                if self.Tweening then
                    return  
                end
    
                Library.Items:TweenDescendants(Bool, self)
    
                Library.Elements.Instance.Enabled = Bool
                self.Open = Bool  
            end
    
            -- // Page
            Library.OpenPage = function(self)
                if self.Tweening then return end 
    
                local Window = self.Window
                local OldTab = Window.TabInfo
    
                local Items = self.Items
    
                if OldTab == self or (self.Tweening or (OldTab and OldTab.Tweening)) then
                    return
                end
    
                if OldTab then
                    local OldItems = OldTab.Items
    
                    OldItems.Icon:Tween({ImageColor3 = Themes.Preset.TextDisabled})
                    OldItems.Title:Tween({TextColor3 = Themes.Preset.TextDisabled})
    
                    OldItems.Accent:Tween({BackgroundTransparency = 1})
                    OldItems.AccentBar:Tween({BackgroundTransparency = 1})
    
                    OldItems.Pages:TweenDescendants(false, OldTab)
                    OldItems.Pages.Parent = Library.Other.Instance
    
                    OldTab.Tweening = false -- // To nullify the debounce, yes kind of annoying todo but its whatever 
                end
    
                Items.Icon:Tween({ImageColor3 = Themes.Preset.Accent})
                Items.Title:Tween({TextColor3 = Themes.Preset.TextEnabled})
    
                Items.Accent:Tween({BackgroundTransparency = 0})
                Items.AccentBar:Tween({BackgroundTransparency = 0})
    
                Items.Pages:TweenDescendants(true, self)
                Items.Pages.Parent = self.Parent;
                
                Window.TabInfo = self
            end
    
            Library.OpenMultiPage = function(self)
                if self.Tweening then return end 
    
                local Tab = self.Tab
                local OldTab = Tab.TabInfo
                
                local Items = self.Items
    
                if OldTab == self or (self.Tweening or (OldTab and OldTab.Tweening)) then
                    return
                end
    
                if OldTab then
                    local OldItems = OldTab.Items
    
                    OldItems.UIStroke:Tween({Transparency = 1})
                    OldItems.Title:Tween({TextColor3 = Themes.Preset.TextDisabled})
                        
                    OldItems.PageHolder:TweenDescendants(false, OldTab)
                    OldItems.PageHolder.Parent = Library.Other.Instance
                end
    
                Items.UIStroke:Tween({Transparency = 0})
                Items.Title:Tween({TextColor3 = Themes.Preset.TextEnabled})
    
                self.Tweening = false 
                Items.PageHolder:TweenDescendants(true, self)
                Items.PageHolder.Parent = self.Parent;
    
                Tab.TabInfo = self
            end
    
            Library.AddPage = function(self, Data)
                Data = Data or {} 
                
                local Cfg = {
                    Text = Data.Text or Data.Name or Data.Title or "Tab",
                    Columns = Data.Columns or 2,
    
                    OldTab = {}, 
                    Items = {}, 
    
                    Parent = self.Items.Pages.Instance, 
    
                    TabInfo, 
                    Tab = self,
                    Tweening = false,
                    SectionData = self.SectionData,
    
                    Names = self.Names, 
                    Elements = self.Elements
                }
    
                local Items = Cfg.Items; do  
                    -- // Page
                    Items.PageHolder = Library:Create("ScrollingFrame",{Visible = false; Selectable = false; ZIndex = 2; BorderSizePixel = 0; CanvasSize = UDim2.new(0, 0, 0, 0); ScrollBarImageColor3 = Themes.Preset.Accent; MidImage = "rbxassetid://79702515185028"; ScrollBarThickness = 4; Parent = Library.Other.Instance; Size = UDim2.new(1, 8, 1, -38); Position = UDim2.new(0, 0, 0, 38); BackgroundTransparency = 1; AutomaticCanvasSize = Enum.AutomaticSize.Y; BottomImage = "rbxassetid://138501318258067"; TopImage = "rbxassetid://88458957766814"; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    :Reparent(Cfg.Parent)
                    Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.PageHolder.Instance; Padding = UDim.new(0, 14); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingRight = UDim.new(0, 12); PaddingTop = UDim.new(0, 0); Parent = Items.PageHolder.Instance})
    
                    -- // Button 
                    Items.Button = Library:Create("TextButton",{Parent = self.Items.MultiHolder.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 6); PaddingBottom = UDim.new(0, 6); Parent = Items.Button.Instance; PaddingRight = UDim.new(0, 10); PaddingLeft = UDim.new(0, 10)})
                    Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Color3.fromRGB(141, 135, 135); Text = Cfg.Text; Parent = Items.Button.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Button.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Color3.fromRGB(10, 9, 9); Transparency = 1; Parent = Items.Button.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
    
                    -- // Columns
                    for Index = 1, Cfg.Columns do
                        Items[tostring(Index)] = Library:Create("Frame",{Parent = Items.PageHolder.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 100, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                        Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items[tostring(Index)].Instance; Padding = UDim.new(0, 12); SortOrder = Enum.SortOrder.LayoutOrder})
                    end
                end 
    
                local MultiPage = setmetatable(Cfg, Library)
    
                Items.Button:OnClick(function()
                    if Cfg.Tweening or self.Tweening then
                        return 
                    end
    
                    MultiPage:OpenMultiPage()
                    
                    self.Tweening = true 
                    task.wait(Library.TweeningSpeed)
                    self.Tweening = false
                end)
    
                if not self.TabInfo then
                    MultiPage:OpenMultiPage()
                end 
                
                return MultiPage
            end
            
            -- // Section
            Library.CreateElements = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Parent = Data.Parent or self.Items.Section or self.Instance,
                    Position = Data.Position or UDim2.new(0, 13, 0, 13),
                    Size = Data.Size or UDim2.new(1, -26, 0, 0),
    
                    Items = {},
                    DataElements = {},
                }
    
                local Items = Cfg.Items; do
                    Items.Elements = Library:Create("Frame",{Parent = self.Instance or Cfg.Parent; BackgroundTransparency = 1; Position = Cfg.Position; Size = Cfg.Size; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Elements.Instance; Padding = UDim.new(0, 12); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 13); Parent = Items.Elements.Instance})
                end
    
                Cfg.SetVisible = function(Bool)
                    Items.Elements.Instance.Visible = Bool
                end
    
                return setmetatable(Cfg, Library)
            end
    
            -- // Elements
            Library.SetupElement = function(self, Default, Extra)
                if self.Set and self.Flag then
                    ConfigFlags[self.Flag] = self.Set
                    self.Set(Default)
                end
    
                if self.Items.Object and self.Names and self.Elements then
                    table.insert(self.Names, self.Text)
                    table.insert(self.Elements, self.Items.Object)
                end
    
                if self.Hovering and self.Type ~= "Label" and self.DataElements and self.IsHovering then
                    table.insert(self.DataElements, self.IsHovering)
                end
            end
    
            -- // Slider
            Library.UpdateSlider = function(self, Input)
                local Items = self.Items
    
                local Size = (Input.Position.X - Items.Outline.Instance.AbsolutePosition.X) / Items.Outline.Instance.AbsoluteSize.X
                local Value = ((self.Max - self.Min) * Size) + self.Min
    
                self.Set(Value)
            end
    
            Library.UpdateRangeSlider = function(self, Input)
                local Items = self.Items 
    
                local MouseX = Input.Position.X
                local BarX = Items.Holder.Instance.AbsolutePosition.X
                local BarW = Items.Holder.Instance.AbsoluteSize.X
    
                local Scale = math.clamp((MouseX - BarX) / BarW, 0, 1)
                local Value = Library:Round((Scale * (self.Max - self.Min)) + self.Min, self.Intervals)
    
                if self.SlidingHandle == Items.Min then
                    self.Set(Value, self.Value[2])
                else
                    self.Set(self.Value[1], Value)
                end
            end
    
            Library.UpdateSliderPosition = function(self, Bool, Debounce)
                local Items = self.Items
                    
                local YOffset = 81 - 5
                local Position = Debounce and Items.Settings.Instance.AbsolutePosition or Vector2.new(Mouse.X, Mouse.Y)
                local Width = Library:Round(Position.X, 0.5)
                local FrameWidth = Library:Round(Items.Value.Instance.AbsoluteSize.X, 0.5)
    
                if Debounce then
                    return
                end
    
                if Bool then
                    Items.Settings.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15)))
                    Items.Settings:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset)) })
                else
                    Items.Settings:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15))) })
                end
            end
    
            -- // Lists / Dropdowns
            Library.RenderDropdownOption = function(self, Text)
                local Items = self.Items
                local Items = {}    
    
                Items.Value = Library:Create("TextLabel",{
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); 
                    TextColor3 = Themes.Preset["TextEnabled"]; 
                    Text = Text or "dropdown"; 
                    Parent = self.Items.OptionsHolder.Instance; 
                    Size = UDim2.new(1, 0, 0, 0); 
                    Position = UDim2.new(0, 25, 0, 0); 
                    BackgroundTransparency = 1; 
                    TextXAlignment = Enum.TextXAlignment.Left; 
                    BorderSizePixel = 0; 
                    AutomaticSize = Enum.AutomaticSize.Y; 
                    TextSize = 16; 
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Themify("TextEnabled", "TextColor3"):Themify("Accent", "TextColor3")
    
                Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 9); PaddingBottom = UDim.new(0, 9); Parent = Items.Value.Instance; PaddingRight = UDim.new(0, 9); PaddingLeft = UDim.new(0, 9)})
    
                -- Items.Value.Instance.Text = Text
    
                table.insert(self.OptionInstances, Items)
    
                return Items
            end 
    
            Library.RefreshDropdown = function(self, Options)
                local Items = self.Items
    
                for _, Option in self.OptionInstances do
                    Option.Value.Instance:Destroy()
                end
    
                self.OptionInstances = {}
    
                for _, Option in Options do
                    local Object = self:RenderDropdownOption(Option)
                    local Button = Object.Value
                    local Text = Object.Value.Instance.Text
                    
                    Button:OnClick(function()
                        if self.Tweening then
                            return
                        end
    
                        if self.Multi then
                            local Selected = table.find(self.MultiItems, Text)
    
                            if Selected then
                                table.remove(self.MultiItems, Selected)
                            else
                                table.insert(self.MultiItems, Text)
                            end
    
                            self.Set(self.MultiItems)
                        else
                            self.Set(Text)
                        end
                    end)
                end
    
                if #self.OptionInstances >= 10 or self.Scrolling then
                    Items.OptionsHolder.Instance.Size = UDim2.new(1, 0, 0, 100)
                    Items.OptionsHolder.Instance.AutomaticSize = Enum.AutomaticSize.None
                else
                    Items.OptionsHolder.Instance.Size = UDim2.new(1, 0, 0, 0)
                    Items.OptionsHolder.Instance.AutomaticSize = Enum.AutomaticSize.Y
                end
            end
    
            Library.RenderListOption = function(self, Text)
                local Items = {}    
    
                Items.Value = Library:Create("TextLabel",{BackgroundColor3 = Themes.Preset.Accent; Parent = self.Items.Holder.Instance; TextColor3 = Themes.Preset.TextMisc; Text = Text; Size = UDim2.new(1, 0, 0, 0); ClipsDescendants = true; BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; RichText = true; AutomaticSize = Enum.AutomaticSize.Y}):Themify("Accent", "BackgroundColor3"):Themify("TextMisc", "TextColor3")
                Items.UIStroke = Library:Create("UIStroke",{Parent = Items.Value.Instance; LineJoinMode = Enum.LineJoinMode.Miter})
                Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 4); PaddingBottom = UDim.new(0, 4); Parent = Items.Value.Instance; PaddingRight = UDim.new(0, 4); PaddingLeft = UDim.new(0, 4)})
    
                Items.Value.Instance.TextTransparency = 0
    
                Items.Value.Instance:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
                    local Value = Flags[self.Flag]
                    local Text = Items.Value.Instance.Text
                    local IsTable = type(Value) == "table"
    
                    if (Text == Value or (IsTable and table.find(Value, Text))) then 
                        Items.Value.Instance.TextColor3 = Themes.Preset.Accent
                    end  
                end)
    
                local Hover = function()
                    local Value = Flags[self.Flag]
                    local Text = Items.Value.Instance.Text
                    local IsTable = type(Value) == "table"
    
                    if not (Text == Value or (IsTable and table.find(Value, Text))) then 
                        Items.Value:Tween({TextColor3 = Themes.Preset.TextMain})
                    end 
                end 
    
                local NoHover = function()
                    local Value = Flags[self.Flag]
                    local Text = Items.Value.Instance.Text
                    local IsTable = type(Value) == "table"
    
                    if not (Text == Value or (IsTable and table.find(Value, Text))) then 
                        Items.Value:Tween({TextColor3 = Themes.Preset.TextMisc})
                    end 
                end 
    
                Items.Value:OnHover(Hover, NoHover)
    
                table.insert(self.OptionInstances, Items)
    
                return Items
            end 
            
            Library.RefreshList = function(self, Options)
                local Items = self.Items
    
                for _, Option in self.OptionInstances do
                    Option.Value.Instance:Destroy()
                end
                
                self.OptionInstances = {}
    
                for _, Option in Options do
                    local Object = self:RenderListOption(Option)
                    local Button = Object.Value
                    local Text = Object.Value.Instance.Text
                        
                    Button:OnClick(function()
                        if self.Multi then
                            local Selected = table.find(self.MultiItems, Text)
    
                            if Selected then
                                table.remove(self.MultiItems, Selected)
                            else
                                table.insert(self.MultiItems, Text)
                            end
    
                            self.Set(self.MultiItems)
                        else
                            self.Set(Text)
                        end
                    end)
                end
            end
    
            Library.UpdateDropdownPosition = function(self, Bool, Debounce)
                local Items = self.Items
    
                local YOffset = 100
                local Position = Items.Outline.Instance.AbsolutePosition
                local Width = Library:Round(Position.X, 0.5)
                local FrameWidth = Library:Round(Items.Outline.Instance.AbsoluteSize.X, 0.5)
    
                Items.DropdownHolder.Instance.Size = UDim2.fromOffset(FrameWidth,
                Items.DropdownHolder.Instance.AbsoluteSize.Y)
    
                if Debounce then
                    Items.DropdownHolder.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset))
    
                    return
                end
    
                if Bool then
                    Items.DropdownHolder.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15)))
                    Items.DropdownHolder:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset)) })
                else
                    Items.DropdownHolder:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15))) })
                end
            end
    
            -- // Keybind 
            Library.SetMode = function(self, Mode)
                local Items = self.Items;
                self.Mode = Mode
    
                if Mode == "Always" then
                    self.Set(true)
                elseif Mode == "Hold" then
                    self.Set(false)
                end
    
                Flags[self.Flag].Mode = Mode
            end
    
            Library.NewKey = function(self)
                if self.Binding then
                    return
                end
    
                task.wait()
    
                local Items = self.Items
    
                Items.Value.Instance.Text = "Selecting"
    
                self.Binding = Library:Connect(Services.UserInputService.InputBegan, function(Input, GameProcessedEvent)
                    if GameProcessedEvent then -- // Stops stuff like chatting clicking other buttons etc.
                        return
                    end
    
                    self.Set(Input.KeyCode ~= Enum.KeyCode.Unknown and Input.KeyCode or Input.UserInputType)
    
                    if self.Binding and self.Binding.Connection then 
                        self.Binding.Connection:Disconnect()
                        self.Binding = nil
                    end 
                end)
            end
    
            Library.UpdateKeyPickerPosition = function(self, Bool, Debounce)
                local Items = self.Items
                    
                local YOffset = 91
                local Position = Items.Outline.Instance.AbsolutePosition
                local Width = Library:Round(Position.X, 0.5)
                local FrameWidth = Library:Round(Items.Outline.Instance.AbsoluteSize.X, 0.5)
    
                if Debounce then
                    Items.Section.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset))
    
                    return
                end
    
                if Bool then
                    Items.Section.Instance.Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15)))
                    Items.Section:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + YOffset)) })
                else
                    Items.Section:Tween({ Position = UDim2.fromOffset(Width, math.floor(Position.Y + (YOffset - 15))) })
                end
            end
    
            -- // Colorpicker
            Library.Colorpicker = function(self, properties)
                local Cfg = {
                    Text = properties.Text or properties.Name or properties.Title or "Color",
                    Flag = properties.Flag or properties.Name or properties.Title or properties.Text or Library:NextFlag(),
                    Callback = properties.Callback or function() end,
    
                    Color = properties.Color or Color3.fromRGB(1, 1, 1),
                    Alpha = properties.Alpha or properties.Transparency or 0,
                    Colors = properties.Colors or {},
    
                    Open = false,
                    PageCount = 0;
                    Items = {},
                    OldTab; 
                    Tweening = false,
    
                    Type = properties.Type or "Animation", -- // Terminating condition
                    Colorpickers = {},
                    ColorpickerMetadata = {},
    
                    DataElements = self.DataElements,
                }   
    
                local DraggingSat = false
                local DraggingHue = false
                local DraggingAlpha = false
    
                local h, s, v = Cfg.Color:ToHSV()
                local a = Cfg.Alpha
    
                local OldHue = h;
                local OldAlpha = a;
    
                local Colorpicker = setmetatable(Cfg, Library)
    
                local Items = Cfg.Items; do
                    -- // Label
                    Items.ComponentsHolder = self.Items.ComponentsHolder
                    if not Items.ComponentsHolder then 
                        Items.Label =  self:AddLabel({Name = Cfg.Text})
                        Items.ComponentsHolder = Items.Label.Items.ComponentsHolder
                        Items.Label.Items.Title.Instance.Position = UDim2.new(0, 0, 0, 5)
                    end 
    
                    -- // Button 
                    Items.Clicker = Library:Create("Frame",{Parent = Items.ComponentsHolder.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 0, 1, 5); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.ObjectColor = Library:Create("Frame",{Parent = Items.Clicker.Instance; Position = UDim2.new(0, 0, 0, 9); Size = UDim2.new(0, 14, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 0, 0)})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.ObjectColor.Instance; CornerRadius = UDim.new(1, 0)})
    
                    -- // Object                       
                    Items.Outline = Library:Create("TextButton",{Visible = false; FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["PageBackground"]; Text = ""; AutoButtonColor = false; Parent = Library.Other.Instance; Position = UDim2.new(0.1930195689201355, 0, 0.21043477952480316, 0); Size = UDim2.new(0, 245, 0, 264); BorderSizePixel = 0; TextSize = 14; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3"):Reparent(Library.Elements.Instance)
                    Items.Outline:OutsideClick(Cfg)
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Outline.Instance; CornerRadius = UDim.new(0, 0)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.Outline.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border}):Themify("PageElementOutline", "Color")
                    Items.MainHolder = Library:Create("Frame",{Parent = Items.Outline.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.SatValBackground = Library:Create("Frame",{Parent = Items.MainHolder.Instance; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(21, 255, 99)})
                    Items.Saturation = Library:Create("Frame",{Parent = Items.SatValBackground.Instance; Size = UDim2.new(1, 0, 1, 0); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 270; Transparency = NumSeq{NumKey(0, 0), NumKey(1, 1)}; Parent = Items.Saturation.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(0, 0, 0)), ColorKey(1, Color3.fromRGB(0, 0, 0))}})
                    Items.Value = Library:Create("Frame",{Parent = Items.SatValBackground.Instance; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIGradient = Library:Create("UIGradient",{Parent = Items.Value.Instance; Transparency = NumSeq{NumKey(0, 0), NumKey(1, 1)}})
                    Items.SatValPickerHolder = Library:Create("Frame",{Parent = Items.SatValBackground.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 3, 0, 3); Size = UDim2.new(1, -6, 1, -6); ZIndex = 2; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.SatValPicker = Library:Create("Frame",{Parent = Items.SatValPickerHolder.Instance; AnchorPoint = Vector2.new(0.5, 0.5); BackgroundTransparency = 1; Position = UDim2.new(0.5, 0, 0.5, 0); Size = UDim2.new(0, 3, 0, 3); ZIndex = 100; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.HueOutlinePicker = Library:Create("UIStroke",{Thickness = 2; LineJoinMode = Enum.LineJoinMode.Bevel; Color = Color3.fromRGB(255, 255, 255); Parent = Items.SatValPicker.Instance})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.SatValPicker.Instance; CornerRadius = UDim.new(1, 0)})
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.SatValBackground.Instance})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingRight = UDim.new(0, 30); Parent = Items.MainHolder.Instance})
                    Items.Hue = Library:Create("Frame",{AnchorPoint = Vector2.new(1, 0); Parent = Items.MainHolder.Instance; Position = UDim2.new(1, 30, 0, 0); Size = UDim2.new(0, 18, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Hue.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(255, 0, 0)), ColorKey(0.17, Color3.fromRGB(255, 255, 0)), ColorKey(0.33, Color3.fromRGB(0, 255, 0)), ColorKey(0.5, Color3.fromRGB(0, 255, 255)), ColorKey(0.67, Color3.fromRGB(0, 0, 255)), ColorKey(0.83, Color3.fromRGB(255, 0, 255)), ColorKey(1, Color3.fromRGB(255, 0, 0))}})
                    Items.HuePickerHolder = Library:Create("Frame",{Parent = Items.Hue.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0, 3); Size = UDim2.new(1, 0, 1, -6); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.HuePicker = Library:Create("Frame",{Parent = Items.HuePickerHolder.Instance; AnchorPoint = Vector2.new(0.5, 0.5); BackgroundTransparency = 0.10000000149011612; Position = UDim2.new(0.5, 0, 0.5, 0); Size = UDim2.new(1, 0, 0, 2); ZIndex = 100; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Holder = Library:Create("Frame",{Parent = Items.Outline.Instance; AnchorPoint = Vector2.new(0, 1); BackgroundTransparency = 1; Position = UDim2.new(0, 0, 1, 0); Size = UDim2.new(1, -2, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.HexHolder = Library:Create("Frame",{Parent = Items.Holder.Instance; Position = UDim2.new(0, 1, 0, 27); Size = UDim2.new(1, -2, 0, 32); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.HexHolder.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.HexHolder.Instance}):Themify("PageElementOutline", "Color")
                    Items.HexInput = Library:Create("TextBox",{ClearTextOnFocus = false; FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = "# FFFFFF"; Parent = Items.HexHolder.Instance; Size = UDim2.new(1, 0, 1, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; TextTruncate = Enum.TextTruncate.SplitWord; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingLeft = UDim.new(0, 9); Parent = Items.HexInput.Instance})
                    Items.AlphaHolder = Library:Create("Frame",{Parent = Items.Holder.Instance; Position = UDim2.new(0, 1, 0, 27); Size = UDim2.new(1, -2, 0, 32); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.AlphaHolder.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.AlphaHolder.Instance}):Themify("PageElementOutline", "Color")
                    Items.AlphaInput = Library:Create("TextBox",{ClearTextOnFocus = false; FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = "% 100"; Parent = Items.AlphaHolder.Instance; Size = UDim2.new(1, 0, 1, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; TextTruncate = Enum.TextTruncate.SplitWord; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingLeft = UDim.new(0, 9); Parent = Items.AlphaInput.Instance})
                    Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.Holder.Instance; Padding = UDim.new(0, 12); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 1); Parent = Items.Holder.Instance; PaddingLeft = UDim.new(0, 1); PaddingRight = UDim.new(0, -1)})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 12); PaddingBottom = UDim.new(0, 12); Parent = Items.Outline.Instance; PaddingRight = UDim.new(0, 12); PaddingLeft = UDim.new(0, 12)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Outline.Instance; Padding = UDim.new(0, 13); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                end
                
                Cfg.SetVisible = function(Bool)
                    if Cfg.Tweening then
                        return
                    end
    
                    Cfg.Open = Bool
    
                    if (Cfg.Open == true) and Items.Outline.Instance.Visible then 
                        return
                    end 
    
                    local ColorpickerObject = Items.ObjectColor.Instance
                    Items.Outline.Instance.Position = UDim2.new(0, ColorpickerObject.AbsolutePosition.X, 0, ColorpickerObject.AbsolutePosition.Y + (Cfg.Open and 64 or 79))
                    Items.Outline:Tween({ Position = UDim2.new(0, ColorpickerObject.AbsolutePosition.X, 0, ColorpickerObject.AbsolutePosition.Y + (Cfg.Open and 79 or 64))})
                    Items.Outline:TweenDescendants(Cfg.Open, Cfg)
                    Items.Outline:ClampToScreen()
                end
    
                Cfg.UpdateColor = function()
                    local Mouse = Services.UserInputService:GetMouseLocation()
                    local Offset = Vector2.new(Mouse.X, Mouse.Y - GuiInset)
    
                    if DraggingSat then
                        s = math.clamp((Offset - Items.Saturation.Instance.AbsolutePosition).X / Items.Saturation.Instance.AbsoluteSize.X, 0, 1)
                        v = 1 - math.clamp((Offset - Items.Saturation.Instance.AbsolutePosition).Y / Items.Saturation.Instance.AbsoluteSize.Y, 0, 1)
                    elseif DraggingHue then
                        h = math.clamp((Offset - Items.Hue.Instance.AbsolutePosition).Y / Items.Hue.Instance.AbsoluteSize.Y, 0, 1)
                    end
    
                    Cfg.Set()
                end
    
                Cfg.Set = function(Color, Alpha, Colors)
                    if Color then
                        h, s, v = Color:ToHSV()
                    end 
    
                    if Alpha then
                        a = Alpha
                    end
    
                    local Flag = Flags[Cfg.Flag]
    
                    Items.ObjectColor.Instance.BackgroundColor3 = Color3.fromHSV(h, s, v)
                    Items.SatValBackground.Instance.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
    
                    Items.SatValPicker:Tween({ Position = UDim2.new(s, 0, 1 - v, 0) })
                    Items.HuePicker:Tween({ Position = UDim2.new(0.5, 0, h, 0) })
    
                    Color = Items.ObjectColor.Instance.BackgroundColor3
    
                    Items.AlphaInput.Instance.Text = "% " .. (a * 100)
                    Items.HexInput.Instance.Text = "# " .. Color:ToHex()
    
                    Cfg.Color = Color 
                    Cfg.Alpha = a
    
                    Flags[Cfg.Flag] = {
                        Color = Color,
                        Transparency = a,
                        Colors = Cfg.Colors
                    }
    
                    Cfg.Callback(Color, a)
                end
    
                Cfg.DisableDragging = function()
                    DraggingSat = false
                    DraggingHue = false
                    DraggingAlpha = false
                end
    
                Cfg.IsHovering = function()
                    return Items.Outline:Hovering()
                end
    
                Items.Hue:OnDrag(Cfg.UpdateColor, function(Dragging)
                    if Dragging then
                        DraggingHue = true
                    else
                        Cfg.DisableDragging()
                    end
                end)
    
                Items.Saturation:OnDrag(Cfg.UpdateColor, function(Dragging)
                    if Dragging then
                        DraggingSat = true
                    else
                        Cfg.DisableDragging()
                    end
                end)
    
                Items.Clicker:OnClick(function()
                    Cfg.Open = not Cfg.Open
    
                    Cfg.SetVisible(Cfg.Open)
                end)
    
                Items.AlphaInput.Instance.FocusLost:Connect(function()
                    Cfg.Set(Items.ObjectColor.Instance.BackgroundColor3, tonumber(string.sub(Items.AlphaInput.Instance.Text, 3)) / 100)
                end)
    
                Items.HexInput.Instance.FocusLost:Connect(function()
                    local r, g, b = Library:ConvertFromHex(Items.HexInput.Instance.Text:gsub("# ", ""))
    
                    if r and g and b and Cfg.Set then 
                        Cfg.Set(Color3.new(r, g, b), Cfg.Alpha)
                    else 
                        Cfg.Set(Cfg.Color, Cfg.Alpha)
                    end 
                end)
    
                Colorpicker:SetupElement(Cfg.Color, Cfg.Alpha)
    
                return setmetatable(Cfg, Library)
            end
    
            do -- // Notification Library
                local YOffset = 0 
                local BiggestX = 0 
    
                Library.Notify = function(self, Data)
                    Data = Data or {} 
    
                    local Cfg = {
                        Text = Data.Title or Data.Name or Data.Text or "Title";
                        Lifetime = Data.Lifetime or 5; 
    
                        Items = {};
                        Status = true;
                        Fade = 2;
                        Tick = tick();
                        Index = #self.Notifications + 1
                    }
                    
                    local Items = Cfg.Items; do 
                        Items.Notification = Library:Create("CanvasGroup",{GroupTransparency = 1; Active = true; Parent = Library.HUD.Instance; Position = Pos(0.1930195689201355, 0, 0.07565217465162277, 0); Selectable = true; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                        Items.UICorner = Library:Create("UICorner",{Parent = Items.Notification.Instance; CornerRadius = UDim.new(0, 6)})
                        Items.UIStroke = Library:Create("UIStroke",{Transparency = 1; Color = Themes.Preset["OtherInline"]; Parent = Items.Notification.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border}):Themify("OtherInline", "Color")
                        Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Notification.Instance; Padding = UDim.new(0, 13); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                        Items.Elements = Library:Create("Frame",{Parent = Items.Notification.Instance; BackgroundTransparency = 1; Position = Cfg.Position; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY})
                        Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Elements.Instance; Padding = UDim.new(0, 9); SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal})
                        Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 13); Parent = Items.Elements.Instance})
                        Items.Text = Library:Create("TextLabel",{TextColor3 = Themes.Preset["TextEnabled"]; Text = Cfg.Text; Parent = Items.Elements.Instance; Position = Pos(0, 25, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY}):Themify("TextEnabled", "TextColor3")
                        Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 10); PaddingBottom = UDim.new(0, -2); Parent = Items.Notification.Instance; PaddingRight = UDim.new(0, 12); PaddingLeft = UDim.new(0, 12)})
                    end     
                    
                    self.Notifications[Cfg.Index] = Cfg 
                    -- Items.Accent:Tween({Size = UDim2.new(0, Items.Notification.Instance.AbsoluteSize.X - 4, 0, 1)}, TweenInfo.new(Cfg.Lifetime, Library.EasingStyle, Library.EasingDirection, 0, false, 0))
    
                    task.delay(Cfg.Lifetime + 1, function()
                        Items.Notification.Instance:Destroy() 
                        self.Notifications[Cfg.Index] = nil 
                    end)
    
                    return setmetatable(Cfg, Library)
                end 
    
                Library.LerpObjects = function(self)
                    YOffset = 0
                    BiggestX = 0
    
                    local Tick = tick()
                    for _,Object in self.Notifications do
                        Object.Fade = Library:Lerp(Object.Fade, Object.Status and 255 or 0, 0.02)
                            
                        if Tick - Object.Tick >= Object.Lifetime then 
                            Object.Status = false 
                        end     
    
                        local Instance = Object.Items.Notification.Instance
    
                        local Offset = UDim2.new(0, 30, 0, 80) 
                        local Transparency = 1 - (1 * (Object.Fade / 255))
    
                        Instance.Position = Offset + UDim2.new(0, -(Instance.AbsoluteSize.X - (Instance.AbsoluteSize.X * (Object.Fade / 255))), 0, YOffset)
                        Object:SetTransparency(Transparency)
    
                        if Object.Status and BiggestX < Instance.AbsoluteSize.X then
                            BiggestX = math.max(BiggestX, Instance.AbsoluteSize.X)
                        end
    
                        YOffset += (Instance.AbsoluteSize.Y + 6) * (Object.Fade / 255)
                    end     
                end
    
                Library.SetTransparency = function(self, Num) 
                    self.Items.Notification.Instance.GroupTransparency = Num
                    self.Items.UIStroke.Instance.Transparency = Num
                end 
            end 
    
            do -- // Keybind List Library 
                local YOffset = 0 
                local BiggestX = 0 
                local KeybindListTransparency = 0 
    
                Library.AddHotKey = function(self, Data)
                    Data = Data or {} 
                    
                    local Cfg = {
                        Lifetime = Data.Lifetime or 5; 
    
                        Items = {};
                        Status = true;
                        Fade = 2;
                        Tick = tick();
                        Index = #self.Keybinds + 1
                    }   
    
                    local Items = Cfg.Items; do 
                        Items.Keybind = Library:Create("CanvasGroup",{Parent = self.Window.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 16); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                        Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = Cfg.Text; Parent = Items.Keybind.Instance; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                        Items.Mode = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = "(Hold)"; Parent = Items.Keybind.Instance; AnchorPoint = Vector2.new(1, 0); Position = UDim2.new(1, 0, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    end     
    
                    function Cfg:ChangeText(Key, Name, Mode)
                        Items.Title.Instance.Text = string.format("%s [%s]", Name, Key)
                        Items.Mode.Instance.Text = "("..Mode..")"
                    end 
    
                    function Cfg:SetEnabled(Bool)
                        Cfg.Status = Bool
                    end
    
                    self.Keybinds[Cfg.Index] = Cfg 
    
                    return setmetatable(Cfg, Library)
                end 
    
                Library.LerpKeybinds = function(self)
                    if not self.Window then return end
                    YOffset = 0
                    BiggestX = 0
    
                    local Tick = tick()
                    for _,Object in self.Keybinds do
                        Object.Fade = Library:Lerp(Object.Fade, Object.Status and 255 or 0, 0.02)  
                        local Instance = Object.Items.Keybind.Instance
    
                        local Offset = UDim2.new(0, 1, 0, 0) -- great pasting skills
                        local Transparency = 1 - (1 * (Object.Fade / 255))
    
                        Instance.Position = Offset + UDim2.new(0, -(Instance.AbsoluteSize.X - (Instance.AbsoluteSize.X * (Object.Fade / 255))), 0, YOffset)
                        Object:SetKeypickerTransparency(Transparency)
                        
                        if Object.Status and BiggestX < Instance.AbsoluteSize.X then
                            BiggestX = math.max(BiggestX, Instance.AbsoluteSize.X * (Object.Fade / 255))
                        end
    
                        YOffset += (Instance.AbsoluteSize.Y + 5) * (Object.Fade / 255)
                    end     
    
                    self.Window.Items.Elements.Instance.Size = UDim2.new(1, -24, 0, YOffset)
                    self.Window.Items.KeybindList.Instance.Size = UDim2.new(0, 245, 0, YOffset + 51)
                end
    
                Library.SetKeypickerTransparency = function(self, Num) 
                    self.Items.Keybind.Instance.GroupTransparency = Num
                end 
            end 
        end
    
        -- // Library Functions
        do
            -- // Data Library
            do
                Library.ConvertToHex = function(self, Color)
                    local r = math.floor(Color.R * 255)
                    local g = math.floor(Color.G * 255)
                    local b = math.floor(Color.B * 255)
                    return string.format("#%02X%02X%02X", r, g, b)
                end 
    
                Library.ConvertFromHex = function(self, Color)
                    Color = Color:gsub("#", "")
                    local r = tonumber(Color:sub(1, 2), 16) / 255
                    local g = tonumber(Color:sub(3, 4), 16) / 255
                    local b = tonumber(Color:sub(5, 6), 16) / 255
                    return r, g, b
                end
    
                Library.GroupRGB = function(self, String)
                    local Values = {}
    
                    for Value in string.gmatch(String, "[^,]+") do
                        table.insert(Values, tonumber(Value))
                    end
    
                    if #Values == 3 then
                        return unpack(Values)
                    else
                        return
                    end
                end
    
                Library.ConvertEnum = function(self, enum)
                    local EnumParts = {}
    
                    for _, part in string.gmatch(tostring(enum), "[%w_]+") do
                        table.insert(EnumParts, part)
                    end
    
                    local EnumTable = tostring(enum)
    
                    for i = 2, #EnumParts do
                        local EnumItem = EnumTable[EnumParts[i]]
    
                        EnumTable = EnumItem
                    end
    
                    return EnumTable
                end
    
                Library.Lerp = function(self, start, finish, t)
                    t = t or 1 / 8
    
                    return start * (1 - t) + finish * t
                end
    
                Library.Round = function(self, num, float)
                    local Multiplier = 1 / (float or 1)
                    return math.floor(num * Multiplier + 0.5) / Multiplier
                end
    
                Library.IsDecimal = function(self, Num)
                    return math.floor(Num) ~= Num
                end
    
                Library.GetCalculatePosition = function(self, Position, Normal, Origin, Direction)
                    local n = Normal;
                    local d = Direction;
                    local v = Origin - Position;
    
                    local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z); -- Dot exists for vector3.new i think? idk im not good with math
                    local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
                    local a = -num / den;
    
                    return Origin + (a * Direction);
                end
            end
    
            -- // Instance Library
            do
                Library.Create = function(self, Class, Options)
                    local Info = {
                        Instance = Instance.new(Class),
                        Properties = Options,
                        Tweening = false,
                        Blur,
                    }
    
                    local Instance = Info.Instance
                    local Mt = setmetatable(Info, Library)
    
                    for Property, Value in Info.Properties do
                        if Property == "ScrollingBarImageColor3" then 
                            continue 
                        end 
    
                        Instance[Property] = Value
                    end
    
                    if Class == "TextButton" then
                        Instance.AutoButtonColor = false
                        Instance.Text = ""
                    end
    
                    if Class == "ScrollingFrame" then 
                        Instance.ScrollBarImageColor3 = Themes.Preset.Accent
                        Mt:Themify("Accent", "ScrollBarImageColor3")
                    end 
    
                    if Class == "TextLabel" or Class == "TextBox" or Class == "TextButton" then
                        Instance.FontFace = Fonts.Main
                        Instance.TextSize = 16
                        
                        if (not Info.Properties["TextColor3"]) then 
                            Instance.TextColor3 = Themes.Preset.TextEnabled
                        end
                    end
    
                    if Class == "ScreenGui" then
                        table.insert(self.Guis, Instance)
                    end
    
                    if Class == "UIGradient" then 
                        local KeyPoints = Instance.Color.Keypoints
    
                        for _,KeyPoint in KeyPoints do 
                            local Color = Color3ToRGB(KeyPoint.Value)
    
                            if #KeyPoints > 2 then 
                                break
                            end 
    
                            for Name,Value in Themes.Preset do 
                                if Color3ToRGB(Value) == Color then 
                                    if not table.find(Themes.GradientsThemes, Name) then 
                                        table.insert(Themes.GradientsThemes, Name)
                                    end
    
                                    Mt:Themify(Name, "Color")
                                end 
                            end
                        end 
                    end 
    
                    local ColorProperties = Library:GetColors(Instance)
    
                    if ColorProperties then 
                        for _,Property in ColorProperties do 
                            local Color = Color3ToRGB(Instance[Property])
    
                            for Name,Value in Themes.Preset do 
                                if Color3ToRGB(Value) == Color then 
                                    Mt:Themify(Name, Property)
                                end 
                            end
                        end 
                    end 
    
                    Instance.Name = "\0"
    
                    return Mt
                end
    
                Library.AddGlow = function(self, Options)
                    Options = Options or {} 
    
                    local Cfg = {
                        Amount = Options.Amount or 5;
                        DampingFactor = Options.DampingFactor or 0.4;
                        Parent = self.Instance;
                        Items = {};
                    }   
    
                    local Items = Cfg.Items; 
    
                    for Outline = 0, Cfg.Amount do  
                        Items[tostring(Outline)] = Library:Create( "UIStroke", {
                            Parent = self.Instance;
                            Color = Color3.fromRGB(255, 255, 255);
                            LineJoinMode = Enum.LineJoinMode.Round;
                            BorderOffset = UDim.new(0, Outline);
                            Transparency = (Outline / (Cfg.Amount + Cfg.DampingFactor))
                        })
    
                        Library:Create( "UIGradient", {
                            Parent = Items[tostring(Outline)].Instance;
                            Transparency = NumberSequence.new{
                                NumberSequenceKeypoint.new(0, Cfg.DampingFactor),
                                NumberSequenceKeypoint.new(1, Cfg.DampingFactor)
                            }
                        })
                    end
    
                    table.insert(Library.Glows, Cfg)
    
                    return self
                end
    
                Library.Resizify = function(self)
                    local Instance = self.Instance
    
                    local Resizing = Library:Create("TextButton", {
                        Position = UDim2.new(1, -10, 1, -10),
                        Size = UDim2.new(0, 10, 0, 10),
                        BorderSizePixel = 0,
                        Parent = Instance,
                        BackgroundTransparency = 1,
                        ZIndex = 9e9,
                        Text = ""
                    })
    
                    local IsResizing = false
                    local Size;
                    local InputLost;
                    local ParentSize = Instance.Size
    
                    Resizing.Instance.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            IsResizing = true
                            InputLost = Input.Position
                            Size = Instance.Size
                        end
                    end)
    
                    Resizing.Instance.InputEnded:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            IsResizing = false
                        end
                    end)
    
                    Library:Connect(Services.UserInputService.InputChanged, function(Input, game_event)
                        if IsResizing and Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                            self:Tween({
                                Size = UDim2.new(
                                    Size.X.Scale,
                                    math.clamp(Size.X.Offset + (Input.Position.X - InputLost.X), ParentSize.X.Offset,
                                        Camera.ViewportSize.X),
                                    Size.Y.Scale,
                                    math.clamp(Size.Y.Offset + (Input.Position.Y - InputLost.Y), ParentSize.Y.Offset,
                                        Camera.ViewportSize.Y)
                                )
                            })
                        end
                    end)
    
                    return self
                end
    
                Library.Hovering = function(self) -- Kinda old
                    if self == nil then
                        return
                    end
    
                    local y_cond = self.Instance.AbsolutePosition.Y <= Mouse.Y and
                    Mouse.Y <= self.Instance.AbsolutePosition.Y + self.Instance.AbsoluteSize.Y
                    local x_cond = self.Instance.AbsolutePosition.X <= Mouse.X and
                    Mouse.X <= self.Instance.AbsolutePosition.X + self.Instance.AbsoluteSize.X
    
                    return (y_cond and x_cond)
                end
    
                Library.CheckHoveredItems = function(self, Cfg, Items)
                    local Connection = Library:Connect(Services.UserInputService.InputBegan, function(Input)
                        if self.Instance.Visible == false or Cfg.Open == false then
                            return
                        end
    
                        local InputType = Input.UserInputType
    
                        if not (InputType == Enum.UserInputType.MouseButton1 or InputType == Enum.UserInputType.Touch) then
                            return
                        end
    
                        local Objects = Library.Items.Instance:GetGuiObjectsAtPosition(Mouse.X, Mouse.Y + GuiInset)
    
                        if not Items then
                            if not table.find(Objects, self.Instance) then
                                Cfg.SetVisible(false)
                            end
                        else
                            local Pass = true
    
                            for _, Item in Items do
                                if not table.find(Objects, Item.Instance) then
                                    Pass = false
                                end
                            end
                        end
    
                        Cfg.SetVisible(Pass)
                    end)
    
                    return self
                end
    
                Library.Draggify = function(self)
                    local Instance = self.Instance
    
                    local Dragging = false
                    local IntialSize = Instance.Position
                    local InitialPosition
                    Library.Dragging = false
    
                    Instance.InputBegan:Connect(function(Input)
                        if not Library.Dragging and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                            Dragging = true
                            Library.Dragging = true
                            InitialPosition = Input.Position
                            InitialSize = Instance.Position
                        end
                    end)
    
                    Instance.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            Dragging = false
                            Library.Dragging = false
                        end
                    end)
    
                    Library:Connect(Services.UserInputService.InputChanged, function(Input, GameEvent)
                        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                            local Horizontal = Camera.ViewportSize.X
                            local Vertical = Camera.ViewportSize.Y
    
                            local NewPosition = UDim2.new(
                                0,
                                InitialSize.X.Offset + (Input.Position.X - InitialPosition.X),
                                0,
                                InitialSize.Y.Offset + (Input.Position.Y - InitialPosition.Y)
                            )
    
                            self:Tween({ Position = NewPosition },
                                TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0,
                                    false, 0))
                        end
                    end)
    
                    return self
                end 
    
                Library.ClampToScreen = function(self)
                    local Parent = self
                    local Horizontal = Camera.ViewportSize.X
                    local Vertical = Camera.ViewportSize.Y
    
                    local ClampedPosition = UDim2.new(
                        0,
                        math.clamp(
                            Parent.Instance.Position.X.Offset,
                            0,
                            Horizontal - Parent.Instance.Size.X.Offset
                        ),
                        0,
                        math.clamp(
                            Parent.Instance.Position.Y.Offset,
                            0,
                            Vertical - Parent.Instance.Size.Y.Offset
                        )
                    )
    
                    if Parent.Instance.Position ~= ClampedPosition then
                        Parent:Tween({Position = ClampedPosition}, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                    end
                end
    
                Library.OnClick = function(self, Callback)
                    local Connection = Library:Connect(self.Instance.InputBegan, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            Callback()
                        end
                    end)
    
                    return Connection
                end
    
                Library.OnRightClick = function(self, Callback)
                    local Connection = Library:Connect(self.Instance.InputBegan, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.Touch then
                            Callback()
                        end
                    end)
    
                    return self
                end
    
                Library.OnHover = function(self, Callback1, Callback2)
                    Callback2 = Callback2 or function() end
    
                    Library:Connect(self.Instance.MouseEnter, function()
                        Callback1()
                    end)
    
                    Library:Connect(self.Instance.MouseLeave, function()
                        Callback2()
                    end)
    
                    return self
                end
    
                Library.OnDrag = function(self, Callback1, Callback2)
                    local Dragging = false
                    Callback2 = Callback2 or function() end
    
                    self.Instance.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            Dragging = true
                            Callback2(Dragging)
                        end
                    end)
    
                    Library:Connect(Services.UserInputService.InputEnded, function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Dragging = false
                            Callback2(Dragging)
                        end
                    end)
    
                    Library:Connect(Services.UserInputService.InputChanged, function(Input)
                        if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                            Callback1(Input)
                        end
                    end)
    
                    return self
                end
    
                Library.Reparent = function(self, Parent)
                    Parent = Parent or self.Instance.Parent
    
                    local Connection = Library:Connect(self.Instance:GetPropertyChangedSignal("Visible"), function()
                        local Visible = self.Instance.Visible
    
                        self.Instance.Parent = Visible and Parent or Library.Other.Instance
                    end)
    
                    return self
                end
    
                Library.OutsideClick = function(self, Cfg, Functions)
                    local Connection = Library:Connect(Services.UserInputService.InputBegan, function(Input)
                        if self.Instance.Visible == false or Cfg.Open == false then
                            return
                        end
                        
                        local InputType = Input.UserInputType
    
                        if not (InputType == Enum.UserInputType.MouseButton1 or InputType == Enum.UserInputType.Touch) then
                            return
                        end
    
                        if Functions then
                            local Pass = false
    
                            if self:Hovering() then
                                Pass = true
                            end
    
                            for _, IsHovering in Functions do
                                if IsHovering() then
                                    Pass = true
                                end
                            end
    
                            Cfg.SetVisible(Pass, true)
    
                            return
                        end
    
                        if not self:Hovering() then
                            Cfg.SetVisible(false)
                        end
                    end)
    
                    return self
                end
    
                Library.Blurify = function(self, Strength)
                    Strength = Strength or 0.90
    
                    local Instance = self.Instance
                    self.Strength = Strength
    
                    local Part = Library:Create("Part", {
                        Material = Enum.Material.Glass,
                        Transparency = Strength,
                        Reflectance = 1,
                        CastShadow = false,
                        Anchored = true,
                        CanCollide = false,
                        CanQuery = false,
                        CollisionGroup = " ",
                        Size = Vector3.new(1, 1, 1) * 0.01,
                        Color = Color3.fromRGB(0, 0, 0),
                        Parent = Camera,
                    });
    
                    local BlockMesh = Library:Create("BlockMesh", {
                        Parent = Part.Instance,
                    })
    
                    local DepthOfField = Library:Create("DepthOfFieldEffect", {
                        Parent = Services.Lighting,
                        Enabled = true,
                        FarIntensity = 0,
                        FocusDistance = 0,
                        InFocusRadius = 1000,
                        NearIntensity = 1,
                        Name = ""
                    })
    
                    Library:Connect(Services.RunService.RenderStepped, function()
                        if not self.Instance.Visible then 
                            Part.Transparency = 1
                            Part.Instance.CFrame = CFrame.new(0/0, 9e9, 9e9)
                            return 
                        end    
    
                        local Corner0 = Instance.AbsolutePosition;
                        local Corner1 = Corner0 + Instance.AbsoluteSize;
                        
                        local Ray0 = Workspace.CurrentCamera.ScreenPointToRay(Workspace.CurrentCamera,Corner0.X, Corner0.Y, 1);
                        local Ray1 = Workspace.CurrentCamera.ScreenPointToRay(Workspace.CurrentCamera,Corner1.X, Corner1.Y, 1);
    
                        local Origin = Workspace.CurrentCamera.CFrame.Position + Workspace.CurrentCamera.CFrame.LookVector * (0.05 - Workspace.CurrentCamera.NearPlaneZ);
    
                        local Normal = Workspace.CurrentCamera.CFrame.LookVector;
    
                        local Pos0 = Library:GetCalculatePosition(Origin, Normal, Ray0.Origin, Ray0.Direction);
                        local Pos1 = Library:GetCalculatePosition(Origin, Normal, Ray1.Origin, Ray1.Direction);
    
                        Pos0 = Workspace.CurrentCamera.CFrame:PointToObjectSpace(Pos0);
                        Pos1 = Workspace.CurrentCamera.CFrame:PointToObjectSpace(Pos1);
    
                        local Size = Pos1 - Pos0;
                        local Center = (Pos0 + Pos1) / 2;
    
                        BlockMesh.Instance.Offset = Center
                        BlockMesh.Instance.Scale  = Size / 0.0101;
    
                        Part.Instance.CFrame = Workspace.CurrentCamera.CFrame;
                        Part.Instance.Transparency = self.Strength
                    end)
    
                    return self
                end
            end
    
            -- // Tween Library
            do
                Library.GetTransparency = function(self, obj)
                    local Instance = obj
    
                    if Instance:IsA("Frame") or Instance:IsA("CanvasGroup") then
                        return { "BackgroundTransparency" }
                    elseif Instance:IsA("TextLabel") or Instance:IsA("TextButton") then
                        return { "TextTransparency", "BackgroundTransparency" }
                    elseif Instance:IsA("ImageLabel") or Instance:IsA("ImageButton") then
                        return { "BackgroundTransparency", "ImageTransparency" }
                    elseif Instance:IsA("ScrollingFrame") then
                        return { "BackgroundTransparency", "ScrollBarImageTransparency" }
                    elseif Instance:IsA("TextBox") then
                        return { "TextTransparency", "BackgroundTransparency" }
                    elseif Instance:IsA("UIStroke") then
                        return { "Transparency" }
                    elseif Instance:IsA("BasePart") then
                        return { "Transparency" }
                    end
    
                    return nil
                end
    
                Library.GetColors = function(self, obj)
                    local Instance = obj
                    
                    if Instance:IsA("Frame") or Instance:IsA("CanvasGroup") then
                        return { "BackgroundColor3" }
                    elseif Instance:IsA("TextLabel") or Instance:IsA("TextButton") then
                        return { "TextColor3", "BackgroundColor3" }
                    elseif Instance:IsA("ImageLabel") or Instance:IsA("ImageButton") then
                        return { "BackgroundColor3", "ImageColor3" }
                    elseif Instance:IsA("ScrollingFrame") then
                        return { "BackgroundColor3", "ScrollBarImageColor3" }
                    elseif Instance:IsA("TextBox") then
                        return { "TextColor3", "BackgroundColor3" }
                    elseif Instance:IsA("UIStroke") then
                        return { "Color" }
                    elseif Instance:IsA("BasePart") then
                        return { "Color" }
                    end
    
                    return nil
                end
    
                Library.Tween = function(self, Properties, Info, Obj)
                    local Instance = self.Instance or Obj
    
                    local Tween = Services.TweenService:Create(Instance,
                        Info or
                        TweenInfo.new(Library.TweeningSpeed, Library.EasingStyle, Enum.EasingDirection.Out, 0, false, 0),
                        Properties)
                    Tween:Play()    
    
                    if table.find(Properties, "TextColor3") then 
                        Tween.Completed:Connect(function()
                            print("Nigga")
                            self.Instance.TextColor3 = Properties.TextColor3
                        end)
                    end
    
                    return Tween
                end
    
                Library.Fade = function(self, obj, prop, vis)
                    if not (prop and obj) then
                        return
                    end
    
                    local OldTransparency = obj[prop]
                    obj[prop] = vis and 1 or OldTransparency
    
                    local Animation = Library:Tween({ [prop] = vis and OldTransparency or 1 }, nil, obj)
                    Library:Connect(Animation.Completed, function()
                        if not vis then
                            obj[prop] = OldTransparency
                        end
                    end)
    
                    return Animation
                end
    
                Library.TweenDescendants = function(self, Bool, Path)
                    Path = Path or { Tweening = false }
    
                    if Path.Tweening == true then
                        return
                    end
    
                    local Instance = self.Instance
                    Path.Tweening = true
    
                    if Bool then
                        if Instance:IsA("ScreenGui") then 
                            Instance.Enabled = true
                        else 
                            Instance.Visible = true
                        end 
                    end
    
                    local Children = Instance:GetDescendants()
                    table.insert(Children, Instance)
    
                    if self.Blur then
                        table.insert(Children, self.Blur)
                    end
    
                    local FadingAnimation;
                    for _, obj in Children do
                        local Index = Library:GetTransparency(obj)
    
                        if not Index then
                            continue
                        end
    
                        if type(Index) == "table" then
                            for _, prop in Index do
                                FadingAnimation = Library:Fade(obj, prop, Bool)
                            end
                        else
                            FadingAnimation = Library:Fade(obj, Index, Bool)
                        end
                    end
    
                    Library:Connect(FadingAnimation.Completed, function()
                        Path.Tweening = false
                        if Instance:IsA("ScreenGui") then 
                            Instance.Enabled = Bool
                        else 
                            Instance.Visible = Bool
                        end 
                    end)
                end
            end
    
            -- // Config
            do
                Library.GetConfig = function(self)
                    local Config = {}
    
                    for Idx, Value in Flags do
                        if type(Value) == "table" and Value.Key then
                            Config[Idx] = {Active = Value.Active, Mode = Value.Mode, Key = tostring(Value.Key)}
                        elseif type(Value) == "table" and Value["Transparency"] and Value["Color"] then
                            Config[Idx] = {Transparency = Value["Transparency"], Color = Value["Color"]:ToHex()}
                        else
                            Config[Idx] = Value
                        end
                    end 
    
                    return Services.HttpService:JSONEncode(Config)
                end
    
                Library.LoadConfig = function(self, JSON) 
                    local Config = Services.HttpService:JSONDecode(JSON)
    
                    for Idx, Value in Config do  
                        local Function = ConfigFlags[Idx]
    
                        if string.find(Idx, "_RGB") or string.find(Idx, "_ALPHA") then 
                            continue 
                        end 
    
                        if Function then 
                            if type(Value) == "table" and Value["Transparency"] and Value["Color"] then
                                Function(Color3.fromHex(Value["Color"]), Value["Transparency"])
                            else 
                                Function(Value)
                            end
                        end 
                    end 
                end 
    
                Library.DeleteConfig = function(self, Config)
                    local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Configs", Config)
                    if isfile(Path) then 
                        delfile(Path)
                    end
                end
    
                Library.SaveConfig = function(self, Config)
                    if Config == "" then 
                        return 
                    end 
    
                    local Path = string.format("%s/%s/%s.Cfg", Library.Directory, "Configs", Config)
                    writefile(Path, self:GetConfig())
                end
    
                Library.AutoLoad = function(self)
                    self.Window.Tweening = true 
                    local Name = readfile(self.Directory.."/Autoload.txt")
                    
                    if Name ~= "" then 
                        for i = 1, 2 do 
                            self:LoadConfig(readfile(self.Directory .. "/Configs/" .. Name .. ".Cfg"))
                        end 
                    end 
                    self.Window.Tweening = false 
                end 
    
                Library.UpdateConfigList = function(self) 
                    local List = {}
                    
                    for _, File in listfiles(Library.Directory .. "/Configs") do
                        local Name = File:gsub(Library.Directory .. "/Configs\\", ""):gsub(".Cfg", ""):gsub(Library.Directory .. "\\Configs\\", "")
                        List[#List + 1] = Name
                    end
    
                    self:RefreshDropdown(List)
                end 
    
                Library.NextFlag = function(self)
                    self.FlagCount += 1
                    local String = "Flag "..tostring(self.FlagCount)
                    
                    return String
                end 
            end
    
            -- // Connections / Utility Library
            do
                Library.Thread = function(self, Function)
                    local Thread = coroutine.create(Function)
    
                    coroutine.wrap(function()
                        coroutine.resume(Thread)
                    end)()
    
                    table.insert(self.Threads, Thread)
    
                    return Thread
                end
    
                Library.SafeCall = function(self, Function, ...)
                    local Arguments = { ... }
                    local Success, Result = pcall(Function, table.unpack(Arguments))
    
                    if not Success then
                        warn(Result)
                        return false
                    end
    
                    return Success
                end
    
                Library.Connect = function(self, Signal, Callback)
                    local ConnectionInfo = {
                        Event = Signal,
                        Callback = Callback,
                        Connection,
                    }
    
                    Library:Thread(function()
                        ConnectionInfo.Connection = Signal:Connect(Callback)
                    end)
    
                    table.insert(self.Connections, ConnectionInfo)
    
                    return ConnectionInfo
                end
    
                Library.Delay = function(self)
                    task.spawn(function()
                        self.Tweening = true
                        task.wait()
                        self.Tweening = false
                    end)
    
                    return self
                end
    
                Library.Unload = function(self)
                    repeat task.wait() until #self.Notifications == 0
    
                    for Index, Value in self.Connections do
                        if Value.Connection then
                            Value.Connection:Disconnect()
                        end
                    end
    
                    for Index, Value in self.Threads do
                        coroutine.close(Value)
                    end
    
                    for _, Item in self.Guis do
                        if Item then
                            Item:Destroy()
                            Item = nil
                        end
                    end
    
                    for _,Instance in self.Blurs do 
                        Instance:Destroy()
                    end         
    
                    Library = nil
                    getgenv().Library = nil
                end
            end
        end
    
        -- // Window
        do
            Library.Items = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true, DisplayOrder = 100});
            Library.HUD = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = true, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 1000001});
            Library.Other = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true});
            Library.Elements = Library:Create("ScreenGui", {Parent = Services.CoreGui, Name = "\0", Enabled = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true, DisplayOrder = 101});
    
            Library.CreateWindow = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Title = Data.Title or "Ultimate",
                    Build = Data.Build or "V3", 
                    Icon = "rbxassetid://82851477751652",
                    Size = Data.Size or UDim2.new(0, 652, 0, 666),
    
                    TabInfo,
    
                    Tweening = false,
                    Open = true,
                    KeybindListVisible = false,
    
                    Items = {},
                    KeybindElements = {},
    
                    Sections = {},
                    PageCount = 0;
                }; Library.Window = setmetatable(Cfg, Library);
                
                local Items = Cfg.Items; do
                    Items.Menu = Library:Create("CanvasGroup",{AnchorPoint = Vector2.new(0.5, 0.5); Parent = Library.Items.Instance; Position = UDim2.fromScale(0.5, 0.5); Size = Cfg.Size; BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3"):Draggify():Resizify()
                    
                    Items.Menu.Instance.Position = UDim2.fromOffset(Items.Menu.Instance.AbsolutePosition.X, Items.Menu.Instance.AbsolutePosition.Y)
                    Items.Menu.Instance.AnchorPoint = Vector2.new(0, 0)
                    Items.Top = Library:Create("Frame",{Parent = Items.Menu.Instance; Size = UDim2.new(1, 0, 0, 48); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.Logo = Library:Create("Frame",{Parent = Items.Top.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 55, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Line = Library:Create("Frame",{Parent = Items.Logo.Instance; Position = UDim2.new(1, 0, 0, 0); Size = UDim2.new(0, 1, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(20, 18, 18)})
                    Items.Icon = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset["Accent"]; Parent = Items.Logo.Instance; AnchorPoint = Vector2.new(0.5, 0.5); Image = Cfg.Icon; BackgroundTransparency = 1; Position = UDim2.new(0.5, 0, 0.5, 0); Size = UDim2.new(0, 40, 0, 40); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "ImageColor3")
                    Items.TabButtonHolder = Library:Create("Frame",{Parent = Items.Top.Instance; AnchorPoint = Vector2.new(1, 0); BackgroundTransparency = 1; Position = UDim2.new(1, -15, 0, 0); Size = UDim2.new(0, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.TabButtonHolder.Instance; Padding = UDim.new(0, 12); SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal})
                    Items.Middle = Library:Create("Frame",{Parent = Items.Menu.Instance; Position = UDim2.new(0, 0, 0, 48); Size = UDim2.new(1, 0, 1, -87); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageBackground"]}):Themify("PageBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Middle.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Color3.fromRGB(20, 18, 18); Parent = Items.Middle.Instance})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Middle.Instance; Padding = UDim.new(0, 15); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 12); PaddingBottom = UDim.new(0, 12); Parent = Items.Middle.Instance; PaddingRight = UDim.new(0, 12); PaddingLeft = UDim.new(0, 12)})
                    Items.Pages = Library:Create("Frame",{Parent = Items.Middle.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Build = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = "Build: Developer"; Parent = Items.Menu.Instance; AnchorPoint = Vector2.new(0, 1); Position = UDim2.new(0, 12, 1, -12); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Menu.Instance; CornerRadius = UDim.new(0, 4)})
    
                    -- // Keybind list 
                    Items.KeybindList = Library:Create("CanvasGroup",{GroupTransparency = 1; Active = true; Parent = Library.HUD.Instance; Size = UDim2.new(0, 245, 0, 0); Position = UDim2.new(0.5573770403862, 0, 0.1008695662021637, 0); Selectable = true; BorderSizePixel = 0;BackgroundColor3 = Themes.Preset["OtherBackground"]}):Themify("OtherBackground", "BackgroundColor3")
                    :Draggify()
                    
                    Items.KeybindList.Instance.Position = UDim2.fromOffset(Items.KeybindList.Instance.AbsolutePosition.X, Items.KeybindList.Instance.AbsolutePosition.Y)
                    Items.KeybindList.Instance.AnchorPoint = Vector2.new(0, 0)
    
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.KeybindList.Instance; CornerRadius = UDim.new(0, 3)})
                    Items.KeyUIStroke = Library:Create("UIStroke",{Transparency = 1; Color = Themes.Preset["OtherInline"]; Parent = Items.KeybindList.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border}):Themify("OtherInline", "Color")
                    Items.Elements = Library:Create("Frame",{Parent = Items.KeybindList.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 12, 0, 52-5); Size = UDim2.new(1, -24, 0, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 13); PaddingLeft = UDim.new(0, -3); Parent = Items.Elements.Instance})
                    Items.Topbar = Library:Create("Frame",{Parent = Items.KeybindList.Instance; Size = UDim2.new(1, 0, 0, 40); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.Holder2 = Library:Create("Frame",{Parent = Items.Topbar.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 55, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Holder = Library:Create("Frame",{LayoutOrder = -1; AnchorPoint = Vector2.new(0.5, 0.5); Parent = Items.Holder2.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 12, 0.5, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; Parent = Items.Holder.Instance; Padding = UDim.new(0, 8); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.KeybindListTitle = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = "Keybinds"; Parent = Items.Holder.Instance; Position = UDim2.new(0, 25, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.Icon = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset["Accent"]; Parent = Items.Holder.Instance; Size = UDim2.new(0, 20, 0, 20); AnchorPoint = Vector2.new(0.5, 0.5); Image = "rbxassetid://72338035902424"; BackgroundTransparency = 1; Position = UDim2.new(0.5, 0, 0.5, 0); LayoutOrder = -1; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "ImageColor3")
    
                    -- // Watermark 
                    Items.Watermark = Library:Create("CanvasGroup",{GroupTransparency = 1; Active = true; Parent = Library.HUD.Instance; Position = UDim2.new(0, 40, 0, 40); Selectable = true; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3"):Draggify()
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Watermark.Instance; CornerRadius = UDim.new(0, 6)})
                    Items.UIStrokeWatermark = Library:Create("UIStroke",{Transparency = 1; Color = Themes.Preset["OtherInline"]; Parent = Items.Watermark.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border}):Themify("OtherInline", "Color")
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Watermark.Instance; Padding = UDim.new(0, 13); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                    Items.Elements2 = Library:Create("Frame",{Parent = Items.Watermark.Instance; BackgroundTransparency = 1; Position = Cfg.Position; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Elements2.Instance; Padding = UDim.new(0, 9); SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingBottom = UDim.new(0, 13); Parent = Items.Elements2.Instance})
                    Items.WatermarkTitle = Library:Create("TextLabel",{RichText = true; FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["Accent"]; Text = ""; Parent = Items.Elements2.Instance; Position = UDim2.new(0, 25, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 10); PaddingBottom = UDim.new(0, -2); Parent = Items.Watermark.Instance; PaddingRight = UDim.new(0, 12); PaddingLeft = UDim.new(0, 12)})
                    
                    -- // Target Stats
                    Items.TargetStats = Library:Create("CanvasGroup",{GroupTransparency = 1; Active = true; Parent = Library.HUD.Instance; Position = Pos(0, 300, 0, 300); Selectable = true; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset["OtherBackground"]}):Themify("OtherBackground", "BackgroundColor3")
                    :Draggify()
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.TargetStats.Instance; CornerRadius = UDim.new(0, 3)})
                    Items.TargetStatsUIStroke = Library:Create("UIStroke",{Transparency = 1; Color = Themes.Preset["OtherInline"]; Parent = Items.TargetStats.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border}):Themify("OtherInline", "Color")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 12); PaddingBottom = UDim.new(0, 12); Parent = Items.TargetStats.Instance; PaddingRight = UDim.new(0, 12); PaddingLeft = UDim.new(0, 12)})
                    Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; Parent = Items.TargetStats.Instance; Padding = UDim.new(0, 10); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.ImageHolder = Library:Create("Frame",{LayoutOrder = -1; Parent = Items.TargetStats.Instance; Size = Pos(0, 68, 0, 68); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["OtherInline"]; Parent = Items.ImageHolder.Instance}):Themify("OtherInline", "Color")
                    Items.Image = Library:Create("ImageLabel",{Parent = Items.ImageHolder.Instance; Image = "rbxassetid://82574858136292"; BackgroundTransparency = 1; Position = Pos(0, 1, 0, 1); Size = Pos(1, -2, 1, -2); BorderSizePixel = 0})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Image.Instance})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.ImageHolder.Instance})
                    Items.Holder2 = Library:Create("Frame",{Parent = Items.TargetStats.Instance; BackgroundTransparency = 1; Size = Pos(0, 0, 0, 68); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY})
                    Items.Username = Library:Create("TextLabel",{TextColor3 = Color3.fromRGB(231, 231, 231); Text = "?? (@??)"; Parent = Items.Holder2.Instance; Position = Pos(0, -2, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY})
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Username.Instance})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Holder2.Instance; Padding = UDim.new(0, 5); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.Distance = Library:Create("TextLabel",{TextColor3 = Color3.fromRGB(231, 231, 231); Text = "Distance: ??"; Parent = Items.Holder2.Instance; Position = Pos(0, -2, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY})
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Distance.Instance})
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Holder2.Instance; PaddingTop = UDim.new(0, -1)})
                    Items.Slider = Library:Create("Frame",{Parent = Items.Holder2.Instance; BackgroundTransparency = 1; Size = Pos(0, 175, 0, 16); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y})
                    Items.Health = Library:Create("TextLabel",{TextColor3 = Themes.Preset["TextEnabled"]; Text = "Health"; Parent = Items.Slider.Instance; Position = Pos(0, -1, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY}):Themify("TextEnabled", "TextColor3")
                    Items.Outline = Library:Create("Frame",{Parent = Items.Slider.Instance; Position = Pos(0, 0, 0, 27); Size = Pos(1, 0, 0, 3); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Outline.Instance; CornerRadius = UDim.new(1, 0)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.Outline.Instance}):Themify("PageElementOutline", "Color")
                    Items.Holder = Library:Create("Frame",{Parent = Items.Outline.Instance; BackgroundTransparency = 1; Position = Pos(0, -1, 0, -1); Size = Pos(1, 2, 1, 2); BorderSizePixel = 0})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Holder.Instance})
                    Items.Accent = Library:Create("Frame",{Parent = Items.Holder.Instance; Size = Pos(0.5, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Accent"]}):Themify("Accent", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Accent.Instance})
                    Items.HealthText = Library:Create("TextLabel",{TextColor3 = Themes.Preset["TextEnabled"]; Text = "50/100"; Parent = Items.Slider.Instance; AnchorPoint = Vec(1, 0); Position = Pos(1, 0, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY}):Themify("TextEnabled", "TextColor3")
                    
                    Items.Username.Instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                        Items.Slider.Instance.Size = Pos(0, Items.Username.Instance.AbsoluteSize.X, 0, 0)
                    end)
    
                    -- // InventoryViewer
                    Items.InventoryViewer = Library:Create("CanvasGroup",{GroupTransparency = 1; Parent = Library.HUD.Instance; Position = Pos(0, 400, 0, 400); BackgroundTransparency = 1; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY})
                    :Draggify()
                    Items.Viewer = Library:Create("Frame",{Parent = Items.InventoryViewer.Instance; ClipsDescendants = true; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.Holder = Library:Create("Frame",{Parent = Items.Viewer.Instance; BackgroundTransparency = 1; Size = Pos(0, 0, 0, 68); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY})
                    Items.ImageHolder = Library:Create("Frame",{Parent = Items.Holder.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY})
                    Items.UISizeConstraint = Library:Create("UISizeConstraint",{Parent = Items.ImageHolder.Instance; MaxSize = Vec(350, inf)})
                    Items.UIGridLayout = Library:Create("UIGridLayout",{Parent = Items.ImageHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder; CellSize = Pos(0, 75, 0, 75)})
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Holder.Instance; PaddingTop = UDim.new(0, -1)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Holder.Instance; Padding = UDim.new(0, 5); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.InvViewerInfo = Library:Create("TextLabel",{LayoutOrder = -1; TextColor3 = Themes.Preset["TextEnabled"]; Text = "Inventory Viewer - $5100, 4 Items"; Parent = Items.Holder.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; TextTruncate = Enum.TextTruncate.SplitWord; AutomaticSize = Enum.AutomaticSize.XY}):Themify("TextEnabled", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.InvViewerInfo.Instance})
                    Items.Description = Library:Create("TextLabel",{LayoutOrder = -1; TextColor3 = Themes.Preset["TextEnabled"]; Text = "User: Username (@DisplayName)"; Parent = Items.Holder.Instance; BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; TextTruncate = Enum.TextTruncate.SplitWord; AutomaticSize = Enum.AutomaticSize.XY}):Themify("TextEnabled", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Description.Instance})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; BorderOffset = UDim.new(0, -1); Parent = Items.Viewer.Instance}):Themify("PageElementOutline", "Color")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 11); PaddingBottom = UDim.new(0, 11); Parent = Items.Viewer.Instance; PaddingRight = UDim.new(0, 11); PaddingLeft = UDim.new(0, 11)})
                    Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; Parent = Items.Viewer.Instance; Padding = UDim.new(0, 10); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Transparency = NumSeq{NumKey(0, 0), NumKey(0.279, 1), NumKey(1, 0)}; Color = ColorSeq{ColorKey(0, Color3.fromRGB(255, 0, 0)), ColorKey(0.17, Color3.fromRGB(255, 255, 0)), ColorKey(0.33, Color3.fromRGB(0, 255, 0)), ColorKey(0.5, Color3.fromRGB(0, 255, 255)), ColorKey(0.67, Color3.fromRGB(0, 0, 255)), ColorKey(0.83, Color3.fromRGB(255, 0, 255)), ColorKey(1, Color3.fromRGB(255, 0, 0))}; Parent = Items.Viewer.Instance; Enabled = false})
                end     
    
                function Cfg.SetKeybindListVisibility(Bool)                
                    Items.KeybindList:Tween({GroupTransparency = Bool and 0 or 1})
                    Items.KeyUIStroke:Tween({Transparency = Bool and 0 or 1})
                end
                
                function Cfg.SetWatermarkVisibility(Bool)
                    Items.Watermark:Tween({GroupTransparency = Bool and 0 or 1})
                    Items.UIStrokeWatermark:Tween({Transparency = Bool and 0 or 1})
                end
    
                -- // Stats 
                function Cfg.SetTargetStatsVisibility(Bool)
                    Items.TargetStats:Tween({GroupTransparency = Bool and 0 or 1})
                    Items.TargetStatsUIStroke:Tween({Transparency = Bool and 0 or 1})
                end
    
                function Cfg:UpdateStatsProfile(Player)
                    Items.Image.Instance.Image = Services.Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
                    Items.Username.Instance.Text = string.format("%s (%s)", Player.Name, Player.DisplayName)
                end     
    
                function Cfg:UpdateStats(Data)
                    Items.HealthText.Instance.Text = Data.Health
                    Items.Distance.Instance.Text = string.format("Distance: %s", Data.Distance)
                    Items.Accent:Tween({ Size = UDim2.new(Data.Health / Data.MaxHealth, 0, 1, 0) }, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0))
                end
    
                function Cfg:UpdateViewer(Data)
                    if Data.Clear then 
                        Items.ImageHolder.Instance:ClearAllChildren()
                        Items.UIGridLayout = Library:Create("UIGridLayout",{Parent = Items.ImageHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder; CellSize = UDim2.new(0, 75, 0, 75)})
                        Items.UISizeConstraint = Library:Create("UISizeConstraint",{Parent = Items.ImageHolder.Instance; MaxSize = Vector2.new(350, math.huge)})
    
                        Items.InventoryViewer:Tween({GroupTransparency = 1})
    
                        return
                    end 
    
                    Items.InventoryViewer:Tween({GroupTransparency = 0})
    
                    Items.InvViewerInfo.Instance.Text = string.format("Inventory Viewer - $%s, %s Items", Data.Money, #Data.Images)
                    Items.Description.Instance.Text = string.format("User: %s (%s)", Data.Name, Data.DisplayName)
                    Items.ImageHolder.Instance:ClearAllChildren()
                    Items.UIGridLayout = Library:Create("UIGridLayout",{Parent = Items.ImageHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder; CellSize = UDim2.new(0, 75, 0, 75)})
                    Items.UISizeConstraint = Library:Create("UISizeConstraint",{Parent = Items.ImageHolder.Instance; MaxSize = Vector2.new(350, math.huge)})
    
                    for _,Image in Data.Images do 
                        Cfg.AddImage(Image)
                    end
                end
    
                function Cfg.AddImage(Image)
                    Items.Image = Library:Create("Frame",{Parent = Items.ImageHolder.Instance; Size = Pos(0, 100, 0, 100); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; BorderOffset = UDim.new(0, -1); Parent = Items.Image.Instance}):Themify("PageElementOutline", "Color")
                    Items.Icon = Library:Create("ImageLabel",{ScaleType = Enum.ScaleType.Crop; Parent = Items.Image.Instance; Image = Image; BackgroundTransparency = 1; Size = Pos(1, 0, 1, 0); BorderSizePixel = 0})
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 10); PaddingBottom = UDim.new(0, 5); Parent = Items.Image.Instance; PaddingRight = UDim.new(0, 10); PaddingLeft = UDim.new(0, 5)})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Image.Instance; CornerRadius = UDim.new(0, 4)})
                end
    
                local Frames = 0
                local FPS = 0
                local LastTick = tick()
                local GameName = Services.MarketplaceService:GetProductInfo(game.PlaceId).Name -- // errr cant get rate limited now can we??
    
                Services.RunService.RenderStepped:Connect(function(Delta)
                    Tick = tick()
    
                    if not Flags["Refresh Rate"] then 
                        return 
                    end 
    
                    if not (Tick - LastTick >= Flags["Refresh Rate"]) then
                        return
                    end
    
                    if Items.Watermark.Instance.GroupTransparency == 1 then 
                        return 
                    end 
                    
                    LastTick = Tick
                    FPS = math.floor(1 / Delta)
    
                    local Strings = Flags["WatermarkSettings"] or {}
    
                    local Parts = {}
    
                    if table.find(Strings, "Fps") then
                        table.insert(Parts, FPS .. " fps")
                    end
    
                    if table.find(Strings, "Ping") then
                        table.insert(Parts, Services.Stats.PerformanceStats.Ping:GetValue() .. " ping")
                    end
    
                    if table.find(Strings, "Game Name") then
                        table.insert(Parts, GameName)
                    end
    
                    if table.find(Strings, "User ID") then
                        table.insert(Parts, tostring(Services.Players.LocalPlayer.UserId))
                    end
    
                    if table.find(Strings, "LocalPlayer Name") then
                        table.insert(Parts, Services.Players.LocalPlayer.Name)
                    end
    
                    if table.find(Strings, "Date") then
                        table.insert(Parts, os.date("%b %d, %Y"))
                    end
    
                    local FinalText = table.concat(Parts, " - ")
    
                    Items.WatermarkTitle.Instance.Text = string.format(
                        '%s<font color = "rgb(%s, %s, %s)">%s%s</font>', 
                        table.find(Strings, "Title") and Cfg.Title or "", 
                        math.floor(Themes.Preset.TextEnabled.R * 255),
                        math.floor(Themes.Preset.TextEnabled.G * 255), 
                        math.floor(Themes.Preset.TextEnabled.B * 255), 
                        #Strings > 1 and table.find(Strings, "Title") and " - " or "", 
                        FinalText
                    )
                end)
    
                return Library.Window
            end
    
            Library.AddTab = function(self, Data)
                self.PageCount += 1 
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Name or Data.Title or "Tab",
                    Icon = Data.Icon or "rbxassetid://101410207355204",
                    Columns = Data.Columns or 2,
    
                    -- DO NOT TOUCH
                    OldTab,
                    Items = {},
                    Pages = {},
    
                    Tweening = false,
                    Window = self,
    
                    Buttons = self.Items.TabButtonHolder,
                    SectionData = self.Sections,
                    Parent = self.Items.Pages.Instance;
                    Parent,
                    TabInfo,
                    PageCount = self.PageCount;
                };  
    
                local Items = Cfg.Items; do
                    -- // Button    
                    Items.Button = Library:Create("TextButton",{Parent = self.Items.TabButtonHolder.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 0, 1, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.X; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Button.Instance; PaddingRight = UDim.new(0, 5); PaddingLeft = UDim.new(0, 5)})
                    Items.Holder = Library:Create("Frame",{Parent = Items.Button.Instance; AnchorPoint = Vector2.new(0, 0.5); BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0.5, 0); Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; Parent = Items.Holder.Instance; Padding = UDim.new(0, 10); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Color3.fromRGB(141, 135, 135); Text = Cfg.Text; Parent = Items.Holder.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Icon = Library:Create("ImageLabel",{LayoutOrder = -1; Parent = Items.Holder.Instance; Image = Cfg.Icon; BackgroundTransparency = 1; Size = UDim2.new(0, 12, 0, 12); ImageColor3 = Color3.fromRGB(141, 135, 135); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.AccentBar = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, -5, 1, -1); Size = UDim2.new(1, 10, 0, 1); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(166, 147, 243)})
                    Items.Accent = Library:Create("Frame",{Parent = Items.Button.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, -5, 0, 0); Size = UDim2.new(1, 10, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(166, 147, 243)})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Transparency = NumSeq{NumKey(0, 1), NumKey(0.338, 0.9937499761581421), NumKey(0.834, 0.78125), NumKey(0.954, 0.606249988079071), NumKey(1, 0)}; Parent = Items.Accent.Instance})
                    Items.Icon:ThemeListener("Accent", function() return self.TabInfo == Cfg end, "ImageColor3", "BackgroundColor3")
    
                    Items.Pages = Library:Create("Frame",{Parent = Library.Other.Instance; Visible = false; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    :Reparent(Cfg.Parent)
    
                    Items.ScrollingBar = Library:Create("Frame",{Parent = Items.Pages.Instance; BackgroundTransparency = 1; Position = UDim2.new(1, 4, 0, 0); Size = UDim2.new(0, 4, 1, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(16, 16, 16)})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.ScrollingBar.Instance})
    
                    -- // Button Holder
                    Items.MultiHolder = Library:Create("Frame",{Visible = true; Parent = Items.Pages.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 1, 0, 1); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.MultiHolder.Instance; Padding = UDim.new(0, 8); SortOrder = Enum.SortOrder.LayoutOrder; FillDirection = Enum.FillDirection.Horizontal})
                end
    
                local Tab = setmetatable(Cfg, Library)
    
                Items.Button:OnClick(function()
                    if Cfg.Tweening then
                        return 
                    end
    
                    Tab:OpenPage()
                end)
    
                if not self.TabInfo then
                    Tab:OpenPage()
                end 
    
                return Tab
            end
            
            Library.AddSection = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Title = Data.Title or Data.Text or Data.Name or "Title",
                    Description = Data.Description,
                    Icon = Data.Logo or Data.Icon or "rbxassetid://137452965100669",
                    Side = Data.Side or 1,
                    Accent = Data.Accent or false, 
    
                    Items = {},
                    Tweening = false,
    
                    Elements = {},
                    Names = {},
                    DataElements = {},
    
                    SeperatedElements = {},
                }
    
                local Parent = (self.Items and self.Items[tostring(Cfg.Side)] and self.Items[tostring(Cfg.Side)].Instance)
                local ElementsHolder; 
    
                local Items = Cfg.Items; do
                    if Parent then
                        -- // Section
                        Items.SectionHolder = Library:Create("Frame",{Parent = Parent; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                        Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextDisabled"]; Text = Cfg.Title; Parent = Items.SectionHolder.Instance; BackgroundTransparency = 1; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextDisabled", "TextColor3")
                        Items.UIPadding = Library:Create("UIPadding",{PaddingLeft = UDim.new(0, 9); Parent = Items.Title.Instance})
                        Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.SectionHolder.Instance; Padding = UDim.new(0, 12); SortOrder = Enum.SortOrder.LayoutOrder})
                        Items.Section = Library:Create("Frame",{Parent = Items.SectionHolder.Instance; Size = UDim2.new(1, 0, 0, 0); Position = UDim2.new(-0.13442623615264893, 0, 0.0714285746216774, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                        Items.UICorner = Library:Create("UICorner",{Parent = Items.Section.Instance; CornerRadius = UDim.new(0, 4)})
                        ElementsHolder = Items.Section:CreateElements({})
                        Items.Elements = ElementsHolder.Items.Elements
                        Cfg.SetVisible = ElementsHolder.SetVisible
                        Cfg.DataElements = ElementsHolder.DataElements
                    end
                end
    
                return setmetatable(Cfg, Library)
            end
    
            -- // Elements
            Library.AddToggle = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or "Toggle",
    
                    Flag = Data.Flag or Data.Text or Library:NextFlag(),
                    Enabled = Data.Default or false,
                    Callback = Data.Callback or function() end,
    
                    Items = {},
    
                    Names = self.Names,
    
                    Elements = self.Elements,
                    DataElements = self.DataElements,
                    SeperatedElements = self.SeperatedElements,
                }
    
                local Items = Cfg.Items; do
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 16); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Accent = Library:Create("Frame",{Parent = Items.Object.Instance; BackgroundTransparency = 1; Size = UDim2.new(0, 16, 0, 16); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Accent"]}):Themify("Accent", "BackgroundColor3")
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; BorderOffset = UDim.new(0, -1); Parent = Items.Accent.Instance}):Themify("PageElementOutline", "Color"):Themify("Accent", "Color")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Accent.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.Tick = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset["PageElementBackground"]; ImageTransparency = 1; Parent = Items.Accent.Instance; AnchorPoint = Vector2.new(0.5, 0.5); Image = "rbxassetid://101167838270412"; BackgroundTransparency = 1; Position = UDim2.new(0.5, 0, 0.5, 0); Size = UDim2.new(0, 18, 0, 18); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("PageElementBackground", "ImageColor3")
                    Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextDisabled"]; Text = Cfg.Text; Parent = Items.Object.Instance; Position = UDim2.new(0, 25, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextDisabled", "TextColor3")
                end
    
                Items.Accent.Instance:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
                    if not Cfg.Enabled then 
                        return 
                    end 
    
                    Items.UIStroke.Instance.Color = Items.Accent.Instance.BackgroundColor3
                end)
    
                Cfg.Set = function(Bool)
                    Items.Accent:Tween({ BackgroundTransparency = Bool and 0 or 1 })
                    Items.Tick.Instance.Rotation = Bool and 45 or 0
                    Items.Tick:Tween({ ImageTransparency = Bool and 0 or 1; Rotation = Bool and 0 or 45 })
                    Items.UIStroke:Tween({ Color = Bool and Themes.Preset["Accent"] or Themes.Preset["PageElementOutline"] })
                    Items.Title:Tween({ TextColor3 = Bool and Themes.Preset["TextEnabled"] or Themes.Preset["TextDisabled"] })
    
                    Cfg.Enabled = Bool
                    Flags[Cfg.Flag] = Bool  
                    Cfg.Callback(Bool)
                end
    
                Items.Object:OnClick(function()
                    Cfg.Enabled = not Cfg.Enabled
                    Cfg.Set(Cfg.Enabled)
                end)
    
                local Toggle = setmetatable(Cfg, Library)
                Toggle:SetupElement(Cfg.Enabled)
    
                return setmetatable(Cfg, Library)
            end
    
            Library.AddSlider = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Title or Data.Name or "Text",
                    Suffix = Data.Suffix or "",
                    Flag = Data.Flag or Data.Text or Data.Title or Data.Name or Library:NextFlag(),
                    Callback = Data.Callback or function() end,
    
                    Min = Data.Min or 0,
                    Max = Data.Max or 100,
                    Intervals = Data.Decimal or Data.Rounding or 1,
                    Value = Data.Default or 10,
    
                    Dragging = false,
                    Items = {},
    
                    Names = self.Names,
                    Elements = self.Elements,
                    DataElements = self.DataElements,
    
                    SeperatedElements = self.SeperatedElements,
                    Type = Data.Type or "Animation",
                }
    
                local Slider = setmetatable(Cfg, Library)
    
                local Items = Cfg.Items; do
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 32); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.None; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = Cfg.Text; Parent = Items.Object.Instance; Position = UDim2.new(0, -1, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 0, 0, 27); Size = UDim2.new(1, 0, 0, 4); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Outline.Instance; CornerRadius = UDim.new(1, 0)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.Outline.Instance}):Themify("PageElementOutline", "Color")
                    Items.Holder = Library:Create("Frame",{Parent = Items.Outline.Instance; BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0.5, 0); AnchorPoint = Vector2.new(0, 0.5); Size = UDim2.new(1, 0, 1, 10); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Holder.Instance})
                    Items.Accent = Library:Create("Frame",{Parent = Items.Holder.Instance; Size = UDim2.new(0.5, 0, 0, 4); BorderSizePixel = 0; Position = UDim2.new(0, 0, 0, 5); BackgroundColor3 = Themes.Preset["Accent"]}):Themify("Accent", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Accent.Instance})
                    Items.Circle = Library:Create("Frame",{AnchorPoint = Vector2.new(0.5, 0.5); Parent = Items.Accent.Instance; Position = UDim2.new(1, 0, 0.5, 0); Size = UDim2.new(0, 12, 0, 12); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["TextEnabled"]}):Themify("TextEnabled", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Circle.Instance; CornerRadius = UDim.new(1, 0)})
                    Items.Value = Library:Create("TextBox",{Parent = Items.Object.Instance; FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); Active = false; Text = "50%"; Selectable = false; Position = UDim2.new(1, 0, 0, 0); AnchorPoint = Vector2.new(1, 0); BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; TextColor3 = Themes.Preset["TextEnabled"]; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                end
    
                Cfg.Set = function(Value)
                    Cfg.Value = math.clamp(Library:Round(Value, Cfg.Intervals), Cfg.Min, Cfg.Max)
    
                    Items.Value.Instance.Text = tostring(Cfg.Value) .. Cfg.Suffix
                    Items.Accent:Tween({ Size = UDim2.new((Cfg.Value - Cfg.Min) / (Cfg.Max - Cfg.Min), 0, 0, 4) })
    
                    Flags[Cfg.Flag] = Cfg.Value 
                    Cfg.Callback(Flags[Cfg.Flag])
                end
    
                Items.Value.Instance.FocusLost:Connect(function()
                    local OldValue = Cfg.Value
    
                    local Succesful, Result = pcall(function()
                        Cfg.Set(Items.Value.Instance.Text)
                    end)
    
                    if not Succesful then
                        Cfg.Set(OldValue)
                    end
                end)
    
                Slider:SetupElement(Cfg.Value)
    
                Items.Outline:OnDrag(function(Input)
                    Slider:UpdateSlider(Input)
                    Items.Circle:Tween({Size = UDim2.new(0, 14, 0, 14)})
                end, function()
                    Items.Circle:Tween({Size = UDim2.new(0, 12, 0, 12)})
                end)
    
                Items.Circle:OnDrag(function(Input)
                    Slider:UpdateSlider(Input)
                    Items.Circle:Tween({Size = UDim2.new(0, 14, 0, 14)})
                end, function()
                    Items.Circle:Tween({Size = UDim2.new(0, 12, 0, 12)})
                end)
                
                return Slider
            end
    
            Library.AddDropdown = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Title or Data.Name or nil,
                    Flag = Data.Flag or Library:NextFlag(),
                    Options = Data.Options or Data.Values or { "" },
                    Callback = Data.Callback or function() end,
                    Multi = Data.Multi or false,
                    Search = Data.Search or false; 
    
                    -- Ignore these
                    Open = true,
                    OptionInstances = {},
                    MultiItems = {},
                    Items = {},
                    Tweening = false,
    
                    Names = self.Names,
                    Elements = self.Elements,
                    DataElements = self.DataElements,
    
                    SeperatedElements = self.SeperatedElements
                }   
                Cfg.Default = Data.Default or Cfg.Options[1] or "";
    
                local Items = Cfg.Items; do
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 16); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = Cfg.Text; Parent = Items.Object.Instance; Position = UDim2.new(0, -1, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 1, 0, 27); Size = UDim2.new(1, -2, 0, 35); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Outline.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.Outline.Instance}):Themify("PageElementOutline", "Color")
                    Items.Value = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = "Option1, Option2, Option3, Option4"; Parent = Items.Outline.Instance; Size = UDim2.new(1, -100, 1, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; TextTruncate = Enum.TextTruncate.SplitWord; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingLeft = UDim.new(0, 9); Parent = Items.Value.Instance})
                    Items.Indicator = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset["TextDisabled"]; Parent = Items.Outline.Instance; AnchorPoint = Vector2.new(1, 0.5); Image = "rbxassetid://99956667726557"; BackgroundTransparency = 1; Position = UDim2.new(1, -5, 0.5, 0); Size = UDim2.new(0, 20, 0, 20); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextDisabled", "ImageColor3")
    
                    Items.DropdownHolder = Library:Create("TextButton",{Text = ""; AutoButtonColor = false; Parent = Library.Other.Instance; Position = UDim2.new(0.1930195689201355, 0, 0.5626087188720703, 0); Size = UDim2.new(0, 245, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3"):Reparent(Library.Elements.Instance):OutsideClick(Cfg)
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.DropdownHolder.Instance; CornerRadius = UDim.new(0, 0)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.DropdownHolder.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border}):Themify("PageElementOutline", "Color")
                    Items.OptionsHolder = Library:Create("ScrollingFrame",{TopImage = "rbxassetid://118384633897629"; BottomImage = "rbxassetid://118384633897629"; MidImage = "rbxassetid://118384633897629"; ScrollBarImageColor3 = Themes.Preset["Accent"]; Active = true; AutomaticCanvasSize = Enum.AutomaticSize.Y; Parent = Items.DropdownHolder.Instance; Size = UDim2.new(1, 0, 1, 0); BackgroundTransparency = 1; BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255); AutomaticSize = Enum.AutomaticSize.Y; CanvasSize = UDim2.new(0, 0, 0, 0); ScrollBarThickness = 2}):Themify("Accent", "ScrollBarImageColor3")
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.OptionsHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
                end
    
                local Dropdown = setmetatable(Cfg, Library)
    
                Cfg.SetVisible = function()
                    if Cfg.Tweening then
                        return
                    end
                    
                    Cfg.Open = not Cfg.Open
    
                    Dropdown:UpdateDropdownPosition(Cfg.Open)
                    Items.DropdownHolder:TweenDescendants(Cfg.Open, Cfg)
                    Items.DropdownHolder:ClampToScreen()
                end 
    
                Cfg.Set = function(Value)
                    local Selected = {}
                    local IsTable = type(Value) == "table"
    
                    for _, Option in Cfg.OptionInstances do
                        local Text = Option.Value.Instance.Text
    
                        if Text == Value or (IsTable and table.find(Value, Text)) then
                            table.insert(Selected, Text)
                            Cfg.MultiItems = Selected
    
                            Option.Value:Tween({TextColor3 = Themes.Preset.Accent; BackgroundColor3 = Themes.Preset.PageBackground; BackgroundTransparency = 0})
                        else
                            Option.Value:Tween({TextColor3 = Themes.Preset.TextEnabled; BackgroundColor3 = Themes.Preset.PageElementBackground; BackgroundTransparency = 1})
                        end
                    end
    
                    Items.Value.Instance.Text = IsTable and table.concat(Selected, ", ") or Selected[1] or "Select"
    
                    Flags[Cfg.Flag] = IsTable and Selected or Selected[1]
                    Cfg.Callback(Flags[Cfg.Flag])
                end
    
                Cfg.IsHovering = function()
                    return Items.DropdownHolder:Hovering()
                end
    
                Items.Outline:OnClick(function()
                    Cfg.SetVisible()
                end)
    
                Dropdown:RefreshDropdown(Cfg.Options)
                Dropdown:SetupElement(Cfg.Default)
    
                return setmetatable(Cfg, Library)
            end
                
            Library.AddLabel = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Title or Data.Name or nil,
                    Items = {},
    
                    Names = self.Names,
                    Elements = self.Elements,
                    DataElements = self.DataElements,
                    SeperatedElements = self.SeperatedElements,
    
                    Type = "Label",
                }
                
                local Items = Cfg.Items; do
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 28); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Title = Library:Create("TextLabel",{Parent = Items.Object.Instance; RichText = true; TextColor3 = Themes.Preset["TextEnabled"]; Text = Cfg.Text; Size = UDim2.new(1, 0, 0, 0); Position = UDim2.new(0, -1, 0, 0); BorderSizePixel = 0; TextWrapped = true; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; AutomaticSize = Enum.AutomaticSize.Y; FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.ComponentsHolder = Library:Create("Frame",{AnchorPoint = Vector2.new(1, 0); Parent = Items.Object.Instance; BackgroundTransparency = 1; Position = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; Parent = Items.ComponentsHolder.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
    
                    Cfg.ChangeText = function(Text)
                        Items.Title.Instance.Text = Text
                    end
                end
    
                local Label = setmetatable(Cfg, Library)
                Label:SetupElement()
                
                return Label
            end
    
            Library.AddKeyPicker = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Name or Data.Title or "Keybind",
                    Flag = Data.Flag or Library:NextFlag(),
                    Callback = Data.Callback or function() end,
    
                    Key = Data.Key or Data.Default or nil,
                    Mode = Data.Mode or "Toggle",
                    Active = Data.Active or false,
                    ShowInList = Data.ShowInList or false, 
    
                    Open = false,
                    Tweening = false,
                    Binding,
    
                    Items = {},
                    Type = "KeybindPicker",
    
                    Names = self.Names,
                    Elements = self.Elements,
                    DataElements = self.DataElements,
                    SeperatedElements = self.SeperatedElements,
    
                    Old;
                }
    
                Flags[Cfg.Flag] = {
                    Mode = Cfg.Mode,
                    Key = Cfg.Key,
                    Active = Cfg.Active
                }
    
                local Keypicker = setmetatable(Cfg, Library)
                local KeybindListElement = Library:AddHotKey({})
                local Items = Cfg.Items; do
                    -- // Menu Element  
                    Items.ComponentsHolder = self.Items.ComponentsHolder
                    if not Items.ComponentsHolder then 
                        Items.Label =  self:AddLabel({Name = Cfg.Text})
                        Items.ComponentsHolder = Items.Label.Items.ComponentsHolder
                        Items.Label.Items.Title.Instance.Position = UDim2.new(0, 0, 0, 6)
                    end 
    
                    Items.Outline = Library:Create("Frame",{Parent = Items.ComponentsHolder.Instance; AutomaticSize = Enum.AutomaticSize.XY; AnchorPoint = Vector2.new(1, 0); BackgroundTransparency = 1; Position = UDim2.new(1, 0, 0, -5); Size = UDim2.new(0, 0, 0, 0); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; Parent = Items.Outline.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.Holder = Library:Create("Frame",{Parent = Items.Outline.Instance; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; BackgroundColor3 = Themes.Preset["OtherBackground"]}):Themify("OtherBackground", "BackgroundColor3")
                    Items.Value = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = "CTRL"; Parent = Items.Holder.Instance; AnchorPoint = Vector2.new(0, 0.5); BackgroundTransparency = 1; Position = UDim2.new(0, 0, 0.5, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingTop = UDim.new(0, 5); PaddingBottom = UDim.new(0, 5); Parent = Items.Holder.Instance; PaddingRight = UDim.new(0, 8); PaddingLeft = UDim.new(0, 8)})
                    Items.UIListLayout = Library:Create("UIListLayout",{VerticalAlignment = Enum.VerticalAlignment.Center; FillDirection = Enum.FillDirection.Horizontal; Parent = Items.Holder.Instance; Padding = UDim.new(0, 5); SortOrder = Enum.SortOrder.LayoutOrder})
                    Items.Icon = Library:Create("ImageLabel",{ImageColor3 = Themes.Preset["Accent"]; Parent = Items.Holder.Instance; Image = "rbxassetid://72338035902424"; BackgroundTransparency = 1; Size = UDim2.new(0, 14, 0, 14); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("Accent", "ImageColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Holder.Instance; CornerRadius = UDim.new(0, 2)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.Holder.Instance}):Themify("PageElementOutline", "Color")
    
                    -- Items.Holder.Instance:GetPropertyChangedSignal("Size"):Connect(function()
                    --     print("hi")
                    --     Items.Outline:Tween({Size = UDim2.new(0, Items.Holder.Instance.AbsoluteSize.X, 0, 26)})
                    -- end)
    
                    -- Items.Outline:Tween({Size = UDim2.new(0, Items.Holder.Instance.AbsoluteSize.X, 0, 26)})
    
                    -- // Right click panel     
                    Items.Section = Library:Create("TextButton",{Visible = false; FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["PageElementBackground"]; Text = ""; AutoButtonColor = false; Parent = Library.Other.Instance; Size = UDim2.new(0, 245, 0, 0); Position = UDim2.new(0.1930195689201355, 0, 0.44956523180007935, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; TextSize = 14; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.Section:Reparent(Library.Elements.Instance)
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Section.Instance; CornerRadius = UDim.new(0, 3)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["OtherInline"]; Parent = Items.Section.Instance; ApplyStrokeMode = Enum.ApplyStrokeMode.Border}):Themify("OtherInline", "Color")
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Section.Instance; Padding = UDim.new(0, 13); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                    Items.UIPadding = Library:Create("UIPadding",{Parent = Items.Section.Instance; PaddingTop = UDim.new(0, 12); PaddingRight = UDim.new(0, 12); PaddingLeft = UDim.new(0, 12)})
    
                    local Elements = Items.Section:CreateElements({Size = UDim2.new(1, 0, 0, 0), Position = UDim2.new(0, 0, 0, 0)})
                    Elements:AddToggle({Text = "Show in list", Default = Cfg.ShowInList, Flag = Cfg.Flag .. "_SHOW_IN_LIST", Callback = function(Bool)
                        if Bool then 
                            KeybindListElement:SetEnabled(Cfg.Active)
                        else 
                            KeybindListElement:SetEnabled(false)
                        end
                    end})
                    Elements:AddDropdown({Text = "Mode", Options = {"Hold", "Toggle", "Always"}, Default = Cfg.Mode, Flag = Cfg.Flag .. "_MODE", Callback = function(Option)
                        if Cfg.Set then 
                            Cfg.Set(Option)
                        end 
                    end})
    
                    Items.Section:OutsideClick(Cfg, Elements.DataElements)
                end
    
                Cfg.Set = function(Input)
                    if type(Input) == "boolean" then
                        Cfg.Active = Input
    
                        if Cfg.Mode == "Always" then
                            Cfg.Active = true
                        end
                    elseif tostring(Input):find("Enum") then
                        Input = Input.Name == "Escape" and "None" or Input
    
                        Cfg.Key = Input or "None"
                    elseif table.find({ "Toggle", "Hold", "Always" }, Input) then
                        if Input == "Always" then
                            Cfg.Active = true
                        end
    
                        Cfg.Mode = Input
                        Keypicker:SetMode(Cfg.Mode)
                    elseif type(Input) == "table" then
                        Input.Key = type(Input.Key) == "string" and Input.Key ~= "None" and Library:ConvertEnum(Input.Key) or Input.Key
                        Input.Key = Input.Key == Enum.KeyCode.Escape and "None" or Input.Key
    
                        Cfg.Key = Input.Key or "None"
                        Cfg.Mode = Input.Mode or "Toggle"
    
                        if Input.Active then
                            Cfg.Active = Input.Active
                        end
    
                        Keypicker:SetMode(Cfg.Mode)
                    end
    
                    Cfg.Callback(Cfg.Active)
    
                    local text = (tostring(Cfg.Key) ~= "Enums" and (Keys[Cfg.Key] or tostring(Cfg.Key):gsub("Enum.", "")) or nil)
                    local __text = text and tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", "") or ""
    
                    Items.Value.Instance.Text = __text
    
                    KeybindListElement:ChangeText(__text, Cfg.Text, Cfg.Mode)
                    
                    if Flags[Cfg.Flag .. "_SHOW_IN_LIST"] then  
                        KeybindListElement:SetEnabled(Cfg.Active)
                    end
    
                    Flags[Cfg.Flag] = {
                        Mode = Cfg.Mode,
                        Key = Cfg.Key,
                        Active = Cfg.Active
                    }
                end
    
                Cfg.SetVisible = function(Open, Debounce)
                    if Cfg.Tweening then
                        return
                    end
    
                    Cfg.Open = Open
                    
                    Keypicker:UpdateKeyPickerPosition(Cfg.Open, Debounce)
    
                    if Debounce and Cfg.Open then
                        return 
                    end
    
                    Items.Section:TweenDescendants(Cfg.Open, Cfg)
                    Items.Section:ClampToScreen()
                end
    
                Cfg.IsHovering = function()
                    return Items.Modepicker:Hovering()
                end
    
                Items.Outline:OnClick(function()
                    Keypicker:NewKey()
                end)
    
                Library:Connect(Services.UserInputService.InputBegan, function(Input, GameProcessedEvent)
                    local SelectedKey = Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or Input.UserInputType
    
                    if SelectedKey == Cfg.Key or tostring(SelectedKey) == Cfg.Key and not GameProcessedEvent then
                        if Cfg.Mode == "Toggle" then
                            Cfg.Active = not Cfg.Active
                            Cfg.Set(Cfg.Active)
                        elseif Cfg.Mode == "Hold" then
                            Cfg.Set(true)
                        end
                    end
                end)
                    
                Items.Outline:OnRightClick(function()
                    Cfg.Open = not Cfg.Open
                    Cfg.SetVisible(Cfg.Open)
                end)
    
                Library:Connect(Services.UserInputService.InputEnded, function(Input, GameProcessedEvent)
                    if GameProcessedEvent then
                        return
                    end
    
                    local SelectedKey = Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode or
                    Input.UserInputType
    
                    if SelectedKey == Cfg.Key then
                        if Cfg.Mode == "Hold" then
                            Cfg.Set(false)
                        end
                    end
                end)
    
                Keypicker:SetupElement({ Mode = Cfg.Mode, Active = Cfg.Active, Key = Cfg.Key })
    
                Cfg.Old = Flags[Cfg.Flag]
    
                return Keypicker
            end
    
            Library.AddButton = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Title or Data.Name or "Button",
                    Callback = Data.Callback or function() end,
                    Seperator = Data.Seperator,
                    Confirmation = Data.Confirmation or false; 
    
                    Items = {}, 
    
                    Elements = self.Elements,
                    Names = self.Names,
                    DataElements = self.DataElements,
                }
    
                local Items = Cfg.Items; do
                    Items.Object = self.Items.Object
                    
                    if not Items.Object then
                        Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 35); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255); AutomaticSize = Enum.AutomaticSize.Y})
                        Items.UIListLayout = Library:Create("UIListLayout",{FillDirection = Enum.FillDirection.Horizontal; HorizontalFlex = Enum.UIFlexAlignment.Fill; Parent = Items.Object.Instance; Padding = UDim.new(0, 11); SortOrder = Enum.SortOrder.LayoutOrder; VerticalFlex = Enum.UIFlexAlignment.Fill})
                    end
    
                    Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 1, 0, 0); Size = UDim2.new(1, -2, 0, 35); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Outline.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.Outline.Instance}):Themify("PageElementOutline", "Color")
                    Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = Cfg.Text; Parent = Items.Outline.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 1, 0); BorderSizePixel = 0; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                end
    
                local Connection;
                local Confirm = false;
                Cfg.Set = function()
                    if Cfg.Confirmation then 
                        Items.Title:Tween({TextColor3 = Themes.Preset.Accent})
                    else 
                        Items.Title.Instance.TextColor3 = Themes.Preset.Accent
                    end 
                    
                    if Confirm or not Cfg.Confirmation then
                        Cfg.Callback()
                        Items.Title:Tween({TextColor3 = Themes.Preset.TextEnabled})
    
                        Items.Title.Instance.Text = Cfg.Text 
    
                        Confirm = false
    
                        return
                    end 
    
                    if not Confirm and Cfg.Confirmation then
                        Confirm = true 
    
                        for i = 30, 0, -1 do 
                            if Confirm == false then 
                                break
                            end 
    
                            Items.Title.Instance.Text = string.format("Confirm? (%ss)", i/10)
    
                            task.wait(0.1)
                        end
                        
                        Items.Title:Tween({TextColor3 = Themes.Preset.TextEnabled})
    
                        Items.Title.Instance.Text = Cfg.Text 
    
                        Confirm = false
    
                        return
                    end 
                end
    
                Items.Outline:OnClick(Cfg.Set)
    
                local Button = setmetatable(Cfg, Library)
                Button:SetupElement()
    
                return Button
            end
    
            Library.AddInput = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Title or Data.Name,
                    Placeholder = Data.PlaceHolder or Data.TextColor or Data.Holder or Data.HolderText or "Input here...",
                    Default = Data.Default or "",
                    Flag = Data.Flag or Library:NextFlag(),
                    Callback = Data.Callback or function() end,
                    FocusLost = Data.FocusLost or false, 
    
                    Items = {},
                    Focused = false,
    
                    Names = self.Names,
                    Elements = self.Elements,
                    DataElements = self.DataElements,
                    SeperatedElements = self.SeperatedElements,
                }   
    
                local Items = Cfg.Items; do
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 0); BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.Y; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Position = UDim2.new(0, 1, 0, Cfg.Text and 27 or 0); Size = UDim2.new(1, -2, 0, 35); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["PageElementBackground"]}):Themify("PageElementBackground", "BackgroundColor3")
                    Items.UICorner = Library:Create("UICorner",{Parent = Items.Outline.Instance; CornerRadius = UDim.new(0, 4)})
                    Items.UIStroke = Library:Create("UIStroke",{Color = Themes.Preset["PageElementOutline"]; Parent = Items.Outline.Instance}):Themify("PageElementOutline", "Color")
                    Items.Input = Library:Create("TextBox",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); Parent = Items.Outline.Instance; TextColor3 = Themes.Preset["TextEnabled"]; Text = "Option1, Option2, Option3, Option4"; Size = UDim2.new(1, -20, 1, 0); Selectable = false; BorderSizePixel = 0; BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; TextTruncate = Enum.TextTruncate.SplitWord; Active = false; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    Items.UIPadding = Library:Create("UIPadding",{PaddingLeft = UDim.new(0, 9); Parent = Items.Input.Instance})
    
                    if Cfg.Text then 
                        Items.Title = Library:Create("TextLabel",{FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal); TextColor3 = Themes.Preset["TextEnabled"]; Text = Cfg.Text; Parent = Items.Object.Instance; Position = UDim2.new(0, -1, 0, 0); BackgroundTransparency = 1; TextXAlignment = Enum.TextXAlignment.Left; BorderSizePixel = 0; AutomaticSize = Enum.AutomaticSize.XY; TextSize = 16; BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Themify("TextEnabled", "TextColor3")
                    end 
                end
    
                function Cfg.Set(Text)
                    if type(Text) == "boolean" or Text == nil then 
                        return 
                    end 
    
                    Flags[Cfg.Flag] = Text
    
                    Items.Input.Instance.Text = Text
    
                    Cfg.Callback(Text)
                end
    
                Items.Input.Instance.Focused:Connect(function()
                    Cfg.Focused = true;
    
                    Items.Input:Tween({
                        TextColor3 = Themes.Preset.Accent;
                    })
                end)
    
                Items.Input.Instance.FocusLost:Connect(function()
                    Cfg.Focused = false;
    
                    Items.Input:Tween({
                        TextColor3 = Themes.Preset.TextEnabled;
                    })
    
                    if Cfg.FocusLost then 
                        Cfg.Set(Items.Input.Instance.Text)
                    end 
                end)
    
                if not Cfg.FocusLost then 
                    Items.Input.Instance:GetPropertyChangedSignal("Text"):Connect(function()
                        Cfg.Set(Items.Input.Instance.Text)
                    end)
                end
    
                local Input = setmetatable(Cfg, Library)
                Input:SetupElement(Cfg.Default)
    
                return Input
            end
    
            Library.AddColorPicker = function(self, Data)
                Data = Data or {}
    
                local Cfg = {
                    Text = Data.Text or Data.Name or Data.Title or "Color",
                    Flag = Data.Flag or Data.Text or Data.Title or Library:NextFlag(),
                    Callback = Data.Callback or function() end,
    
                    Color = Data.Color or Data.Default or Color3.new(1, 1, 1), -- Default to white color if not provided
                    Alpha = Data.Alpha or Data.Transparency or 1,
                    Colors = Data.Colors or {},
    
                    -- Other    
                    Open = false,
                    Items = {},
    
                    Names = self.Names, 
                    DataElements = self.DataElements,
                    Items = self.Items,
                    Element = self,
    
                    Type = Data.Type or "Animation"
                }
    
                local Picker = self:Colorpicker(Cfg)
                Picker.Items.ComponentsHolder = self.Items.ComponentsHolder
    
                local Items = Picker.Items; do
                    Cfg.Items = Items;
                    Cfg.Set = Picker.Set;
                    Cfg.SetDeleterVisible = Picker.SetDeleterVisible;
                    Cfg.IsHovering = Picker.IsHovering;
                end
    
                return setmetatable(Cfg, Library)
            end
    
            Library.AddList = function(self, Data)  
                Data = Data or {}
    
                local Cfg = {
                    Flag = Data.Flag or Library:NextFlag(),
                    Options = Data.Options or { "Option 1", "Option 2", "Option 3", "Option 4" },
                    Callback = Data.Callback or function() end,
                    Multi = Data.Multi or false,
    
                    Size = Data.Size or 100,
                    Scrolling = Data.Scrolling or false, 
    
                    Names = self.Names,
                    Items = {},
                    OptionInstances = {},
                    MultiItems = {},
                    DataElements = self.DataElements,
                }
                
                local Items = Cfg.Items; do
                    Items.Object = Library:Create("TextButton",{Parent = self.Items.Elements.Instance; BackgroundTransparency = 1; Size = UDim2.new(1, 0, 0, 100); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.Outline = Library:Create("Frame",{Parent = Items.Object.Instance; Size = UDim2.new(1, 0, 0, 100); BorderSizePixel = 0; BackgroundColor3 = Themes.Preset["Outline"]}):Themify("Outline", "BackgroundColor3")
                    Items.Inline = Library:Create("Frame",{Parent = Items.Outline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(54, 54, 54)})
                    Items.Gray = Library:Create("Frame",{Parent = Items.Inline.Instance; Position = UDim2.new(0, 1, 0, 1); Size = UDim2.new(1, -2, 1, -2); BorderSizePixel = 0; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIGradient = Library:Create("UIGradient",{Rotation = 90; Parent = Items.Gray.Instance; Color = ColorSeq{ColorKey(0, Color3.fromRGB(38, 38, 38)), ColorKey(1, Color3.fromRGB(25, 25, 25))}})
                    Items.Holder = Library:Create("ScrollingFrame",{AutomaticCanvasSize = Enum.AutomaticSize.Y; BorderSizePixel = 0; CanvasSize = UDim2.new(0, 0, 0, 0); ScrollBarImageColor3 = Color3.fromRGB(245, 20, 136); MidImage = "rbxassetid://118384633897629"; Parent = Items.Gray.Instance; ScrollBarThickness = 3; Size = UDim2.new(1, 0, 1, 0); ElasticBehavior = Enum.ElasticBehavior.Always; Selectable = false; TopImage = "rbxassetid://118384633897629"; BottomImage = "rbxassetid://118384633897629"; BackgroundTransparency = 1; BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                    Items.UIListLayout = Library:Create("UIListLayout",{Parent = Items.Holder.Instance; SortOrder = Enum.SortOrder.LayoutOrder})
                end 
    
                Cfg.Set = function(Value)
                    local Selected = {}
                    local IsTable = type(Value) == "table"
    
                    for _, Option in Cfg.OptionInstances do
                        local Text = Option.Value.Instance.Text
    
                        if Text == Value or (IsTable and table.find(Value, Text)) then
                            table.insert(Selected, Text)
                            Cfg.MultiItems = Selected
    
                            Option.Value:Tween({ TextColor3 = Themes.Preset.Accent })
                        else    
                            Option.Value:Tween({ TextColor3 = Themes.Preset.TextMisc })
                        end
                    end
    
                    Flags[Cfg.Flag] = IsTable and Selected or Selected[1]
                    Cfg.Callback(Flags[Cfg.Flag])
                end
    
                local List = setmetatable(Cfg, Library)
                List:SetupElement(Cfg.Default)
                List:RefreshList(Cfg.Options)
    
                return setmetatable(Cfg, Library)
            end
        end
        
        -- // Configs
        do 
            Library.InitPanels = function(self)
                if getgenv().Text then getgenv().Text = nil end 
    
                local Tab = self:AddTab({Title = "Settings", Columns = 2, Icon = "rbxassetid://75121128014531"});
                local Settings = Tab:AddPage({Text = "Configs", Columns = 2});
    
                local Section = Settings:AddSection({Title = "Configuration", Side = 1, Icon = "rbxassetid://89805822444471"}) do 
                    local ConfigText;
                    local ConfigHolder = Section:AddDropdown({Text = "Configs", Flag = "ConfigList", Callback = function(option) 
                        if Text and Text.Set and option then 
                            Text.Set(option, true) 
                        end 
                    end})
    
                    Text = Section:AddInput({Text = "Config Name:", Flag = "config_Name_text", PlaceHolder = "Type config name here...", Callback = function(text)
                        ConfigText = text
                    end})
    
                    Section:AddButton({Text = "Save", Confirmation = true, Callback = function() 
                        if not ConfigText then 
                            return 
                        end 
    
                        Library:SaveConfig(ConfigText)
                        ConfigHolder:UpdateConfigList()
                    end})
                    :AddButton({Text = "Load", Confirmation = true, Callback = function()
                        if not (ConfigText and isfile(Library.Directory .. "/Configs/" .. ConfigText .. ".cfg")) then 
                            return 
                        end 
                        self.Tweening = true
                        Library:LoadConfig(readfile(Library.Directory .. "/Configs/" .. ConfigText .. ".cfg"))
                        self.Tweening = false
                        ConfigHolder:UpdateConfigList()
                    end})
                    
                    Section:AddButton({Text = "Delete", Confirmation = true, Callback = function() 
                        if not ConfigText then 
                            return 
                        end 
    
                        Library:DeleteConfig(ConfigText)
                        ConfigHolder:UpdateConfigList()
                    end})
                    :AddButton({Text = "Refresh", Confirmation = true, Callback = function() 
                        ConfigHolder:UpdateConfigList()
                    end})
                    
                    ConfigHolder:UpdateConfigList()
                end
    
                local Section = Settings:AddSection({Title = "Menu", Side = 1}) do 
                    self.Tweening = true
                    Section:AddKeyPicker({Text = "Menu bind", Key = Enum.KeyCode.RightShift, Mode = "Toggle", ShowInList = false, Callback = function(Value)
                        if self.Tweening then 
                            return 
                        end     
                        
                        self:SetMenuVisible(Value)
                    end})
                    self.Tweening = false
    
                    Section:AddDropdown({Text = "Easing Style", Flag = "Easing Style", Options = {"Linear", "Cubic", "Quad", "Quart", "Quint", "Sine", "Exponential", "Back", "Bounce", "Elastic", "Circular"}, Default = tostring(Library.EasingStyle):match("%.([%w]+)$"), Callback = function(Option) Library.EasingStyle = Enum.EasingStyle[Option] end})
                    Section:AddDropdown({Text = "Easing Direction", Flag = "Easing Direction", Options = {"In", "Out", "InOut"}, Default = tostring(Library.EasingDirection):match("%.([%w]+)$"), Callback = function(Option) Library.EasingDirection = Enum.EasingDirection[Option] end})
                    Section:AddSlider({Text = "Tweening Speed", Flag = "Tweening Speed", Min = 0, Max = 2, Default = 0.3, Suffix = "s", Decimal = 0.01, Callback = function(Text) Library.TweeningSpeed = Text  end})
                    Section:AddSlider({Text = "Dragging Speed", Flag = "Dragging Speed", Min = 0, Max = 2, Default = 0.05, Suffix = "s", Decimal = 0.01, Callback = function(Text) Library.DraggingSpeed = Text end})
                end
    
                local Section = Settings:AddSection({Title = "HUD", Side = 2}) do 
                Section:AddToggle({Text = "Watermark", Default = true, Callback = self.SetWatermarkVisibility})
                Section:AddDropdown({Text = "Options", Flag = "WatermarkSettings", Options = {"Title", "Fps", "Ping", "Game Name", "User ID", "LocalPlayer Name", "Date"}, Multi = true, Default = {"Title", "Fps", "Ping"}})
                Section:AddSlider({Text = "Refresh Rate", Flag = "Refresh Rate", Min = 0, Max = 2, Default = 0.1, Suffix = "s", Decimal = 0.01})
                Section:AddToggle({Text = "Keybind List", Default = true, Callback = self.SetKeybindListVisibility}) 
                    
                local Section = Settings:AddSection({Title = "Theming", Side = 2})
                    for Name,Value in Themes.Preset do 
                        Section:AddColorPicker({Text = Name:gsub("(%l)(%u)", "%1 %2"), Default = Value, Flag = Name, NoCallback = true, Callback = function(Color)
                            Library:Refresh(Name, Color)
                        end})
                    end 
    
                    local Input;
                    ThemeHolder = Section:AddDropdown({
                        Text = "Themes", 
                        Callback = function(Option)
                            if Input then Input.Set(Option) end
                            -- auto load it
                            if not Option or Option == "" then return end
                            local path = Library.Directory .. "/Themes/" .. Option .. ".Cfg"
                            if isfile(path) then
                                Library:LoadConfig(readfile(path))
                            end
                        end
                    })
                    Input = Section:AddInput({Text = "Config Name:", Flag = "Theming_Text_Name", PlaceHolder = "Theme name here..."})
                    Section:AddButton({Text = "Save", Callback = function() 
                        Library:SaveTheme(Flags["Theming_Text_Name"])
                        ThemeHolder:UpdateThemingList()
                    end})
                    :AddButton({Text = "Load", Callback = function()
                        if not Flags["Theming_Text_Name"] then 
                            return 
                        end 
    
                        if not isfile(Library.Directory .. "/Themes/" .. Flags["Theming_Text_Name"] .. ".Cfg") then 
                            return 
                        end 
    
                        Library:LoadConfig(readfile(Library.Directory .. "/Themes/" .. Flags["Theming_Text_Name"] .. ".Cfg"))
                        ThemeHolder:UpdateThemingList()
                    end})
    
                    Section:AddButton({Text = "Delete", Callback = function() 
                        if not Flags["Theming_Text_Name"] then 
                            return 
                        end 
    
                        Library:DeleteTheme(Flags["Theming_Text_Name"])
                        ThemeHolder:UpdateThemingList()
                    end})
                    :AddButton({Text = "Refresh", Callback = function() 
                        ThemeHolder:UpdateThemingList()
                    end})
    
                    ThemeHolder:UpdateThemingList()
                end 
            end
        end 
    
        Library:Connect(Services.RunService.Heartbeat, function()
            if not (Library.LerpObjects) then 
                return 
            end     
    
            Library:LerpObjects()
            Library:LerpKeybinds()
        end)
    end

    return Library
