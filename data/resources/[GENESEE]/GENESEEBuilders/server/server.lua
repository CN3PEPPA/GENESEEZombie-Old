local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

builders = {}
Tunnel.bindInterface("GENESEEBuilders", builders)
Proxy.addInterface("GENESEEBuilders", builders)

vRP.prepare("vRP/select_buildings", "SELECT * FROM vrp_buildings")
vRP.prepare("vRP/select_user_buildings", "SELECT * FROM vrp_user_buildings")
vRP.prepare("vRP/get_chest_backup", "SELECT * FROM chest_backup")

vRP.prepare("vRP/create_buildings",
    "INSERT INTO vrp_buildings (model_hash, x, y, z, heading) VALUES (@model_hash, @x, @y, @z, @heading)")
vRP.prepare("vRP/create_user_buildings",
    "INSERT INTO vrp_user_buildings (user_id, pass, type, model_hash, x, y, z, heading) VALUES (@user_id, @pass, @type, @model_hash, @x, @y, @z, @heading)")
vRP.prepare("vRP/save_chest_backup", "INSERT INTO chest_backup (value, user_id) VALUES (@value, @user_id)")

vRP.prepare("vRP/set_pass_user_buildings", "UPDATE vrp_user_buildings SET pass = @pass WHERE user_id = @user_id")
vRP.prepare("vRP/set_upgrade_user_buildings",
    "UPDATE vrp_user_buildings SET type = @type WHERE user_id = @user_id AND type = @dtype")
vRP.prepare("vRP/set_chest_backup", "UPDATE vrp_user_buildings SET value = @value WHERE user_id = @user_id")

vRP.prepare("vRP/delete_buildings", "DELETE FROM vrp_buildings WHERE x = @x AND y = @y AND z = @z")
vRP.prepare("vRP/delete_user_buildings",
    "DELETE FROM vrp_user_buildings WHERE user_id = @user_id AND model_hash = @model_hash")
vRP.prepare("vRP/delete_chest_backup", "DELETE FROM chest_backup WHERE user_id = @user_id")
vRP.prepare("vRP/delete_all_backup", "DELETE FROM chest_backup")

function builders.Players()
    local user_id = vRP.getUserId(source)
    return user_id
end

function builders.Check(user_id, craft)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        return false
    else
        local rows = vRP.query('vRP/select_user_buildings')
        for _, item in pairs(rows) do
            if user_id == item.user_id then
                if craft == item.model_hash then
                    return true
                end
            end
        end
    end
end

function builders.consumeItem(item)
    local source = source
    local user_id = vRP.getUserId(source)

    vRP.tryGetInventoryItem(user_id, item, 1)
end

RegisterNetEvent('BM:demolishBuilding', function(objectHandle, entityCoords)
    DeleteEntity(NetworkGetEntityFromNetworkId(objectHandle))
    vRP.execute("vRP/delete_buildings", {
        x = entityCoords.x,
        y = entityCoords.y,
        z = entityCoords.z
    })
    Wait(1000)
    TriggerEvent('BM:getsctructure')
    TriggerClientEvent('BM:deleteStructure', -1, NetworkGetEntityFromNetworkId(objectHandle))
end)

RegisterServerEvent('BM:demolishUserBuilding')
AddEventHandler('BM:demolishUserBuilding', function(objectHandle, hash, object, user_id, x, y, z)
    DeleteEntity(NetworkGetEntityFromNetworkId(object))
    vRP.execute("vRP/delete_user_buildings", {
        user_id = user_id,
        model_hash = hash
    })
    Wait(1000)
    TriggerEvent("BM:getsctructure")
    TriggerClientEvent('BM:deleteStructure', -1, NetworkGetEntityFromNetworkId(objectHandle))
end)

RegisterNetEvent('BM:createStructure', function(modelHash, entityCoords, entityHeading)
    if modelHash and entityCoords and entityHeading then
        local position = entityCoords
        -- local objectHandle = CreateObjectNoOffset(modelHash, position, true, true, true)
        -- SetEntityHeading(objectHandle, tonumber(entityHeading))
        -- SetEntityDistanceCullingRadius(objectHandle, 9999.0)

        vRP.execute("vRP/create_buildings", {
            model_hash = modelHash,
            x = position.x,
            y = position.y,
            z = position.z,
            heading = entityHeading
        })

        TriggerClientEvent("BM:generateStructure", -1, modelHash, position.x, position.y, position.z, entityHeading)
    end
end)

RegisterNetEvent('BM:createStructure_UserId', function(user_id, modelHash, entityCoords, entityHeading)
    if modelHash and entityCoords and entityHeading then
        local position = entityCoords
        -- local objectHandle = CreateObjectNoOffset(modelHash, position, true, true, true)
        -- Wait(5)
        -- SetEntityHeading(objectHandle, entityHeading)
        if modelHash == 1268754372 then
            vRP.execute("vRP/create_user_buildings", {
                user_id = user_id,
                pass = nil,
                type = 'small',
                model_hash = modelHash,
                x = position.x,
                y = position.y,
                z = position.z,
                heading = entityHeading
            })
        else
            vRP.execute("vRP/create_user_buildings", {
                user_id = user_id,
                type = 'Not Chest',
                model_hash = modelHash,
                x = position.x,
                y = position.y,
                z = position.z,
                heading = entityHeading
            })
        end
        TriggerClientEvent("BM:generateStructure", -1, modelHash, position.x, position.y, position.z, entityHeading)
    end
end)

RegisterServerEvent('BM:getsctructure', function()
    local source = source
    local user_id = vRP.getUserId(source)

    local rows = vRP.query('vRP/select_buildings')
    for _, objectContext in pairs(rows) do
        TriggerClientEvent("BM:generateStructure", source, objectContext.model_hash, objectContext.x, objectContext.y,
            objectContext.z, objectContext.heading)
        Wait(10)
    end

    local buildings = vRP.query('vRP/select_user_buildings')
    for _n, objectContextBuildings in pairs(buildings) do
        TriggerClientEvent("BM:generateStructure", source, objectContextBuildings.model_hash, objectContextBuildings.x,
            objectContextBuildings.y, objectContextBuildings.z, objectContextBuildings.heading)
        Wait(10)
    end
end)
