local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

CreateThread(function()
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local speed = GetEntitySpeed(vehicle) * 3.6
                if speed >= 40 then
                    SetPlayerCanDoDriveBy(PlayerId(), false)
                else
                    SetPlayerCanDoDriveBy(PlayerId(), true)
                end
            end
        end
    end
end)
