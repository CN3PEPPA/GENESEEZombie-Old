local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
local Tools = module('vrp', 'lib/Tools')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

vRPN = {}
Tunnel.bindInterface('vrp_inventory', vRPN)
Proxy.addInterface('vrp_inventory', vRPN)
vRPCclient = Tunnel.getInterface('vrp_inventory')

local idgens = Tools.newIDGenerator()
local actived = {}
local pick = {}
local blips = {}

local using = false

function vRPN.Inventory()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local data = vRP.getUserDataTable(user_id)
        local inventory = {}

        if data and data.inventory then
            local tSlot = vRP.verifySlots(user_id)
            local fSlot = 18

            if tSlot ~= nil then
                tSlot = tSlot
            else
                tSlot = 11
            end

            if tSlot < fSlot then
                fSlot = fSlot - tSlot
            elseif tSlot >= fSlot then
                fSlot = 0
            end

            for k, v in pairs(data.inventory) do
                tSlot = tSlot - 1

                if vRP.itemBodyList(k) then
                    if tSlot >= 0 then
                        table.insert(inventory, {
                            amount = parseInt(v.amount),
                            name = vRP.itemNameList(k),
                            index = vRP.itemIndexList(k),
                            key = k,
                            type = vRP.itemTypeList(k),
                            peso = vRP.getItemWeight(k)
                        })
                    end
                end
            end

            return inventory, vRP.getInventoryWeight(user_id), vRP.getInventoryMaxWeight(user_id), parseInt(tSlot),
                parseInt(fSlot)
        end

    end
end

function vRPN.sendItem(itemName, type, amount)
    local source = source

    if itemName then
        local user_id = vRP.getUserId(source)
        local nplayer = vRPclient.getNearestPlayer(source, 3)
        local nuser_id = vRP.getUserId(nplayer)
        local identity = vRP.getUserIdentity(user_id)
        local identitynu = vRP.getUserIdentity(nuser_id)
        local tnSlot = 0

        if nuser_id then
            local data = vRP.getUserDataTable(nuser_id)
            local inventory = {}
            if data and data.inventory then
                tnSlot = vRP.verifySlots(nuser_id)
                if tnSlot ~= nil then
                    tnSlot = tnSlot
                else
                    tnSlot = 11
                end
                for k, v in pairs(data.inventory) do
                    tnSlot = tnSlot - 1
                    if vRP.itemBodyList(k) then
                        if tnSlot >= 0 then
                            table.insert(inventory, {
                                amount = parseInt(v.amount),
                                name = vRP.itemNameList(k),
                                index = vRP.itemIndexList(k),
                                key = k,
                                type = vRP.itemTypeList(k),
                                peso = vRP.getItemWeight(k)
                            })
                        end
                    end
                end
            end
        end

        if nuser_id and tnSlot > 0 and vRP.itemIndexList(itemName) then
            local x, y, z = vRPclient.getPosition(source)
            if parseInt(amount) > 0 then
                if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <=
                    vRP.getInventoryMaxWeight(nuser_id) then
                    if vRP.tryGetInventoryItem(user_id, itemName, amount) then
                        vRP.giveInventoryItem(nuser_id, itemName, amount)
                        vRPclient._playAnim(source, true, {{'mp_common', 'givetake1_a'}}, false)
                        PerformHttpRequest(config.webhookSend, function(err, text, headers)
                        end, 'POST', json.encode({
                            embeds = {{
                                title = 'REGISTRO DE ITEM ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                                thumbnail = {
                                    url = config.webhookIcon
                                },
                                fields = {{
                                    name = '**QUEM ENVIOU:**',
                                    value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                        '**]'
                                }, {
                                    name = '**ITEM ENVIADO:**',
                                    value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ][ **Quantidade: ' ..
                                        vRP.format(parseInt(amount)) .. '** ]'
                                }, {
                                    name = '**QUEM RECEBEU:**',
                                    value = '**' .. identitynu.name .. ' ' .. identitynu.firstname .. '** [**' ..
                                        nuser_id .. '**]\n⠀⠀'
                                }, {
                                    name = '**LOCAL: ' .. tD(x) .. ', ' .. tD(y) .. ', ' .. tD(z) .. '**',
                                    value = '⠀'
                                }},
                                footer = {
                                    text = config.webhookBottomText .. os.date('%d/%m/%Y |: %H:%M:%S'),
                                    icon_url = config.webhookIcon
                                },
                                color = config.webhookColor
                            }}
                        }), {
                            ['Content-Type'] = 'application/json'
                        })
                        TriggerClientEvent('itensNotify', source, 'sucesso', 'Enviou',
                            '' .. vRP.itemIndexList(itemName) .. '', '' .. vRP.format(parseInt(amount)) .. '',
                            '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')
                        TriggerClientEvent('itensNotify', nplayer, 'sucesso', 'Recebeu',
                            '' .. vRP.itemIndexList(itemName) .. '', '' .. vRP.format(parseInt(amount)) .. '',
                            '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')
                        vRPclient._playAnim(nplayer, true, {{'mp_common', 'givetake1_a'}}, false)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                        TriggerClientEvent('vrp_inventory:Update', nplayer, 'updateInventory')
                        return true
                    end
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Quantidade <b>inválida</b>.', 8000)
            end
        end
    end
    return false
