local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

CreateThread(function()
    while true do
        Wait(1)
        local ped = PlayerPedId()
        local shot = IsPedShooting(ped)
        if shot == 1 and IsPedInAnyVehicle(ped) then
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
        end
    end
end)
