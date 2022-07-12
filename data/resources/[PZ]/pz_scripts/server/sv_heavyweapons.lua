local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPClient = Tunnel.getInterface("vRP")

pz = {}
Tunnel.bindInterface("pz_scripts", pz)

function pz.checkUID()
    local source = source
    local user_id = vRP.getUserId(source)
    return user_id
end

function pz.checkWeapon(weapon)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = vRP.getInventoryItemAmount(user_id, weapon)
    if amount >= 1 then
        return true
    end
end
