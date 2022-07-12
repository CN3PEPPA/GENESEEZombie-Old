local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

admin = {}
Tunnel.bindInterface("vrp_admin", admin)
Proxy.addInterface("vrp_admin", admin)

-- RegisterCommand('bvida', function(source, args, rawCommand)
--     if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
--         vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
--         vRP.hasPermission(user_id, "suporte.permissao") then
--         if args[1] then
--             vRPclient._setCustomization(source, vRPclient.getCustomization(args[1]))
--             vRP.removeCloak(args[1])
--         end
--     end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparinv',function(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"manager.permissao") then
        TriggerEvent("clearInventoryTwo",user_id)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAR AREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpararea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"manager.permissao") or vRP.hasPermission(user_id,"moderador.permissao") or vRP.hasPermission(user_id,"limpar.permissao") then
        TriggerClientEvent("GENESEESync:areasmall", -1, x, y, z)
    end
end)

RegisterCommand('bvida', function(source, rawCommand)
    local user_id = vRP.getUserId(source)
    vRPclient._setCustomization(source, vRPclient.getCustomization(source))
    vRP.removeCloak(source)
end)

RegisterCommand('adminbau', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then
            TriggerClientEvent('vrp_chest:use', source, args[1])
        end
    end
end)

RegisterCommand('adminskin', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("vrp_admin:skin", nplayer, args[2])
                TriggerClientEvent("Notify", source, "sucesso", "Voce setou a skin <b>" .. args[2] ..
                    "</b> no passaporte <b>" .. parseInt(args[1]) .. "</b>.")
            end
        end
    end
end)

RegisterCommand('tuning', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") then
        TriggerClientEvent('vrp_admin:tuning', source)
    end
end)

RegisterCommand('reviver', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                local nuser_id = vRP.getUserId(nplayer)
                local identitynu = vRP.getUserIdentity(nuser_id)

                PerformHttpRequest(config.Revive, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{
                        title = "REGISTRO DE REVIVER⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = "**COLABORADOR DA EQUIPE:**",
                            value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id ..
                                "**]\n⠀"
                        }, {
                            name = "**INFORMAÇÕES DO PLAYER REVIVIDO:**",
                            value = "**" .. identitynu.name .. " " .. identitynu.firstname .. "** [**" .. nuser_id ..
                                "**]\n⠀"
                        }},
                        footer = {
                            text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhookIcon
                        },
                        color = config.webhookColor
                    }}
                }), {
                    ['Content-Type'] = 'application/json'
                })

                TriggerClientEvent("resetBleeding", nplayer)
                TriggerClientEvent("resetDiagnostic", nplayer)

                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer, 400)

                vRP.varyThirst(nuser_id, -100)
                vRP.varyHunger(nuser_id, -100)
                vRP.varySleep(nuser_id, -100)
            end
        else
            PerformHttpRequest(config.Revive, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "REGISTRO DE REVIVER⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })

            TriggerClientEvent("resetBleeding", source)
            TriggerClientEvent("resetDiagnostic", source)

            vRPclient.killGod(source)
            vRPclient.setHealth(source, 400)

            vRP.varyThirst(user_id, -100)
            vRP.varyHunger(user_id, -100)
            vRP.varySleep(user_id, -100)
        end
    end
end)

RegisterCommand('reviverall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        local users = vRP.getUsers()
        for k, v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                TriggerClientEvent("resetBleeding", id)
                TriggerClientEvent("resetDiagnostic", id)

                vRPclient.killGod(id)
                vRPclient.setHealth(id, 400)

                vRP.varyThirst(user_id, -100)
                vRP.varyHunger(user_id, -100)
                vRP.varySleep(user_id, -100)
            end
        end

        PerformHttpRequest(config.Revive, function(err, text, headers)
        end, 'POST', json.encode({
            embeds = {{
                title = "REGISTRO DE REVIVER TODOS⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                thumbnail = {
                    url = config.webhookIcon
                },
                fields = {{
                    name = "**COLABORADOR DA EQUIPE:**",
                    value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                }},
                footer = {
                    text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = config.webhookIcon
                },
                color = config.webhookColor
            }}
        }), {
            ['Content-Type'] = 'application/json'
        })
    end
