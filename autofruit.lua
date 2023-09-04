repeat wait() until game:IsLoaded()
local client = game.Players.LocalPlayer
local HTTPService = game:GetService("HttpService")
pcall(function()
repeat wait() until client.PlayerGui.LoadingGui.Frame:FindFirstChild('Indicator')
end)

local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("baboucheserver.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("baboucheserver.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("baboucheserver.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("baboucheserver.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, client)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end


local fruitfound = false
for i, v in pairs(workspace:GetChildren()) do
    if not table.find(getgenv().skipfruit, v.Name) then
        if v:IsA('Tool') then
            fruitfound = true
        elseif v:IsA('Model') then
            if v:FindFirstChild('Eat') then
                fruitfound = true
            end
        end
    end
end

if not fruitfound then
    Teleport()
end

pcall(function()
repeat wait() until client.PlayerGui.LoadingGui.Frame.Indicator.Text == 'LOADING COMPLETE'
wait(1.5)
for i, v in pairs(getgc()) do
    if getinfo(v).name == 'Play' then
        v()
    end
end

local leaderstat = client.leaderstats
local inventory = leaderstat.Inventory
local storage = leaderstats:GetAttribute('FruitStorage') + 1

end)
pcall(function()
repeat wait() until client.Character.HumanoidRootPart.Anchored == false
end)
function tp(p1)
    task.spawn(function()
        pcall(function()
            client.Character.HumanoidRootPart.CFrame = p1
        end)
    end)
end

function collectfruit(fruit)
    local args = {
        [1] = {
            [1] = {
                [1] = "\4",
                [2] = "EatFruit",
                [3] = fruit,
                [4] = "Storage"
            }
        }
    }

    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))
end



function notif(title, message, dur)
    task.spawn(function()
        game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = dur
        })
    end)
end

function webhook(message)
    task.spawn(function()
        request({
            Url = getgenv().webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game.HttpService:JSONEncode({
                content = message
           })
        })
    end)
end

for i, v in pairs(workspace:GetChildren()) do
    if not table.find(getgenv().skipfruit, v.Name) then
            if v:IsA('Tool') then
            notif('Fruit Found', v.Name, 2)
            webhook(client.Name .. ' Found a ' .. v.Name)
            repeat wait()
            firetouchinterest(client.Character.HumanoidRootPart, v.Handle, 0)
            firetouchinterest(client.Character.HumanoidRootPart, v.Handle, 1)
            until client.Character:FindFirstChild(v.Name)
            client.Character:WaitForChild(v.Name)
            collectfruit(client.Character[v.Name])
            wait(0.1)
        elseif v:IsA('Model') then
            if v:FindFirstChild('Eat') then
                notif('Natural Fruit Found', v.Name, 2)
                webhook(client.Name .. ' Found a ' .. v.Name)
                tp(CFrame.new(v.PrimaryPart.Position))
                wait(0.1)
                task.spawn(function()
                    repeat task.wait()
                        pcall(function()
                            fireproximityprompt(v.Eat)
                        end)
                    until not v:IsDescendantOf(workspace)
                end)

                task.spawn(function()
                repeat task.wait()
                    pcall(function()
                        tp(CFrame.new(v.PrimaryPart.Position))
                    end)
                until not v:IsDescendantOf(workspace)
                end)

                repeat wait() until not v:IsDescendantOf(workspace)
                client.Character.Humanoid:EquipTool(client.Backpack[v.Name])
                collectfruit(client.Character[v.Name])
                wait(0.1)
            end
        end
    end
end
wait(1)



Teleport()
