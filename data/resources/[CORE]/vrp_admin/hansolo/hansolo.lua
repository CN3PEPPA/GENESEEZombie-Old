local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

admin = {}
Tunnel.bindInterface("vrp_admin", admin)
Proxy.addInterface("vrp_admin", admin)

adminSV = Tunnel.getInterface("vrp_admin")

RegisterNetEvent("vrp_admin:skin")
AddEventHandler("vrp_admin:skin", function(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(), mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end)

RegisterNetEvent("spawnarveiculo")
AddEventHandler("spawnarveiculo", function(vehicle)
    local mhash = GetHashKey(vehicle)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        local ped = PlayerPedId()
        local nveh = CreateVehicle(mhash, GetEntityCoords(ped), GetEntityHeading(ped), true, false)

        NetworkRegisterEntityAsNetworked(nveh)
        while not NetworkGetEntityIsNetworked(nveh) do
            NetworkRegisterEntityAsNetworked(nveh)
            Citizen.Wait(1)
        end

        SetVehicleOnGroundProperly(nveh)
        SetVehicleAsNoLongerNeeded(nveh)
        SetVehicleIsStolen(nveh, false)
        SetPedIntoVehicle(ped, nveh, -1)
        SetVehicleNeedsToBeHotwired(nveh, false)
        SetEntityInvincible(nveh, false)
        SetVehicleNumberPlateText(nveh, vRP.getRegistrationNumber())
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
        SetVehicleHasBeenOwnedByPlayer(nveh, true)
        SetVehRadioStation(nveh, "OFF")

        SetModelAsNoLongerNeeded(mhash)
    end
end)

RegisterNetEvent('vrp_admin:spawnvh')
AddEventHandler('vrp_admin:spawnvh', function(name)
    local mhash = GetHashKey(name)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        local ped = PlayerPedId()
        local nveh = CreateVehicle(mhash, GetEntityCoords(ped), GetEntityHeading(ped), true, false)

        NetworkRegisterEntityAsNetworked(nveh)
        while not NetworkGetEntityIsNetworked(nveh) do
            NetworkRegisterEntityAsNetworked(nveh)
            Citizen.Wait(1)
        end

        SetVehicleOnGroundProperly(nveh)
        SetVehicleAsNoLongerNeeded(nveh)
        SetVehicleIsStolen(nveh, false)
        SetPedIntoVehicle(ped, nveh, -1)
        SetVehicleNeedsToBeHotwired(nveh, false)
        SetEntityInvincible(nveh, false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
        SetVehicleHasBeenOwnedByPlayer(nveh, true)
        SetVehRadioStation(nveh, "OFF")

        SetModelAsNoLongerNeeded(mhash)
        TriggerEvent('persistent-vehicles/register-vehicle', nveh)
    end
end)

RegisterNetEvent('vrp_admin:dv')
AddEventHandler('vrp_admin:dv', function(vehicle)
    if IsEntityAVehicle(vehicle) then
        TriggerEvent('persistent-vehicles/delete-vehicle', vehicle)
        TriggerServerEvent("GENESEESync:trydeleteveh", VehToNet(vehicle))
    end
end)

RegisterNetEvent('vrp_admin:tptoway')
AddEventHandler('vrp_admin:tptoway', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if IsPedInAnyVehicle(ped) then
        ped = veh
    end

    local waypointBlip = GetFirstBlipInfoId(8)
    local x, y, z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector()))

    local ground
    local groundFound = false
    local groundCheckHeights = {0.0, 50.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0, 450.0, 500.0, 550.0, 600.0,
                                650.0, 700.0, 750.0, 800.0, 850.0, 900.0, 950.0, 1000.0, 1050.0, 1100.0}

    for i, height in ipairs(groundCheckHeights) do
        SetEntityCoordsNoOffset(ped, x, y, height, 0, 0, 1)

        RequestCollisionAtCoord(x, y, z)
        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x, y, z)
            Citizen.Wait(1)
        end
        Citizen.Wait(20)

        ground, z = GetGroundZFor_3dCoord(x, y, height)
        if ground then
            z = z + 1.0
            groundFound = true
            break
        end
    end

    if not groundFound then
        z = 1200
        GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0)
    end

    RequestCollisionAtCoord(x, y, z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x, y, z)
        Citizen.Wait(1)
    end

    SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
