local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

death = {}
Tunnel.bindInterface("pz_deathnotes", death)
Proxy.addInterface("pz_deathnotes", death)

local using = false

RegisterServerEvent('diedplayer')
AddEventHandler('diedplayer', function(killer, reason)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id ~= nil then
        if killer == "**Invalid**" or killer == source then
            PerformHttpRequest(config.webhookkill, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = 'REGISTRO DE KILL/DEATH:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = '**QUEM SE MATOU:**',
                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
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
        elseif killer == nil then
            PerformHttpRequest(config.webhookkill, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = 'REGISTRO DE KILL/DEATH:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = '**QUEM SE MATOU:**',
                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' .. user_id .. '**]'
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
        elseif killer ~= nil then
            if reason == 1 then
                local killer_id = vRP.getUserId(killer)
                local nidentity = vRP.getUserIdentity(killer_id)
                if killer_id then
                    local request = vRP.request(source, 'Você morreu honestamente? Se sim, o player irá perder XP',
                        1200)
                    if request then
                        if not using then
                            using = true
                            PerformHttpRequest(config.webhookkill, function(err, text, headers)
                            end, 'POST', json.encode({
                                embeds = {{
                                    title = 'REGISTRO DE KILL/DEATH:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                                    thumbnail = {
                                        url = config.webhookIcon
                                    },
                                    fields = {{
                                        name = '**QUEM MATOU:**',
                                        value = '**' .. nidentity.name .. ' ' .. nidentity.firstname .. '** [**' ..
                                            killer_id .. '**]'
                                    }, {
                                        name = '**QUEM MORREU:**',
                                        value = '**' .. identity.name .. ' ' .. identity.firstname .. '** [**' ..
                                            user_id .. '**]'
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
                            TriggerEvent('GENESEEExperience:remSV', 2500, killer_id)

                            SetTimeout(5000, function()
                                using = false
                            end)
                        end
                    end
                end
            end
        end
    end
end)
