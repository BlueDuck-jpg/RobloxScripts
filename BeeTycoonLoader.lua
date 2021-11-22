-- Checks if player claimed a tycoon
if game.Players.LocalPlayer.Team ~= "For Hire" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlueDuck-jpg/RobloxScripts/main/BeeTycoonMain.lua"))()
else
    local unclaimed = workspace.Tycoons.Tycoons:FindFirstChild("Touch to claim!", true)
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, unclaimed.Head, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, unclaimed.Head, 1)
    createNotification("NOTIFICATION!", "Claimed " + unclaimed.Parent.Parent.Name, 5)
end
