local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

fuel = {}
Tunnel.bindInterface("vrp_legacyfuel", fuel)

RegisterCommand("admfuel", function(source, args)
    TriggerClientEvent("admfuel", source)
end)

function fuel.getFuelAmmount()
    local source = source
    local user_id = vRP.getUserId(source)
    local fuel = vRP.getInventoryItemAmount(user_id, 'gasolina')
    return fuel
end

RegisterServerEvent("vrp_legacyfuel:removeFuel")
AddEventHandler("vrp_legacyfuel:removeFuel", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.tryGetInventoryItem(user_id, "gasolina", amount)
end)