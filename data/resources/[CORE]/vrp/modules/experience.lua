function vRP.getLevel(user_id)
    local row = vRP.query("vRP/get_level", {
        user_id = user_id
    })

    return row[1].level
end

function vRP.getExperience(user_id)
    local row = vRP.query("vRP/get_experience", {
        user_id = user_id
    })

    return row[1].experience
end

function vRP.setExperience(user_id, amount)
    local exp = vRP.getExperience(user_id)
    local result = (exp + amount)

    vRP.execute("vRP/set_experience", {
        user_id = user_id,
        experience = result
    })
end

function vRP.remExperience(user_id, amount)
    local exp = vRP.getExperience(user_id)
    local result = (exp - amount)

    vRP.execute("vRP/set_experience", {
        user_id = user_id,
        experience = result
    })
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local exp = vRP.getExperience(user_id)
    Wait(1 * 1500)

    TriggerClientEvent('XNL_NET:XNL_SetInitialXPLevels', source, exp, true, true)
end)

AddEventHandler("vRP:playerJoin", function(user_id, source, name, last_login)
    local exp = vRP.getExperience(user_id)
    Wait(1 * 1500)

    TriggerClientEvent('XNL_NET:XNL_SetInitialXPLevels', source, exp, true, true)   
end)
