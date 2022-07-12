local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

RegisterCommand('playradio', function(source, args)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        TriggerEvent('InteractSound_SV:PlayOnAll', args[1], 0.400)
    end
end)
