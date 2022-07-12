local dropList = {}

RegisterNetEvent('DropSystem:remove')
AddEventHandler('DropSystem:remove', function(id)
    if dropList[id] ~= nil then
        dropList[id] = nil
    end
end)

RegisterNetEvent('DropSystem:createForAll')
AddEventHandler('DropSystem:createForAll', function(id, marker)
    dropList[id] = marker
end)

local cooldown = false
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        for k, v in pairs(dropList) do
            local ped = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(ped))
            local bowz, cdz = GetGroundZFor_3dCoord(v.x, v.y, v.z)
            local distance = GetDistanceBetweenCoords(v.x, v.y, cdz, x, y, z, true)
            if distance <= 15 then
                idle = 5
                DrawMarker(22, v.x, v.y, z + 0.50, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.15, 255, 0, 0, 155,
                    false, false, false, 1, false, false, false)
                if distance < 1.8 then
                    drawTxt('Pressione [~g~E~w~] para pegar ~g~' .. v.count .. '~w~x ~g~' .. string.upper(v.name) ..
                                '~w~.', 4, 0.5, 0.90, 0.35, 255, 255, 255, 255)
                    if distance <= 1.8 and v.count ~= nil and v.name ~= nil and not IsPedInAnyVehicle(ped) then
                        if IsControlJustPressed(1, 38) and not cooldown then
                            cooldown = true
                            TriggerServerEvent('DropSystem:take33', k, v.count)
                            SetTimeout(3000, function()
                                cooldown = false
                            end)
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end