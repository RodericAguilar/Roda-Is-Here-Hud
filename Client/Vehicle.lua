
Citizen.CreateThread(function ()
    while true do 
        ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            _sleep = 200
            local vehiculo = GetVehiclePedIsUsing(ped)
            local velo = (GetEntitySpeed(vehiculo)* 3.6)
            local gaso = GetVehicleFuelLevel(vehiculo)
            local carhealth = GetVehicleBodyHealth(vehiculo)/10
            if Config.MinimapJustInCar then 
                DisplayRadar(true)
            end
            SendNUIMessage({
                action = 'showCarhud';
                vel = velo; 
                gasolina = gaso;
                carhealth = carhealth;
                map = true
            })
        else
            if Config.MinimapJustInCar then 
                DisplayRadar(false)
                _sleep = 1000
                SendNUIMessage({
                    action = 'hideCarhud';
                    map = false
                })
            else
                _sleep = 1000
                SendNUIMessage({
                    action = 'hideCarhud'
                })
            end
        end
        Wait(_sleep)
    end
end)

