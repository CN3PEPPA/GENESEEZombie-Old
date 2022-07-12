local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

dormir = {}
Tunnel.bindInterface("pz_dormir", dormir)
Proxy.addInterface("pz_dormir", dormir)

local sleep = 0
local sleeping = false

local sleeptimer = 10

RegisterNetEvent("vrp_hud:update")
AddEventHandler("vrp_hud:update", function(rHunger, rThirst, rSleep)
    sleep = parseInt(rSleep)
end)

CreateThread(function()
    while true do
        local PlayerCoords = GetEntityCoords(PlayerPedId())
        if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
            bocejo = 'bocejo_mas'
        else
            bocejo = 'bocejo_fem'
        end

        if sleep == 80 then
            if not sleeping then
                DoScreenFadeOut(1000)
                TriggerEvent('InteractSound_CL:PlayWithinDistance', PlayerCoords, 4, bocejo, 0.25)
                SetTimeout(2000, function()
                    DoScreenFadeIn(1000)
                    sleeping = true
                end)
            end
        end

        if sleep == 85 then
            if not sleeping then
                DoScreenFadeOut(1000)
                TriggerEvent('InteractSound_CL:PlayWithinDistance', PlayerCoords, 4, bocejo, 0.25)
                SetTimeout(2000, function()
                    DoScreenFadeIn(1000)
                    sleeping = true
                end)
            end
        end

        if sleep == 90 then
            if not sleeping then
                DoScreenFadeOut(1000)
                TriggerEvent('InteractSound_CL:PlayWithinDistance', PlayerCoords, 4, bocejo, 0.25)
                SetTimeout(2000, function()
                    DoScreenFadeIn(1000)
                    sleeping = true
                end)
            end
        end

        if sleep == 95 then
            if not sleeping then
                DoScreenFadeOut(1000)
                TriggerEvent('InteractSound_CL:PlayWithinDistance', PlayerCoords, 4, bocejo, 0.25)
                SetTimeout(2000, function()
                    DoScreenFadeIn(1000)
                    sleeping = true
                end)
            end
        end

        if sleep == 100 then
            TriggerEvent('pz_dormir:fallAsleep')
        end
        Wait(2500)
    end
end)

RegisterNetEvent('pz_dormir:fallAsleep')
AddEventHandler('pz_dormir:fallAsleep', function()
    fallAsleep('Você está dormindo!')
end)

function fallAsleep(message)

    sleeping = true

    TriggerServerEvent('pz_dormir:animation')
    local ped = PlayerPedId()
    DoScreenFadeOut(1000)
    SetEntityVisible(ped, false)
    SetEntityInvincible(ped, true) -- mqcu
    Wait(1000)

    local s = sleeptimer
    while s >= 0 and GetEntityHealth(PlayerPedId()) > 101 do
        SendNUIMessage({
            action = "display",
            message = message,
            sleeptimer = s
        })
        s = s - 1
        Wait(1000)
    end

    sleep = 0
    sleeping = false

    SetEntityVisible(ped, true)
    SetEntityInvincible(ped, false) -- mqcu

    TriggerServerEvent('pz_dormir:stopAnimation')

    SendNUIMessage({
        action = "hide"
    })

    DoScreenFadeIn(1000)

    SetEntityInvincible(PlayerPedId(), true)
    Wait(5 * 1000)
    SetEntityInvincible(PlayerPedId(), false)
end
