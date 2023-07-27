repeat wait() until game:IsLoaded()
local client = game.Players.LocalPlayer
local nonfruit = {'SukeFruit', 
                  'BaraFruit',  
                  'KiloFruit',
                  'SpinFruit',
                  'BarrierFruit', 
                  'LoveFruit', 
                  'BomuFruit',
                  'MirrorFruit', 
                  'LightFruit', 
                  'MeraFruit',
                  'SunaFruit',
                  'SmokeFruit', 
                  'YamiFruit'}
pcall(function()
repeat wait() until client.PlayerGui.LoadingGui.Frame.Indicator.Text == 'LOADING COMPLETE'
wait(1.5)
for i, v in pairs(getgc()) do
    if getinfo(v).name == 'Play' then
        v()
    end
end

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

for i, v in pairs(workspace:GetChildren()) do
    if not table.find(nonfruit, v.Name) then
        if v:IsA('Tool') then
            notif('Fruit Found', v.Name, 2)
            repeat wait()
            firetouchinterest(client.Character.HumanoidRootPart, v.Handle)
            until client.Character:FindFirstChild(v.Name)
            client.Character:WaitForChild(v.Name)
            collectfruit(client.Character[v.Name])
            wait(0.1)
        elseif v:IsA('Model') then
            if v:FindFirstChild('Eat') then
                notif('Natural Fruit Found', v.Name, 2)
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

function shop()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"

    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
    end

    local Server, Next; repeat
    local Servers = ListServers(Next)
    Server = Servers.data[1]
    Next = Servers.nextPageCursor
    until Server
    TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)

end

shop()
