local statsInterval = 5

function tvRP.varyHealth(variation)
    local ped = PlayerPedId()
    local n = math.floor(GetEntityHealth(ped) + variation)
    SetEntityHealth(ped, n)
end

-- [ GETHEALTH ]--------------------------------------------------------------------------------------------------------------------------

function tvRP.getHealth()
    return GetEntityHealth(PlayerPedId())
end

-- [ SETHEALTH ]--------------------------------------------------------------------------------------------------------------------------

function tvRP.setHealth(health)
    SetEntityHealth(PlayerPedId(), parseInt(health))
end

-- [ SETFRIENDLYFIRE ]--------------------------------------------------------------------------------------------------------------------

function tvRP.setFriendlyFire(flag)
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(PlayerPedId(), flag, flag)
end

-- [ SEDE & FOME ]------------------------------------------------------------------------------------------------------------------------

function tvRP.sedeFome()
    vRPserver.varyHunger(-100)
end

-- [ SEDE & FOME THREAD ]-----------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(statsInterval * 1000)

        if IsPlayerPlaying(PlayerId()) then
            local ped = GetPlayerPed(-1)
            local vthirst = 0.1
            local vhunger = 0.1
            local vsleep = 0.1

            if IsPedOnFoot(ped) then
                local factor = math.min(tvRP.getSpeed(), 10)

                vthirst = vthirst + 0.5 * factor
                vhunger = vhunger + 0.2 * factor
                vsleep = vsleep + 0.2 * factor
            end

            if IsPedInMeleeCombat(ped) then
                vthirst = vthirst + 5
                vhunger = vhunger + 2
                vsleep = vsleep + 2
            end

            if IsPedHurt(ped) or IsPedInjured(ped) then
                vthirst = vthirst + 1
                vhunger = vhunger + 1
                vsleep = vsleep + 1
            end

            if GetClockHours() > 01 and GetClockHours() < 07 then
                vsleep = vsleep + 0.1
            end

            if vthirst ~= 0 then
                vRPserver.varyThirst(vthirst / 12.0)
            end

            if vhunger ~= 0 then
                vRPserver.varyHunger(vhunger / 12.0)
            end

            if vsleep ~= 0 then
                vRPserver.varySleep(vsleep / 12.0)
            end
        end
    end
end)

-- [ HEALTHRECHARGE ]---------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
    end
end)

-- [ NETWORKRESSURECTION ]----------------------------------------------------------------------------------------------------------------

function tvRP.killGod()
    nocauteado = false
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    NetworkResurrectLocalPlayer(x, y, z, true, true, false)
    ClearPedBloodDamage(ped)
    SetEntityInvincible(ped, false)
    SetEntityHealth(ped, 110)
    ClearPedTasks(ped)
    ClearPedSecondaryTask(ped)
end

-- [ NETWORKPRISON ]----------------------------------------------------------------------------------------------------------------------

function tvRP.PrisionGod()
    local ped = PlayerPedId()
    if GetEntityHealth(ped) <= 101 then
        nocauteado = false
        ClearPedBloodDamage(ped)
        SetEntityInvincible(ped, false)
        SetEntityHealth(ped, 110)
        ClearPedTasks(ped)
        ClearPedSecondaryTask(ped)
    end
end

-- [ ISINCOMA ]---------------------------------------------------------------------------------------------------------------------------

function tvRP.isInComa()
    return nocauteado
end