end

function vRPN.sendItemMax(itemName, type)
    local source = source

    if itemName then
        local user_id = vRP.getUserId(source)
        local nplayer = vRPclient.getNearestPlayer(source, 3)
        local nuser_id = vRP.getUserId(nplayer)
        local identity = vRP.getUserIdentity(user_id)
        local identitynu = vRP.getUserIdentity(nuser_id)
        local tnSlot = 0
        local amount = vRP.getInventoryItemAmount(user_id, itemName)
        if nuser_id then
            local data = vRP.getUserDataTable(nuser_id)
            local inventory = {}
            if data and data.inventory then
                tnSlot = vRP.verifySlots(nuser_id)
                if tnSlot ~= nil then
                    tnSlot = tnSlot
                else
                    tnSlot = 11
                end
                for k, v in pairs(data.inventory) do
                    tnSlot = tnSlot - 1
                    if vRP.itemBodyList(k) then
                        if tnSlot >= 0 then
                            table.insert(inventory, {
                                amount = parseInt(v.amount),
                                name = vRP.itemNameList(k),
                                index = vRP.itemIndexList(k),
                                key = k,
                                type = vRP.itemTypeList(k),
                                peso = vRP.getItemWeight(k)
                            })
                        end
                    end
                end
            end
        end

        if nuser_id and tnSlot > 0 and vRP.itemIndexList(itemName) then
            local x, y, z = vRPclient.getPosition(source)
            if parseInt(amount) > 0 then
                if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <=
                    vRP.getInventoryMaxWeight(nuser_id) then
                    if vRP.tryGetInventoryItem(user_id, itemName, amount) then
                        vRP.giveInventoryItem(nuser_id, itemName, amount)
                        vRPclient._playAnim(source, true, {{'mp_common', 'givetake1_a'}}, false)
                        PerformHttpRequest(config.webhookSend, function(err, text, headers)
                        end, 'POST', json.encode({
                            embeds = {{
                                title = 'REGISTRO DE ITEM ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                                thumbnail = {
                                    url = config.webhookIcon
                                },
                                fields = {{
                                    name = '**QUEM ENVIOU:**',
                                    value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                        '**]'
                                }, {
                                    name = '**ITEM ENVIADO:**',
                                    value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ][ **Quantidade: ' ..
                                        vRP.format(parseInt(amount)) .. '** ]'
                                }, {
                                    name = '**QUEM RECEBEU:**',
                                    value = '**' .. identitynu.name .. ' ' .. identitynu.firstname .. '** [**' ..
                                        nuser_id .. '**]\n⠀⠀'
                                }, {
                                    name = '**LOCAL: ' .. tD(x) .. ', ' .. tD(y) .. ', ' .. tD(z) .. '**',
                                    value = '⠀'
                                }},
                                footer = {
                                    text = config.webhookBottomText .. os.date('%d/%m/%Y |: %H:%M:%S'),
                                    icon_url = config.webhookIcon
                                },
                                color = config.webhookColor
                            }}
                        }), {
                            ['Content-Type'] = 'application/json'
                        })
                        TriggerClientEvent('itensNotify', source, 'sucesso', 'Enviou',
                            '' .. vRP.itemIndexList(itemName) .. '', '' .. vRP.format(parseInt(amount)) .. '',
                            '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')
                        TriggerClientEvent('itensNotify', nplayer, 'sucesso', 'Recebeu',
                            '' .. vRP.itemIndexList(itemName) .. '', '' .. vRP.format(parseInt(amount)) .. '',
                            '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')
                        vRPclient._playAnim(nplayer, true, {{'mp_common', 'givetake1_a'}}, false)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                        TriggerClientEvent('vrp_inventory:Update', nplayer, 'updateInventory')
                        return true
                    end
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Quantidade <b>inválida</b>.', 8000)
            end
        end
    end
    return false
end

function vRPN.dropItem(itemName, type, amount)
    local source = source
    if itemName then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        local x, y, z = vRPclient.getPosition(source)
        if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id, itemName, amount) then
            TriggerEvent('DropSystem:create', itemName, amount, x, y, z, 3600)
            vRPclient._playAnim(source, true, {{'pickup_object', 'pickup_low'}}, false)
            PerformHttpRequest(config.webhookDrop, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = 'REGISTRO DE ITEM DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = '**QUEM DROPOU:**',
                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
                    }, {
                        name = '**ITEM DROPADO:**',
                        value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ][ **Quantidade: ' ..
                            vRP.format(parseInt(amount)) .. '** ]\n⠀⠀'
                    }, {
                        name = '**LOCAL: ' .. tD(x) .. ', ' .. tD(y) .. ', ' .. tD(z) .. '**',
                        value = '⠀'
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date('%d/%m/%Y | %H:%M:%S'),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })
            TriggerClientEvent('itensNotify', source, 'negado', 'Largou', '' .. vRP.itemIndexList(itemName) .. '',
                '' .. vRP.format(parseInt(amount)) .. '',
                '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')
            TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
            return true
        else
            TriggerClientEvent('Notify', source, 'negado', 'Quantidade <b>inválida</b>.', 8000)
        end
    end
    return false
end

