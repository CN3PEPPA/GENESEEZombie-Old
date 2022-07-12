local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

death = {}
Tunnel.bindInterface("pz_deathnotes", death)
Proxy.addInterface("pz_deathnotes", death)

local alreadyDead = false

CreateThread(function()
    while true do
        Wait(20)
        if GetGameTimer() > 15000 then
            for k, v in pairs(GetActivePlayers()) do
                N_0x31698aa80e0223f8(v)
            end
            local playerPed = PlayerPedId()
            if IsEntityDead(playerPed) and alreadyDead == false then
                local killer = GetPedKiller(playerPed)
                local killerId = 0
                for k, v in pairs(GetActivePlayers()) do
                    if killer == GetPlayerPed(v) then
                        killerId = GetPlayerServerId(v)
                        break
                    end
                end
                if killer == playerPed then
                    TriggerServerEvent('diedplayer', nil, nil)
                    alreadyDead = true
                elseif killerId and killerId ~= 0 then
                    TriggerServerEvent('diedplayer', tostring(killerId), 1)
                    alreadyDead = true
                else
                    TriggerServerEvent('diedplayer', nil, nil)
                    alreadyDead = true
                end
                alreadyDead = true
            end
            if not IsEntityDead(playerPed) and alreadyDead == true then
                alreadyDead = false
            end
        end
    end
end)
