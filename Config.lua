Config = {}

Config.MinimapJustInCar = true



-- This is for thirst and hunger of ESX.

Config.StatusUpdateInterval = 3000 -- Time it takes for status to update (lowering this value adds ms)

function GetStatus(cb)

    TriggerEvent("esx_status:getStatus", "hunger", function(h)
        TriggerEvent("esx_status:getStatus", "thirst", function(t)
            local hunger = h.getPercent()
            local thirst = t.getPercent()
            local stress = 10  -- u can trigger your stress.
            cb({hunger, thirst, stress})
        end)
    end)

end