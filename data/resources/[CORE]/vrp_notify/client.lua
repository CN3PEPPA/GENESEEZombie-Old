RegisterNetEvent("Notify")
AddEventHandler("Notify", function(type, string)
    SendNUIMessage({
        NotifyString = string,
        NotifyType = type
    })
end)