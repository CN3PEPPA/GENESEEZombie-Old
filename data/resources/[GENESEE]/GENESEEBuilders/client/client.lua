
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

builders = {}
Tunnel.bindInterface("GENESEEBuilders", builders)
Proxy.addInterface("GENESEEBuilders", builders)

buildersSV = Tunnel.getInterface("GENESEEBuilders")

local using = false

local OFFSETS = {
    WIDTH = 4.3,
    HEIGHT = vector3(0.0, 0, 3.5)
}
local DIST_OFFSETS = {
    RIGHT = 1.0,
    LEFT = 1.0,
    TOP = 1.5,
    BOTTOM = 0.5
}

function GetFixedHeading(angle)
    local opposite = 0.0

    if angle == 0 then
        opposite = 180.0
    else
        if angle > 0 then
            opposite = angle - 180.0
        else
            opposite = angle + 180.0
        end
    end

    return opposite
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }

    local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z,
        destination.x, destination.y, destination.z, 1, -1, 1))
    return b, c, e
end

function LoadModel(modelName)
    local modelHash
    if type(modelName) ~= 'string' then
        modelHash = modelName
    else
        modelHash = GetHashKey(modelName)
    end
    if IsModelInCdimage(modelHash) then
        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(0)
            end
        end
        return modelHash
    else
        return nil
    end

    SetModelAsNoLongerNeeded(modelHash)
end

function LoadPtfx(ptfxAsset)
    if not HasNamedPtfxAssetLoaded(ptfxAsset) then
        RequestNamedPtfxAsset(ptfxAsset)
        while not HasNamedPtfxAssetLoaded(ptfxAsset) do
            Wait(0)
        end
    end

    UseParticleFxAsset(ptfxAsset)
end

