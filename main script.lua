repeat wait() until game:IsLoaded()
-- local vars
local client = game.Players.LocalPlayer
local savedpos
local THEremote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
local tpservice = game:GetService("TeleportService")

-- local weapons

local melee
local fruit
local gun
local sword
local defence

-- local tables

local skills = {}
local weaponsforskill = {}

-- toggles

local tpautofarm = false
local levelfarm = false
local combatfarm = false
local swordfarm = false
local fruitfarm = false
local defencefarm = false
local gunfarm = false
local autobuso = false
local autoken = false
local autohao = false
local autoskill = false
local tpsavedpos = false

-- local args for remotes

local meleeargs = {
    [1] = {
        [1] = {
            [1] = "\4",
            [2] = "Combat",
            [3] = 1,
            [4] = false,
            [5] = nil,
            [6] = nil
        },
        [2] = {
            [1] = "\t",
            [2] = nil,
            [3] = nil
        }
    }
}

local gunargs = {
    [1] = {
        [1] = {
            [1] = "\4",
            [2] = "GunCombat",
            [3] = {
                [1] = nil,
                [2] = Vector3.new(nil)
            },
            [4] = false,
            [5] = nil,
            [6] = "Gun"
        }
    }
}

local defenceargs = {
    [1] = {
        [1] = {
            [1] = "\4",
            [2] = "Defence",
            [3] = nil,
            [4] = "Defence"
        }
    }
}

local skillarg1 = {
    [1] = {
        [1] = {
            [1] = "\4",
            [2] = "skillsControl",
            [3] = nil,
            [4] = nil,
            [5] = "Hold",
            [6] = nil
        }
    }
}

local skillarg2 = {
    [1] = {
        [1] = {
            [1] = "\4",
            [2] = "skillsControl",
            [3] = nil,
            [4] = nil,
            [5] = "Release",
            [6] = nil
        }
    }
}

local questarg = {
    [1] = {
        [1] = {
            [1] = "\3",
            [2] = "GetQuest",
            [3] = nil
        }
    }
}

-- JOIN


pcall(function()
    repeat wait() until client.PlayerGui.LoadingGui.Frame.Indicator.Text == 'LOADING COMPLETE'
    wait(1.5)
    for i, v in pairs(getgc()) do
        if getinfo(v).name == 'Play' then
            v()
        end
    end
end)

client.CharacterAdded:Connect(function()
    task.spawn(function()
        task.wait(1.5)
        client.Character.Humanoid:UnequipTools()
    end)
end)

local level = client.leaderstats.Level.Value
local questfile = workspace.__GAME.__Quests

-- VITAL FUNCTIONS

function updtools()
for i, v in pairs(client.Character:GetChildren()) do
    if v.ClassName == 'Tool' then
        for a, b in pairs(v:GetAttributes()) do
            if b == 'Melee' then
                melee = v
            elseif b == 'Fruit' then
                fruit = v
            elseif b == 'Gun' then
                gun = v
            elseif b == 'Sword' then
                sword = v
            elseif b == 'Defence' then
                defence = v
            end
        end
    end
end

for i, v in pairs(client.Backpack:GetChildren()) do
    if v.ClassName == 'Tool' then
        for a, b in pairs(v:GetAttributes()) do
            if b == 'Melee' then
                melee = v
            elseif b == 'Fruit' then
                fruit = v
            elseif b == 'Gun' then
                gun = v
            elseif b == 'Sword' then
                sword = v
            elseif b == 'Defence' then
                defence = v
            end
        end
    end
end
end

updtools()

function checkdistance(obj)
    local dist
        pcall(function()
        dist = (obj.Position - client.Character.HumanoidRootPart.Position).Magnitude
        end)
    return dist
end

function getclosestmob(mobs)
    local closest
    pcall(function()
    for i, v in pairs(mobs) do
        if closest == nil then
            closest = v
        else
            if checkdistance(CFrame.new(v.NpcModel.HumanoidRootPart.Position)) < checkdistance(CFrame.new(closest.NpcModel.HumanoidRootPart.Position)) then
                closest = v
            end
        end
    end
    end)
    return closest
