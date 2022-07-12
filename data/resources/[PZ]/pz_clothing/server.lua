-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("pz_clothingSelect", cnVRP)
vCLIENT = Tunnel.getInterface("pz_clothingSelect")

RegisterServerEvent("deleteInventoryItem")
AddEventHandler("deleteInventoryItem", function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.tryGetInventoryItem(user_id, item, 1)
end)
