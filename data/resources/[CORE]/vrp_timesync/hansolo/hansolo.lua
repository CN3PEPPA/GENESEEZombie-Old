local hours = config.startHour
local minutes = config.startMinutes
local currentweather = config.standardWeather
local lastWeather = currentweather

-- [ UPDATEWEATHER ]----------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vrp_timesync:updateWeather')
AddEventHandler('vrp_timesync:updateWeather', function(NewWeather)
    currentweather = NewWeather
end)

-- [ FUNCTIONWEATHER ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= currentweather then
            lastWeather = currentweather
            SetWeatherTypeOverTime(currentweather, 15.0)
            Citizen.Wait(15000)
        end
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        SetArtificialLightsState(true)
        SetArtificialLightsStateAffectsVehicles(false)
        Citizen.Wait(5000)
    end
end)

-- [ PLAYERSPAWNED ]----------------------------------------------------------------------------------------------------------------------

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vrp_timesync:requestSync')
end)

-- [ SYNCTIMERS ]-------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('vrp_timesync:syncTimers')
AddEventHandler('vrp_timesync:syncTimers', function(sHour, sMinutes)
    hours = sHour
    minutes = sMinutes
end)

-- [ NETWORKCLOCK ]-----------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        NetworkOverrideClockTime(hours, minutes, 00)
    end
end)
