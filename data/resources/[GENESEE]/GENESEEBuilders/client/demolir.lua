local demolishMode = false
local function Draw3DText(text, coords, scale, color)
  local r, g, b = table.unpack(color)
  local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)

  if onScreen then
    SetTextScale(scale, scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(r, g, b, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    -- SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(x, y)
  end
end

local function isBuildingProp(hash)
  for _, objectHash in pairs(structures) do
    if objectHash.model == hash then
      return true
    end
  end

  return false
end

local function findClosestBuilding(objectPool)
  local closestObj = objectPool[1]
  local playerCoords = GetEntityCoords(PlayerPedId())

  for _, objectHandle in pairs(objectPool) do
    local objectCoords = GetEntityCoords(objectHandle)
    local objectModel = GetEntityModel(objectHandle)
    local closestObjCoords = GetEntityCoords(closestObj)

    if isBuildingProp(objectModel) then
      if #(playerCoords - closestObjCoords) > #(playerCoords - objectCoords) then
        closestObj = objectHandle
      end
    end
  end

  return closestObj
end

function demolishThread()
  while demolishMode do
    Wait(0)

    local objectPool = GetGamePool('CObject')

    for _, objectHandle in pairs(objectPool) do
      local objectCoords = GetEntityCoords(objectHandle)
      local objectModel = GetEntityModel(objectHandle)

      if isBuildingProp(objectModel) then
        Draw3DText('Press [E] to Demolish', objectCoords + vec3(0, 0, 2.0), 0.4, {255, 51, 51})
      end
    end

    if IsControlJustPressed(0, 51) then
      local closestBuilding = findClosestBuilding(objectPool)
      if closestBuilding ~= 0 then
        TriggerServerEvent('BM:demolishBuilding', ObjToNet(closestBuilding), GetEntityCoords(closestBuilding))
      end
    end
  end
end

RegisterCommand('demolish', function()
  demolishMode = not demolishMode

  if demolishMode then
    CreateThread(demolishThread)
  end
end)
