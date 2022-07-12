local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

genesee = {}
Tunnel.bindInterface("pz_deathscreen", genesee)

RegisterServerEvent("fomesede")
AddEventHandler("fomesede", function()
    local source = source
    local user_id = vRP.getUserId(source)

    vRP.varyThirst(user_id, -100)
    vRP.varyHunger(user_id, -100)
    vRP.varySleep(user_id, -100)
end)

function genesee.getInvPlayer()
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    if user_id then
        local inventario = vRP.getInventory(user_id)
        for k, v in pairs(inventario) do
            TriggerEvent("DropSystem:create", k, v.amount, x, y, z, 120)
        end
    end
end
