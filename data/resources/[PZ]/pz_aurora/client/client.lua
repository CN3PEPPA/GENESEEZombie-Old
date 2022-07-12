local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPServer = Tunnel.getInterface("vRP")
aurora = {}
Tunnel.bindInterface("pz_aurora", aurora)
vSERVER = Tunnel.getInterface("pz_aurora")

function aurora.SendNuiMessage(functionName, functionParameters)
    SendNUIMessage({
        type = functionName,
        content = functionParameters
    })
end

function closeNUI()
    aurora.SendNuiMessage("showMenu", false)
    SetNuiFocus(false, false)
end

RegisterNUICallback("close", function()
    closeNUI()
end)

RegisterNetEvent("pz_aurora:openPriceMenu")
AddEventHandler("pz_aurora:openPriceMenu", function()
    SetNuiFocus(true, true)
    aurora.SendNuiMessage('showMenu', true)
end)