function vRPN.dropItemMax(itemName, type)
    local source = source
    if itemName then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        local x, y, z = vRPclient.getPosition(source)
        local amount = vRP.getInventoryItemAmount(user_id, itemName)
        if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id, itemName, amount) then
            TriggerEvent('DropSystem:create', itemName, amount, x, y, z, 3600)
            vRPclient._playAnim(source, true, {{'pickup_object', 'pickup_low'}}, false)
            PerformHttpRequest(config.webhookDrop, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = 'REGISTRO DE ITEM DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = '**QUEM DROPOU:**',
                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
                    }, {
                        name = '**ITEM DROPADO:**',
                        value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ][ **Quantidade: ' ..
                            vRP.format(parseInt(amount)) .. '** ]\n⠀⠀'
                    }, {
                        name = '**LOCAL: ' .. tD(x) .. ', ' .. tD(y) .. ', ' .. tD(z) .. '**',
                        value = '⠀'
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date('%d/%m/%Y | %H:%M:%S'),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })
            TriggerClientEvent('itensNotify', source, 'negado', 'Largou', '' .. vRP.itemIndexList(itemName) .. '',
                '' .. vRP.format(parseInt(amount)) .. '',
                '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')
            TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
            return true
        else
            TriggerClientEvent('Notify', source, 'negado', 'Quantidade <b>inválida</b>.', 8000)
        end
    end
    return false
end

