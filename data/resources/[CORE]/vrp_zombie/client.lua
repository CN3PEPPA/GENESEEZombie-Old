local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

pz_zombie = Tunnel.getInterface("vrp_zombie")

local Shooting = false
local Running = false
local isDeadAlready = {}

DecorRegister('RegisterZombie', 2)

AddRelationshipGroup('ZOMBIE')
SetRelationshipBetweenGroups(0, GetHashKey('ZOMBIE'), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), GetHashKey('ZOMBIE'))

function IsPlayerShooting()
    return Shooting
end

function IsPlayerRunning()
    return Running
end

Citizen.CreateThread(function() -- Will only work in it's own while loop
    while true do
        Citizen.Wait(0)

        -- Peds
        SetPedDensityMultiplierThisFrame(config.pedDensity)
        SetScenarioPedDensityMultiplierThisFrame(config.pedDensity, config.pedDensity)

        -- Vehicles
        SetRandomVehicleDensityMultiplierThisFrame(config.vehicleDensity)
        SetParkedVehicleDensityMultiplierThisFrame(config.vehicleDensity)
        SetVehicleDensityMultiplierThisFrame(config.vehicleDensity)
    end
end)

Citizen.CreateThread(function() -- Will only work in it's own while loop
    while true do
        Citizen.Wait(5)

        if IsPedShooting(PlayerPedId()) then
            Shooting = true
            Citizen.Wait(config.shotAlertTime * 1000)
            Shooting = false
        end

        if IsPedSprinting(PlayerPedId()) or IsPedRunning(PlayerPedId()) then
            if Running == false then
                Running = true
            end
        else
            if Running == true then
                Running = false
            end
        end
    end
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(1000)

        local Zombie = -1
        local Success = false
        Handler, Zombie = FindFirstPed()

        repeat
            Citizen.Wait(100)

            if IsPedHuman(Zombie) and not IsPedAPlayer(Zombie) and not IsPedDeadOrDying(Zombie, true) then
                if not DecorExistOn(Zombie, 'RegisterZombie') then
                    ClearPedTasks(Zombie)
                    ClearPedSecondaryTask(Zombie)
                    ClearPedTasksImmediately(Zombie)
                    TaskWanderStandard(Zombie, 10.0, 10)
                    SetPedRelationshipGroupHash(Zombie, 'ZOMBIE')
                    ApplyPedDamagePack(Zombie, 'BigHitByVehicle', 0.0, 1.0)
                    SetEntityHealth(Zombie, config.zombieHealth)

                    RequestAnimSet('move_m@drunk@verydrunk')
                    while not HasAnimSetLoaded('move_m@drunk@verydrunk') do
                        Citizen.Wait(5)
                    end
                    SetPedMovementClipset(Zombie, 'move_m@drunk@verydrunk', 1.0)

                    SetPedConfigFlag(Zombie, 100, false)
                    DecorSetBool(Zombie, 'RegisterZombie', true)
                end

                SetPedRagdollBlockingFlags(Zombie, 1)
                SetPedCanRagdollFromPlayerImpact(Zombie, false)
                SetPedSuffersCriticalHits(Zombie, true)
                SetPedEnableWeaponBlocking(Zombie, true)
                DisablePedPainAudio(Zombie, true)
                StopPedSpeaking(Zombie, true)
                SetPedDiesWhenInjured(Zombie, false)
                StopPedRingtone(Zombie)
                SetPedMute(Zombie)
                SetPedIsDrunk(Zombie, true)
                SetPedConfigFlag(Zombie, 166, false)
                SetPedConfigFlag(Zombie, 170, false)
                SetBlockingOfNonTemporaryEvents(Zombie, true)
                SetPedCanEvasiveDive(Zombie, false)
                RemoveAllPedWeapons(Zombie, true)

                local PlayerCoords = GetEntityCoords(PlayerPedId())
                local PedCoords = GetEntityCoords(Zombie)
                local Distance = #(PedCoords - PlayerCoords)
                local DistanceTarget

                if IsPlayerShooting() or (IsControlJustPressed(0, 313) and IsPedInAnyVehicle(PlayerPedId())) then
                    DistanceTarget = config.shootDistanceAlert
                elseif IsPedInAnyVehicle(PlayerPedId()) then
                    DistanceTarget = config.vehicleDistanceAlert
                elseif IsPlayerRunning() then
                    DistanceTarget = config.runningDistanceAlert
                else
                    DistanceTarget = config.defaultDistanceAlert
                end

                local isImune = pz_zombie.verifyImunePlayers()
                if not isImune then
                    if Distance <= DistanceTarget then
                        TaskGoToEntity(Zombie, PlayerPedId(), -1, 0.0, config.defaultVelocity, 1073741824, 0)
                    end
                end

                if Distance <= 15 and Distance >= 11 then
                    local ZombieSound = config.zombieSounds[math.random(1, #config.zombieSounds)]
                    TriggerEvent('InteractSound_CL:PlayWithinDistance', PedCoords, 15, ZombieSound, 0.005)
                end
                if Distance <= 10 and Distance >= 4 then
                    local ZombieSound = config.zombieSounds[math.random(1, #config.zombieSounds)]
                    TriggerEvent('InteractSound_CL:PlayWithinDistance', PedCoords, 15, ZombieSound, 0.01)
                end
                if Distance <= 3 then
                    local ZombieSound = config.zombieSounds[math.random(1, #config.zombieSounds)]
                    TriggerEvent('InteractSound_CL:PlayWithinDistance', PedCoords, 15, ZombieSound, 0.05)
                end

                local isImune = pz_zombie.verifyImunePlayers()
                if not isImune then
                    if Distance <= config.defaultAttackDistance then
                        if not IsPedRagdoll(Zombie) and not IsPedGettingUp(Zombie) then
                            local health = GetEntityHealth(PlayerPedId())
                            if health <= 101 then
                                ClearPedTasks(Zombie)
                                TaskWanderStandard(Zombie, 10.0, 10)
                            else

                                RequestAnimSet('melee@unarmed@streamed_core_fps')
                                while not HasAnimSetLoaded('melee@unarmed@streamed_core_fps') do
                                    Citizen.Wait(1)
                                end

                                TaskPlayAnim(Zombie, 'melee@unarmed@streamed_core_fps', 'ground_attack_0_psycho', 8.0,
                                    1.0, -1, 48, 0.001, false, false, false)

                                if not IsPedInAnyVehicle(PlayerPedId()) then
                                    ApplyDamageToPed(PlayerPedId(), config.defaultAttackDamage, false)
                                end
                            end
                        end
                    end
                end

                if not NetworkGetEntityIsNetworked(Zombie) then
                    DeleteEntity(Zombie)
                end
            end

            if IsPedDeadOrDying(Zombie, true) and isDeadAlready[Zombie] == nil then

                if GetPedSourceOfDeath(Zombie) == PlayerPedId() then

                    local time = GetClockHours()
                    if time >= 18 and time <= 7 then
                        TriggerServerEvent('GENESEEExperience:addCL', math.random(80, 120))
                    else
                        TriggerServerEvent('GENESEEExperience:addCL', math.random(20, 60))
                    end

                    isDeadAlready[Zombie] = true
                end
            end

            Success, Zombie = FindNextPed(Handler)
        until not (Success)

        EndFindPed(Handler)
    end
end)

function LoadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(10)
        end
    end
end
