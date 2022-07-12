local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

RegisterCommand('imortal', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            TriggerClientEvent("admin:c_godmode", nplayer)
        else
            TriggerClientEvent("admin:c_godmode", source)
        end
    end
end)
