local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

inspect = {}
Tunnel.bindInterface("vrp_inspect", inspect)
Proxy.addInterface("vrp_inspect", inspect)

inspectCL = Tunnel.getInterface('vrp_inspect')

local opened = {}
local plunder = false

RegisterCommand(config.inspectCommand, function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local x, y, z = vRPclient.getPosition(source)
    if user_id then
        if vRPclient.getHealth(source) >= 102 then
            local nplayer = vRPclient.getNearestPlayer(source, 2)
            if nplayer then
                local nuser_id = vRP.getUserId(nplayer)
                local identitynu = vRP.getUserIdentity(nuser_id)
                if vRPclient.getHealth(nplayer) >= 102 and not inspectCL.inVehicle(nplayer) and
                    not inspectCL.inVehicle(source) then
                    local h = inspectCL.entityHeading(source)
                    local request = vRP.request(nplayer, 'Solicitação de revista! Deseja cooperar?', 60)
                    if request then
                        vRPclient._playAnim(source, true, {{config.inspectAnim[1], config.inspectAnim[2]}}, true)
                        vRPclient._playAnim(nplayer, true, {{config.nuInspectAnim[1], config.nuInspectAnim[2]}}, true)
                        TriggerClientEvent('canceling', nplayer, true)
                        local weapons = vRPclient.replaceWeapons(nplayer, {})
                        for k, v in pairs(weapons) do
                            vRP.giveInventoryItem(parseInt(nuser_id), 'wbody' .. k, 1)
                            if parseInt(v.ammo) > 0 then
                                vRP.giveInventoryItem(parseInt(nuser_id), 'wammo' .. k, parseInt(v.ammo))
                            end
                        end
                        inspectCL.toggleCarry(nplayer, source)
                        PerformHttpRequest(config.webhookInspect, function(err, text, headers)
                        end, 'POST', json.encode({
                            embeds = {{
                                title = 'REGISTRO DE REVISTAR:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                                thumbnail = {
                                    url = config.webhookIcon
                                },
                                fields = {{
                                    name = '**QUEM ESTÁ REVISTANDO:**',
                                    value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                        '**]'
                                }, {
                                    name = '**QUEM ESTÁ SENDO REVISTADO:**',
                                    value = '**' .. identitynu.name .. ' ' .. identitynu.firstname .. '** [**' ..
                                        nuser_id .. '**]\n⠀⠀'
                                }, {
                                    name = '**LOCAL: ' .. tD(x) .. ', ' .. tD(y) .. ', ' .. tD(z) .. '**',
                                    value = '⠀'
                                }},
                                footer = {
                                    text = config.webhookBottom .. os.date('%d/%m/%Y | %H:%M:%S'),
                                    icon_url = config.webhookIcon
                                },
                                color = config.webhookColor
                            }}
                        }), {
                            ['Content-Type'] = 'application/json'
                        })
                        opened[parseInt(user_id)] = parseInt(nuser_id)
                        inspectCL.openInspect(source)
                    else
                        TriggerClientEvent('Notify', source, 'negado', 'Revista negada! A pessoa não quer cooperar.',
                            5000)
                    end
                end
            end
        end
    end
end)

RegisterCommand(config.plunderCommand, function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local x, y, z = vRPclient.getPosition(source)
    if user_id then
        if vRPclient.getHealth(source) >= 102 and not inspectCL.inVehicle(source) then
            local nplayer = vRPclient.getNearestPlayer(source, 2)
            if nplayer then
                local nuser_id = vRP.getUserId(nplayer)
                local identitynu = vRP.getUserIdentity(nuser_id)
                if vRPclient.getHealth(nplayer) <= 102 then
                    local weapons = vRPclient.replaceWeapons(nplayer, {})
                    TriggerClientEvent('canceling', nplayer, true)
                    for k, v in pairs(weapons) do
                        vRP.giveInventoryItem(parseInt(nuser_id), 'wbody' .. k, 1)
                        if parseInt(v.ammo) > 0 then
                            vRP.giveInventoryItem(parseInt(nuser_id), 'wammo' .. k, parseInt(v.ammo))
                        end
                    end
                    vRPclient._playAnim(source, false, {{config.plunderAnim[1], config.plunderAnim[2]}}, true)
                    PerformHttpRequest(config.webhookPlunder, function(err, text, headers)
                    end, 'POST', json.encode({
                        embeds = {{
                            title = 'REGISTRO DE SAQUEAR:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                            thumbnail = {
                                url = config.webhookIcon
                            },
                            fields = {{
                                name = '**QUEM ESTÁ SAQUEANDO:**',
                                value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                    '**]'
                            }, {
                                name = '**QUEM ESTÁ SENDO SAQUEADO:**',
                                value = '**' .. identitynu.name .. ' ' .. identitynu.firstname .. '** [**' .. nuser_id ..
                                    '**]\n⠀⠀'
                            }, {
                                name = '**LOCAL: ' .. tD(x) .. ', ' .. tD(y) .. ', ' .. tD(z) .. '**',
                                value = '⠀'
                            }},
                            footer = {
                                text = config.webhookBottom .. os.date('%d/%m/%Y | %H:%M:%S'),
                                icon_url = config.webhookIcon
                            },
                            color = config.webhookColor
                        }}
                    }), {
                        ['Content-Type'] = 'application/json'
                    })
                    opened[parseInt(user_id)] = parseInt(nuser_id)
                    inspectCL.openInspect(source)
                    plunder = true
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Essa pessoa não está em coma.', 5000)
                end
            end
        end
    end