end

function tp(p1)
    pcall(function()
        client.Character.HumanoidRootPart.CFrame = p1
    end)
end

function getisland()
    local island
    for i, v in pairs(workspace.__GAME.__Mobs:GetChildren()) do
        if string.find(v.Name, 'Ilha') then
            island = v
        end
    end
    if island ~= nil then
    return island
    end
end

function getattribute(inst, att)
    for i, v in pairs(inst:GetAttributes()) do
        if i == att then
            return V
        end
    end
end 


function getbestquest()
    local questdude
    if level < 10 then
        questdude = questfile.Quest01
    elseif level < 20 then
        questdude = questfile.Quest02
    elseif level < 35 then
        questdude = questfile.Quest03
    elseif level < 50 then
        questdude = questfile.Quest04
    elseif level < 60 then
        questdude = questfile.Quest05
    elseif level < 75 then
        questdude = questfile.Quest06
    elseif level < 90 then
        questdude = questfile.Quest07
    elseif level < 100 then
        questdude = questfile.Quest08
    elseif level < 120 then
        questdude = questfile.Quest09
    elseif level < 135 then
        questdude = questfile.Quest10
    elseif level < 150 then
        questdude = questfile.Quest11
    elseif level < 170 then
        questdude = questfile.Quest12
    elseif level < 185 then
        questdude = questfile.Quest13
    elseif level < 200 then
        questdude = questfile.Quest14
    elseif level < 215 then
        questdude = questfile.Quest15
    elseif level < 230 then
        questdude = questfile.Quest16
    elseif level < 250 then
        questdude = questfile.Quest17
    elseif level < 275 then
        questdude = questfile.Quest18
    elseif level < 305 then
        questdude = questfile.Quest19
    elseif level < 330 then
        questdude = questfile.Quest20
    elseif level < 350 then
        questdude = questfile.Quest21
    elseif level < 380 then
        questdude = questfile.Quest22
    elseif level < 400 then
        questdude = questfile.Quest23
    elseif level < 425 then
        questdude = questfile.Quest24
    elseif level < 460 then
        questdude = questfile.Quest25
    elseif level < 490 then
        questdude = questfile.Quest26
    elseif level < 530 then
        questdude = questfile.Quest27
    elseif level < 600 then
        questdude = questfile.Quest28
    elseif level >= 600 then
        questdude = questfile.Quest28
    end
    return questdude
end

function serverhop()
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

-- SCRIPT FUNCTION

function combatfarmf()
    task.spawn(function()
        combatfarm = true
        swordfarm = false
        fruitfarm = false
        updtools()
        local target = getclosestmob(getisland():GetChildren())
        meleeargs[1][1][5] = melee
        meleeargs[1][1][6] = 'Melee'
        meleeargs[1][2][3] = melee
        meleeargs[1][2][2] = target
        repeat task.wait()
            pcall(function()
            updtools()
            local target = getclosestmob(getisland():GetChildren())
            meleeargs[1][1][5] = melee
            meleeargs[1][2][3] = melee
            meleeargs[1][2][2] = target
            melee.Parent = client.Character
            THEremote:FireServer(unpack(meleeargs))
            end)
        until not combatfarm or fruitfarm or swordfarm
        melee.Parent = client.Backpack
    end)
end

function swordfarmf()
    pcall(function()
        task.spawn(function()
            swordfarm = true
            combatfarm = false
            fruitfarm = false
            updtools()
            local target = getclosestmob(getisland():GetChildren())
            meleeargs[1][1][5] = sword
            meleeargs[1][1][6] = 'Sword'
            meleeargs[1][2][3] = sword
            meleeargs[1][2][2] = target
            repeat task.wait()
                pcall(function()
                updtools()
                local target = getclosestmob(getisland():GetChildren())
                meleeargs[1][1][5] = sword
                meleeargs[1][2][3] = sword
                meleeargs[1][2][2] = target
                sword.Parent = client.Character
                THEremote:FireServer(unpack(meleeargs))
                end)
            until combatfarm or fruitfarm or not swordfarm
            sword.Parent = client.Backpack
        end)
    end)
