-----------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXA?O
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("pz_hud", cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
onInt = false
local hour = 0
local voice = 2
local minute = 0
local month = ""
local hunger = 100
local thirst = 100
local sleep = 100
local ammoCurrent = 0
local ammoTotal = 0
local ammoTotalInClip = 0
local dayMonth = 0
local varDay = "th"
local showHud = true
local showMovie = false
local showRadar = false
local sBuffer = {}
local seatbelt = false
local ExNoCarro = false
local timedown = 0
local talking = false

local imageWidth = 100 -- leave this variable, related to pixel size of the directions
local width = 0;
local south = (-imageWidth) + width
local west = (-imageWidth * 2) + width
local north = (-imageWidth * 3) + width
local east = (-imageWidth * 4) + width
local south2 = (-imageWidth * 5) + width
minimap = nil

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(100)
    end

    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    SetMinimapClipType(2)
    SetMinimapComponentPosition("minimap", "L", "B", 0.025, -0.05, 0.153, 0.24)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.135, 0.12, 0.093, 0.164)
    SetMinimapComponentPosition("minimap_blur", "L", "B", 0.012, 0.022, 0.256, 0.337)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATETIMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
function calculateTimeDisplay()
    hour = GetClockHours()
    month = GetClockMonth()
    minute = GetClockMinutes()
    dayMonth = GetClockDayOfMonth()

    if hour <= 9 then
        hour = "0" .. hour
    end

    if minute <= 9 then
        minute = "0" .. minute
    end

    if month == 0 then
        month = "January"
    elseif month == 1 then
        month = "February"
    elseif month == 2 then
        month = "March"
    elseif month == 3 then
        month = "April"
    elseif month == 4 then
        month = "May"
    elseif month == 5 then
        month = "June"
    elseif month == 6 then
        month = "July"
    elseif month == 7 then
        month = "August"
    elseif month == 8 then
        month = "September"
    elseif month == 9 then
        month = "October"
    elseif month == 10 then
        month = "November"
    elseif month == 11 then
        month = "December"
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOKOVOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:Tokovoip")
AddEventHandler("vrp_hud:Tokovoip", function(status)
    voice = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOKOVOIPTALKING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:TokovoipTalking")
AddEventHandler("vrp_hud:TokovoipTalking", function(status)
    talking = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:update")
AddEventHandler("vrp_hud:update", function(rHunger, rThirst, rSleep)
    hunger, thirst, sleep = rHunger, rThirst, rSleep
end)

RegisterNetEvent("pz_hud:mileage")
AddEventHandler("pz_hud:mileage", function(rmileage)
    mileage = rmileage
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudActived")
AddEventHandler("hudActived", function()
    showHud = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do

        if IsPauseMenuActive() or IsScreenFadedOut() or menu_celular then
            SendNUIMessage({
                hud = false,
                movie = false
            })
        else
            local ped = PlayerPedId()
            local armour = GetPedArmour(ped)
            local health = (GetEntityHealth(GetPlayerPed(-1)) - 100) / 300 * 100
            local _w, weapon = GetCurrentPedWeapon(GetPlayerPed(-1))
            local _a, ammoCurrent = GetAmmoInClip(GetPlayerPed(-1), weapon)
            local ammoTotal = GetAmmoInPedWeapon(GetPlayerPed(-1), weapon)
            local ammoTotalInClip = GetMaxAmmoInClip(GetPlayerPed(-1), weapon)
            local stamina = GetPlayerSprintStaminaRemaining(PlayerId())
            nsei, baixo, alto = GetVehicleLightsState(GetVehiclePedIsIn(PlayerPedId()))
            local x, y, z = table.unpack(GetEntityCoords(ped))
            local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x, y, z))

            calculateTimeDisplay()

            if dayOfMonth == 1 then
                varDay = "st"
            elseif dayOfMonth == 2 then
                varDay = "nd"
            elseif dayOfMonth == 3 then
                varDay = "rd"
            else
                varDay = "th"
            end

            local ped = PlayerPedId()
            local car = GetVehiclePedIsIn(ped)

            if not showHud then
                showRadar = false
            end

            if IsPedOnAnyBike(ped) then
                showRadar = true
            end

            if not IsPedInAnyVehicle(ped) then
                showRadar = false
                DisplayRadar(showRadar)
            end

            if baixo == 1 and alto == 0 then
                farol = 1
            elseif alto == 1 then
                farol = 2
            else
                farol = 0
            end

            if IsPedInAnyVehicle(ped) then
                showRadar = true
                local vehicle = GetVehiclePedIsIn(ped)
                local seat = GetPedInVehicleSeat(vehicle, 0)

                if seat == 0 then
                    local fuel = GetVehicleFuelLevel(vehicle)
                    local enginehealth = GetVehicleEngineHealth(vehicle)
                    local speed = GetEntitySpeed(vehicle) * 3.6

                    SendNUIMessage({
                        hud = showHud,
                        movie = showMovie,
                        car = true,
                        day = dayMonth .. varDay,
                        month = month,
                        hour = hour,
                        minute = minute,
                        street = street,
                        radio = radioDisplay,
                        voice = voice,
                        talking = talking,
                        health = parseInt(health),
                        armour = parseInt(armour),
                        thirst = parseInt(thirst),
                        hunger = parseInt(hunger),
                        sleep = parseInt(sleep),
                        stamina = parseInt(stamina),
                        fuel = parseInt(fuel),
                        speed = parseInt(speed),
                        seatbelt = seatbelt,
                        farol = farol,
                        enginehealth = enginehealth,
                        mileage = mileage
                    })
                end
            else
                SendNUIMessage({
                    hud = showHud,
                    movie = showMovie,
                    car = false,
                    day = dayMonth .. varDay,
                    month = month,
                    hour = hour,
                    minute = minute,
                    street = street,
                    radio = radioDisplay,
                    voice = voice,
                    talking = talking,
                    health = parseInt(health),
                    ammoCurrent = ammoCurrent,
                    ammoTotal = ammoTotal,
                    ammoTotalInClip = ammoTotalInClip,
                    weapon = weapon,
                    armour = parseInt(armour),
                    thirst = parseInt(thirst),
                    hunger = parseInt(hunger),
                    sleep = parseInt(sleep),
                    stamina = parseInt(stamina)
                })
            end
        end
        Citizen.Wait(200)
    end
end)

-- Citizen.CreateThread(function()
--      while true do
--              if IsControlJustPressed(0,313) then
--                      idle = 5
--                      onInt = true
--                      SendNUIMessage({ interact = true })
--                      SetNuiFocus(true, true)
--              end
--              Citizen.Wait(5)
--      end
-- end)

RegisterKeyMapping('hud:interact', 'Abrir menu de interação', 'keyboard', 'I')

RegisterCommand('hud:interact', function()
    TriggerEvent(":triggerhud")
end)

RegisterNUICallback('hideFocus', function()
    SetNuiFocus(false, false)
    onInt = false
    TransitionFromBlurred(1000)
end)

RegisterNUICallback('hideHUD', function()
    TriggerEvent(":triggerhud")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud", function(source, args)
    TriggerEvent(":triggerhud")
end)

RegisterNetEvent(":triggerhud")
AddEventHandler(":triggerhud", function()
    showHud = not showHud
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie", function(source, args)
    showMovie = not showMovie
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 15 and vc <= 20)
end

Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local car = GetVehiclePedIsIn(ped)

        if car ~= 0 and (ExNoCarro or IsCar(car)) then
            ExNoCarro = true
            if seatbelt then
                DisableControlAction(0, 75)
            end

            timeDistance = 4
            sBuffer[2] = sBuffer[1]
            sBuffer[1] = GetEntitySpeed(car)

            if sBuffer[2] ~= nil and not seatbelt and GetEntitySpeedVector(car, true).y > 1.0 and sBuffer[1] > 10.25 and
                (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
                SetEntityHealth(ped, GetEntityHealth(ped) - 10)
                SetFlyThroughWindscreenParams(25.0, 2.0, 15.0, 15.0) -- Parametros para sair voando à aprox.. 120KM/h, mas pode ir mudando conforme seu gosto. Se deixar tudo em 0.00 seu boneco voa assim que entra no carro.
                SetPedConfigFlag(ped, 32, true)
                timedown = 10
            end

            if IsControlJustReleased(1, 47) then
                if seatbelt then
                    TriggerEvent("vrp_sound:source", "unbelt", 0.5)
                    seatbelt = false
                else
                    TriggerEvent("vrp_sound:source", "belt", 0.5)
                    seatbelt = true
                end
            end

            if IsPedOnAnyBike(ped) then
                showRadar = true
            end

            if not seatbelt and not showHud then
                showRadar = false
            end

        elseif ExNoCarro then
            ExNoCarro = false
            seatbelt = false
            sBuffer[1], sBuffer[2] = 0.0, 0.0
        end
        DisplayRadar(showRadar)
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        if timedown > 0 and GetEntityHealth(ped) > 101 then
            timedown = timedown - 1
            if timedown <= 1 then
                TriggerServerEvent("vrp_inventory:Cancel")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAGDOLL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        if timedown > 1 and GetEntityHealth(ped) > 101 then
            if not IsEntityPlayingAnim(ped, "anim@heists@ornate_bank@hostages@hit", "hit_react_die_loop_ped_a", 3) then
                vRP.playAnim(false, {"anim@heists@ornate_bank@hostages@hit", "hit_react_die_loop_ped_a"}, true)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local TimeDistance = 500
        if timedown > 0 then
            TimeDistance = 4
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 187, true)
            DisableControlAction(0, 189, true)
            DisableControlAction(0, 190, true)
            DisableControlAction(0, 188, true)
            DisableControlAction(0, 57, true)
            DisableControlAction(0, 105, true)
            DisableControlAction(0, 167, true)
            DisableControlAction(0, 20, true)
            DisableControlAction(0, 29, true)
        end
        Citizen.Wait(TimeDistance)
    end
end)

