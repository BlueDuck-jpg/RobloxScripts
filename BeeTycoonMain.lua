if game.CoreGui:FindFirstChild("Bee Tycoon") then
    game.CoreGui["Bee Tycoon"]:Destroy()
end

function createNotification(Title, Text, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Duration
    }) 
end

createNotification("Thanks!", "Thanks for choosing this script!", 5)

local keybind = Enum.KeyCode.Equals

-- Variables
local library = loadstring(game:HttpGet("https://pastebin.com/raw/ZvU19kR3"))()
local window = library:Window("Bee Tycoon", Color3.fromRGB(44,120,224), keybind)
local tab = window:Tab("Main")
local tycoon = Workspace.Tycoons.Tycoons[tostring(game.Players.LocalPlayer.Team)]

-- Globals
getgenv().dropper = false
getgenv().collect = false
getgenv().buy = false
getgenv().owneronly = false
getgenv().walkspeed = false
getgenv().killall = false
getgenv().loopkill = false

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

-- Components

tab:Toggle("Auto Click Dropper", function(t)
    getgenv().dropper = t
    spawn(function()
        while wait() do
            if getgenv().dropper then
                fireclickdetector(workspace.Tycoons.Tycoons[tostring(game.Players.LocalPlayer.Team)].PurchasedObjects.Mine.Clicker.ClickDetector, 0) 
            end
        end
    end)
end)

tab:Toggle("Auto Collect", function(t)
    getgenv().collect = t
    spawn(function()
        while wait() do
            if getgenv().collect then
                firetouchinterest(workspace.Tycoons.Tycoons[tostring(game.Players.LocalPlayer.Team)].Essentials.Giver, game.Players.LocalPlayer.Character.HumanoidRootPart, 0) 
                wait()
                firetouchinterest(workspace.Tycoons.Tycoons[tostring(game.Players.LocalPlayer.Team)].Essentials.Giver, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
                wait(.2)
            end
        end
    end)
end)

tab:Toggle("Auto Buy", function(t)
    getgenv().buy = t
    spawn(function(t)
        while wait() do
            if getgenv().buy then
                for i,v in ipairs(tycoon.Buttons:GetChildren()) do
                    if not v:FindFirstChild("Gamepass") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Head, 0)
                        wait()
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Head, 1)
                        wait(.2)
                    end
                end
            end
        end
    end)
end)

tab:Toggle("Spam Tycoon's Laser (IF HAVE LASER DOOR)", function(t)
    getgenv().owneronly = t 
    spawn(function()
        while wait(.5) do
            if getgenv().owneronly then
                fireclickdetector(tycoon.PurchasedObjects.OwnerOnlyDoor.Button.ClickDetector)
            end
        end
    end)
end)

tab:Button("Remove all lasers", function()
    spawn(function()
        for i,v in pairs(workspace:GetDescendants()) do
            if v.Name == "OwnerOnlyDoor" then
                if v.Parent.Parent.Name ~= tostring(game.Players.LocalPlayer.Team) then
                    v:Destroy() 
                end
            end
        end
    end)
end)

tab:Toggle("2x WalkSpeed (Re-Enable if die)", function(t)
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

tab:Button("Get All Items", function(t)
    -- 1
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 1)
    wait()
    
    -- 2
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver2", true).Model.Main, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver2", true).Model.Main, 1)
    wait()
    
    -- 3
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver3", true).Model.Main, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver3", true).Model.Main, 1)
    wait()
    
    -- 4
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver4", true).Model.Main, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver4", true).Model.Main, 1)
    wait()
end)

tab:Toggle("Kill All", function(t)
    getgenv().killall = t
    spawn(function()
        while wait() do
            if getgenv().killall then
                if game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword") then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
                else
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 1)
                    wait(.5)
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
                end
                wait(.6)
                for i,v in ipairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then
                        repeat wait() game.Players.LocalPlayer.Character:PivotTo(v.Character:GetPivot()) until v.Character.Humanoid.Health <= 0 or not getgenv().killall
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
    local findplayer = game.Players:FindFirstChild(PlayerName)
    if findplayer then
        local v = findplayer
        if game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
        else
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 0)
            wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 1)
            wait(.5)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
        end
        wait(.6)
        repeat wait() game.Players.LocalPlayer.Character:PivotTo(v.Character:GetPivot()) until v.Character.Humanoid.Health <= 0 or game.Players.LocalPlayer.Character.Humanoid.Health == 0
    else
        createNotification("ERROR!", "Can't find player.", 2.5)
    end
end)

local a = 1
tab:Toggle("Loop Kill Player", function(t)
    getgenv().loopkill = t
    spawn(function()
        while wait() do
            if getgenv().loopkill then
                local findplayer = game.Players:FindFirstChild(PlayerName)
                if findplayer then
                    local v = findplayer
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword") then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
                    else
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 0)
                        wait()
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Tycoons.Tycoons:FindFirstChild("WeaponGiver1", true).Model.Main, 1)
                        wait(.5)
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("ClassicSword"))
                    end
                    wait(.6)
                    repeat wait() game.Players.LocalPlayer.Character:PivotTo(v.Character:GetPivot()) until v.Character.Humanoid.Health <= 0 or not getgenv().loopkill
                else
                    if a == 1 then
                        createNotification("ERROR!", "Can't find player.", 2.5)
                        a = a + 1
                    end
                end
            end
        end
    end)
end)

-- Theme

local theme = window:Tab("Settings")

theme:Bind("Hide/Show UI Keybind", keybind, function(t)
    keybind = t 
end)

theme:Colorpicker("Change Selections Color", Color3.fromRGB(44, 120, 224), function(t)
    library:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G* 255, t.B* 255))
end)

theme:Colorpicker("Change Background Color", Color3.fromRGB(30, 30, 30), function(t)
    library:ChangeMainColor(Color3.fromRGB(t.R * 255, t.G* 255, t.B* 255))
end)