CreateThread(function()
    -- Load required models
    structures = {
        ['mout_base'] = {
            model = LoadModel('mout_base')
        },
        ['mout_base_02'] = {
            model = LoadModel('mout_base_02')
        },
        ['mout_base_03'] = {
            model = LoadModel('mout_base_03')
        },
        ['mout_base_large'] = {
            model = LoadModel('mout_base_large')
        },
        ['mout_base_large_02'] = {
            model = LoadModel('mout_base_large_02')
        },
        ['mout_base_raised'] = {
            model = LoadModel('mout_base_raised')
        },
        ['mout_base_raised_02'] = {
            model = LoadModel('mout_base_raised_02')
        },
        ['mout_base_raised_tall'] = {
            model = LoadModel('mout_base_raised_tall')
        },
        ['mout_base_raised_tall_02'] = {
            model = LoadModel('mout_base_raised_tall_02')
        },
        ['mout_shutter_wood'] = {
            model = LoadModel('mout_shutter_wood')
        },
        ['mout_shutter_metal'] = {
            model = LoadModel('mout_shutter_metal')
        },
        ['mout_int_light_01'] = {
            model = LoadModel('mout_int_light_01')
        },
        ['mout_ext_stair'] = {
            model = LoadModel('mout_ext_stair')
        },
        ['mout_ext_steps'] = {
            model = LoadModel('mout_ext_steps')
        },
        ['mout_ext_cover_01'] = {
            model = LoadModel('mout_ext_cover_01')
        },
        ['mout_ext_cover_02'] = {
            model = LoadModel('mout_ext_cover_02')
        },
        ['mout_ext_cover_03'] = {
            model = LoadModel('mout_ext_cover_03')
        },
        ['mout_ext_cover_04'] = {
            model = LoadModel('mout_ext_cover_04')
        },
        ['mout_ext_cover_05'] = {
            model = LoadModel('mout_ext_cover_05')
        },
        ['mout_ext_cover_06'] = {
            model = LoadModel('mout_ext_cover_06')
        },
        ['mout_cap_wall'] = {
            model = LoadModel('mout_cap_wall')
        },
        ['mout_cap_wall_02'] = {
            model = LoadModel('mout_cap_wall_02')
        },
        ['mout_cap_wall_03'] = {
            model = LoadModel('mout_cap_wall_03')
        },
        ['mout_cap_stair'] = {
            model = LoadModel('mout_cap_stair')
        },
        ['mout_cap_stair_02'] = {
            model = LoadModel('mout_cap_stair_02')
        },
        ['mout_cap_stair_03'] = {
            model = LoadModel('mout_cap_stair_03')
        },
        ['mout_cap_door_01'] = {
            model = LoadModel('mout_cap_door_01')
        },
        ['mout_cap_door_02'] = {
            model = LoadModel('mout_cap_door_02')
        },
        ['mout_cap_door_03'] = {
            model = LoadModel('mout_cap_door_03')
        },
        ['mout_cap_door_04'] = {
            model = LoadModel('mout_cap_door_04')
        },
        ['mout_cap_door_05'] = {
            model = LoadModel('mout_cap_door_05')
        },
        ['mout_cap_door_06'] = {
            model = LoadModel('mout_cap_door_06')
        },
        ['mout_cap_window_01'] = {
            model = LoadModel('mout_cap_window_01')
        },
        ['mout_cap_window_02'] = {
            model = LoadModel('mout_cap_window_02')
        },
        ['mout_cap_window_03'] = {
            model = LoadModel('mout_cap_window_03')
        },
        ['mout_cap_window_04'] = {
            model = LoadModel('mout_cap_window_04')
        },
        ['mout_cap_window_05'] = {
            model = LoadModel('mout_cap_window_05')
        },
        ['mout_cap_garage_01'] = {
            model = LoadModel('mout_cap_garage_01')
        },
        ['mout_cap_garage_02'] = {
            model = LoadModel('mout_cap_garage_02')
        },
        ['mout_cap_garage_03'] = {
            model = LoadModel('mout_cap_garage_03')
        },
        ['mout_cap_garage_04'] = {
            model = LoadModel('mout_cap_garage_04')
        },
        ['mout_cap_garage_05'] = {
            model = LoadModel('mout_cap_garage_05')
        },
        ['mout_cap_garage_06'] = {
            model = LoadModel('mout_cap_garage_06')
        },
        ['mout_mid_wall'] = {
            model = LoadModel('mout_mid_wall')
        },
        ['mout_mid_wall_02'] = {
            model = LoadModel('mout_mid_wall_02')
        },
        ['mout_mid_door'] = {
            model = LoadModel('mout_mid_door')
        },
        ['mout_mid_door_02'] = {
            model = LoadModel('mout_mid_door_02')
        },
        ['mout_mid_window'] = {
            model = LoadModel('mout_mid_window')
        },
        ['mout_mid_window_02'] = {
            model = LoadModel('mout_mid_window_02')
        },

        --
        ['barraca'] = {
            model = LoadModel('prop_skid_tent_03')
        },
        ['bau'] = {
            model = LoadModel('bau')
        }

    }
end)

RegisterNetEvent('GENESEEBuilders:struct')
AddEventHandler('GENESEEBuilders:struct', function(requestedStructure)
    local requestedStructure = requestedStructure
    if not requestedStructure then
        return
    end
    handleStructure(requestedStructure)
end)