function vRPN.useItem(itemName, type, ramount)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
        if type == 'use' then

            -- ITENS DE MOCHILA
            if itemName == 'mochila_p' then
                if vRP.getInventoryMaxWeight(user_id) >= 51 then
                    TriggerClientEvent('Notify', source, 'negado', 'Você não pode equipar mais mochilas.', 8000)
                else
                    if vRP.tryGetInventoryItem(user_id, 'mochila_p', 1) then
                        TriggerClientEvent('vrp_inventory:fechar', source)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                        vRP.varyExp(user_id, 'physical', 'strength', 650)
                        if config.equipBackpack then
                            TriggerClientEvent('inventory:mochilaon', source, 'pequena')
                        end
                        TriggerClientEvent('itensNotify', source, 'use', 'Equipou', '' .. itemName .. '')
                    end
                end
            elseif itemName == 'mochila_m' then
                if vRP.getInventoryMaxWeight(user_id) >= 51 then
                    TriggerClientEvent('Notify', source, 'negado', 'Você não pode equipar mais mochilas.', 8000)
                else
                    if vRP.tryGetInventoryItem(user_id, 'mochila_m', 1) then
                        TriggerClientEvent('vrp_inventory:fechar', source)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                        vRP.varyExp(user_id, 'physical', 'strength', 1300)
                        if config.equipBackpack then
                            TriggerClientEvent('inventory:mochilaon', source, 'media')
                        end
                        TriggerClientEvent('itensNotify', source, 'use', 'Equipou', '' .. itemName .. '')
                    end
                end
            elseif itemName == 'mochila_g' then
                if vRP.getInventoryMaxWeight(user_id) >= 51 then
                    TriggerClientEvent('Notify', source, 'negado', 'Você não pode equipar mais mochilas.', 8000)
                else
                    if vRP.tryGetInventoryItem(user_id, 'mochila_g', 1) then
                        TriggerClientEvent('vrp_inventory:fechar', source)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                        vRP.varyExp(user_id, 'physical', 'strength', 1900)
                        if config.equipBackpack then
                            TriggerClientEvent('inventory:mochilaon', source, 'grande')
                        end
                        TriggerClientEvent('itensNotify', source, 'use', 'Equipou', '' .. itemName .. '')
                    end
                end

                -- ITENS DE CUSTOMIZAÇÃO
            elseif itemName == 'kit_barbeador' then
                if vRP.tryGetInventoryItem(user_id, 'kit_barbeador', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    TriggerClientEvent('pz_barbershop:openBarbershop', source)
                end
            elseif itemName == 'kit_tattoo' then
                if vRP.tryGetInventoryItem(user_id, 'kit_tattoo', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    TriggerClientEvent('dpn_tattoo:openTattoo', source)
                end
                -- ITENS DE ROUBOS
            elseif itemName == 'colete' then
                if vRP.tryGetInventoryItem(user_id, 'colete', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    vRPclient.setArmour(source, 100)
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    TriggerClientEvent('itensNotify', source, 'use', 'Equipou', '' .. itemName .. '')
                end
            elseif itemName == 'capuz' then
                if vRP.getInventoryItemAmount(user_id, 'capuz') >= 1 then
                    local nplayer = vRPclient.getNearestPlayer(source, 2)
                    if nplayer then
                        vRPclient.setCapuz(nplayer)
                        vRP.closeMenu(nplayer)
                        TriggerClientEvent('Notify', source, 'sucesso', 'Capuz utilizado com sucesso.', 8000)
                    end
                end
            elseif itemName == 'radio' then
                if vRP.getInventoryItemAmount(user_id, 'radio') >= 1 then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    TriggerClientEvent("vrp_radio:OpenNUI", source)
                end
            elseif itemName == 'silenciador' then
                if vRP.getInventoryItemAmount(user_id, 'silenciador') >= 1 then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    TriggerClientEvent("vrp_inventory:suppressor", source)
                end
            elseif itemName == 'lanterna' then
                if vRP.getInventoryItemAmount(user_id, 'lanterna') >= 1 then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    TriggerClientEvent("vrp_inventory:flashlight", source)
                end

                -- ITENS DE BEBIDAS
            elseif itemName == 'agua' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'agua', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_ld_flow_bottle', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -40)
                        vRP.giveInventoryItem(user_id, 'garrafa-vazia', 1)
                        vRPclient._deleteObject(src)
                    end)

                end
            elseif itemName == 'agua-impropria' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'agua-impropria', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_ld_flow_bottle', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, 80)
                        vRP.varyHunger(user_id, 80)
                        vRP.giveInventoryItem(user_id, 'garrafa-vazia', 1)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'leite' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'leite', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_ld_flow_bottle', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -65)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'limonada' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'limonada', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_energy_drink', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -45)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'refrigerante' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'refrigerante', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'ng_proc_sodacan_01a', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -20)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'cafe' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'cafe', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'prop_fib_coffee',
                        49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varySleep(user_id, -20)
                        vRP.varyThirst(user_id, -10)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'cerveja' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'cerveja', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_amb_beer_bottle', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -30)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'tequila' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'tequila', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_drink_whisky', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -10)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'vodka' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'vodka', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_drink_whisky', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -10)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'whisky' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'whisky', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_drink_whisky', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -10)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'conhaque' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'conhaque', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_drink_whisky', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -10)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'absinto' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'absinto', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_drink_whisky', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -10)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'energetico' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'energetico', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a',
                        'prop_energy_drink', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Bebendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, -40)
                        vRP.varySleep(user_id, -30)
                        vRPclient._deleteObject(src)
                    end)
                end

                -- ITENS DE COMIDA
            elseif itemName == 'pao' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'pao', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'mp_player_inteat@burger', 'mp_player_int_eat_burger',
                        'prop_sandwich_01', 49, 60309)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyHunger(user_id, -70)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'sanduiche' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'sanduiche', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'mp_player_inteat@burger', 'mp_player_int_eat_burger',
                        'prop_sandwich_01', 49, 60309)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyHunger(user_id, -85)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'chocolate' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'chocolate', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c',
                        'prop_choc_meto', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varySleep(user_id, -10)
                        vRP.varyHunger(user_id, -30)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'sardinha' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'sardinha', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c',
                        'prop_choc_meto', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyHunger(user_id, -25)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'feijao' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'feijao', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c',
                        'prop_choc_meto', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyHunger(user_id, -50)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'atum' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'atum', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c',
                        'prop_choc_meto', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyHunger(user_id, -25)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'arroz' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'arroz', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c',
                        'prop_choc_meto', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyHunger(user_id, -45)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'carne_cozida' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'carne_cozida', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c',
                        'prop_choc_meto', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyHunger(user_id, -70)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'carne_crua' then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'carne_crua', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c',
                        'prop_choc_meto', 49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'comendo')
                    TriggerClientEvent('itensNotify', source, 'use', 'Comendo', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        vRP.varyThirst(user_id, 80)
                        vRP.varyHunger(user_id, 80)
                        vRPclient._deleteObject(src)
                    end)
                end

                -- ITENS DE REMEDIOS
            elseif itemName == 'paracetamol' and vRPCclient.checkVida(source) then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'paracetamol', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'prop_cs_pills',
                        49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Tomando', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent('remedios', source)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'voltarem' and vRPCclient.checkVida(source) then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'voltarem', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'prop_cs_pills',
                        49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Tomando', '' .. itemName .. '')
                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent('remedios', source)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'tandrilax' and vRPCclient.checkVida(source) then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'tandrilax', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'prop_cs_pills',
                        49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Tomando', '' .. itemName .. '')
                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent('remedios', source)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'dorflex' and vRPCclient.checkVida(source) then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'dorflex', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'prop_cs_pills',
                        49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Tomando', '' .. itemName .. '')

                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent('remedios', source)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == 'buscopan' and vRPCclient.checkVida(source) then
                local src = source
                if vRP.tryGetInventoryItem(user_id, 'buscopan', 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, 'amb@world_human_drinking@beer@male@idle_a', 'idle_a', 'prop_cs_pills',
                        49, 28422)
                    TriggerClientEvent('progress', source, 10000, 'tomando')
                    TriggerClientEvent('itensNotify', source, 'use', 'Tomando', '' .. itemName .. '')
                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent('remedios', source)
                        vRPclient._deleteObject(src)
                    end)
                end
            elseif itemName == "bandagem" then
                local src = source
                if vRP.tryGetInventoryItem(user_id, "bandagem", 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, "amb@world_human_gardener_plant@male@idle_a", "idle_a", "prop_cs_pills",
                        49, 28422)
                    TriggerClientEvent("progress", source, 10000, "Enfaixando")
                    TriggerClientEvent('itensNotify', source, 'use', 'Enfaixando', '' .. itemName .. '')
                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent("bandagem", source)
                        vRPclient._deleteObject(src)
                        TriggerClientEvent("Notify", source, "sucesso", "Você se <b>Enfaixou</b>.")
                    end)
                end
            elseif itemName == "kit_medico" then
                local src = source
                if vRP.tryGetInventoryItem(user_id, "kit_medico", 1) then
                    TriggerClientEvent('vrp_inventory:fechar', source)
                    actived[user_id] = true
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    vRPclient._loadObject(src, "amb@world_human_gardener_plant@male@idle_a", "idle_a", "prop_cs_pills",
                        49, 28422)
                    TriggerClientEvent("progress", source, 10000, "Aplicando o tratamento")
                    TriggerClientEvent('itensNotify', source, 'use', 'Aplicando o tratamento', '' .. itemName .. '')
                    SetTimeout(10000, function()
                        actived[user_id] = nil
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent("medkit", source)
                        vRPclient._deleteObject(src)
                        TriggerClientEvent("Notify", source, "sucesso", "Você se <b>Curou</b>.")
                    end)
                end
            elseif itemName == 'blueprint' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEECraft:OpenNUI', source)
            elseif itemName == 'tesoura' then
                TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                if vRP.tryGetInventoryItem(user_id, "luvas", 1) then
                    vRP.giveInventoryItem(user_id, 'pano', 1)
                elseif vRP.tryGetInventoryItem(user_id, "jaqueta", 1) then
                    vRP.giveInventoryItem(user_id, 'pano', 2)
                elseif vRP.tryGetInventoryItem(user_id, "calca", 1) then
                    vRP.giveInventoryItem(user_id, 'pano', 2)
                elseif vRP.tryGetInventoryItem(user_id, "mascara", 1) then
                    vRP.giveInventoryItem(user_id, 'pano', 1)
                elseif vRP.tryGetInventoryItem(user_id, "blusa", 1) then
                    vRP.giveInventoryItem(user_id, 'pano', 2)
                elseif vRP.tryGetInventoryItem(user_id, "chapeu", 1) then
                    vRP.giveInventoryItem(user_id, 'pano', 1)
                end

                -- ITENS DE CONSTRUÇÃO
            elseif itemName == 'mout_base' then
                vRP.tryGetInventoryItem(user_id, '1', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base')
            elseif itemName == 'mout_base_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_02')
            elseif itemName == 'mout_base_03' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_03', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_03')
            elseif itemName == 'mout_base_large' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_large', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_large')
            elseif itemName == 'mout_base_large_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_large_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_large_02')
            elseif itemName == 'mout_base_raised' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_raised', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_raised')
            elseif itemName == 'mout_base_raised_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_raised_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_raised_02')
            elseif itemName == 'mout_base_raised_tall' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_raised_tall', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_raised_tall')
            elseif itemName == 'mout_base_raised_tall_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_base_raised_tall_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_base_raised_tall_02')
            elseif itemName == 'mout_shutter_wood' then
                vRP.tryGetInventoryItem(user_id, 'mout_shutter_wood', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_shutter_wood')
            elseif itemName == 'mout_shutter_metal' then
                vRP.tryGetInventoryItem(user_id, 'mout_shutter_metal', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_shutter_metal')
            elseif itemName == 'mout_int_light_01' then
                vRP.tryGetInventoryItem(user_id, 'mout_int_light_01', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_int_light_01')
            elseif itemName == 'mout_ext_stair' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_stair', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_stair')
            elseif itemName == 'mout_ext_steps' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_steps', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_steps')
            elseif itemName == 'mout_ext_cover_01' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_cover_01', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_cover_01')
            elseif itemName == 'mout_ext_cover_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_cover_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_cover_02')
            elseif itemName == 'mout_ext_cover_03' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_cover_03', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_cover_03')
            elseif itemName == 'mout_ext_cover_04' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_cover_04', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_cover_04')
            elseif itemName == 'mout_ext_cover_05' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_cover_05', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_cover_05')
            elseif itemName == 'mout_ext_cover_06' then
                vRP.tryGetInventoryItem(user_id, 'mout_ext_cover_06', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_ext_cover_06')
            elseif itemName == 'mout_cap_wall' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_wall', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_wall')
            elseif itemName == 'mout_cap_wall_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_wall_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_wall_02')
            elseif itemName == 'mout_cap_wall_03' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_wall_03', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_wall_03')
            elseif itemName == 'mout_cap_stair' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_stair', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_stair')
            elseif itemName == 'mout_cap_stair_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_stair_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_stair_02')
            elseif itemName == 'mout_cap_stair_03' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_stair_03', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_stair_03')
            elseif itemName == 'mout_cap_door_01' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_door_01', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_door_01')
            elseif itemName == 'mout_cap_door_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_door_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_door_02')
            elseif itemName == 'mout_cap_door_03' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_door_03', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_door_03')
            elseif itemName == 'mout_cap_door_04' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_door_04', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_door_04')
            elseif itemName == 'mout_cap_door_05' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_door_05', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_door_05')
            elseif itemName == 'mout_cap_door_06' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_door_06', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_door_06')
            elseif itemName == 'mout_cap_window_01' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_window_01', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_window_01')
            elseif itemName == 'mout_cap_window_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_window_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_window_02')
            elseif itemName == 'mout_cap_window_03' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_window_03', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_window_03')
            elseif itemName == 'mout_cap_window_04' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_window_04', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_window_04')
            elseif itemName == 'mout_cap_window_05' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_window_05', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_window_05')
            elseif itemName == 'mout_cap_garage_01' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_garage_01', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_garage_01')
            elseif itemName == 'mout_cap_garage_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_garage_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_garage_02')
            elseif itemName == 'mout_cap_garage_03' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_garage_03', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_garage_03')
            elseif itemName == 'mout_cap_garage_04' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_garage_04', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_garage_04')
            elseif itemName == 'mout_cap_garage_05' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_garage_05', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_garage_05')
            elseif itemName == 'mout_cap_garage_06' then
                vRP.tryGetInventoryItem(user_id, 'mout_cap_garage_06', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_cap_garage_06')
            elseif itemName == 'mout_mid_wall' then
                vRP.tryGetInventoryItem(user_id, 'mout_mid_wall', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_mid_wall')
            elseif itemName == 'mout_mid_wall_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_mid_wall_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_mid_wall_02')
            elseif itemName == 'mout_mid_door' then
                vRP.tryGetInventoryItem(user_id, 'mout_mid_door', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_mid_door')
            elseif itemName == 'mout_mid_door_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_mid_door_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_mid_door_02')
            elseif itemName == 'mout_mid_window' then
                vRP.tryGetInventoryItem(user_id, 'mout_mid_window', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_mid_window')
            elseif itemName == 'mout_mid_window_02' then
                vRP.tryGetInventoryItem(user_id, 'mout_mid_window_02', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'mout_mid_window_02')

            elseif itemName == 'barraca' then
                vRP.tryGetInventoryItem(user_id, 'barraca', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'barraca')
            elseif itemName == 'bau' then
                vRP.tryGetInventoryItem(user_id, 'bau', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('GENESEEBuilders:struct', source, 'bau')

            elseif itemName == 'epi_masc' then
                vRP.tryGetInventoryItem(user_id, 'epi_masc', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("indossa:hazmatman", source)
            elseif itemName == 'epi_fem' then
                vRP.tryGetInventoryItem(user_id, 'epi_fem', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("indossa:hazmatwoman", source)
            elseif itemName == 'antidote' then
                vRP.tryGetInventoryItem(user_id, 'bau', 1)
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent('rad:clear', source)

                -- ITENS DE ROUPAS
            elseif itemName == 'luvas' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "luvas")
            elseif itemName == 'jaqueta' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "jaqueta")
            elseif itemName == 'calca' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "calca")
            elseif itemName == 'mascara' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "mascara")
            elseif itemName == 'blusa' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "blusa")
            elseif itemName == 'sapatos' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "sapatos")
            elseif itemName == 'chapeu' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "chapeu")
            elseif itemName == 'oculos' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                TriggerClientEvent("openClothingMenu", source, "oculos")

                -- ITENS DE OBJETOS
            elseif itemName == 'presente_p' then
                if vRP.tryGetInventoryItem(user_id, 'presente_p', 1) then
                    TriggerEvent('pz_kits:open', "small", user_id)
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    TriggerClientEvent('Notify', source, 'sucesso', 'Você abriu um presente pequeno')
                end
            elseif itemName == 'presente_m' then
                if vRP.tryGetInventoryItem(user_id, 'presente_m', 1) then
                    TriggerEvent('pz_kits:open', "medium", user_id)
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    TriggerClientEvent('Notify', source, 'sucesso', 'Você abriu um presente médio')
                end
            elseif itemName == 'presente_g' then
                if vRP.tryGetInventoryItem(user_id, 'presente_g', 1) then
                    TriggerEvent('pz_kits:open', "big", user_id)
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    
                end
            elseif itemName == 'violao' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                if not using then
                    vRPclient._loadObject(source, "amb@world_human_musician@guitar@male@base", "base",
                        "prop_acc_guitar_01", 49, 60309)

                    using = true
                else
                    vRPclient._stopAnim(source, false)
                    vRPclient._deleteObject(source)

                    using = false
                end
            elseif itemName == 'vara_pesca' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                if not using then
                    vRPclient._loadObject(source, "amb@world_human_stand_fishing@idle_a", "idle_c",
                        "prop_fishing_rod_01", 49, 60309)

                    using = true
                else
                    vRPclient._stopAnim(source, false)
                    vRPclient._deleteObject(source)

                    using = false
                end
            elseif itemName == 'binoculo' then
                TriggerClientEvent('vrp_inventory:fechar', source)
                if not using then
                    vRPclient._loadObject(source, "amb@world_human_stand_fishing@idle_a", "idle_c",
                        "prop_fishing_rod_01", 49, 60309)

                    using = true
                else
                    vRPclient._stopAnim(source, false)
                    vRPclient._deleteObject(source)

                    using = false
                end
            end

            --
        elseif type == 'equip' then
            if not vRPCclient.checkHasWeapon(source, itemName) then
                if vRP.tryGetInventoryItem(user_id, itemName, 1) then
                    local weapons = {}
                    local identity = vRP.getUserIdentity(user_id)
                    weapons[string.gsub(itemName, 'wbody', '')] = {
                        ammo = 0
                    }
                    vRPclient._giveWeapons(source, weapons)
                    PerformHttpRequest(config.webhookEquip, function(err, text, headers)
                    end, 'POST', json.encode({
                        embeds = {{
                            title = 'REGISTRO DE ITEM EQUIPADO:\n⠀',
                            thumbnail = {
                                url = config.webhookIcon
                            },
                            fields = {{
                                name = '**QUEM EQUIPOU:**',
                                value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                    '**]'
                            }, {
                                name = '**ITEM EQUIPADO:**',
                                value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ]'
                            }},
                            footer = {
                                text = config.webhookBottomText .. os.date('%d/%m/%Y | %H:%M:%S'),
                                icon_url = config.webhookIcon
                            },
                            color = config.webhookColor
                        }}
                    }), {
                        ['Content-Type'] = 'application/json'
                    })
                    TriggerClientEvent('itensNotify', source, 'use', 'Equipou', '' .. vRP.itemIndexList(itemName) .. '')
                    TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você ja possui essa arma equipada')
            end
        elseif type == 'reloading' then
            local uweapons = vRPclient.getWeapons(source)
            local weaponuse = string.gsub(itemName, 'wammo', '')
            local weaponusename = 'wammo' .. weaponuse
            local identity = vRP.getUserIdentity(user_id)
            if uweapons[weaponuse] then
                local itemAmount = 0
                local data = vRP.getUserDataTable(user_id)
                for k, v in pairs(data.inventory) do
                    if weaponusename == k then
                        if v.amount > 250 then
                            v.amount = 250
                        end
                        itemAmount = v.amount
                        if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
                            local weapons = {}
                            local nameFix = string.gsub(itemName, '|', '-')
                            weapons[weaponuse] = {
                                ammo = v.amount
                            }
                            itemAmount = v.amount
                            vRPclient._giveWeapons(source, weapons, false)

                            PerformHttpRequest(config.webhookEquip, function(err, text, headers)
                            end, 'POST', json.encode({
                                embeds = {{
                                    title = 'REGISTRO DE ITEM EQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                                    thumbnail = {
                                        url = config.webhookIcon
                                    },
                                    fields = {{
                                        name = '**QUEM EQUIPOU:**',
                                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' ..
                                            user_id .. '**]'
                                    }, {
                                        name = '**ITEM EQUIPADO:**',
                                        value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ][ **Quantidade: ' ..
                                            vRP.format(parseInt(v.amount)) .. '** ]'
                                    }},
                                    footer = {
                                        text = config.webhookBottomText .. os.date('%d/%m/%Y | %H:%M:%S'),
                                        icon_url = config.webhookIcon
                                    },
                                    color = config.webhookColor
                                }}
                            }), {
                                ['Content-Type'] = 'application/json'
                            })

                            TriggerClientEvent('itensNotify', source, 'use', 'Recarregou', '' .. nameFix .. '')
                            TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                        end
                    end
                end
            end
        end
    end
