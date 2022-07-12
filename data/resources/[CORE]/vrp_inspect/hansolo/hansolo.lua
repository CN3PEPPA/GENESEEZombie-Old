local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

inspect = {}
Tunnel.bindInterface("vrp_inspect", inspect)
Proxy.addInterface("vrp_inspect", inspect)

inspectSV = Tunnel.getInterface("vrp_inspect")

RegisterNUICallback("chestClose", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hideMenu"
    })
    inspectSV.resetInspect()
end)

RegisterNUICallback("takeItem", function(data)
    inspectSV.takeItem(data.item, data.amount)
end)

RegisterNUICallback("storeItem", function(data)
    inspectSV.storeItem(data.item, data.amount)
end)

RegisterNetEvent("vrp_inspect:updateInspect")
AddEventHandler("vrp_inspect:updateInspect", function(action)
    SendNUIMessage({
        action = action
    })
end)

RegisterNUICallback("requestChest", function(data, cb)
    local imageService = config.imageService
    local inventory, nuinventory, weight, maxweight, nuweight, numaxweight, slots, nuslots = inspectSV.openChest()
    if inventory then
        cb({
            inventory = inventory,
            nuinventory = nuinventory,
            weight = weight,
            maxweight = maxweight,
            nuweight = nuweight,
            numaxweight = numaxweight,
            slots = slots,
            nuslots = nuslots,
            imageService = imageService
        })
    end
end)

function inspect.openInspect()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "showMenu"
    })
end

function inspect.entityHeading()
    return GetEntityHeading(PlayerPedId())
end

function inspect.setEntityHeading(h)
    SetEntityHeading(PlayerPedId(), h)
end

function inspect.inVehicle(source)
    local ped = PlayerPedId(source)
    if IsPedInAnyVehicle(ped) then
        return true
    else
        return false
    end
end

local uCarry = nil
local iCarry = false
local sCarry = false

function inspect.toggleCarry(source)
    uCarry = source
    iCarry = not iCarry

    local ped = PlayerPedId()
    if iCarry and uCarry then
        Citizen.InvokeNative(0x6B9BBD38AB0796DF, PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(uCarry)), 4103,
            11816, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        sCarry = true
    else
        if sCarry then
            DetachEntity(ped, true, false)
            sCarry = false
        end
    end
end