end)

RegisterCommand('al', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "aprovador-al.permissao") then
        if args[1] then

            PerformHttpRequest(config.Whitelist, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "NOVO ID ADICIONADO A WHITELIST⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }, {
                        name = "**ID ADICIONADO: **" .. vRP.format(parseInt(args[1])),
                        value = "⠀"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })

            vRP.setWhitelisted(parseInt(args[1]), true)
            TriggerClientEvent("Notify", source, "sucesso",
                "Você aprovou o passaporte <b>" .. args[1] .. "</b> na AllowList.")
        end
    end
end)

RegisterCommand('unal', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "aprovador-al.permissao") then
        if args[1] then

            PerformHttpRequest(config.UnWhitelist, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "ID REMOVIDO DA ALLOWLIST⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }, {
                        name = "**ID REMOVIDO: **" .. vRP.format(parseInt(args[1])),
                        value = "⠀"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })

            vRP.setWhitelisted(parseInt(args[1]), false)
            TriggerClientEvent("Notify", source, "sucesso",
                "Você retirou o passaporte <b>" .. args[1] .. "</b> da AllowList.")
        end
    end
end)

RegisterCommand('kick', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "aprovador-al.permissao") then
        if args[1] then
            local id = vRP.getUserSource(parseInt(args[1]))
            if id then

                PerformHttpRequest(config.Kick, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{
                        title = "REGISTRO DE KICK⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = "**COLABORADOR DA EQUIPE:**",
                            value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id ..
                                "**]\n⠀"
                        }, {
                            name = "**ID KIKADO: **" .. vRP.format(parseInt(args[1])),
                            value = "⠀"
                        }},
                        footer = {
                            text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhookIcon
                        },
                        color = config.webhookColor
                    }}
                }), {
                    ['Content-Type'] = 'application/json'
                })

                vRP.kick(id, "Você foi expulso da cidade.")
                TriggerClientEvent("Notify", source, "sucesso",
                    "Voce kickou o passaporte <b>" .. args[1] .. "</b> da cidade.")
            end
        end
    end
end)

RegisterCommand('kickall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "aprovador-al.permissao") then
        local users = vRP.getUsers()
        for k, v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                vRP.kick(id, "Você foi vitima do terremoto.")
            end
        end

        PerformHttpRequest(config.Kick, function(err, text, headers)
        end, 'POST', json.encode({
            embeds = {{
                title = "REGISTRO DE KICKAR TODOS⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                thumbnail = {
                    url = config.webhookIcon
                },
                fields = {{
                    name = "**COLABORADOR DA EQUIPE:**",
                    value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                }},
                footer = {
                    text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = config.webhookIcon
                },
                color = config.webhookColor
            }}
        }), {
            ['Content-Type'] = 'application/json'
        })
    end
end)

RegisterCommand('ban', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then
            local nuser_id = vRP.getUserSource(parseInt(args[1]))

            PerformHttpRequest(config.Ban, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "REGISTRO DE BANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }, {
                        name = "**ID BANIDO: **" .. vRP.format(parseInt(args[1])),
                        value = "⠀"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })

            vRP.setBanned(parseInt(args[1]), true)
            vRP.kick(nuser_id, "Você foi banido! [ Mais informações em: discord.gg/projetozrp ]")

            TriggerClientEvent("Notify", source, "sucesso",
                "Voce baniu o passaporte <b>" .. args[1] .. "</b> da cidade.")
        end
    end
end)

