local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

-- [ CONNECTION ]-------------------------------------------------------------------------------------------------------------------------

vRPNserver = Tunnel.getInterface("vrp_inventory")

vRPC = {}
Tunnel.bindInterface("vrp_inventory", vRPC)
Proxy.addInterface("vrp_inventory", vRPC)
armour = false
bag = false

-- [ VARIABLES ]--------------------------------------------------------------------------------------------------------------------------

local invOpen = false

-- [ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
end)

-- [ INVCLOSE ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("invClose", function(data)
    StopScreenEffect("MenuMGSelectionIn")
    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hideMenu"
    })
    invOpen = false
end)

RegisterNUICallback("unEquip", function(cb)
    if not bag then
        -- bag = true
        if vRPNserver.unEquip() then
            bag = true
            SetTimeout(10000, function()
                bag = false
            end)
        end
    else
        TriggerEvent("Notify", "negado", "Você já está desequipando uma mochila.")
    end
end)

-- [ INVOPEN ]----------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vrp_inventory:openInv')
AddEventHandler('vrp_inventory:openInv', function()
    local ped = PlayerPedId()
    local user_id = vRPNserver.getUserId()
    if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and
        not IsPlayerFreeAiming(ped) then
        if not invOpen then
            StartScreenEffect("MenuMGSelectionIn", 0, true)
            invOpen = true
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "showMenu",
                id = user_id,
            })
        else
            StopScreenEffect("MenuMGSelectionIn")
            SetNuiFocus(false, false)
            SendNUIMessage({
                action = "hideMenu"
            })
            invOpen = false
        end
    end
end)

-- [ CLONEPLATES ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local clonada = GetVehicleNumberPlateText(vehicle)
    if IsEntityAVehicle(vehicle) then
        PlateIndex = GetVehicleNumberPlateText(vehicle)
        SetVehicleNumberPlateText(vehicle, "CLONADA")
        FreezeEntityPosition(vehicle, false)
        if clonada == CLONADA then
            SetVehicleNumberPlateText(vehicle, PlateIndex)
            PlateIndex = nil
        end
    end
end)

-- [ VEHICLEANCHOR ]----------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vehicleanchor')
AddEventHandler('vehicleanchor', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehicle, true)
end)

-- [ DROPITEM ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("dropItem", function(data)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        TriggerEvent("Notify", "negado", "Você não pode dropar itens quando estiver em um veículo.")
    else
        if data.amount > 0 then
            vRPNserver.dropItem(data.item, data.type, data.amount)
        else
            vRPNserver.dropItemMax(data.item, data.type)
        end
    end
end)

-- [ SENDITEM ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("sendItem", function(data)
    if data.amount > 0 then
        vRPNserver.sendItem(data.item, data.type, data.amount)
    else
        vRPNserver.sendItemMax(data.item, data.type, data.amount)
    end
end)

-- [ USEITEM ]----------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("useItem", function(data)
    vRPNserver.useItem(data.item, data.type, data.amount)
end)

-- [ INVENTORY ]--------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestInventory", function(data, cb)
    local inventario, peso, maxpeso, slots, fslots = vRPNserver.Inventory()
    local imageService = config.imageService
    if inventario then
        cb({
            inventario = inventario,
            peso = peso,
            maxpeso = maxpeso,
            slots = slots,
            fslots = fslots,
            imageService = imageService
        })
    end
end)

-- [ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("vrp_inventory:Update")
AddEventHandler("vrp_inventory:Update", function(action)
    SendNUIMessage({
        action = action
    })
end)

RegisterNetEvent("vrp_inventory:fechar")
AddEventHandler("vrp_inventory:fechar", function(action)
    StopScreenEffect("MenuMGSelectionIn")
    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hideMenu"
    })
    invOpen = false
end)

-- [ USO REMÉDIO ]------------------------------------------------------------------------------------------------------------------------

