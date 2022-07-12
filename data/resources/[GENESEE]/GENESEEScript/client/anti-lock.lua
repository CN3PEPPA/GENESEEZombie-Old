local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

--  SE ESSA PORRA NAO FUNCIONAR EU KITO

CreateThread(function()
    while true do
        local sleep = 1000
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
            sleep = 5
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh, -1) then
                TriggerServerEvent("GENESEESync:tryDoors", veh, 2, GetVehicleNumberPlateText(veh))
            end
        end
        Wait(sleep)
    end
end)
