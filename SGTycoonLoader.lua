-- Checks if player claimed a tycoon
if tostring(game.Players.LocalPlayer.Team) ~= "For Hire" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlueDuck-jpg/RobloxScripts/main/SGTycoonMain.lua"))()
else
    function createNotification(Title, Text, Duration)
        game.StarterGui:SetCore("SendNotification", {
            Title = Title,
            Text = Text,
            Duration = Duration
        }) 
    end
    local unclaimed = workspace.Tycoon.Tycoons:FindFirstChild("Touch To Claim", true)
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, unclaimed, 0)
    wait()
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, unclaimed, 1)
    createNotification("NOTIFICATION!", "Claimed " .. unclaimed.Parent.Parent.Name, 5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BlueDuck-jpg/RobloxScripts/main/SGTycoonMain.lua"))()
end
