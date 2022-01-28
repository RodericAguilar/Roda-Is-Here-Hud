if GetResourceState('es_extended') == "started" then

local ESX = exports["es_extended"]:getSharedObject()
local ped, health, armor, pid, data, job

AddEventHandler('playerSpawned', function()   
    Citizen.CreateThread(function ()
        while true do 
            if not IsPauseMenuActive() then 
                ped = PlayerPedId()
                health = GetEntityHealth(ped)
                armor = GetPedArmour(ped)
                pid = GetPlayerServerId(PlayerId())
                data = ESX.GetPlayerData()
                job = data.job.label
                money, bank = 0, 0
                for i = 1, #data.accounts do 
                    if data.accounts[i].name == 'money' then 
                        money = data.accounts[i].money
                    elseif data.accounts[i].name == 'bank' then
                        bank = data.accounts[i].money
                    end
                end
                SendNUIMessage({
                    action = 'updateStatus',
                    health = health - 100,
                    armor = armor,
                    pid = pid,
                    hunger = food,
                    thirst = water,
                    stress = stress,
                    money = money,
                    bank = bank,
                    job = job
                })
                
                if IsPedArmed(ped, 7) then
                    local weapon = GetSelectedPedWeapon(ped)
                    local ammoTotal = GetAmmoInPedWeapon(ped,weapon)
                    local bool,ammoClip = GetAmmoInClip(ped,weapon)
                    local ammoRemaining = math.floor(ammoTotal - ammoClip)
                    SendNUIMessage({
                        action = 'updateAmmo',
                        ammo = ammoClip,
                        ammohand = ammoRemaining
                    })
                else
                    SendNUIMessage({
                        action = 'hideAmmo',
                    })
                end
            else
                SendNUIMessage({
                    action = 'hideAllHud',
                })
            end
            Wait(500)
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(Config.StatusUpdateInterval)
            GetStatus(function(data)
                    food = data[1]
                    water = data[2]
                    stress = data[3]
            end)
        end
    end)
    
end)

end