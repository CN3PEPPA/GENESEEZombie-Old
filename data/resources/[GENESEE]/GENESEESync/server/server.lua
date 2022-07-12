local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

sync = {}
Tunnel.bindInterface("GENESEESync", sync)
Proxy.addInterface("GENESEESync", sync)

RegisterServerEvent("GENESEESync:trydeleteped")
AddEventHandler("GENESEESync:trydeleteped", function(index)
    TriggerClientEvent("GENESEESync:deleteped", -1, index)
end)

RegisterServerEvent("GENESEESync:trydeleteobj")
AddEventHandler("GENESEESync:trydeleteobj", function(index)
    TriggerClientEvent("GENESEESync:deleteobj", -1, index)
end)

RegisterServerEvent("GENESEESync:trydeleteveh")
AddEventHandler("GENESEESync:trydeleteveh", function(index)
    TriggerClientEvent("GENESEESync:deleteveh", -1, index)
end)

RegisterServerEvent("GENESEESync:tryrepair")
AddEventHandler("GENESEESync:tryrepair", function(nveh)
    TriggerClientEvent("GENESEESync:repair", -1, nveh)
end)

RegisterServerEvent("GENESEESync:trydoors")
AddEventHandler("GENESEESync:trydoors", function(veh, doors, placa)
    TriggerClientEvent("GENESEESync:doors", -1, veh, doors)
end)
