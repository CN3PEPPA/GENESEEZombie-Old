local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

dormir = {}
Tunnel.bindInterface("pz_dormir", dormir)
Proxy.addInterface("pz_dormir", dormir)

RegisterServerEvent("pz_dormir:animation")
AddEventHandler("pz_dormir:animation", function()
    local source = source
    local user_id = vRP.getUserId(source)

    vRP._playAnim(source, false, {{"timetable@tracy@sleep@", "idle_c"}}, true)
end)

RegisterServerEvent("pz_dormir:stopAnimation")
AddEventHandler("pz_dormir:stopAnimation", function()
    local source = source
    local user_id = vRP.getUserId(source)

    vRP.setSleep(user_id, -100)

    Wait(3000)

    vRP._stopAnim(source, false)
end)
