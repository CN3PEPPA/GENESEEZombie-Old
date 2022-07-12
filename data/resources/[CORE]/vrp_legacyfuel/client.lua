local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

fuel = Tunnel.getInterface("vrp_legacyfuel")

local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentFuel2 = 0.0
local currentCost = 0.0

function ManageFuelUsage(vehicle)
    if IsVehicleEngineOn(vehicle) then
        SetVehicleFuelLevel(vehicle,
            GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] *
                (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
        DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
    end
end

Citizen.CreateThread(function()
    DecorRegister(Config.FuelDecor, 1)
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                ManageFuelUsage(vehicle)
            end
        end
    end
end)

AddEventHandler('pz_fuel:AddFuel', function(vehicle)
    local currentFuel = GetVehicleFuelLevel(vehicle)
    
    local oldFuel = DecorGetFloat(vehicle, Config.FuelDecor)
    local fuelQty = fuel.getFuelAmmount()
    local fuelToTake = 100 - oldFuel

    if fuelQty > 0 then
        currentFuel = oldFuel + fuelToTake
        if currentFuel > 100.0 then
            currentFuel = 100.0
        end
        if fuelToTake > 0 then
            TriggerEvent("progress", 30000, "Abastecendo")
            vRP._playAnim(false, {{"mini@repair", "fixing_a_player"}}, true)
            Wait(30000)
            vRP._stopAnim(false)
            SetVehicleFuelLevel(vehicle, currentFuel)
            TriggerServerEvent("vrp_legacyfuel:removeFuel",parseInt(fuelToTake))
            DecorSetFloat(vehicle, Config.FuelDecor, GetVehicleFuelLevel(vehicle))
            TriggerEvent("Notify", "sucesso", "Você abasteceu o carro")
        else
            TriggerEvent("Notify", "negado", "O tanque já está cheio")
        end
    else
        TriggerEvent("Notify", "negado", "Sem combustível suficiente")
    end
end)

RegisterNetEvent("syncfuel")
AddEventHandler("syncfuel", function(index, fuel)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToVeh(index)
        if DoesEntityExist(v) then
            SetVehicleFuelLevel(v, fuel)
            DecorSetFloat(v, Config.FuelDecor, GetVehicleFuelLevel(v))
        end
    end
end)

RegisterNetEvent("admfuel")
AddEventHandler("admfuel", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle then
        currentFuel = 100.0
        SetVehicleFuelLevel(vehicle, currentFuel)
    end
end)

function Round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