end

function fruitfarmf()
    pcall(function()
        task.spawn(function()
            fruitfarm = true
            combatfarm = false
            swordfarm = false
            updtools()
            local target = getclosestmob(getisland():GetChildren())
            meleeargs[1][1][5] = fruit
            meleeargs[1][1][6] = 'Fruit'
            meleeargs[1][2][3] = fruit
            meleeargs[1][2][2] = target
            repeat task.wait()
                pcall(function()
                updtools()
                local target = getclosestmob(getisland():GetChildren())
                meleeargs[1][1][5] = fruit
                meleeargs[1][2][3] = fruit
                meleeargs[1][2][2] = target
                fruit.Parent = client.Character
                THEremote:FireServer(unpack(meleeargs))
                end)
            until combatfarm or not fruitfarm or swordfarm
            fruit.Parent = client.Backpack
        end)
    end)
end

function defencefarmf()
    task.spawn(function()
        defencefarm = true
        defenceargs[1][1][3] = defence
        repeat task.wait()
            defenceargs[1][1][3] = defence
            defence.Parent = client.Character
            THEremote:FireServer(unpack(defenceargs))
        until not defencefarm
        defence.Parent = client.Backpack
    end)
end


function gunfarmf()
    task.spawn(function()
        gunfarm = true
        updtools()
        gunargs[1][1][5] = gun
        repeat task.wait()
            pcall(function()
                updtools()
                gunargs[1][1][5] = gun
                gun.Parent = client.Character
                local target = getclosestmob(getisland():GetChildren())
                gunargs[1][1][3][1] = target.NpcModel.HumanoidRootPart.Position
                repeat task.wait()
                    updtools()
                    gunargs[1][1][5] = gun
                    gun.Parent = client.Character
                    local target = getclosestmob(getisland():GetChildren())
                    gunargs[1][1][3][1] = target.NpcModel.HumanoidRootPart.Position
                    THEremote:FireServer(unpack(gunargs))

                until not gunfarm or not target:IsDescendantOf(workspace)
            end)
        until not gunfarm
        gun.Parent = client.Backpack
    end)
end


function autobusof()
    task.spawn(function()
        autobuso = true
        repeat task.wait()
            if not client.Character:GetAttribute('Buso') then
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "\4",
                            [2] = "BusoHaki"
                        }
                    }
                }
                THEremote:FireServer(unpack(args))                
            end
        until not autobuso
    end)
end

function autokenf()
    task.spawn(function()
        autoken = true
        repeat task.wait()
            if not client.Character:GetAttribute('Ken') then
                local args = {
                    [1] = {
                        [1] = {
                            [1] = "\4",
                            [2] = "KenHaki",
                            [3] = "null",
                            [4] = true
                        }
                    }
                } 
                THEremote:FireServer(unpack(args))                
            end
        until not autoken
    end)
end

function autohaof()
    autohao = true
    task.spawn(function()
        repeat task.wait()
            local haoarg = {
                [1] = {
                    [1] = {
                        [1] = "\4",
                        [2] = "HaoHaki",
                        [3] = "null",
                        [4] = false
                    }
                }
            }     
            THEremote:FireServer(unpack(haoarg))
        until not autohao
    end)
end

function autoskillf()
    task.spawn(function()
        autoskill = true
        repeat task.wait()
            updtools()
            for a, weapon in pairs(weaponsforskill) do
                pcall(function()
                    skillarg1[1][1][3] = weapon
                    skillarg2[1][1][3] = weapon
                    local target = getclosestmob(getisland():GetChildren())
                    skillarg1[1][1][6] = target.NpcModel.HumanoidRootPart.Position
                    skillarg2[1][1][6] = target.NpcModel.HumanoidRootPart.Position
                    pcall(function()
                    client.Backpack:FindFirstChild(weapon).Parent = client.Character
                    end)
                    for b, skill in pairs(skills) do
                        skillarg1[1][1][4] = skill
                        skillarg2[1][1][4] = skill
                        THEremote:FireServer(unpack(skillarg1))
                        THEremote:FireServer(unpack(skillarg2))
                    end
                end)
            end
            task.wait(2)
        until not autoskill
        client.Character.Humanoid:UnequipTools()
    end)
