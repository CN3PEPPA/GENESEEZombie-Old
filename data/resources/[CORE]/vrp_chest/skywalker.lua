local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

chest = {}
Tunnel.bindInterface("vrp_chest", chest)
Proxy.addInterface("vrp_chest", chest)

function chest.openChest(chestName)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local hsinventory = {}
        local myinventory = {}
        local data = vRP.getSDataChest(tostring(chestName))
        local result = json.decode(data) or {}
        local tcSlot = chest.verifyChestSlots(user_id, chestName)
        local tSlot = vRP.verifySlots(user_id)

        local weight = vRP.getWeight(chestName)
        local sloot = vRP.getSlot(chestName)

        if result then
            if tcSlot ~= nil then
                tcSlot = tcSlot
            else
                tcSlot = 11
            end
            if tSlot ~= nil then
                tSlot = tSlot
            else
                tSlot = 11
            end
            for k, v in pairs(result) do
                tcSlot = tcSlot - 1
                if vRP.itemBodyList(k) then
                    if tcSlot >= 0 then
                        table.insert(hsinventory, {
                            amount = parseInt(v.amount),
                            name = vRP.itemNameList(k),
                            index = vRP.itemIndexList(k),
                            key = k,
                            peso = vRP.getItemWeight(k)
                        })
                    end
                end
            end
            local inv = vRP.getInventory(parseInt(user_id))
            for k, v in pairs(inv) do
                if vRP.itemBodyList(k) then
                    tSlot = tSlot - 1
                    table.insert(myinventory, {
                        amount = parseInt(v.amount),
                        name = vRP.itemNameList(k),
                        index = vRP.itemIndexList(k),
                        key = k,
                        peso = vRP.getItemWeight(k)
                    })
                end
            end
        end

        return hsinventory, myinventory, vRP.getInventoryWeight(user_id), vRP.getInventoryMaxWeight(user_id),
            vRP.computeItemsWeight(result), weight, parseInt(tSlot), parseInt(tcSlot)
    end
    return false
end

function chest.verifyChestSlots(user_id, chestName)
    local sloot = vRP.getSlot(user_id)
    return sloot
end

function chest.haveMoreChestSlots(chestName)
    local chestData = tostring(chestName)
    if vRP.getRemaingChestSlots(chestData, chest.verifyChestSlots(chestName)) > 0 then
        return true
    else
        return false
    end
end

function chest.storeItem(chestName, itemName, amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)

        if user_id then

            local weight = vRP.getWeight(user_id)
            local sloot = vRP.getSlot(user_id)

            if vRP.storeChestItem(user_id, tostring(chestName), itemName, amount, weight, sloot) then

                TriggerClientEvent('Chest:updateChest', source, 'updateChest')
                TriggerClientEvent('itensNotify', source, 'negado', 'Guardou', '' .. vRP.itemIndexList(itemName) .. '',
                    '' .. vRP.format(parseInt(amount)) .. '',
                    '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')

            end

            PerformHttpRequest(config.webhooksend, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = 'REGISTRO DE BAÚ:\n⠀',
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = '**QUEM GUARDOU:**',
                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
                    }, {
                        name = '**ITEM GUARDADO:**',
                        value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ][ **Quantidade: ' .. parseInt(amount) ..
                            '** ]\n⠀⠀'
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
end

function chest.takeItem(chestName, itemName, amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if user_id then
            if vRP.tryChestItem(user_id, tostring(chestName), itemName, amount) then

                TriggerClientEvent('Chest:updateChest', source, 'updateChest')
                TriggerClientEvent('itensNotify', source, 'sucesso', 'Pegou', '' .. vRP.itemIndexList(itemName) .. '',
                    '' .. vRP.format(parseInt(amount)) .. '',
                    '' .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. '')

                PerformHttpRequest(config.webhookremoved, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{
                        title = 'REGISTRO DE BAÚ:\n⠀',
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = '**QUEM RETIROU:**',
                            value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
                        }, {
                            name = '**ITEM RETIRADO:**',
                            value = '[ **Item: ' .. vRP.itemNameList(itemName) .. '** ][ **Quantidade: ' ..
                                parseInt(amount) .. '** ]\n⠀⠀'
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
    end
end

RegisterServerEvent('vrp_chest:unlockChest')
AddEventHandler('vrp_chest:unlockChest', function(entity, x, y, z)
    local source = source
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/select_user_buildings')
    
    for k, v in pairs(rows) do
        if rows[k].user_id == user_id then
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) == string.format("%.0f", y) then
                TriggerClientEvent('Notify', source, 'negado', 'O baú pertence a você')
            end
        else
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) == string.format("%.0f", y) then
                if vRP.tryGetInventoryItem(user_id, "lockpick", 1) then
                    local chances = math.random(0,100)

                    vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
                    TriggerClientEvent("progress", source, 30000, "Arrombando")

                    Wait(30000)
                    vRPclient._stopAnim(source, false)
                    if chances <= 5 then
                        TriggerClientEvent('Notify', source, 'sucesso', 'Você arrombou o baú')
                        TriggerClientEvent('vrp_chest:use', source, rows[k].user_id)
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'A ferramenta quebrou')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Você não possui uma lockpick')
                end
            end
        end
    end
end)

RegisterServerEvent('vrp_chest:openChest')
AddEventHandler('vrp_chest:openChest', function(x, y, z)
    local source = source
    local user_id = vRP.getUserId(source)

    local pass
    local rows = vRP.query('vRP/select_user_buildings')

    for k, v in pairs(rows) do
        if rows[k].user_id == user_id then
            if not rows[k].pass or rows[k].pass == nil or rows[k].pass == '' then
                local pass = vRP.prompt(source, "Escolha uma Senha:", "")
                if pass and pass ~= nil and pass ~= '' then
                    local rows = vRP.query('vRP/set_pass_user_buildings', {
                        pass = pass,
                        user_id = rows[k].user_id
                    })
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Senha inválida')
                end
            end
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) ==
                string.format("%.0f", y) then
                TriggerClientEvent('vrp_chest:use', source, rows[k].user_id)
            end
        else
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) ==
                string.format("%.0f", y) then
                local pass = vRP.prompt(source, "Senha:", "")
                if pass and pass ~= nil and pass ~= '' then
                    if rows[k].pass == pass then
                        TriggerClientEvent('vrp_chest:use', source, rows[k].user_id)
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Você errou a senha.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Senha inválida')
                end
            end
        end
    end
