function NotificationIsHere(type, title, msg, time)
    SendNUIMessage({
        action = 'showNoti',
        type = type,
        title = title,
        msg = msg,
        time = time
    })
end


RegisterNetEvent('Roda_IsHere:Notify')
AddEventHandler('Roda_IsHere:Notify', function (type, title, msg, time)
    NotificationIsHere(type, title, msg, time)
end)
