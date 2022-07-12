local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRP.prepare("vRP/create_log", "INSERT INTO logs (user_id, message, x, y, z) VALUES (@user_id, @message, @x, @y, @z)")
vRP.prepare("vRP/select_log", "SELECT * FROM logs WHERE user_id = @user_id")

RegisterServerEvent('pz_logs:create')
AddEventHandler("pz_logs:create", function(message)
    local user_id = vRP.getUserId(source)

    local playerCoords = GetEntityCoords(GetPlayerPed(source))

    vRP.execute("vRP/create_log", {
        user_id = user_id,
        message = message,
        coords = playerCoords.x .. "," .. playerCoords.y .. "," .. playerCoords.z
    })
end)

RegisterServerEvent('pz_logs:get')
AddEventHandler("pz_logs:get", function(user_id)
    vRP.execute("vRP/select_log", {
        user_id = user_id
    })
end)