local usandoRemedios = false
RegisterNetEvent("remedios")
AddEventHandler("remedios", function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped, health)

    if usandoRemedios then
        return
    end

    usandoRemedios = true

    if usandoRemedios then
        repeat
            Citizen.Wait(600)
            if GetEntityHealth(ped) > 101 then
                if GetEntityHealth(ped) > 150 then
                    SetEntityHealth(ped, GetEntityHealth(ped) + 1)
                end
            end
        until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 150
        TriggerEvent("Notify", "sucesso", "O medicamento acabou de fazer efeito.", 8000)
        usandoRemedios = false
    end
end)

local usandoMedkit = false
RegisterNetEvent("medkit")
AddEventHandler("medkit", function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped, health)
    SetPedArmour(ped, armour)

    if usandoMedkit then
        return
    end

    usandoMedkit = true

    if usandoMedkit then
        repeat
            Citizen.Wait(5000)
            if GetEntityHealth(ped) > 101 then
                if GetEntityHealth(ped) < 400 then
                    SetEntityHealth(ped, GetEntityHealth(ped) + 5)
                end
            end
        until GetEntityHealth(ped) >= 400
        TriggerEvent("Notify", "sucesso", "O tratamento foi conclúido.", 8000)
        usandoMedkit = false
    end
end)

local usandoBandagem = false
RegisterNetEvent("bandagem")
AddEventHandler("bandagem", function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped, health)
    SetPedArmour(ped, armour)

    if GetEntityHealth(ped) >= 290 then
        TriggerEvent("Notify", "negado",
            "Você não pode usar a <b>Bandagem</b> pois ela já atingiu o limite do seu efeito.", 8000)
    else
        if usandoBandagem then
            return
        end

        usandoBandagem = true

        if usandoBandagem then
            repeat
                Citizen.Wait(10000)
                if GetEntityHealth(ped) > 101 then
                    if GetEntityHealth(ped) < 290 then
                        SetEntityHealth(ped, GetEntityHealth(ped) + 1)
                    end
                end
            until GetEntityHealth(ped) >= 290
            TriggerEvent("Notify", "sucesso", "O tratamento foi conclúido.", 8000)
            usandoBandagem = false
        end
    end
end)

RegisterNetEvent("inventory:mochilaon")
AddEventHandler("inventory:mochilaon", function(type)
    if type == 'pequena' then
        SetPedComponentVariation(PlayerPedId(), 5, 52, 4, 2)
    end

    if type == 'media' then
        SetPedComponentVariation(PlayerPedId(), 5, 52, 4, 2)
    end

    if type == 'grande' then
        SetPedComponentVariation(PlayerPedId(), 5, 1, 1, 1)
    end
end)

RegisterNetEvent("inventory:mochilaoff")
AddEventHandler("inventory:mochilaoff", function()
    SetPedComponentVariation(PlayerPedId(), 5, -1, 0, 2)
end)

function vRPC.checkVida()
    local ped = PlayerPedId()
    if GetEntityHealth(ped) >= 150 and GetEntityHealth(ped) < 400 then
        return true
    end
    return false
end

function vRPC.checkHasWeapon(itemName)
    return HasPedGotWeapon(PlayerPedId(), GetHashKey(string.gsub(itemName, "wbody", "")), false)
end

RegisterNetEvent("allowArmour")
AddEventHandler("allowArmour", function()
    armour = false
    SetPedArmour(PlayerPedId(), 0)
end)

RegisterNetEvent("notallowArmour")
AddEventHandler("notallowArmour", function()
    armour = true
end)

RegisterNetEvent("allowBag")
AddEventHandler("allowBag", function()
    bag = false
end)

RegisterNetEvent("notallowBag")
AddEventHandler("notallowBag", function()
    bag = true
end)

RegisterNetEvent("vrp_inventory:suppressor")
AddEventHandler("vrp_inventory:suppressor", function()
    local ped = PlayerPedId()
    if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
        GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))
    elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNIPERRIFLE") then
        GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
        GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
        GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))
    end
end)

RegisterNetEvent("vrp_inventory:flashlight")
AddEventHandler("vrp_inventory:flashlight", function()
    local ped = PlayerPedId()
    if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
        GiveWeaponComponentToPed(ped, GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    end
end)