end)

slotsuser = 0
slotsnuser = 0

function inspect.openChest()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local ninventory = {}
        local uinventory = {}
        local tcSlot = vRP.verifySlots(user_id)
        local tSlot = vRP.verifySlots(parseInt(opened[user_id]))

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

        local inv = vRP.getInventory(parseInt(opened[user_id]))
        if inv then
            for k, v in pairs(inv) do
                if vRP.itemBodyList(k) then
                    tSlot = tSlot - 1
                    table.insert(ninventory, {
                        amount = parseInt(v.amount),
                        name = vRP.itemNameList(k),
                        index = vRP.itemIndexList(k),
                        key = k,
                        peso = vRP.getItemWeight(k)
                    })
                end
            end
        end

        slotsuser = tSlot

        local inv2 = vRP.getInventory(parseInt(user_id))
        if inv2 then
            for k, v in pairs(inv2) do
                if vRP.itemBodyList(k) then
                    tcSlot = tcSlot - 1
                    table.insert(uinventory, {
                        amount = parseInt(v.amount),
                        name = vRP.itemNameList(k),
                        index = vRP.itemIndexList(k),
                        key = k,
                        peso = vRP.getItemWeight(k)
                    })
                end
            end
        end
        slotsnuser = tcSlot

        return ninventory, uinventory, vRP.getInventoryWeight(parseInt(user_id)),
            vRP.getInventoryMaxWeight(parseInt(user_id)), vRP.getInventoryWeight(parseInt(opened[user_id])),
            vRP.getInventoryMaxWeight(parseInt(opened[user_id])), parseInt(tSlot), parseInt(tcSlot)
    end
end

