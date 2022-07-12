local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

chest = {}
Tunnel.bindInterface("vrp_chest", chest)
Proxy.addInterface("vrp_chest", chest)

chestSV = Tunnel.getInterface("vrp_chest")

local chestOpen = ""

RegisterNUICallback("chestClose", function(data)
    TransitionFromBlurred(1000)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hideMenu"
    })
end)

RegisterNUICallback("takeItem", function(data)
    chestSV.takeItem(tostring(chestOpen), data.item, data.amount)
end)

RegisterNUICallback("storeItem", function(data)
    chestSV.storeItem(tostring(chestOpen), data.item, data.amount)
end)

RegisterNetEvent("Chest:updateChest")
AddEventHandler("Chest:updateChest", function(action)
    SendNUIMessage({
        action = action
    })
end)

RegisterNUICallback("requestChest", function(data, cb)
    local imageService = config.imageService
    local inventory, chest, weight, maxweight, weightchest, maxweightchest, slots, slotschest = chestSV.openChest(
        tostring(chestOpen))
    if inventory then
        cb({
            inventory = inventory,
            chest = chest,
            weight = weight,
            maxweight = maxweight,
            weightchest = weightchest,
            maxweightchest = maxweightchest,
            slots = slots,
            slotschest = slotschest,
            imageService = imageService
        })
    end
end)

RegisterNetEvent("vrp_chest:use")
AddEventHandler("vrp_chest:use", function(user_id)
    local nuser_id = vRP.getNearestPlayer(5)
    if not nuser_id then
        TransitionToBlurred(1000)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showMenu"
        })
        chestOpen = tostring(user_id)
    else
        TriggerEvent('Notify', 'negado', 'Não pode abrir o bau com jogadores próximos a você')
    end
end)