RegisterCommand('unban', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") then
        if args[1] then

            PerformHttpRequest(config.UnBan, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "REGISTRO DE DESBANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }, {
                        name = "**ID DESBANIDO: **" .. vRP.format(parseInt(args[1])),
                        value = "⠀"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })

            vRP.setBanned(parseInt(args[1]), false)
            TriggerClientEvent("Notify", source, "sucesso",
                "Voce desbaniu o passaporte <b>" .. args[1] .. "</b> da cidade.")
        end
    end
end)

RegisterCommand('group', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        if args[1] and args[2] then
            vRP.addUserGroup(parseInt(args[1]), args[2])

            TriggerClientEvent("Notify", source, "sucesso", "Voce setou o passaporte <b>" .. parseInt(args[1]) ..
                "</b> no grupo <b>" .. args[2] .. "</b>.")

            PerformHttpRequest(config.Group, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "REGISTRO DE GROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }, {
                        name = "**ID & GROUP: **",
                        value = "**" .. args[1] .. " no grupo: " .. args[2] .. "**"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })
        end
    end
end)

RegisterCommand('ungroup', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        if args[1] and args[2] then
            vRP.removeUserGroup(parseInt(args[1]), args[2])

            TriggerClientEvent("Notify", source, "sucesso", "Voce removeu o passaporte <b>" .. parseInt(args[1]) ..
                "</b> do grupo <b>" .. args[2] .. "</b>.")

            PerformHttpRequest(config.UnGroup, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "REGISTRO DE UNGROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }, {
                        name = "**ID & GROUP: **",
                        value = "**" .. args[1] .. " retirou o grupo: " .. args[2] .. "**"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })
        end
    end
end)

RegisterCommand('car', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local identity = vRP.getUserIdentity(user_id)
        if vRP.hasPermission(user_id, "manager.permissao") then
            if args[1] then

                TriggerClientEvent('vrp_admin:spawnvh', source, args[1])
            end
        end
    end
end)

