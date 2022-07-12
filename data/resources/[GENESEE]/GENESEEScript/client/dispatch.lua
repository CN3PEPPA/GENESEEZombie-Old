local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

script = {}
Tunnel.bindInterface("GENESEEScript", script)
Proxy.addInterface("GENESEEScript", script)

Citizen.CreateThread(function()
    for i = 1, 120 do
        EnableDispatchService(i, false)
    end
end)