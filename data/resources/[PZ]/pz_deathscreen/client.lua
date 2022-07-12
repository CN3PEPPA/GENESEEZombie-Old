local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

tvRP = Tunnel.getInterface("vrp")
vRPserver = Tunnel.getInterface("vrp")

genesee = Tunnel.getInterface("pz_deathscreen")

-- [ NOCAUTEVAR ]-------------------------------------------------------------------------------------------------------------------------

local nocauteado = false
local deathtimer = 900

-- [ NOCAUTEADO ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
            idle = 5
            if not nocauteado then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                NetworkResurrectLocalPlayer(x, y, z, true, true, false)

                deathtimer = 900
                nocauteado = true
                vRPserver._updateHealth(101)

                SetEntityHealth(ped, 101)
                SetEntityInvincible(ped, false)

                if IsPedInAnyVehicle(ped) then
                    TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped), 4160)
                end
                exports['pma-voice']:removePlayerFromRadio()
                exports['pma-voice']:removePlayerFromCall()
            else
                if deathtimer > 0 then

                    SetNuiFocus(true, true)

                    SendNUIMessage({
                        setDisplay = true,
                        deathtimer = deathtimer
                    })
                else
                    Revive()
                end
                SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                SetEntityHealth(ped, 101)
                BlockWeaponWheelThisFrame()
                DisableControlAction(0, 21, true)
                DisableControlAction(0, 22, true)
                DisableControlAction(0, 23, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 29, true)
                DisableControlAction(0, 32, true)
                DisableControlAction(0, 33, true)
                DisableControlAction(0, 34, true)
                DisableControlAction(0, 35, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 56, true)
                DisableControlAction(0, 58, true)
                DisableControlAction(0, 73, true)
                DisableControlAction(0, 75, true)
                DisableControlAction(0, 137, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
                DisableControlAction(0, 143, true)
                DisableControlAction(0, 166, true)
                DisableControlAction(0, 167, true)
                DisableControlAction(0, 168, true)
                DisableControlAction(0, 169, true)
                DisableControlAction(0, 170, true)
                DisableControlAction(0, 177, true)
                DisableControlAction(0, 182, true)
                DisableControlAction(0, 187, true)
                DisableControlAction(0, 188, true)
                DisableControlAction(0, 189, true)
                DisableControlAction(0, 190, true)
                DisableControlAction(0, 243, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 264, true)
                DisableControlAction(0, 268, true)
                DisableControlAction(0, 269, true)
                DisableControlAction(0, 270, true)
                DisableControlAction(0, 271, true)
                DisableControlAction(0, 288, true)
                DisableControlAction(0, 289, true)
                DisableControlAction(0, 311, true)
                DisableControlAction(0, 344, true)
            end
        else
            SetNuiFocus(false, false)

            SendNUIMessage({
                setDisplay = false,
                deathtimer = deathtimer
            })

            nocauteado = false
        end
        Citizen.Wait(idle)
    end
end)

coords = {{
    x = -101.52,
    y = 6345.07,
    z = 31.58
}, {
    x = -949.41,
    y = 6192.76,
    z = 3.83
}, {
    x = -1576.73,
    y = 5160.12,
    z = 19.77
}, {
    x = -2634.46,
    y = 2808.67,
    z = 2.8
}, {
    x = -2567.1,
    y = 2307.78,
    z = 33.22
}, {
    x = -1904.03,
    y = 2098.87,
    z = 136.36
}, {
    x = -1812.15,
    y = -1222.3,
    z = 19.17
}, {
    x = -949.74,
    y = -2517.19,
    z = 14.55
}, {
    x = -1693.56,
    y = -3152.44,
    z = 24.33
}, {
    x = -225.39,
    y = -2000.34,
    z = 24.69
}, {
    x = 2907.89,
    y = 363.63,
    z = 2.61
}, {
    x = 1697.14,
    y = -1685.58,
    z = 112.53
}, {
    x = 813.62,
    y = -2982.61,
    z = 6.03
}, {
    x = -2010.32,
    y = 822.9,
    z = 162.2
}}

function Revive()
    local ped = PlayerPedId()
    genesee.getInvPlayer()
    TriggerEvent("resetBleeding")
    TriggerEvent("resetDiagnostic")
    TriggerServerEvent("clearInventory")
    TriggerServerEvent("fomesede")
    deathtimer = 900
    nocauteado = false
    ClearPedBloodDamage(ped)
    SetEntityInvincible(ped, false)
    DoScreenFadeOut(1000)
    SetEntityHealth(ped, 500)
    SetPedArmour(ped, 0)
    Citizen.Wait(1000)

    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(PlayerPedId(), 1, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 4, 61, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 5, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 6, 16, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 7, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 9, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 10, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 2)
        SetPedPropIndex(PlayerPedId(), 2, -1, 0, 2)
        SetPedPropIndex(PlayerPedId(), 6, -1, 0, 2)
        SetPedPropIndex(PlayerPedId(), 7, -1, 0, 2)
    else
        SetPedComponentVariation(PlayerPedId(), 1, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 4, 10, 0, 1)
        SetPedComponentVariation(PlayerPedId(), 5, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 6, 16, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 7, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 8, 2, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 9, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 10, -1, 0, 2)
        SetPedComponentVariation(PlayerPedId(), 11, 5, 0, 2)
        SetPedPropIndex(PlayerPedId(), 2, -1, 0, 2)
        SetPedPropIndex(PlayerPedId(), 6, -1, 0, 2)
        SetPedPropIndex(PlayerPedId(), 7, -1, 0, 2)
    end

    local location = math.random(1, #coords)

    SetEntityCoords(ped, coords[location].x, coords[location].y, coords[location].z + 0.20, 1, 0, 0, 1)
    SetEntityHeading(ped, heading)
    FreezeEntityPosition(ped, true)
    SetNuiFocus(false, false)
    TransitionFromBlurred(1000)
    TriggerScreenblurFadeOut(2500)
    SendNUIMessage({
        setDisplay = false,
        deathtimer = deathtimer
    })
    SetTimeout(5000, function()
        FreezeEntityPosition(ped, false)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end)

end

RegisterNUICallback('ButtonRevive', function()
    TriggerEvent("DropSystem:create", item, 1, x, y, z, 120)
    Revive()
end)

-- [ DEATHTIMER ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if nocauteado and deathtimer > 0 then
            deathtimer = deathtimer - 1
        end
    end
end)
