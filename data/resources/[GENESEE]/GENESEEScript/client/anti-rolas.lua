local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

CreateThread(function()
    while true do
        Wait(5)
        if IsControlPressed(0, 25) then
            DisableControlAction(0, 22, true)
        end
    end
end)
