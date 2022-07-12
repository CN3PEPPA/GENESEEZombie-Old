local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = Tunnel.getInterface("vrp_player", src)

RegisterCommand("homem", function(source, args)
    vRP.loadAnimSet("move_m@confident")
end)

RegisterCommand("mulher", function(source, args)
    vRP.loadAnimSet("move_f@heels@c")
end)

RegisterCommand("ferido", function(source, args)
    vRP.loadAnimSet("move_m@injured")
end)

RegisterCommand("depressivo", function(source, args)
    vRP.loadAnimSet("move_m@depressed@a")
end)

RegisterCommand("depressiva", function(source, args)
    vRP.loadAnimSet("move_f@depressed@a")
end)

RegisterCommand("empresario", function(source, args)
    vRP.loadAnimSet("move_m@business@a")
end)

RegisterCommand("bebado", function(source, args)
    vRP.loadAnimSet("move_m@drunk@slightlydrunk")
end)

RegisterCommand("bebado2", function(source, args)
    vRP.loadAnimSet("move_m@drunk@verydrunk")
end)

RegisterCommand("bebado3", function(source, args)
    vRP.loadAnimSet("move_m@drunk@moderatedrunk")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30 * 60000)
        TriggerServerEvent('salario:pagamento')
    end
end)

function GetPlayers()
    local players = {}
    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            players[#players + 1] = i
        end
    end
    return players
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh, -1) then
                TriggerServerEvent("TryDoorsEveryone", veh, 2, GetVehicleNumberPlateText(veh))
            end
        end
    end
end)

RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone", function(veh, doors)
    SetVehicleDoorsLocked(veh, doors)
end)

local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos', function(status)
    energetico = status
    if energetico then
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
    else
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        if energetico then
            idle = 5
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        Citizen.Wait(idle)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        if x == px and y == py then
            if tempo > 0 then
                tempo = tempo - 1
                if tempo == 60 then
                    TriggerEvent("Notify", "importante", "Você vai ser desconectado em <b>60 segundos</b>.", 8000)
                end
            else
                TriggerServerEvent("kickAFK")
            end
        else
            tempo = 1800
        end
        px = x
        py = y
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        DisableControlAction(0, 36, true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0, 36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped, 0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
                    SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
                    agachar = true
                end
            end
        end
    end
end)

-- local carregado = false
-- RegisterCommand("carregar", function(source, args)
--     local ped = PlayerPedId()
--     local randomico, npcs = FindFirstPed()
--     repeat
--         local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(npcs), true)
--         if not IsPedAPlayer(npcs) and distancia <= 3 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npcs) then
--             if carregado then
--                 ClearPedTasksImmediately(carregado)
--                 DetachEntity(carregado, true, true)
--                 TaskWanderStandard(carregado, 10.0, 10)
--                 Citizen.InvokeNative(0xAD738C3085FE7E11, carregado, true, true)
--                 carregado = false
--             else
--                 Citizen.InvokeNative(0xAD738C3085FE7E11, npcs, true, true)
--                 AttachEntityToEntity(npcs, ped, 4103, 11816, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false,
--                     2, true)
--                 carregado = npcs
--                 sucess = true
--             end
--         end
--         sucess, npcs = FindNextPed(randomico)
--     until not sucess
--     EndFindPed(randomico)
-- end)

local sequestrado = nil
RegisterCommand("sequestro2", function(source, args)
    local ped = PlayerPedId()
    local random, npc = FindFirstPed()
    repeat
        local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(npc), true)
        if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
            vehicle = vRP.getNearestVehicle(7)
            if IsEntityAVehicle(vehicle) then
                if vRP.getCarroClass(vehicle) then
                    if sequestrado then
                        AttachEntityToEntity(sequestrado, vehicle, GetEntityBoneIndexByName(vehicle, "bumper_r"), 0.6,
                            -1.2, -0.6, 60.0, -90.0, 180.0, false, false, false, true, 2, true)
                        DetachEntity(sequestrado, true, true)
                        SetEntityVisible(sequestrado, true)
                        SetEntityInvincible(sequestrado, false)
                        Citizen.InvokeNative(0xAD738C3085FE7E11, sequestrado, true, true)
                        ClearPedTasksImmediately(sequestrado)
                        sequestrado = nil
                    elseif not sequestrado then
                        Citizen.InvokeNative(0xAD738C3085FE7E11, npc, true, true)
                        AttachEntityToEntity(npc, vehicle, GetEntityBoneIndexByName(vehicle, "bumper_r"), 0.6, -0.4,
                            -0.1, 60.0, -90.0, 180.0, false, false, false, true, 2, true)
                        SetEntityVisible(npc, false)
                        SetEntityInvincible(npc, false)
                        sequestrado = npc
                        complet = true
                    end
                    TriggerServerEvent("trymala", VehToNet(vehicle))
                end
            end
        end
        complet, npc = FindNextPed(random)
    until not complet
    EndFindPed(random)
end)

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {
            handle = iter,
            destructor = disposeFunc
        }
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
    local vehicles = GetVeh()
    local closestDistance = -1
    local closestVehicle = -1
    local coords = coords

    if coords == nil then
        local ped = PlayerPedId()
        coords = GetEntityCoords(ped)
    end

    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local Vehicle = {
    Coords = nil,
    Vehicle = nil,
    Dimension = nil,
    IsInFront = false,
    Distance = nil
}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local closestVehicle, Distance = GetClosestVeh()
        if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
            Vehicle.Coords = GetEntityCoords(closestVehicle)
            Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
            Vehicle.Vehicle = closestVehicle
            Vehicle.Distance = Distance
            if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle),
                GetEntityCoords(ped), true) >
                GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1,
                    GetEntityCoords(ped), true) then
                Vehicle.IsInFront = false
            else
                Vehicle.IsInFront = true
            end
        else
            Vehicle = {
                Coords = nil,
                Vehicle = nil,
                Dimensions = nil,
                IsInFront = false,
                Distance = nil
            }
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if Vehicle.Vehicle ~= nil then
            local ped = PlayerPedId()
            if IsControlPressed(0, 244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle, -1) and
                not IsEntityInAir(ped) and not IsPedBeingStunned(ped) and
                not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and
                not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
                RequestAnimDict('missfinale_c2ig_11')
                TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                NetworkRequestControlOfEntity(Vehicle.Vehicle)

                if Vehicle.IsInFront then
                    AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0,
                        Vehicle.Dimensions.y * -1 + 0.1, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false,
                        true, false, true)
                else
                    AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3,
                        Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                end

                while true do
                    Citizen.Wait(5)
                    if IsDisabledControlPressed(0, 34) then
                        TaskVehicleTempAction(ped, Vehicle.Vehicle, 11, 100)
                    end

                    if IsDisabledControlPressed(0, 9) then
                        TaskVehicleTempAction(ped, Vehicle.Vehicle, 10, 100)
                    end

                    if Vehicle.IsInFront then
                        SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
                    else
                        SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
                    end

                    if not IsDisabledControlPressed(0, 244) then
                        DetachEntity(ped, false, false)
                        StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                        break
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood", function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToVeh(index)
        local isopen = GetVehicleDoorAngleRatio(v, 4)
        if DoesEntityExist(v) then
            if IsEntityAVehicle(v) then
                if isopen == 0 then
                    SetVehicleDoorOpen(v, 4, 0, 0)
                else
                    SetVehicleDoorShut(v, 4, 0)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("goodboy")
        Wait(30000)
    end
end)
