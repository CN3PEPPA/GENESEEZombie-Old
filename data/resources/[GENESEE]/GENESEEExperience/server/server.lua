local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

experience = {}
Tunnel.bindInterface("GENESEEExperience", experience)
Proxy.addInterface("GENESEEExperience", experience)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    TriggerEvent('GENESEEExperience:update')
end)

RegisterServerEvent("GENESEEExperience:update")
AddEventHandler('GENESEEExperience:update', function()
    updateXP()
end)

--
RegisterCommand("addxp", function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
    vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
    vRP.hasPermission(user_id, "suporte.permissao") then
        if args[2] then
            local nuser = vRP.getUserSource(parseInt(args[2]))
            TriggerEvent('GENESEEExperience:addSV', nuser, parseInt(args[1]), parseInt(args[2]))
        else
            TriggerEvent('GENESEEExperience:addSV', source, parseInt(args[1]), user_id)
        end
    end
 end)
--
RegisterCommand("remxp", function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
    vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
    vRP.hasPermission(user_id, "suporte.permissao") then
        if args[2] then
            local nuser = vRP.getUserSource(parseInt(args[2]))
            TriggerEvent('GENESEEExperience:remSV', nuser, parseInt(args[1]), parseInt(args[2]))
        else
            TriggerEvent('GENESEEExperience:remSV', source, parseInt(args[1]), user_id)
        end
    end
end)
--

-- SERVER > SERVER
RegisterServerEvent('GENESEEExperience:addSV')
AddEventHandler('GENESEEExperience:addSV', function(source, amount, user_idS)
    vRP.setExperience(user_idS, amount)

    TriggerClientEvent('XNL_NET:AddPlayerXP', source, amount)
end)

-- CLIENT > SERVER
RegisterServerEvent('GENESEEExperience:addCL')
AddEventHandler('GENESEEExperience:addCL', function(amount)
    local source = source
    local user_id = vRP.getUserId(source)

    vRP.setExperience(user_id, amount)

    TriggerClientEvent('XNL_NET:AddPlayerXP', source, amount)
end)

--

RegisterServerEvent('GENESEEExperience:remSV')
AddEventHandler('GENESEEExperience:remSV', function(source, amount, user_id)
    local sourceid = vRP.getUserSource(user_id)

    vRP.remExperience(user_id, amount)

    TriggerClientEvent('XNL_NET:RemovePlayerXP', sourceid, amount)
end)

RegisterServerEvent('GENESEEExperience:remSV2')
AddEventHandler('GENESEEExperience:remSV2', function(source, user_id, amount)
    vRP.remExperience(user_id, amount)

    TriggerClientEvent('XNL_NET:RemovePlayerXP', user_id, amount)
end)

--

RegisterServerEvent('GENESEEExperience:convert')
AddEventHandler('GENESEEExperience:convert', function()
    local source = source
    local user_id = vRP.getUserId(source)

    local level = vRP.getLevel(user_id)
    local exp = vRP.getExperience(user_id)

    if exp <= 799 then
        vRP.execute("vRP/convert_experience", {
            level = 1,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 800 then
        vRP.execute("vRP/convert_experience", {
            level = 2,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 2100 then
        vRP.execute("vRP/convert_experience", {
            level = 3,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 3800 then
        vRP.execute("vRP/convert_experience", {
            level = 4,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 6100 then
        vRP.execute("vRP/convert_experience", {
            level = 5,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 9500 then
        vRP.execute("vRP/convert_experience", {
            level = 6,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 12500 then
        vRP.execute("vRP/convert_experience", {
            level = 7,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 16000 then
        vRP.execute("vRP/convert_experience", {
            level = 8,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 19800 then
        vRP.execute("vRP/convert_experience", {
            level = 9,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 24000 then
        vRP.execute("vRP/convert_experience", {
            level = 10,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 28500 then
        vRP.execute("vRP/convert_experience", {
            level = 11,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 33400 then
        vRP.execute("vRP/convert_experience", {
            level = 12,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 38700 then
        vRP.execute("vRP/convert_experience", {
            level = 13,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 44200 then
        vRP.execute("vRP/convert_experience", {
            level = 14,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 50200 then
        vRP.execute("vRP/convert_experience", {
            level = 15,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 56400 then
        vRP.execute("vRP/convert_experience", {
            level = 16,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 63000 then
        vRP.execute("vRP/convert_experience", {
            level = 17,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 69900 then
        vRP.execute("vRP/convert_experience", {
            level = 18,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 77100 then
        vRP.execute("vRP/convert_experience", {
            level = 19,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 84700 then
        vRP.execute("vRP/convert_experience", {
            level = 20,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 92500 then
        vRP.execute("vRP/convert_experience", {
            level = 21,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 100700 then
        vRP.execute("vRP/convert_experience", {
            level = 22,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 109200 then
        vRP.execute("vRP/convert_experience", {
            level = 23,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 118000 then
        vRP.execute("vRP/convert_experience", {
            level = 24,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 127100 then
        vRP.execute("vRP/convert_experience", {
            level = 25,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 136500 then
        vRP.execute("vRP/convert_experience", {
            level = 26,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 146200 then
        vRP.execute("vRP/convert_experience", {
            level = 27,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 156200 then
        vRP.execute("vRP/convert_experience", {
            level = 28,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 166500 then
        vRP.execute("vRP/convert_experience", {
            level = 29,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 177100 then
        vRP.execute("vRP/convert_experience", {
            level = 30,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 188000 then
        vRP.execute("vRP/convert_experience", {
            level = 31,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 199200 then
        vRP.execute("vRP/convert_experience", {
            level = 32,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 210700 then
        vRP.execute("vRP/convert_experience", {
            level = 33,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 222400 then
        vRP.execute("vRP/convert_experience", {
            level = 34,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 234500 then
        vRP.execute("vRP/convert_experience", {
            level = 35,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 246800 then
        vRP.execute("vRP/convert_experience", {
            level = 36,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 259400 then
        vRP.execute("vRP/convert_experience", {
            level = 37,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 272300 then
        vRP.execute("vRP/convert_experience", {
            level = 38,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 285500 then
        vRP.execute("vRP/convert_experience", {
            level = 39,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 299000 then
        vRP.execute("vRP/convert_experience", {
            level = 40,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 312700 then
        vRP.execute("vRP/convert_experience", {
            level = 41,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 326800 then
        vRP.execute("vRP/convert_experience", {
            level = 42,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 341000 then
        vRP.execute("vRP/convert_experience", {
            level = 43,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 355600 then
        vRP.execute("vRP/convert_experience", {
            level = 44,
            id = user_id
        })
    end

    Wait(500)

    if exp >= 370500 then
        vRP.execute("vRP/convert_experience", {
            level = 45,
            id = user_id
        })
    end

end)

function updateXP()
    for _, playerId in ipairs(GetPlayers()) do

        Wait(300)
        local user_id = vRP.getUserId(playerId)
        local exp = vRP.getExperience(user_id)

        Wait(100)
        TriggerClientEvent('XNL_NET:XNL_SetInitialXPLevels', playerId, exp, true, true)
    end
end
