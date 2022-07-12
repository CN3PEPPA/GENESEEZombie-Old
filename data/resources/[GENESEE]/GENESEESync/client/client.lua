local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

sync = {}
Tunnel.bindInterface("GENESEESync", sync)
Proxy.addInterface("GENESEESync", sync)

RegisterNetEvent("GENESEESync:area")
AddEventHandler("GENESEESync:area", function(x, y, z)
    ClearAreaOfVehicles(x, y, z, 2000.0, false, false, false, false, false)
    ClearAreaOfEverything(x, y, z, 2000.0, false, false, false, false)
end)

RegisterNetEvent("GENESEESync:areasmall")
AddEventHandler("GENESEESync:areasmall", function(x, y, z)
    ClearAreaOfVehicles(x, y, z, 15.0, false, false, false, false, false)
    ClearAreaOfEverything(x, y, z, 15.0, false, false, false, false)
end)

RegisterNetEvent("GENESEESync:clean")
AddEventHandler("GENESEESync:clean", function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToVeh(index)
        if DoesEntityExist(v) then
            if IsEntityAVehicle(v) then
                SetVehicleDirtLevel(v, 0.0)
                SetVehicleUndriveable(v, false)
                tvRP.deleteObject()
            end
        end
    end
end)

RegisterNetEvent('GENESEESync:repair')
AddEventHandler('GENESEESync:repair', function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToVeh(index)
        local fuel = GetVehicleFuelLevel(v)
        if DoesEntityExist(v) then
            if IsEntityAVehicle(v) then
                SetVehicleFixed(v)
                -- SetVehicleDirtLevel(v,0.0)
                SetVehicleUndriveable(v, false)
                Citizen.InvokeNative(0xAD738C3085FE7E11, v, true, true)
                SetVehicleOnGroundProperly(v)
                SetVehicleFuelLevel(v, fuel)
            end
        end
    end
end)

RegisterNetEvent("GENESEESync:deleteobj")
AddEventHandler("GENESEESync:deleteobj", function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToPed(index)
        if DoesEntityExist(v) and IsEntityAnObject(v) then
            Citizen.InvokeNative(0xAD738C3085FE7E11, v, true, true)
            SetEntityAsMissionEntity(v, true, true)
            NetworkRequestControlOfEntity(v)
            Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(v))
            DeleteEntity(v)
            DeleteObject(v)
            SetObjectAsNoLongerNeeded(v)
        end
    end
end)

RegisterNetEvent("GENESEESync:deleteped")
AddEventHandler("GENESEESync:deleteped", function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToPed(index)
        if DoesEntityExist(v) then
            Citizen.InvokeNative(0xAD738C3085FE7E11, v, true, true)
            SetPedAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
            DeletePed(v)
        end
    end
end)

RegisterNetEvent("GENESEESync:deleteveh")
AddEventHandler("GENESEESync:deleteveh", function(vehicle)
    if NetworkDoesNetworkIdExist(vehicle) then
        local v = NetToVeh(vehicle)
        if DoesEntityExist(v) and IsEntityAVehicle(v) then
            Citizen.InvokeNative(0xAD738C3085FE7E11, v, true, true)
            SetEntityAsMissionEntity(v, true, true)
            SetVehicleHasBeenOwnedByPlayer(v, true)
            NetworkRequestControlOfEntity(v)
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v))
            DeleteEntity(v)
            DeleteVehicle(v)
            SetEntityAsNoLongerNeeded(v)
        end
    end
end)

RegisterNetEvent("GENESEESync:doors")
AddEventHandler("GENESEESync:doors", function(veh, doors)
    SetVehicleDoorsLocked(veh, doors)
end)
