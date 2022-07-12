local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Vehicle = Tunnel.getInterface("GENESEEVehicle")

passos = {}
Tunnel.bindInterface("GENESEEVehicle", passos)

local VehicleHandling = {}

RegisterServerEvent("core_vehicle:canInstall")
AddEventHandler("core_vehicle:canInstall", function(partType, part)
    local src = source
    local xPlayer = vRP.getUserId(src)
    if vRP.tryGetInventoryItem(xPlayer, part, 1) then
        TriggerClientEvent("core_vehicle:startInstall", src, partType, part)
    else
        TriggerClientEvent("Notify", src, "negado", Config.Text["not_enough"])
    end
end)

RegisterServerEvent("core_vehicle:returnItems")
AddEventHandler("core_vehicle:returnItems", function(parts)
    local src = source
    local xPlayer = vRP.getUserId(src)
    for k, v in pairs(parts) do
        vRP.giveInventoryItem(xPlayer, k, v)
    end
end)

RegisterServerEvent("core_vehicle:canRepair")
AddEventHandler("core_vehicle:canRepair", function(partType, part)
    local src = source
    local xPlayer = vRP.getUserId(src)

    local repair = {}

    if Config.Engines[part] ~= nil then
        repair = Config.Engines[part].repair
    end
    if Config.Turbos[part] ~= nil then
        repair = Config.Turbos[part].repair
    end
    if Config.Transmissions[part] ~= nil then
        repair = Config.Transmissions[part].repair
    end
    if Config.Suspensions[part] ~= nil then
        repair = Config.Suspensions[part].repair
    end
    if Config.Oils[part] ~= nil then
        repair = Config.Oils[part].repair
    end
    if Config.Tires[part] ~= nil then
        repair = Config.Tires[part].repair
    end
    if Config.Brakes[part] ~= nil then
        repair = Config.Brakes[part].repair
    end
    if Config.Nitros[part] ~= nil then
        repair = Config.Nitros[part].repair
    end
    if Config.SparkPlugs[part] ~= nil then
        repair = Config.SparkPlugs[part].repair
    end

    local avail = true
    for k, v in pairs(repair) do
        if vRP.getInventoryItemAmount(xPlayer, k) < v.amount then
            avail = false
        end
    end

    local returnable = {}

    if avail then
        for k, v in pairs(repair) do
            if not v.reusable then
                vRP.tryGetInventoryItem(xPlayer, k, v.amount)
                returnable[k] = v.amount
            end
        end
        TriggerClientEvent("core_vehicle:startRepair", src, partType, part, returnable)
    else
        TriggerClientEvent("Notify", src, "negado", Config.Text["not_enough"])
    end
end)

RegisterServerEvent("core_vehicle:getVehicleHandling")
AddEventHandler("core_vehicle:getVehicleHandling", function(plate)
    local src = source

    TriggerClientEvent("core_vehicle:getVehicleHandling_c", src, plate, VehicleHandling[plate])
end)

RegisterServerEvent("core_vehicle:setVehicleHandling")
AddEventHandler("core_vehicle:setVehicleHandling", function(plate, handlingData)
    VehicleHandling[plate] = handlingData
end)

RegisterServerEvent("core_vehicle:getVehicleParts")
AddEventHandler("core_vehicle:getVehicleParts", function(plate, vehId, model)
    local src = source

    MySQL.Async.fetchAll("SELECT * FROM vrp_user_vehicles_parts WHERE plate = @plate AND vehicle = @vehicle", {
        ["@plate"] = plate,
        ["@vehicle"] = model
    }, function(parts)
        if parts[1] ~= nil then
            local converted = json.decode(parts[1].parts)
            if not converted["sparkplugs"] then
                converted["sparkplugs"] = {
                    type = "sparkplugs_lvl_1",
                    health = 100
                }
            end
            TriggerClientEvent("core_vehicle:getVehicleParts_c", src, converted, parts[1].mileage)

            TriggerClientEvent("core_vehicle:syncVehicle", -1, converted["engine"].type, vehId)
        else
            local defaultParts = {
                ["oil"] = {
                    type = "oil_lvl_1",
                    health = 100
                },
                ["tires"] = {
                    type = "tires_lvl_1",
                    health = 100
                },
                ["brakes"] = {
                    type = "brakes_lvl_1",
                    health = 100
                },
                ["suspension"] = {
                    type = "suspension_lvl_1",
                    health = 100
                },
                ["engine"] = {
                    type = "engine_lvl_1",
                    health = 100.0
                },
                ["transmission"] = {
                    type = "transmission_lvl_1",
                    health = 100
                },
                ["sparkplugs"] = {
                    type = "sparkplugs_lvl_1",
                    health = 100
                }
            }

            MySQL.Async.execute("REPLACE INTO vrp_user_vehicles_parts (vehicle, plate, parts) values(@vehicle, @plate, @parts)",
                {
                    ["@parts"] = json.encode(defaultParts),
                    ["@plate"] = plate,
                    ["@vehicle"] = model
                }, function()
                end)

            TriggerClientEvent("core_vehicle:getVehicleParts_c", src, defaultParts, 0)
            TriggerClientEvent("core_vehicle:syncVehicle", -1, defaultParts["engine"].type, vehId)
        end
    end)
end)

RegisterServerEvent("core_vehicle:setVehicleParts")
AddEventHandler("core_vehicle:setVehicleParts", function(plate, parts, mileage, model)
    local src = source

    MySQL.Async.execute(
        "UPDATE `vrp_user_vehicles_parts` SET `parts`= @parts, `mileage` = @mileage WHERE `plate` = @plate AND `vehicle` = @vehicle",
        {
            ["@parts"] = parts,
            ["@plate"] = plate,
            ["@mileage"] = mileage,
            ["@vehicle"] = model
        }, function()
        end)
end)

RegisterNetEvent("core_vehicle:syncNitro")
AddEventHandler("core_vehicle:syncNitro", function(boostEnabled, purgeEnabled, lastVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent("core_vehicle:sync", player, source, boostEnabled, purgeEnabled, lastVehicle)
        end
    end
end)

function passos.getIfVehicleOwned()
    return true
end
