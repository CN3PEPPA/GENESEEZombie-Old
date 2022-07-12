local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local idle = 1000
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle, 0) == ped and GetVehicleClass(vehicle) == 8 then
                local idle = 250
                DisableControlAction(0, 73, true)
            end
        end
        Wait(idle)
    end
end)
