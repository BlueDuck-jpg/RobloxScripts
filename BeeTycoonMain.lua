-- Anti Multiple GUI
if game.CoreGui:FindFirstChild("Squid Game Tycoon") then
    game.CoreGui["Squid Game Tycoon"]:Destroy()
end

-- Notification Library
function createNotification(Title, Text, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Duration
    }) 
end

-- Greeting Notification
createNotification("THANKS!", "Thanks for choosing this script!", 5)

getgenv().keybind = Enum.KeyCode.Equals

-- Setup
local library = loadstring(game:HttpGet("https://pastebin.com/raw/xwqKZf59"))()
local window = library:Window("Squid Game Tycoon", Color3.fromRGB(44,120,224), getgenv().keybind)
local tab = window:Tab("Main")

-- Variables
local tycoon = workspace.Tycoon.Tycoons[tostring(game.Players.LocalPlayer.Team)]

-- Globals
getgenv().collect = false
getgenv().buy = false
getgenv().laser = false
getgenv().walkspeed = false
getgenv().killall = false
getgenv().loop = false

-- Anti Kick & Anti AFK
local cool, bruh = pcall(function()
    -- Anti Afk
    local bb=game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
        bb:CaptureController()bb:ClickButton2(Vector2.new())
    end)

    -- Anti Kick
    local get = getrawmetatable(game)
    local oldnamecall = get.__namecall
    
    setreadonly(get, false)
    
    get.__namecall = newcclosure(function(Self,...)
        local method = getnamecallmethod()
        if Self == game.Players.LocalPlayer and tostring(method) == "Kick" then
            return
        end
        return oldnamecall(Self,...)
    end)
end)

if cool then
    createNotification("Success!", "Successfully bypassed kick and afk timeout kick!", 5)
else
    createNotification("Error!", "There was an error when trying to bypass kick and afk timeout!", 5)
end

-- Script

tab:Toggle("Auto Collect", function(t)
    getgenv().collect = t
    spawn(function()
        while wait() do
            if getgenv().collect then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tycoon.Essentials.Giver, 0)
                wait()
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, tycoon.Essentials.Giver, 1)
                wait(.5)
            end
        end
    end)
end)

tab:Toggle("Auto Buy", function(t)
    getgenv().buy = t
    spawn(function()
        while wait() do
            if getgenv().buy then
                for i,v in pairs(tycoon.Buttons:GetChildren()) do
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Head, 0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Head, 1)
                    wait()
                end
            end
        end
    end)
end)

tab:Toggle("Spam Laser Door (IF HAVE LASER DOOR)", function(t)
    getgenv().laser = t
    spawn(function()
        while wait(.5) do
            if getgenv().laser then
                fireclickdetector(tycoon.PurchasedObjects["Lazer Door"].Button.ClickDetector, 0) 
            end
        end
    end)
end)

tab:Button("Remove Laser Doors", function()
    spawn(function()
        for i,v in pairs(workspace:GetDescendants()) do
            if v.Name == "Lazer Door" then
                if v.Parent.Parent.Name ~= tostring(game.Players.LocalPlayer.Team) then
                    v:Destroy() 
                end
            end
        end
    end)
end)

tab:Toggle("2x WalkSpeed", function(t)
    getgenv().walkspeed = t
    spawn(function()
        while wait() do
            if getgenv().walkspeed then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
            else
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end)
end)

tab:Toggle("Kill All", function(t)
    getgenv().killall = t
    spawn(function()
        while wait() do
            if getgenv().killall then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
                for i,v in ipairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then
                        repeat wait() game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword")) game.Players.LocalPlayer.Character:PivotTo(v.Character:GetPivot()) until v.Character.Humanoid.Health <= 0 or not getgenv().killall
                    end
                end
            end
        end
    end)
end)

local PlayerName = ""
tab:Textbox("Player Name", false, function(t)
    PlayerName = tostring(t) 
end)

tab:Button("Kill Player", function()
    local v = game.Players:FindFirstChild(PlayerName)
    if v then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
        repeat wait() game.Players.LocalPlayer.Character:PivotTo(v.Character:GetPivot()) until v.Character.Humanoid.Health <= 0 or game.Players.LocalPlayer.Character.Humanoid.Health == 0
    else
        createNotification("ERROR!", "Can't find player!", 5)
    end
end)

tab:Toggle("Loop Kill Player", function(t)
    getgenv().loop = t
    local a = false
    spawn(function()
        while wait() do
            if getgenv().loop then
                local v = game.Players:FindFirstChild(PlayerName)
                if v then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
                    repeat wait() game.Players.LocalPlayer.Character:PivotTo(v.Character:GetPivot()) until v.Character.Humanoid.Health <= 0 or game.Players.LocalPlayer.Character.Humanoid.Health == 0
                else
                    if not a then
                        createNotification("ERROR!", "Can't find player!", 5)
                        a = true
                    end
                end
            end
        end
    end)
end)

-- Settings

local theme = window:Tab("Settings")

theme:UiKeybind(getgenv().keybind, function(t)
    library:ChangeUiKeybind(t) 
end)

theme:DestroyGui()

theme:Colorpicker("Change Selections Color", Color3.fromRGB(44, 120, 224), function(t)
    library:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G* 255, t.B* 255))
end)

theme:Colorpicker("Change Background Color", Color3.fromRGB(30, 30, 30), function(t)
    library:ChangeMainColor(Color3.fromRGB(t.R * 255, t.G* 255, t.B* 255))
end)