function inspect.storeItem(itemName, amount)
    local source = source
    if itemName then
        local user_id = vRP.getUserId(source)
        local nsource = vRP.getUserSource(parseInt(opened[user_id]))
        local identity = vRP.getUserIdentity(user_id)
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        local nuser_id = vRP.getUserId(nsource)
        local identitynu = vRP.getUserIdentity(nuser_id)
        local x, y, z = vRPclient.getPosition(source)

        if user_id and nsource and slotsuser > 0 then
            if parseInt(amount) > 0 then
                if vRP.getInventoryWeight(parseInt(opened[user_id])) + vRP.getItemWeight(itemName) * parseInt(amount) <=
                    vRP.getInventoryMaxWeight(parseInt(opened[user_id])) then
                    if vRP.tryGetInventoryItem(parseInt(user_id), itemName, parseInt(amount)) then
                        vRP.giveInventoryItem(parseInt(opened[user_id]), itemName, parseInt(amount))

                        TriggerClientEvent("itensNotify", source, "sucesso", "Enviou",
                            "" .. vRP.itemIndexList(itemName) .. "", "" .. vRP.format(parseInt(amount)) .. "",
                            "" .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. "")
                        TriggerClientEvent("itensNotify", nplayer, "sucesso", "Adicionou",
                            "" .. vRP.itemIndexList(itemName) .. "", "" .. vRP.format(parseInt(amount)) .. "",
                            "" .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. "")

                        PerformHttpRequest(config.webhookSend, function(err, text, headers)
                        end, 'POST', json.encode({
                            embeds = {{
                                title = 'REGISTRO DE ITEM ENVIADO VIA REVISTAR/SAQUEAR:⠀\n⠀',
                                thumbnail = {
                                    url = config.webhookIcon
                                },
                                fields = {{
                                    name = '**QUEM ENVIOU:**',
                                    value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                        '**]'
                                }, {
                                    name = '**ITEM ENVIADO:**',
                                    value = '[ **Item: ' .. itemName .. '** ][ **Quantidade: ' ..
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
                                    text = config.webhookBottom .. os.date('%d/%m/%Y | %H:%M:%S'),
                                    icon_url = config.webhookIcon
                                },
                                color = config.webhookColor
                            }}
                        }), {
                            ['Content-Type'] = 'application/json'
                        })
                        TriggerClientEvent('vrp_inspect:updateInspect', source, 'updateChest')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Mochila <b>cheia</b>.', 5000)
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Quantidade <b>inválida</b>.', 5000)
            end
        end
    end
    return false
end

function inspect.takeItem(itemName, amount)
    local source = source
    if itemName then
        for k, v in pairs(config.blackList) do
            if itemName == v then
                TriggerClientEvent("Notify", source, "negado", "Nao é permitido pegar esse item")
                return
            end
        end
        local user_id = vRP.getUserId(source)
        local nsource = vRP.getUserSource(parseInt(opened[user_id]))
        local identity = vRP.getUserIdentity(user_id)
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        local nuser_id = vRP.getUserId(nsource)
        local identitynu = vRP.getUserIdentity(nuser_id)
        local x, y, z = vRPclient.getPosition(source)
        if user_id and nsource and slotsnuser > 0 then
            if parseInt(amount) > 0 then
                if vRP.getInventoryWeight(parseInt(user_id)) + vRP.getItemWeight(itemName) * parseInt(amount) <=
                    vRP.getInventoryMaxWeight(parseInt(user_id)) then
                    if vRP.tryGetInventoryItem(parseInt(opened[user_id]), itemName, parseInt(amount)) then
                        vRP.giveInventoryItem(parseInt(user_id), itemName, parseInt(amount))

                        TriggerClientEvent("itensNotify", source, "sucesso", "Pegou",
                            "" .. vRP.itemIndexList(itemName) .. "", "" .. vRP.format(parseInt(amount)) .. "",
                            "" .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. "")
                        TriggerClientEvent("itensNotify", nplayer, "sucesso", "Subtraiu",
                            "" .. vRP.itemIndexList(itemName) .. "", "" .. vRP.format(parseInt(amount)) .. "",
                            "" .. vRP.format(vRP.getItemWeight(itemName) * parseInt(amount)) .. "")

                        PerformHttpRequest(config.webhookTake, function(err, text, headers)
                        end, 'POST', json.encode({
                            embeds = {{
                                title = 'REGISTRO DE ITEM PEGADO VIA REVISTAR/SAQUEAR:⠀⠀\n⠀',
                                thumbnail = {
                                    url = config.webhookBottom
                                },
                                fields = {{
                                    name = '**QUEM ENVIOU:**',
                                    value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                        '**]'
                                }, {
                                    name = '**ITEM ENVIADO:**',
                                    value = '[ **Item: ' .. itemName .. '** ][ **Quantidade: ' ..
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
                                    text = config.webhookBottom .. os.date('%d/%m/%Y | %H:%M:%S'),
                                    icon_url = config.webhookIcon
                                },
                                color = config.webhookColor
                            }}
                        }), {
                            ['Content-Type'] = 'application/json'
                        })
                        TriggerClientEvent('vrp_inspect:updateInspect', source, 'updateChest')
                        TriggerEvent('GENESEEExperience:remSV2', source, 800)
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Mochila <b>cheia</b>.', 5000)
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Quantidade <b>inválida</b>.', 5000)
            end
        end
    end
end

function inspect.resetInspect()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and opened[parseInt(user_id)] then
        local nplayer = vRP.getUserSource(parseInt(opened[parseInt(user_id)]))
        if plunder then
            if nplayer then
                TriggerClientEvent('canceling', nplayer, false)
            end

            opened[parseInt(user_id)] = nil
            vRPclient._stopAnim(source, false)
        else
            if nplayer then
                inspectCL.toggleCarry(nplayer, source)
                TriggerClientEvent('canceling', nplayer, false)
            end

            opened[parseInt(user_id)] = nil
            vRPclient._stopAnim(source, false)
            vRPclient._stopAnim(nplayer, false)
        end
    end
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