end

function vRPN.getUserId()
    local source = source
    local user_id = vRP.getUserId(source)
    return user_id
end

AddEventHandler('vRP:playerLeave', function(user_id, source)
    actived[user_id] = nil
end)

RegisterCommand('garmas', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local rtime = math.random(3, 8)
    TriggerClientEvent('Notify', source, 'aviso', '<b>Aguarde!</b> Suas armas estão sendo desequipadas.', 9500)
    TriggerClientEvent('progress', source, 10000, 'guardando')
    SetTimeout(1000 * rtime, function()
        if user_id then
            local weapons = vRPclient.replaceWeapons(source, {})
            for k, v in pairs(weapons) do

                vRP.giveInventoryItem(user_id, 'wbody' .. k, 1)
                PerformHttpRequest(config.webhookUnequip, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{
                        title = 'REGISTRO DE ITEM DESEQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = '**QUEM DESEQUIPOU:**',
                            value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
                        }, {
                            name = '**ITEM EQUIPADO:**',
                            value = '[ **Item: ' .. k .. '** ][ **Quantidade: 1** ]'
                        }},
                        footer = {
                            text = config.webhookBottomText .. os.date('%d/%m/%Y | %H:%M:%S'),
                            icon_url = config.webhookIcon
                        },
                        color = config.webhookColor
                    }}
                }), {
                    ['Content-Type'] = 'application/json'
                })
                if v.ammo > 0 then
                    vRP.giveInventoryItem(user_id, 'wammo' .. k, v.ammo)
                    PerformHttpRequest(config.webhookUnequip, function(err, text, headers)
                    end, 'POST', json.encode({
                        embeds = {{
                            title = 'REGISTRO DE ITEM DESEQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                            thumbnail = {
                                url = config.webhookIcon
                            },
                            fields = {{
                                name = '**QUEM DESEQUIPOU:**',
                                value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                    '**]'
                            }, {
                                name = '**ITEM DESEQUIPADO:**',
                                value = '[ **Item: ' .. k .. '** ][ **Quantidade: ' .. vRP.format(parseInt(v.ammo)) ..
                                    '** ]'
                            }},
                            footer = {
                                text = config.webhookBottomText .. os.date('%d/%m/%Y | %H:%M:%S'),
                                icon_url = config.webhookIcon
                            },
                            color = config.webhookColor
                        }}
                    }), {
                        ['Content-Type'] = 'application/json'
                    })
                end
            end
            TriggerClientEvent('Notify', source, 'sucesso', 'Guardou seu armamento na mochila.')
        end
    end)
    SetTimeout(10000, function()
        TriggerClientEvent('Notify', source, 'sucesso', 'Guardou seu armamento na mochila.')
    end)