RegisterCommand('fix', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    local vehicle = vRPclient.getNearestVehicle(source, 11)
    if vehicle then
        if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then

            PerformHttpRequest(config.Fix, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{ ------------------------------------------------------------
                    title = "REGISTRO DE FIX⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })

            TriggerClientEvent('vrp_admin:fix', source)
        end
    end
end)

RegisterCommand('dv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then

            PerformHttpRequest(config.dv, function(err, text, headers)
            end, 'POST', json.encode({
                embeds = {{
                    title = "REGISTRO DE SPAWNCAR⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                    thumbnail = {
                        url = config.webhookIcon
                    },
                    fields = {{
                        name = "**COLABORADOR DA EQUIPE:**",
                        value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                    }, {
                        name = "**CARRO DELETADO: **"
                    }},
                    footer = {
                        text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                        icon_url = config.webhookIcon
                    },
                    color = config.webhookColor
                }}
            }), {
                ['Content-Type'] = 'application/json'
            })

            TriggerClientEvent('vrp_admin:dv', source, vehicle)

        end
    end
end)

RegisterCommand('staff', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local cargo = nil
    local status = nil

    if vRP.hasPermission(user_id, "administrador.permissao") then
        cargo = "Administrador"
        status = "Saiu do modo administrativo."
        vRP.addUserGroup(user_id, "off-administrador")
        TriggerClientEvent("Notify", source, "negado", "<b>[ADMINISTRADOR]</b> OFF.")

    elseif vRP.hasPermission(user_id, "off-administrador.permissao") then
        cargo = "Administrador"
        status = "Entrou no modo administrativo."
        vRP.addUserGroup(user_id, "administrador")
        TriggerClientEvent("Notify", source, "sucesso", "<b>[ADMINISTRADOR]</b> ON.")

    elseif vRP.hasPermission(user_id, "desenvolvedor.permissao") then
        cargo = "Moderador"
        status = "Saiu do modo desenvolvedor."
        vRP.addUserGroup(user_id, "off-desenvolvedor")
        TriggerClientEvent("Notify", source, "negado", "<b>[DESENVOLVEDOR]</b> OFF.")

    elseif vRP.hasPermission(user_id, "off-desenvolvedor.permissao") then
        cargo = "Moderador"
        status = "Entrou no modo desenvolvedor."
        vRP.addUserGroup(user_id, "desenvolvedor")
        TriggerClientEvent("Notify", source, "sucesso", "<b>[DESENVOLVEDOR]</b> ON.")

    elseif vRP.hasPermission(user_id, "moderador.permissao") then
        cargo = "Moderador"
        status = "Saiu do modo administrativo."
        vRP.addUserGroup(user_id, "off-moderador")
        TriggerClientEvent("Notify", source, "negado", "<b>[MODERADOR]</b> OFF.")

    elseif vRP.hasPermission(user_id, "off-moderador.permissao") then
        cargo = "Moderador"
        status = "Entrou no modo administrativo."
        vRP.addUserGroup(user_id, "moderador")
        TriggerClientEvent("Notify", source, "sucesso", "<b>[MODERADOR]</b> ON.")

    elseif vRP.hasPermission(user_id, "off-aurora.permissao") then
        cargo = "Aurora"
        status = "Entrou no modo administrativo."
        vRP.addUserGroup(user_id, "aurora")
        TriggerClientEvent("Notify", source, "sucesso", "<b>[AURORA]</b> ON.")

    elseif vRP.hasPermission(user_id, "suporte.permissao") then
        cargo = "Suporte"
        status = "Saiu do modo administrativo."
        vRP.addUserGroup(user_id, "off-suporte")
        TriggerClientEvent("Notify", source, "negado", "<b>[SUPORTE]</b> OFF.")

    elseif vRP.hasPermission(user_id, "off-suporte.permissao") then
        cargo = "Suporte"
        status = "Entrou no modo administrativo."
        vRP.addUserGroup(user_id, "suporte")
        TriggerClientEvent("Notify", source, "sucesso", "<b>[SUPORTE]</b> ON.")
    end

    PerformHttpRequest(config.Status, function(err, text, headers)
    end, 'POST', json.encode({
        embeds = {{
            title = "REGISTRO ADMINISTRATIVO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
            thumbnail = {
                url = config.webhookIcon
            },
            fields = {{
                name = "**IDENTIFICAÇÃO: " .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id ..
                    "**]",
                value = "⠀"
            }, {
                name = "**CARGO: **" .. cargo,
                value = "⠀",
                inline = true
            }, {
                name = "**STATUS: **" .. status,
                value = "⠀",
                inline = true
            }},
            footer = {
                text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                icon_url = config.webhookIcon
            },
            color = config.webhookColor
        }}
    }), {
        ['Content-Type'] = 'application/json'
    })
end)

RegisterCommand('aurora', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local cargo = nil
    local status = nil

    if vRP.hasPermission(user_id, "aurora.permissao") then
        cargo = "Funcionário de Aurora"
        status = "Saiu do modo administrativo."
        vRP.addUserGroup(user_id, "off-aurora")
        TriggerClientEvent("Notify", source, "negado", "<b>[AURORA]</b> OFF.")
    end

    PerformHttpRequest(config.Status, function(err, text, headers)
    end, 'POST', json.encode({
        embeds = {{
            title = "REGISTRO ADMINISTRATIVO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
            thumbnail = {
                url = config.webhookIcon
            },
            fields = {{
                name = "**IDENTIFICAÇÃO: " .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id ..
                    "**]",
                value = "⠀"
            }, {
                name = "**CARGO: **" .. cargo,
                value = "⠀",
                inline = true
            }, {
                name = "**STATUS: **" .. status,
                value = "⠀",
                inline = true
            }},
            footer = {
                text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                icon_url = config.webhookIcon
            },
            color = config.webhookColor
        }}
    }), {
        ['Content-Type'] = 'application/json'
    })
end)

RegisterCommand('nc', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then

        PerformHttpRequest(config.Nc, function(err, text, headers)
        end, 'POST', json.encode({
            embeds = {{
                title = "REGISTRO DE NC⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                thumbnail = {
                    url = config.webhookIcon
                },
                fields = {{
                    name = "**COLABORADOR DA EQUIPE:**",
                    value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                }},
                footer = {
                    text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = config.webhookIcon
                },
                color = config.webhookColor
            }}
        }), {
            ['Content-Type'] = 'application/json'
        })

        vRPclient.toggleNoclip(source)
    end
end)