end

function tpautofarmf()
    pcall(function()
        task.spawn(function()
            tpautofarm = true
            levelfarm = false
            repeat task.wait()
                repeat task.wait()
                    local target = getclosestmob(getisland():GetChildren())
                    tp(target.NpcModel.HumanoidRootPart.CFrame*CFrame.new(0, 25, 0))
                until not target:IsDescendantOf(workspace) or not tpautofarm or levelfarm
            until not tpautofarm or levelfarm
        end)
    end)
end

--[[function levelfarmf()
    task.spawn(function()
        levelfarm = true
        tpautofarm = false
        repeat task.wait()
            local quest = getbestquest()
            tp(quest.HumanoidRootPart.CFrame)
            questarg[1][1][3] = quest:GetAttribute('QuestID')
            task.wait(0.1)
            THEremote:FireServer(unpack(questarg))
            repeat task.wait()
                local target
                for i, v in pairs(getisland():GetChildren()) do
                    if getattribute(v.NpcConfiguration, 'QuestId') == getattribute(quest, 'QuestID') then
                        print(v)
                    end
                end
                repeat task.wait()
                    tp(target.NpcModel.HumanoidRootPart.CFrame*CFrame.new(0, 25, 0))
                until target.NpcConfiguration:GetAttribute('Health') == 0 or not target:IsDescendantOf(workspace) or not levelfarm or tpautofarm
            until client.PlayerGui.Quests.CurrentQuestContainer.QuestAmount.Text == '1/1' or '2/2' or '3/3' or '4/4' or '5/5' or '6/6' or '7/7' or '8/8' or not levelfarm or levelfarm or getbestquest() ~= quest
        until not levelfarm or levelfarm
    end)
end
]]--

function tpsavedposf()
    tpsavedpos = true
    task.spawn(function()
        repeat task.wait()
            pcall(function()
                tp(savedpos)
            end)
        until not tpsavedpos
    end)
end

-- ui lib

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NatsuDevs/Linoria-Rewrite-Modded-/main/Lib.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'one fruit simulator',
    Center = true, 
    AutoShow = true, 
})

local Tabs = {
    ['Farm'] = Window:AddTab('Farm'), 
    ['Teleport'] = Window:AddTab('Teleport'),
    ['Misc'] = Window:AddTab('Misc')
}

local uileftgb = Tabs['Misc']:AddLeftGroupbox('Misc')
uileftgb:AddButton('Rejoin', function() tpservice:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end)
uileftgb:AddButton('Unload Script', function() Library:Unload() end)
uileftgb:AddButton('ServerHop (Lowest)', function() serverhop() end)

-- FARMING TAB

local farming = Tabs['Farm']:AddLeftGroupbox('auto farm') 

local meleeselector = farming:AddDropdown('melee mode', {
    Values = { 'None','fighting style', 'sword', 'fruit'},
    Default = 1,
    Multi = false,

    Text = 'Choose m1 mode',
    Tooltip = nil, 
})

local defencetoggle = farming:AddToggle('auto defence', {
    Text = 'autofarm defence', 
    Default = false, 
    Tooltip = nil,
})

local guntoggle = farming:AddToggle('auto gun', {
    Text = 'autofarm using gun', 
    Default = false, 
    Tooltip = 'kill nearst mob with gun',
})

local tpfarm = farming:AddToggle('tp farm', {
    Text = 'tp farm', 
    Default = false, 
    Tooltip = 'tp above nearest ennemy',
})

--[[local levelfarmtog = farming:AddToggle('levelfarm', {
    Text = 'auto quest + kill mobs', 
    Default = false, 
    Tooltip = 'use in combination with any farm method above',
})
]]--
local autobusohaki = farming:AddToggle('auto buso', {
    Text = 'auto activate buso haki', 
    Default = false, 
    Tooltip = nil,
})

