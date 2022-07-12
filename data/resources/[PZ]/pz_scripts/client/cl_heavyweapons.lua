local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

pz = Tunnel.getInterface("pz_scripts")

local weaponsBlacklist = {-1074790547, -2084633992, 487013001, 100416529}

CreateThread(function()
    while true do
        local player = PlayerPedId()
        local inWater = IsEntityInWater(player)
        local weapon = GetSelectedPedWeapon(player)
        local user_id = pz.checkUID()
        Wait(5)
        for _n, user in ipairs(config.users) do
            if user == user_id then
                for _, v in ipairs(weaponsBlacklist) do
                    if HasPedGotWeapon(player, v, false) then
                        print(true)
                        DisableControlAction(0, 21, true)
                        DisableControlAction(0, 22, true)
                        DisableControlAction(0, 25, true)
                        if IsPedShooting(player) then
                            RecoilFirstPersonMultiplier(5.0, 1.0)
                            RecoilThirdPersonMultiplier(15.0, 2.0)
                        end
                    end
                end
            end
        end
        Wait(5)
    end
end)

function RecoilFirstPersonMultiplier(FirstPersonMultiplier, FirstPersonAimingMultiplier)
    if GetFollowPedCamViewMode() == 4 then -- First Person
        local getwidthrecoil = GetGameplayCamRelativeHeading()
        local widthrecoil = math.random() + math.random() - math.random() - math.random()
        SetGameplayCamRelativeHeading(getwidthrecoil + widthrecoil * FirstPersonMultiplier)

        local getheightrecoil = GetGameplayCamRelativePitch()
        local heightrecoil = math.random() + math.random()
        SetGameplayCamRelativePitch(getheightrecoil + heightrecoil * FirstPersonMultiplier, 1.0)
        if IsControlPressed(0, 25) then -- RMB aim
            local getwidthrecoil = GetGameplayCamRelativeHeading()
            local widthrecoil = math.random() + math.random() - math.random() - math.random()
            SetGameplayCamRelativeHeading(getwidthrecoil + widthrecoil * FirstPersonAimingMultiplier)

            local getheightrecoil = GetGameplayCamRelativePitch()
            local heightrecoil = math.random() + math.random() + math.random() + math.random() + math.random()
            SetGameplayCamRelativePitch(getheightrecoil + heightrecoil * FirstPersonAimingMultiplier, 1.0)
            Citizen.Wait(0)
        end
    end
end

function RecoilThirdPersonMultiplier(ThirdPersonMultiplier, ThirdPersonAimingMultiplier)
    if GetFollowPedCamViewMode() ~= 4 then -- Not First Person
        local getwidthrecoil = GetGameplayCamRelativeHeading()
        local widthrecoil = math.random() + math.random() - math.random() - math.random()
        SetGameplayCamRelativeHeading(getwidthrecoil + widthrecoil * ThirdPersonMultiplier)

        local getheightrecoil = GetGameplayCamRelativePitch()
        local heightrecoil = math.random() + math.random()
        SetGameplayCamRelativePitch(getheightrecoil + heightrecoil * ThirdPersonMultiplier, 1.0)
        if IsControlPressed(0, 25) then -- RMB aim
            local getwidthrecoil = GetGameplayCamRelativeHeading()
            local widthrecoil = math.random() + math.random() - math.random() - math.random()
            SetGameplayCamRelativeHeading(getwidthrecoil + widthrecoil * ThirdPersonAimingMultiplier)

            local getheightrecoil = GetGameplayCamRelativePitch()
            local heightrecoil = math.random() + math.random()
            SetGameplayCamRelativePitch(getheightrecoil + heightrecoil * ThirdPersonAimingMultiplier, 1.0)
            Citizen.Wait(0)
        end
    end
end

function RecoilThirdPersonInCarMultiplier(ThirdPersonInCarMultiplier)
    local getwidthrecoil = GetGameplayCamRelativeHeading()
    local widthrecoil = math.random() + math.random() - math.random() - math.random()
    SetGameplayCamRelativeHeading(getwidthrecoil + widthrecoil * ThirdPersonInCarMultiplier)

    local getheightrecoil = GetGameplayCamRelativePitch()
    local heightrecoil = math.random() + math.random()
    SetGameplayCamRelativePitch(getheightrecoil + heightrecoil * ThirdPersonInCarMultiplier, 1.0)
end

function RecoilFirstPersonInCarMultiplier(FirstPersonInCarMultiplier)
    local getwidthrecoil = GetGameplayCamRelativeHeading()
    local widthrecoil = math.random() + math.random() - math.random() - math.random()
    SetGameplayCamRelativeHeading(getwidthrecoil + widthrecoil * FirstPersonInCarMultiplier)
    -- Doesnt work hence side ways recoil increased
    --[[local getheightrecoil = GetGameplayCamRelativePitch()
local heightrecoil = math.random() + math.random()
SetGameplayCamRelativePitch(getheightrecoil + heightrecoil * FirstPersonInCarMultiplier, 1.0)--]]
end
