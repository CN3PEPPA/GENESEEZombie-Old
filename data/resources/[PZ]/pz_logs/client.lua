local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent('pz_logs:create')
AddEventHandler("pz_logs:create", function(message)
    TriggeServerEvent('pz_logs:create', message)
end)

RegisterNetEvent('pz_logs:get')
AddEventHandler("pz_logs:get", function(user_id)
    vRP.execute("vRP/select_log", {
        user_id = user_id
    })
end)