function handleStructure(struct)
    local user_id = buildersSV.Players()

    allowHeadingControl = true
    runThread = true
    structure = CreateObjectNoOffset(structures[struct].model)
    

    SetEntityAlpha(structure, 100)
    SetEntityCollision(structure, false, false)

    while runThread do
        Wait(0)

        hit, coords, entity = RayCastGamePlayCamera(80.0)

        SetEntityCoords(structure, coords)
        ShowHudComponentThisFrame(14)
        CheckControls()
        
        if GetEntityType(entity) == 3 then
            local forwardVector, rightVector, upVector, entityCoords = GetEntityMatrix(entity)
            local yAxel = coords.z - entityCoords.z
            local highestZ = entityCoords.z
            local zChanged = false
            
            -- -- Object stacking
            -- if yAxel > 2.2 then
            --     local gamePool = GetGamePool('CObject')

            --     for _, object in pairs(gamePool) do
            --         if object ~= structure then
            --             local objectCoords = GetEntityCoords(object)

            --             if objectCoords.xy == entityCoords.xy and objectCoords.z > highestZ then
            --                 zChanged = true
            --                 highestZ = objectCoords.z
            --                 entityCoords = vector3(entityCoords.x, entityCoords.y, highestZ) - OFFSETS.HEIGHT
            --             end
            --         end
            --     end
            -- end

            -- local entityHeading = GetEntityHeading(entity)
            -- if allowHeadingControl then
            --     SetEntityHeading(structure, entityHeading)
            -- end

            -- if zChanged then
            --     SetEntityCoords(structure, entityCoords)
            -- else
            --     local xAxel = coords.x - entityCoords.x
                
            --     if yAxel > 2.2 then
            --         SetEntityCoords(structure, entityCoords + OFFSETS.HEIGHT)
            --     elseif xAxel > 0 then
            --         SetEntityCoords(structure, entityCoords +
            --         vector3(rightVector.x * OFFSETS.WIDTH, rightVector.y * OFFSETS.WIDTH, rightVector.z))
            --     else
            --         SetEntityCoords(structure, entityCoords -
            --         vector3(rightVector.x * OFFSETS.WIDTH, rightVector.y * OFFSETS.WIDTH, rightVector.z))
            --     end
            -- end
        end

        if IsDisabledControlJustPressed(0, 190) or IsDisabledControlJustPressed(0, 16) then
            -- Arrow left
            SetEntityHeading(structure, GetEntityHeading(structure) + 1.0)
        elseif IsDisabledControlJustPressed(0, 189) or IsDisabledControlJustPressed(0, 17) then
            -- Arrow right
            SetEntityHeading(structure, GetEntityHeading(structure) - 1.0)
        end
    end

    if not structure then
        return
    end

    if runThread == nil then
        -- Player wants to cancel structure
        DeleteEntity(structure)
    else
        -- Player wants to place structure
        if not using then
            using = true

            local ptfxModel = LoadPtfx('core')
            local ptfxHandle = StartParticleFxLoopedAtCoord('ent_dst_concrete_large', GetEntityCoords(structure), 0.0,
                0.0, 0.0, 10.0)

            local itemCraft = structures[struct].model
            local check = buildersSV.Check(user_id, itemCraft)
            -- local check = false

            if itemCraft == 1268754372 then
                if check then
                    TriggerEvent('Notify', 'negado', 'Você já possui um <b>baú</b> criado!')
                else
                    TriggerServerEvent('BM:createStructure_UserId', user_id, structures[struct].model,
                        GetEntityCoords(structure), GetEntityHeading(structure))
                end
            else
                TriggerServerEvent('BM:createStructure', structures[struct].model, GetEntityCoords(structure),
                    GetEntityHeading(structure))
            end

            Wait(250)

            DeleteEntity(structure)

            SetTimeout(2500, function()
                using = false
            end)
        end
    end
end

function CheckControls()

    DisableControlAction(0, 16, true)
    DisableControlAction(0, 17, true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 141, true)
    DisableControlAction(0, 189, true)
    DisableControlAction(0, 190, true)
    DisableControlAction(0, 191, true)
    DisableControlAction(0, 194, true)
    DisableControlAction(0, 200, true)

    if IsDisabledControlJustPressed(0, 191) then
        runThread = false
    end

    if IsDisabledControlJustPressed(0, 24) then
        runThread = false
    end
    if IsDisabledControlJustPressed(0, 200) or IsDisabledControlJustPressed(0, 25) then
        runThread = nil
    end

    if IsDisabledControlJustPressed(0, 140) or IsDisabledControlJustPressed(0, 27) then
        allowHeadingControl = true
        SetEntityHeading(structure, 0.0)
    end

    if IsDisabledControlJustPressed(0, 141) then
        allowHeadingControl = false
        SetEntityHeading(structure, GetFixedHeading(GetEntityHeading(entity)))
    end
end

CreateThread(function()
    Wait(3500)
    TriggerServerEvent('BM:getsctructure')
end)

RegisterNetEvent("BM:generateStructure")
AddEventHandler("BM:generateStructure", function(model, x, y, z, h)
    TriggerEvent("GENESEESync:area", x, y, z)
    local objectHandle = CreateObjectNoOffset(model, x, y, z, true, true, true)
    SetEntityHeading(objectHandle, h)
end)

RegisterNetEvent("BM:deleteStructure")
AddEventHandler("BM:deleteStructure", function(objectHandle)
    DeleteEntity(objectHandle)
end)