local autokenhaki = farming:AddToggle('auto ken', {
    Text = 'auto activate ken haki', 
    Default = false, 
    Tooltip = nil,
})

local autohaotog = farming:AddToggle('auto hao', {
    Text = 'auto activate hao haki', 
    Default = false, 
    Tooltip = nil,
})

local weaponselector = farming:AddDropdown('weapon selector', {
    Values = {'fighting style', 'sword', 'fruit', 'gun'},
    Default = 1,
    Multi = true,

    Text = 'Choose wich weapons',
    Tooltip = 'only choose maximum three at the time or you will get kicked', 
})

local skillselector = farming:AddDropdown('skills selector', {
    Values = {'Z', 'X', 'C', 'V', 'B'},
    Default = 1,
    Multi = true,

    Text = 'Choose wich skills',
    Tooltip = nil, 
})

local autoskilltog = farming:AddToggle('auto skill', {
    Text = 'auto use skills', 
    Default = false, 
    Tooltip = nil,
})

local savepos = farming:AddButton('Save Position', function() savedpos = CFrame.new(client.Character.HumanoidRootPart.Position) end)

local autotpsavedpos = farming:AddToggle('tp saved pos', {
    Text = 'tp to saved position', 
    Default = false, 
    Tooltip = nil,
})

meleeselector:OnChanged(function()
    if meleeselector.Value == 'fighting style' then
        combatfarmf()
    elseif meleeselector.Value == 'sword' then
        swordfarmf()
    elseif meleeselector.Value == 'fruit' then
        fruitfarmf()
    elseif meleeselector.Value == 'None' then
        combatfarm = false
        swordfarm = false
        fruitfarm = false
    end
end)

defencetoggle:OnChanged(function() 
    if defencetoggle.Value then
        defencefarmf()
    else 
        defencefarm = false
    end
end)

guntoggle:OnChanged(function()
    if guntoggle.Value then
        gunfarmf()
    else 
        gunfarm = false
    end
end)

tpfarm:OnChanged(function()
    if tpfarm.Value then
        tpautofarmf()
    else
        tpautofarm = false
    end
end)

--[[levelfarmtog:OnChanged(function()
    if levelfarmtog.Value then
        levelfarmf()
    else
        levelfarm = false
    end
end)
]]--
autobusohaki:OnChanged(function()
    if autobusohaki.Value then
        autobusof()
    else
        autobuso = false
    end
end)

autokenhaki:OnChanged(function()
    if autokenhaki.Value then
        autokenf()
    else
        autoken = false
    end
end)

autohaotog:OnChanged(function()
    if autohaotog.Value then
        autohaof()
    else
        autohao = false
    end
end)
weaponselector:OnChanged(function()
    weaponsforskill = {}
    for i, v in pairs(weaponselector.Value) do
        if i == 'fighting style' then
            table.insert(weaponsforskill, 1, melee.Name)
        elseif i == 'sword' then
            table.insert(weaponsforskill, 1, sword.Name)
        elseif i == 'fruit' then
            table.insert(weaponsforskill, 1, fruit.Name)
        elseif i == 'gun' then
            table.insert(weaponsforskill, 1, gun.Name)
        end
    end
end)

skillselector:OnChanged(function()
    skills = {}
    for i, v in pairs(skillselector.Value) do
        table.insert(skills, 1, i)
    end
end)

autoskilltog:OnChanged(function()
    if autoskilltog.Value then
        autoskillf()
    else
        autoskill = false
    end
end)

autotpsavedpos:OnChanged(function()
    if autotpsavedpos.Value then
        tpsavedposf()
    else
        tpsavedpos = false
    end
end)

-- TELEPORT TAB

local teleportgb = Tabs['Teleport']:AddLeftGroupbox('Teleport')
for i, v in pairs(workspace.__GAME.__SpawnLocations:GetChildren()) do
    teleportgb:AddButton(v:GetAttribute('IslandName'), function() tp(CFrame.new(v.Position)) end)
end