RegisterCommand('tptome', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then
            local tplayer = vRP.getUserSource(parseInt(args[1]))
            local x, y, z = vRPclient.getPosition(source)
            if tplayer then

                PerformHttpRequest(config.Tps, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{ ------------------------------------------------------------
                        title = "REGISTRO DE TPTOME⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = "**COLABORADOR:**",
                            value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id ..
                                "**]\n⠀"
                        }, {
                            name = "**ID DO PLAYER PUXADO: **" .. args[1],
                            value = "⠀"
                        }},
                        footer = {
                            text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhookIcon
                        },
                        color = config.webhookColor
                    }}
                }), {
                    ['Content-Type'] = 'application/json'
                })

                vRPclient.teleport(tplayer, x, y, z)
            end
        end
    end
end)

RegisterCommand('tpto', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        if args[1] then
            local tplayer = vRP.getUserSource(parseInt(args[1]))
            if tplayer then
                PerformHttpRequest(config.Tps, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{ ------------------------------------------------------------
                        title = "REGISTRO DE TPTO⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = "**COLABORADOR:**",
                            value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id ..
                                "**]\n⠀"
                        }, {
                            name = "**ID DO PLAYER: **" .. args[1],
                            value = "⠀"
                        }},
                        footer = {
                            text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                            icon_url = config.webhookIcon
                        },
                        color = config.webhookColor
                    }}
                }), {
                    ['Content-Type'] = 'application/json'
                })

                vRPclient.teleport(source, vRPclient.getPosition(tplayer))
            end
        end
    end
end)

RegisterCommand('tpway', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then

        PerformHttpRequest(config.Tps, function(err, text, headers)
        end, 'POST', json.encode({
            embeds = {{ ------------------------------------------------------------
                title = "REGISTRO DE TPWAY⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                thumbnail = {
                    url = config.webhookIcon
                },
                fields = {{
                    name = "**COLABORADOR:**",
                    value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]\n⠀"
                }},
                footer = {
                    text = config.webhookBottomText .. os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = config.webhookIcon
                },
                color = config.webhookColor
            }}
        }), {
            ['Content-Type'] = 'application/json'
        })

        TriggerClientEvent('vrp_admin:tptoway', source)
    end
end)

RegisterCommand('tpcds', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        local fcoords = vRP.prompt(source, "Cordenadas:", "")
        if fcoords == "" then
            return
        end
        local coords = {}
        local a = fcoords:gsub("[%a='%[%]]", "")
        for coord in string.gmatch(a or "0,0,0", "[^,]+") do
            table.insert(coords, parseInt(coord))
        end
        vRPclient.teleport(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
    end
end)

RegisterCommand('cds', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        local x, y, z = vRPclient.getPosition(source)
        heading = GetEntityHeading(GetPlayerPed(-1))
        vRP.prompt(source, "Cordenadas:", "['x'] = " .. tD(x) .. ", ['y'] = " .. tD(y) .. ", ['z'] = " .. tD(z))
    end
end)

RegisterCommand('cds2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "desenvolvedor.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or
        vRP.hasPermission(user_id, "suporte.permissao") then
        local x, y, z = vRPclient.getPosition(source)
        vRP.prompt(source, "Cordenadas:", tD(x) .. ", " .. tD(y) .. ", " .. tD(z))
    end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
