function vRP.getWeight(user_id)
    local row = vRP.query("vRP/get_weight", {
        user_id = user_id
    })

    local weightChest

    if row[1].type == 'small' then
        weightChest = 200
    elseif row[1].type == 'medium' then
        weightChest = 750
    elseif row[1].type == 'big' then
        weightChest = 2000
    end

    return weightChest
end

function vRP.getSlot(user_id)
    local weightChest = vRP.getWeight(user_id)

    local slootChest

    if weightChest == 200 then
        slootChest = 50
    elseif weightChest == 750 then
        slootChest = 100
    elseif weightChest == 2000 then
        slootChest = 250
    end

    return slootChest
end
