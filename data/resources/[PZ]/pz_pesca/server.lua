local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPClient = Tunnel.getInterface("vRP")

pesca = {}
Tunnel.bindInterface("pz_pesca", pesca)

local fishingTimer = 30 -- Tempo em segundos

local fishes = {'tucunare'}

local item = fishes[math.random(1, #fishes)]

function pesca.checkItem()
    local source = source
    local user_id = vRP.getUserId(source)

    local fishingRod = vRP.getInventoryItemAmount(user_id, "vara_pesca")

    if fishingRod >= 1 then
        return true
    end
end

function pesca.checkBait()
    local source = source
    local user_id = vRP.getUserId(source)

    local bait = vRP.getInventoryItemAmount(user_id, "isca")

    if bait >= 1 then
        return true
    end
end

RegisterServerEvent("fishing")
AddEventHandler("fishing", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local ped = GetPlayerPed(source)

    vRPClient._loadObject(source, "amb@world_human_stand_fishing@idle_a", "idle_c", "prop_fishing_rod_01", 49, 60309)
    FreezeEntityPosition(ped, true)

    TriggerClientEvent("progress", source, fishingTimer * 1000, "PESCANDO")
    SetTimeout(fishingTimer * 1000, function()
        vRPClient._stopAnim(source, false)
        vRPClient._deleteObject(source)
        vRP.tryGetInventoryItem(user_id, "isca", 1)
        vRP.giveInventoryItem(user_id, item, 1)
        TriggerClientEvent("Notify", source, "sucesso", "Você pescou <b>" .. item .. "</b>")
        FreezeEntityPosition(ped, false)
    end)
end)