end)

function vRPN.armourOff()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local rtime = math.random(3, 5)

    if vRPclient.getArmour(source) <= 99 then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pode desequipar um <b>colete danificado</b>.')
    else
        if vRP.getInventoryWeight(user_id) + vRP.getItemWeight('colete') <= vRP.getInventoryMaxWeight(user_id) then
            TriggerClientEvent('notallowArmour', source)
            TriggerClientEvent('Notify', source, 'aviso', '<b>Aguarde!</b> Você está desequipando seu colete.', 9000)
            TriggerClientEvent('progress', source, 1000 * rtime, 'guardando')
            SetTimeout(1000 * rtime, function()
                PerformHttpRequest(config.webhookUnequip, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{
                        title = 'REGISTRO DE ITEM DESEQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = '**QUEM DESEQUIPOU:**',
                            value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
                        }, {
                            name = '**ITEM DESEQUIPADO:**',
                            value = '[ **Item: Colete** ][ **Quantidade: 1** ]'
                        }},
                        footer = {
                            text = config.webhookBottomText .. os.date('%d/%m/%Y | %H:%M:%S'),
                            icon_url = config.webhookIcon
                        },
                        color = config.webhookColor
                    }}
                }), {
                    ['Content-Type'] = 'application/json'
                })
                vRP.giveInventoryItem(user_id, 'colete', 1)
            end)
            SetTimeout(1000 * rtime + 2000, function()
                TriggerClientEvent('allowArmour', source)
            end)
        else
            TriggerClientEvent('Notify', source, 'negado', 'Espaço insuficiente na mochila.')
        end
    end
