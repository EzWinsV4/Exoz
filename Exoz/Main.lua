if not game:IsLoaded() then
    game.Loaded:Wait()
end

print([[

▓█████ ▒██   ██▒ ▒█████  ▒███████▒
▓█   ▀ ▒▒ █ █ ▒░▒██▒  ██▒▒ ▒ ▒ ▄▀░
▒███   ░░  █   ░▒██░  ██▒░ ▒ ▄▀▒░ 
▒▓█  ▄  ░ █ █ ▒ ▒██   ██░  ▄▀▒   ░
░▒████▒▒██▒ ▒██▒░ ████▓▒░▒███████▒
░░ ▒░ ░▒▒ ░ ░▓ ░░ ▒░▒░▒░ ░▒▒ ▓░▒░▒
 ░ ░  ░░░   ░▒ ░  ░ ▒ ▒░ ░░▒ ▒ ░ ▒
   ░    ░    ░  ░ ░ ░ ▒  ░ ░ ░ ░ ░
   ░  ░ ░    ░      ░ ░    ░ ░    
                         ░        

--------------------------------------------------
    👽 Exoz - The Best ScriptHub
    👾 https://discord.com/invite/7DVEpdpsyf for premuim scripts.
--------------------------------------------------
    Created by Vn and Vexi. 🛸

]])

local Exoz = {
    ["Universal"] = "https://raw.githubusercontent.com/EzWinsV4/Exoz/refs/heads/main/Exoz/Universal.lua",
    ["Piggy"] = {
        games = {4623386862},
        url = "https://raw.githubusercontent.com/EzWinsV4/Exoz/refs/heads/main/Exoz/Piggy.lua"
    },
    ["Tower Of Hell"] = {
        games = {1962086868, 3582763398, 94971861814985, 5253186791},
        url = "https://raw.githubusercontent.com/EzWinsV4/Exoz/refs/heads/main/Exoz/TowerOfHell.lua"
    },
    ["Lucky Block Battleground"] = {
        games = {662417684, 106931261124996},
        url = "https://raw.githubusercontent.com/EzWinsV4/Exoz/refs/heads/main/Exoz/LuckyBlockBattleground.lua"
    },
    ["Dahood"] = {
        games = {2788229376},
        url = "https://raw.githubusercontent.com/EzWinsV4/Exoz/refs/heads/main/Exoz/Dahood.lua"
}

local currentGameId = game.PlaceId
local scriptFound = false
local scriptUrl = Exoz["Universal"]

for scriptName, scriptData in pairs(Exoz) do
    if scriptName ~= "Universal" then
        for _, gameId in ipairs(scriptData.games) do
            if gameId == currentGameId then
                scriptUrl = scriptData.url
                scriptFound = true
                break
            end
        end
        if scriptFound then break end
    end
end

local scriptContent = game:HttpGet(scriptUrl)
loadstring(scriptContent)()
