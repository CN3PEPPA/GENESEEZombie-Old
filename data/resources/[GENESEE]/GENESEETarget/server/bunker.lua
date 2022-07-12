local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

target = {}
Tunnel.bindInterface("GENESEETarget", target)
Proxy.addInterface("GENESEETarget", target)

RegisterNetEvent('GENESEETarget:BunkerSV')
AddEventHandler('GENESEETarget:BunkerSV', function()
    local source = source
    local user_id = vRP.getUserId(source)

    local pass = vRP.prompt(source, "Digite a Senha:", "")
    if pass and pass ~= nil and pass ~= '' then
        if Config.Passsword == pass then
            TriggerClientEvent("Notify", source, "sucesso", "Você abriu o bunker com sucesso.")
        else
            TriggerClientEvent("Notify", source, "negado", "Você errou a senha.")
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Você errou a senha.")
    end
end)