end

function vRPN.unEquip()
    local source = source
    local user_id = vRP.getUserId(source)
    local rtime = math.random(3, 8)

    if user_id then
        if vRP.getExp(user_id, 'physical', 'strength') == 1900 then -- 90Kg
            if vRP.getInventoryMaxWeight(user_id) - vRP.getInventoryWeight(user_id) >= 15 then
                if vRP.getRemaingSlots(user_id) > 18 then
                    TriggerClientEvent('progress', source, 10000, 'guardando')
                    TriggerClientEvent('Notify', source, 'aviso',
                        '<b>Aguarde!</b> Você está desequipando sua mochila.', 9000)
                    TriggerClientEvent('notallowBag', source)
                    TriggerClientEvent('inventory:mochilaoff', source)
                    SetTimeout(1000 * rtime, function()
                        vRP.varyExp(user_id, 'physical', 'strength', -1880)
                        vRP.giveInventoryItem(user_id, 'mochila_g', 1)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    end)
                    SetTimeout(10000, function()
                        TriggerClientEvent('Notify', source, 'sucesso', 'Você desequipou uma de suas mochilas.')
                        TriggerClientEvent('allowBag', source)
                    end)
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Sem espaço para fazer isso.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você precisa esvaziar a mochila antes de fazer isso.')
            end
        elseif vRP.getExp(user_id, 'physical', 'strength') == 1320 then -- 75Kg
            if vRP.getInventoryMaxWeight(user_id) - vRP.getInventoryWeight(user_id) >= 24 then
                if vRP.getRemaingSlots(user_id) > 12 then
                    TriggerClientEvent('progress', source, 10000, 'guardando')
                    TriggerClientEvent('Notify', source, 'aviso',
                        '<b>Aguarde!</b> Você está desequipando sua mochila.', 9000)
                    TriggerClientEvent('notallowBag', source)
                    TriggerClientEvent('inventory:mochilaoff', source)
                    SetTimeout(1000 * rtime, function()
                        vRP.varyExp(user_id, 'physical', 'strength', -1300)
                        vRP.giveInventoryItem(user_id, 'mochila_m', 1)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    end)
                    SetTimeout(10000, function()
                        TriggerClientEvent('Notify', source, 'sucesso', 'Você desequipou uma de suas mochilas.')
                        TriggerClientEvent('allowBag', source)
                    end)
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Sem espaço para fazer isso.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você precisa esvaziar a mochila antes de fazer isso.')
            end
        elseif vRP.getExp(user_id, 'physical', 'strength') == 670 then -- 51Kg
            if vRP.getInventoryMaxWeight(user_id) - vRP.getInventoryWeight(user_id) >= 45 then
                if vRP.getRemaingSlots(user_id) > 6 then
                    TriggerClientEvent('progress', source, 10000, 'guardando')
                    TriggerClientEvent('Notify', source, 'aviso',
                        '<b>Aguarde!</b> Você está desequipando sua mochila.', 9000)
                    TriggerClientEvent('notallowBag', source)
                    TriggerClientEvent('inventory:mochilaoff', source)
                    SetTimeout(1000 * rtime, function()
                        vRP.varyExp(user_id, 'physical', 'strength', -650)
                        vRP.giveInventoryItem(user_id, 'mochila_p', 1)
                        TriggerClientEvent('inventory:mochilaoff', source)
                        TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
                    end)
                    SetTimeout(10000, function()
                        TriggerClientEvent('itensNotify', source, 'use', 'Desequipou', 'Mochila')
                        TriggerClientEvent('allowBag', source)
                    end)
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Sem espaço para fazer isso.')
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Você precisa esvaziar a mochila antes de fazer isso.')
            end
        elseif vRP.getExp(user_id, 'physical', 'strength') == 20 then -- 6Kg
            TriggerClientEvent('Notify', source, 'negado', 'Você não tem mochilas equipadas.')
            return false
        end
    end
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
