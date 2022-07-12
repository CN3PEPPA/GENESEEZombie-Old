local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        if not IsEntityInWater(ped) then
            if GetEntityHealth(ped) <= 199 then
                setHurt()
            elseif hurt and GetEntityHealth(ped) > 200 then
                setNotHurt()
            end
        end
        Citizen.Wait(idle)
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    DisableControlAction(0, 21)
    DisableControlAction(0, 22)
end

function setNotHurt()
    hurt = false
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end
