local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")
local vRP = Proxy.getInterface("vRP")
local src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)
local sRadio = Tunnel.getInterface(GetCurrentResourceName())
local src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)

local radio_prop = nil
local is_nui_open = false
local radio_prop_hash = GetHashKey("prop_cs_hand_radio")
local last_volume = 100
local is_muted = false
local last_frequency = 0

local PMA = exports["pma-voice"]

async(function()
    RequestModel(radio_prop_hash)
    while not HasModelLoaded(radio_prop_hash) do
        Citizen.Wait(0)
    end
end)

local function createRadioObject()
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 0, 0.0)
    radio_prop = CreateObject(radio_prop_hash, coords, true, true, true)
    SetEntityCollision(radio_prop, false, false)
    AttachEntityToEntity(radio_prop, ped, GetPedBoneIndex(ped, 0xEB95), 0.030, 0.03, -0.06, -127.0, 0.0, 0.0, false,
        false, false, false, 2, true)
    SetEntityAsMissionEntity(radio_prop, true, true)
end

local function removeObject()
    if DoesEntityExist(radio_prop) then
        SetEntityAsMissionEntity(radio_prop, false, true)
        DetachEntity(radio_prop, true, true)
        DeleteObject(radio_prop)
        radio_prop = nil
    end
end

local function AttachObjectToBone(attachBoneObject)
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 0, -5)
    local objectEntity = CreateObject(GetHashKey(attachBoneObject.Prop), coords.x, coords.y, coords.z, true, true, true)
    SetEntityCollision(objectEntity, false, false) -- Fix Prop Colision
    AttachEntityToEntity(objectEntity, ped, GetPedBoneIndex(ped, attachBoneObject.Bone), attachBoneObject.Position[1],
        attachBoneObject.Position[2], attachBoneObject.Position[3], attachBoneObject.Rotation[1],
        attachBoneObject.Rotation[2], attachBoneObject.Rotation[3], false, false, false, false, 2, true)
    SetEntityAsMissionEntity(objectEntity, true, true)
    return objectEntity
end

local function DeAttachObject(objectId)
    if (DoesEntityExist(objectId) and IsEntityAnObject(objectId)) then
        SetEntityAsMissionEntity(objectId, false, true)
        DetachEntity(objectId, true, true)
        DeleteObject(objectId)
    end
end

local function OpenRadioAnim()
    RequestAnimDict("cellphone@")
    while not HasAnimDictLoaded("cellphone@") do
        Wait(5)
    end
    TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_in", 8.0, 0.0, -1, 50, 0, 0, 0, 0)
    prop = AttachObjectToBone({
        Bone = 28422,
        Rotation = vector3(0, 0, 0),
        Position = vector3(0, 0, 0),
        Prop = "prop_cs_hand_radio"
    })
end

RegisterNetEvent('vrp_radio:OpenNUI')
AddEventHandler("vrp_radio:OpenNUI", function()
    if not is_nui_open then
        if sRadio.CheckRadioItem() then
            is_nui_open = true
            OpenRadioAnim()
            SendNUIMessage({
                action = "show"
            })
            SetNuiFocus(true, true)
        end
    end
end)

local function StopRadioAnim()
    if prop then
        StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_in", -4.0)
        DeAttachObject(prop)
        prop = nil
    end
end

local action = {
    ["CLOSE_NUI"] = function()
        SetNuiFocus(false, false)
        is_nui_open = false
        StopRadioAnim()
        return {
            status = true
        }
    end,
    ["MUTE_VOLUME"] = function(p)
        is_muted = p
        if is_muted then
            PMA:setRadioVolume(0)
        else
            PMA:setRadioVolume(last_volume)
        end
        return {
            status = true
        }
    end,
    ["CHANGE_VOLUME"] = function(p)
        if p == 3 then
            last_volume = 100
        elseif p == 2 then
            last_volume = 60
        elseif p == 1 then
            last_volume = 10
        else
            last_volume = 0
        end
        PMA:setRadioVolume(last_volume)
        return {
            status = true
        }
    end,
    ["SET_FREQUENCY"] = function(p)
        TriggerServerEvent("vrp_radio:RemovePlayerFromChannel", last_frequency, vRP.getUserId())
        local hasPerm = sRadio.checkFrequency(p)
        if hasPerm then
            last_frequency = p
            TriggerEvent("vrp_hud:ActiveFrequency", p, true)
            return {
                status = hasPerm,
                type = "connected"
            }
        end
        return {
            status = hasPerm
        }
    end,
    ["DISCONNECT"] = function()
        TriggerServerEvent("vrp_radio:RemovePlayerFromChannel", last_frequency, vRP.getUserId())
        TriggerEvent("vrp_hud:ActiveFrequency", 0, false)
        return {
            status = true,
            type = "disconnected"
        }
    end
}

RegisterNUICallback("pma-radio", function(data, cb)
    if data then
        cb(action[data.action](data.payload))
    end
end)

RegisterNetEvent("vrp_hud:ActiveFrequency", function(freq, active)
    PMA:setRadioChannel(freq)
    PMA:setVoiceProperty('radioEnabled', active)
end)

AddEventHandler("pma-voice:radioActive", function(status)
    if status then
        createRadioObject()
    else
        removeObject()
    end
end)