end)

RegisterNetEvent("vrp_admin:tuning")
AddEventHandler("vrp_admin:tuning", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        ToggleVehicleMod(vehicle, 17, true)
        ToggleVehicleMod(vehicle, 18, true)
        ToggleVehicleMod(vehicle, 19, true)
        ToggleVehicleMod(vehicle, 20, true)
        ToggleVehicleMod(vehicle, 21, true)
        ToggleVehicleMod(vehicle, 22, true)
        SetVehicleMod(vehicle, 24, 1, false)
        SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) - 1, false)
        SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) - 1, false)
        SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) - 1, false)
        SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) - 1, false)
        SetVehicleMod(vehicle, 33, GetNumVehicleMods(vehicle, 33) - 1, false)
        SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle, 34) - 1, false)
        SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle, 35) - 1, false)
        SetVehicleMod(vehicle, 38, GetNumVehicleMods(vehicle, 38) - 1, true)
        SetVehicleWindowTint(vehicle, 1)
        SetVehicleTyresCanBurst(vehicle, false)
        SetVehicleNumberPlateTextIndex(vehicle, 5)
    end
end)

RegisterNetEvent('vrp_admin:fix')
AddEventHandler('vrp_admin:fix', function()
    local vehicle = vRP.getNearestVehicle(3)
    if IsEntityAVehicle(vehicle) then
        TriggerServerEvent("GENESEESync:tryrepair", VehToNet(vehicle))
    end
end)

RegisterCommand("+targetstatus", function()
    local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 2.0, 0.0)
    local hash = GetHashKey('a_f_m_beach_01')
    local hash2 = GetHashKey('a_m_y_hipster_01')
    local hash3 = GetHashKey('a_f_m_bevhills_02')
    local hash4 = GetHashKey('a_m_y_genstreet_01')
    local hash5 = GetHashKey('a_f_m_business_02')
    local hash6 = GetHashKey('a_m_m_salton_01')
    local hash7 = GetHashKey('a_f_m_eastsa_01')
    local hash8 = GetHashKey('a_m_y_musclbeac_01')
    local hash9 = GetHashKey('a_f_m_fatbla_01')
    local hash10 = GetHashKey('a_m_y_gencaspat_01')
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    RequestModel(hash2)
    while not HasModelLoaded(hash2) do
        Citizen.Wait(0)
    end
    RequestModel(hash3)
    while not HasModelLoaded(hash3) do
        Citizen.Wait(0)
    end
    RequestModel(hash4)
    while not HasModelLoaded(hash4) do
        Citizen.Wait(0)
    end
    RequestModel(hash5)
    while not HasModelLoaded(hash5) do
        Citizen.Wait(0)
    end
    RequestModel(hash6)
    while not HasModelLoaded(hash6) do
        Citizen.Wait(0)
    end
    RequestModel(hash7)
    while not HasModelLoaded(hash7) do
        Citizen.Wait(0)
    end
    RequestModel(hash8)
    while not HasModelLoaded(hash8) do
        Citizen.Wait(0)
    end
    RequestModel(hash9)
    while not HasModelLoaded(hash9) do
        Citizen.Wait(0)
    end
    RequestModel(hash10)
    while not HasModelLoaded(hash10) do
        Citizen.Wait(0)
    end
    ped = CreatePed(28, hash, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash2, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash3, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash4, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash5, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash6, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash7, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash8, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash9, pos.x, pos.y, pos.z, 0.0, true, true)
    ped = CreatePed(28, hash10, pos.x, pos.y, pos.z, 0.0, true, true)
end)
