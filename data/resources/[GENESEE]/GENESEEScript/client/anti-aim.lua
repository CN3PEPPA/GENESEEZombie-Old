local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

local shot = false
local check = false
local check2 = false
local count = 0

function ManageReticle()
    local ped = GetPlayerPed(-1)
    local weapon = GetSelectedPedWeapon(ped)

    if DoesEntityExist(ped) and not IsEntityDead(ped) and weapon ~= 100416529 then
        HideHudComponentThisFrame(14)
    end
end

CreateThread(function()
    while true do
        ManageReticle()
        Wait(0)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if IsPlayerFreeAiming(PlayerId()) then
            if GetFollowPedCamViewMode() == 4 and check == false then
                check = false
            else
                SetFollowPedCamViewMode(4)
                check = true
            end
        else
            if check == true then
                SetFollowPedCamViewMode(1)
                check = false
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1)

        if IsPedShooting(GetPlayerPed(-1)) and shot == false and GetFollowPedCamViewMode() ~= 4 then
            check2 = true
            shot = true
            SetFollowPedCamViewMode(4)
        end

        if IsPedShooting(GetPlayerPed(-1)) and shot == true and GetFollowPedCamViewMode() == 4 then
            count = 0
        end

        if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
            count = count + 1
        end

        if not IsPedShooting(GetPlayerPed(-1)) and shot == true then
            if not IsPedShooting(GetPlayerPed(-1)) and shot == true and count > 20 then
                if check2 == true then
                    check2 = false
                    shot = false
                    SetFollowPedCamViewMode(1)
                end
            end
        end
    end
end)
