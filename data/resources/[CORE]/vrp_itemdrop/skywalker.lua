local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
local Tools = module('vrp', 'lib/Tools')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP', 'vrp_itemdrop')

local markers_ids = Tools.newIDGenerator()
local items = {}

AddEventHandler('DropSystem:create', function(item, count, px, py, pz, tempo)
    local id = markers_ids:gen()
    if id then
        items[id] = {
            item = item,
            count = count,
            x = px,
            y = py,
            z = pz,
            name = vRP.itemNameList(item),
            tempo = tempo
        }
        TriggerClientEvent('DropSystem:createForAll', -1, id, items[id])
    end
end)

RegisterServerEvent('DropSystem:drop')
AddEventHandler('DropSystem:drop', function(item, count)
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.giveInventoryItem(user_id, item, count)
        TriggerClientEvent('DropSystem:createForAll', -1)
    end
end)

RegisterServerEvent('DropSystem:take33')
AddEventHandler('DropSystem:take33', function(id, value)
    local source = source
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source, 3.7)
    local nuser_id = vRP.getUserId(nplayer)
    local x, y, z = vRPclient.getPosition(source)
    vRP.antiflood(source, "DropSystem:take33", 5)
    if nuser_id then
        TriggerClientEvent('Notify', source, 'negado', 'Você não consegue pegar os itens com pessoas por perto.')
    else
        if user_id then
            local verifyAmount = value
            if verifyAmount ~= '' and parseInt(verifyAmount) <= parseInt(items[id].count) and parseInt(verifyAmount) >=
                1 then
                local myinventory = {}
                local tSlot = vRP.verifySlots(user_id)

                local inv = vRP.getInventory(parseInt(user_id))
                for k, v in pairs(inv) do
                    if vRP.itemBodyList(k) then
                        tSlot = tSlot - 1
                    end
                end

                if items[id] ~= nil and tSlot > 0 then
                    local new_weight = vRP.getInventoryWeight(user_id) + vRP.getItemWeight(items[id].item) *
                                           parseInt(verifyAmount)
                    if new_weight <= vRP.getInventoryMaxWeight(user_id) then
                        if items[id] == nil then
                            return
                        end
                        vRP.giveInventoryItem(user_id, items[id].item, parseInt(verifyAmount))
                        vRPclient._playAnim(source, true, {{'pickup_object', 'pickup_low'}}, false)
                        local identity = vRP.getUserIdentity(user_id)

                        PerformHttpRequest(config.Take, function(err, text, headers)
                        end, 'POST', json.encode({
                            embeds = {{
                                title = 'REGISTRO DE INVENTÁRIO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                                thumbnail = {
                                    url = config.webhookIcon
                                },
                                fields = {{
                                    name = '**IDENTIFICAÇÃO:**',
                                    value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id ..
                                        '**]'
                                }, {
                                    name = '**ITEM PEGADO DO CHÃO:**',
                                    value = '[ **Item: ' .. items[id].name .. '** ][ **Quantidade: ' ..
                                        parseInt(verifyAmount) .. '** ]\n⠀⠀'
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

                        TriggerClientEvent('itensNotify', source, 'sucesso', 'Pegou', '' .. items[id].item .. '',
                            '' .. parseInt(verifyAmount) .. '',
                            '' .. vRP.getItemWeight(items[id].item) * parseInt(verifyAmount) .. '')

                        local newAmount = items[id].count - parseInt(verifyAmount)
                        items[id].count = newAmount

                        if items[id].count == 0 or items[id].count == nil then
                            TriggerClientEvent('DropSystem:remove', -1, id)
                            items[id] = nil
                            markers_ids:free(id)
                        else
                            local x, y, z = vRPclient.getPosition(source)
                            TriggerClientEvent('DropSystem:remove', -1, id)
                            TriggerEvent('DropSystem:create', items[id].item, newAmount, x, y, z, 3600)
                            items[id] = nil
                            markers_ids:free(id)
                        end
                    else
                        TriggerClientEvent('Notify', source, 'negado', '<b>Mochila</b> cheia.')
                    end
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Quantidade <b>inválida</b>.')
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k, v in pairs(items) do
            if items[k].tempo > 0 then
                items[k].tempo = items[k].tempo - 1
                if items[k].tempo <= 0 then
                    items[k] = nil
                    markers_ids:free(k)
                    TriggerClientEvent('DropSystem:remove', -1, k)
                end
            end
        end
    end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
