local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
pesca = Tunnel.getInterface("pz_pesca")

CreateThread(function()
    while true do
        local source = source
        local user_id = vRP.getUserId(source)

        local player = PlayerPedId(-1)
        local inWater = IsEntityInWater(player)

        local idle = 1000

        if inWater then
            if pesca.checkItem() then
                if IsControlPressed(0, 38) then
                    if pesca.checkBait() then
                        TriggerServerEvent("fishing")
                    else
                        TriggerEvent("Notify", source, "aviso", "Você precisa ter isca para poder pescar.")
                    end
                end
            else
                TriggerEvent("Notify", source, "aviso", "Você precisa ter uma Vara de Pesca para poder pescar.")
            end
        end
        Wait(idle)
    end
end)
