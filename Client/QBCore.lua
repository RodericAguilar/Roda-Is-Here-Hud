if GetResourceState('qb-core') == "started" then

QBCore = exports["qb-core"]:GetCoreObject()
local isLoggedIn = false
local stress = 0 -- You can trigger it as u want.
-- Events
   
RegisterNetEvent('hud:client:UpdateNeeds') -- Triggered in qb-core
AddEventHandler('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

local ped, health, armor, pid, Player, job
    
    Citizen.CreateThread(function ()
        while true do 
            if isLoggedIn and not IsPauseMenuActive() then 
                ped = PlayerPedId()
                health = GetEntityHealth(ped)
                armor = GetPedArmour(ped)
                pid = GetPlayerServerId(PlayerId())
                Player = QBCore.Functions.GetPlayerData()    
                job = Player.job.label
                SendNUIMessage({
                    action = 'updateStatus',
                    health = health - 100,
                    armor = armor,
                    pid = pid,
                    hunger = hunger,
                    thirst = thirst,
                    stress = stress,
                    money =  Player.money['cash'],
                    bank = Player.money['bank'],
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
    
end