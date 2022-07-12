local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPc = Tunnel.getInterface("vRP")

passos = {}
Tunnel.bindInterface("GENESEECraft", passos)

function craft(src, item, retrying)
    local xPlayer = vRP.getUserId(src)
    local cancraft = true

    local count = Config.Recipes[item].Amount

    if not retrying then
        for k, v in pairs(Config.Recipes[item].Ingredients) do

            if vRP.getInventoryItemAmount(xPlayer, k) < v then
                cancraft = false
            end
        end
    end

    if Config.Recipes[item].Level <= vRP.getLevel(xPlayer) then
        if Config.Recipes[item].isGun then
            if cancraft then
                for k, v in pairs(Config.Recipes[item].Ingredients) do
                    if not Config.PermanentItems[k] then
                        vRP.tryGetInventoryItem(xPlayer, k, v)
                    end
                end
                vRPc._playAnim(src, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                TriggerClientEvent('canceling', src, true)
                TriggerClientEvent("GENESEECraft:craftStart", src, item, count)
            else
                TriggerClientEvent("Notify", src, 'aviso', Config.Text["not_enough_ingredients"])
            end
        else
            if cancraft then
                for k, v in pairs(Config.Recipes[item].Ingredients) do
                    vRP.tryGetInventoryItem(xPlayer, k, v)
                end
                vRPc._playAnim(src, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                TriggerClientEvent('canceling', src, true)
                TriggerClientEvent("GENESEECraft:craftStart", src, item, count)
            else
                TriggerClientEvent("Notify", src, 'aviso', Config.Text["not_enough_ingredients"])
            end
        end
    else
        TriggerClientEvent("Notify", src, 'aviso', Config.Text["not_level"])
    end
end

RegisterServerEvent("GENESEECraft:itemCrafted")
AddEventHandler("GENESEECraft:itemCrafted", function(item, count)
    local src = source
    local xPlayer = vRP.getUserId(src)

    if Config.Recipes[item].SuccessRate > math.random(0, Config.Recipes[item].SuccessRate) then
        if Config.Recipes[item].isGun then
            vRP.giveInventoryItem(xPlayer, item, 1)
        else
            vRP.giveInventoryItem(xPlayer, item, count)
        end
        vRPc._stopAnim(src, false)
        TriggerClientEvent('canceling', src, false)
        TriggerClientEvent("Notify", src, 'sucesso', Config.Text["item_crafted"])
    else
        TriggerClientEvent("Notify", src, 'aviso', Config.Text["crafting_failed"])
    end
end)

RegisterServerEvent("GENESEECraft:craft")
AddEventHandler("GENESEECraft:craft", function(item, retrying)
    local src = source
    craft(src, item, retrying)
end)

function passos.getXP()
    local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.getLevel(user_id)
    end
end

function passos.getInvPlayer()
    local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        local inventario = vRP.getInventory(user_id)
        for k, v in pairs(inventario) do
            return k, v.amount
        end
    end
end