end)

RegisterNetEvent('vrp_chest:destroyChest')
AddEventHandler('vrp_chest:destroyChest', function(entity, object, x, y, z)
    local source = source
    local user_id = vRP.getUserId(source)

    local rows = vRP.query('vRP/select_user_buildings')

    for k, v in pairs(rows) do
        if rows[k].user_id == user_id then
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) ==
                string.format("%.0f", y) and string.format("%.0f", rows[k].z) == string.format("%.0f", z) then
                local request = vRP.request(source,
                    'Ao fazer isso, este baú será abandonado e não poderá mais ser acessado, deseja continuar?', 60)
                if request then
                    TriggerEvent('BM:demolishUserBuilding', entity, '1268754372', object, rows[k].user_id, x,y,z)
                    TriggerClientEvent('Notify', source, 'sucesso','O baú foi abandonado e será removido pela tempestade.')
                end
            end
        end
    end
end)

RegisterNetEvent('vrp_chest:upgradeChest')
AddEventHandler('vrp_chest:upgradeChest', function(entity, x, y, z)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    local rows = vRP.query('vRP/select_user_buildings')

    for k, v in pairs(rows) do
        if rows[k].user_id == user_id then
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) ==
                string.format("%.0f", y) and string.format("%.0f", rows[k].z) == string.format("%.0f", z) then
                local request = vRP.request(source,
                    'Você esta preste a fazer um upgrade no bau, alguns itens será consumidos, tem certeza disso?',
                    120)
                if request then
                    if rows[k].type == 'small' then

                        if vRP.getInventoryItemAmount(user_id, 'tabua') >= 20 and
                            vRP.getInventoryItemAmount(user_id, 'fragmento_metal') >= 120 and
                            vRP.getInventoryItemAmount(user_id, 'chapa_metal') >= 15 then

                            local rows = vRP.query('vRP/set_upgrade_user_buildings', {
                                type = 'medium',
                                user_id = rows[k].user_id,
                                dtype = 'small'
                            })

                            vRP.tryGetInventoryItem(user_id, 'tabua', 20)
                            vRP.tryGetInventoryItem(user_id, 'fragmento_metal', 120)
                            vRP.tryGetInventoryItem(user_id, 'chapa_metal', 15)

                            PerformHttpRequest(config.webhookupgrade, function(err, text, headers)
                            end, 'POST', json.encode({
                                embeds = {{
                                    title = 'REGISTRO DE UPGRADE BAÚ:\n⠀',
                                    thumbnail = {
                                        url = config.webhookIcon
                                    },
                                    fields = {{
                                        name = '**QUEM FEZ O UPGRADE:**',
                                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' ..
                                            user_id .. '**]'
                                    }, {
                                        name = '**INFO**',
                                        value = '** FEZ O UPGRADE DO BAU PEQUENO PARA O BAU MÉDIO **'
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
                            TriggerClientEvent('Notify', source, 'sucesso', 'Upgrade feito com sucesso.')
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Você precisa de <p> 20x tábuas</p>')
                            TriggerClientEvent('Notify', source, 'negado',
                                'Você precisa de <p> 120x fragmento de metal</p>')
                            TriggerClientEvent('Notify', source, 'negado', 'Você precisa de <p> 15x chapa de metal</p>')
                        end
                    elseif rows[k].type == 'medium' then

                        if vRP.getInventoryItemAmount(user_id, 'tabua') >= 45 and
                            vRP.getInventoryItemAmount(user_id, 'fragmento_metal') >= 275 and
                            vRP.getInventoryItemAmount(user_id, 'chapa_metal') >= 40 then

                            local rows = vRP.query('vRP/set_upgrade_user_buildings', {
                                type = 'big',
                                user_id = rows[k].user_id,
                                dtype = 'medium'
                            })

                            vRP.tryGetInventoryItem(user_id, 'tabua', 45)
                            vRP.tryGetInventoryItem(user_id, 'fragmento_metal', 275)
                            vRP.tryGetInventoryItem(user_id, 'chapa_metal', 40)

                            PerformHttpRequest(config.webhookupgrade, function(err, text, headers)
                            end, 'POST', json.encode({
                                embeds = {{
                                    title = 'REGISTRO DE UPGRADE BAÚ:\n⠀',
                                    thumbnail = {
                                        url = config.webhookIcon
                                    },
                                    fields = {{
                                        name = '**QUEM FEZ O UPGRADE:**',
                                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' ..
                                            user_id .. '**]'
                                    }, {
                                        name = '**INFO**',
                                        value = '** FEZ O UPGRADE DO BAU MÉDIO PARA O BAU GRANDE **'
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
                            TriggerClientEvent('Notify', source, 'sucesso', 'Upgrade feito com sucesso.')
                        else
                            TriggerClientEvent('Notify', source, 'negado', 'Você precisa de <p> 45x tábuas</p>')
                            TriggerClientEvent('Notify', source, 'negado',
                                'Você precisa de <p> 275x fragmento de metal</p>')
                            TriggerClientEvent('Notify', source, 'negado', 'Você precisa de <p> 40x chapa de metal</p>')
                        end
                    elseif rows[k].type == 'big' then
                        TriggerClientEvent('Notify', source, 'negado', 'O upgrade ja esta no maximo!.')
                    end
                end
            end
        else
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) ==
                string.format("%.0f", y) and string.format("%.0f", rows[k].z) == string.format("%.0f", z) then
                TriggerClientEvent('Notify', source, 'negado', 'Esse baú não pertence a você.')
            end
        end
    end
end)

RegisterServerEvent('vrp_chest:resetChest')
AddEventHandler('vrp_chest:resetChest', function(entity, x, y, z)
    local source = source
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/select_user_buildings')
    local backup = vRP.query('vRP/get_chest_backup')
    for k, v in pairs(rows) do
        if rows[k].user_id == user_id then
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) == string.format("%.0f", y) then
                if backup[1] then
                    for _, backupContext in pairs(backup) do
                        if backupContext.user_id and backupContext.user_id == user_id then
                            vRP.query('vRP/set_chest_backup', {
                                value = backupContext.value,
                                user_id = backupContext.user_id
                            })
                            Wait(20)
                            vRP.query('vRP/delete_chest_backup', {
                                user_id = backupContext.user_id
                            })
                            TriggerClientEvent('Notify', source, 'sucesso', 'O conteúdo do baú foi restaurado com sucesso.')
                        end
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Não existem registros salvos')
                end
            end
        else
            if string.format("%.0f", rows[k].x) == string.format("%.0f", x) and string.format("%.0f", rows[k].y) == string.format("%.0f", y) then
                TriggerClientEvent('Notify', source, 'negado', 'O baú não pertence a você')
            end
        end
    end
end)

-- TODO: Backup system
-- AddEventHandler('onResourceStop', function(resourceName)
--     if (GetCurrentResourceName() ~= resourceName) then
--       return
--     end
--     local chests = vRP.query('vRP/select_user_buildings')
--     local reset = vRP.query('vRP/delete_all_backup')
--     for _, chest in pairs(chests) do
--         vRP.query('vRP/save_chest_backup', {
--             value = chest.value,
--             user_id = chest.user_id
--         })
--         Wait(5)
--     end
-- end)
  
