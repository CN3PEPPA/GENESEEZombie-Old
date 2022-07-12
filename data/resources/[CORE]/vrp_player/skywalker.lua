local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_player", src)
local idgens = Tools.newIDGenerator()

local skin = nil
local using = false

RegisterServerEvent("goodboy")
AddEventHandler("goodboy", function()
    local source = source
    local user_id = vRP.getUserId(source)

    local exp = vRP.getExperience(user_id)

    local Hunger = vRP.getHunger(user_id)
    local Thirst = vRP.getThirst(user_id)
    local Sleep = vRP.getSleep(user_id)

    if exp < 0 and exp >= -1000 then
        vRP.setHunger(user_id, Hunger + 0.1)
        vRP.setThirst(user_id, Thirst + 0.1)
        vRP.setSleep(user_id, Sleep + 0.1)
    elseif exp <= -1001 and exp <= -2000 then
        vRP.setHunger(user_id, Hunger + 0.3)
        vRP.setThirst(user_id, Thirst + 0.3)
        vRP.setSleep(user_id, Sleep + 0.3)
    elseif exp <= -2001 and exp <= -3500 then
        vRP.setHunger(user_id, Hunger + 0.8)
        vRP.setThirst(user_id, Thirst + 0.8)
        vRP.setSleep(user_id, Sleep + 0.8)
    elseif exp <= -3501 then
        vRP.setHunger(user_id, Hunger + 1)
        vRP.setThirst(user_id, Thirst + 1)
        vRP.setSleep(user_id, Sleep + 1)
    else
        vRP.setHunger(user_id, Hunger + 0.01)
        vRP.setThirst(user_id, Thirst + 0.01)
        vRP.setSleep(user_id, Sleep + 0.01)
    end
end)

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
        if vRP.hasPermission(user_id, 'aurora') then
            TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
            TriggerClientEvent("Notify",source,"sucesso","Obrigado por colaborar com a cidade, seu salario de <b>Z$ 1</b> foi entregue.")
            vRP.giveInventoryItem(parseInt(user_id), 'zcola', 1)
        end
	end
end)

RegisterCommand('item', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        if args[1] and args[2] then
            local itemIndex = vRP.itemIndexList(args[1])

            if itemIndex then
                local itemName = vRP.itemNameList(args[1])
                vRP.giveInventoryItem(user_id, args[1], parseInt(args[2]))

                PerformHttpRequest(config.Item, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {{ ------------------------------------------------------------
                        title = "REGISTRO DE ITEM GERADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
                        thumbnail = {
                            url = config.webhookIcon
                        },
                        fields = {{
                            name = "**COLABORADOR DA EQUIPE:**",
                            value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**]"
                        }, {
                            name = "**ITEM GERADO**",
                            value = "[ **Item: " .. itemName .. "** ][ **Quantidade: " .. tonumber(args[2]) ..
                                "** ]\n⠀⠀"
                        }},
                        footer = {
                            text = config.webhookBottomText .. os.date("%d/%m/%Y |: %H:%M:%S"),
                            icon_url = config.webhookIcon
                        },
                        color = config.webhookColor
                    }}
                }), {
                    ['Content-Type'] = 'application/json'
                })

                TriggerClientEvent("itensNotify", source, "sucesso", "Pegou", "" .. itemIndex .. "")
                TriggerClientEvent('vrp_inventory:Update', source, 'updateInventory')
            else
                TriggerClientEvent("Notify", source, "negado", "Item <b>inválido ou inexistente</b>.")
            end
        end
    end
end)

RegisterCommand('skin', function(source, args, rawCommand)
    local request = vRP.request(source,
        'Para que a skin funcione você deve utilizar o comando "/garmas" antes, caso já tenha feito pressione "Y".',
        60)

    if request then
        if not using then
            using = true

            local user_id = vRP.getUserId(source)
            local nplayer = vRP.getUserSource(user_id)

            if user_id == 1 or user_id == 3 or user_id == 4 then
                skin = 'vector'
            elseif user_id == 2 then
                skin = 's_m_y_swat_01'
            elseif user_id == 6 then
                skin = 'TeenLunna'
            elseif user_id == 140 then
                skin = 'a_m_m_hillbilly_01'
            elseif user_id == 912 then
                skin = 'teenferbr'
            elseif user_id == 5 then
                skin = 'teenamanda'
            elseif user_id == 470 then
                skin = 'TeenBernard'
            elseif user_id == 1045 then
                skin = 'QueenMods_TeenSnoop'
            elseif user_id == 122 then
                skin = 's_m_y_marine_03'
            elseif user_id == 877 then
                skin = 'TeenAnd'
            elseif user_id == 814 then
                skin = 'child_m_4'
            elseif user_id == 707 then
                skin = 'dante2'
            elseif user_id == 391 then
                skin = 'AngelStore_LeonZ'
            elseif user_id == 389 then
                skin = 'AngelStore_TeenAnahi'
            elseif user_id == 1036 then
                skin = 'CS_Florzinha'
            elseif user_id == 1069 then
                skin = 'teenCandyRuiva'
            elseif user_id == 229 then
                skin = 'a_c_husky'
            else
                skin = 'none'
            end

            if skin == 'none' then
                TriggerClientEvent("Notify", source, "negado", "Você não tem skins.")
            else
                TriggerClientEvent("vrp_admin:skin", nplayer, skin)
                vRPclient.setHealth(nplayer, 400)
                TriggerClientEvent("Notify", source, "sucesso", "Você usou a skin com sucesso.")
            end
        end
    end
end)

RegisterCommand('reskin', function(source, rawCommand)
    local user_id = vRP.getUserId(source)
    vRPclient._setCustomization(vRPclient.getCustomization(source))
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- [ ID ]---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id', function(source, rawCommand)
    local nplayer = vRPclient.getNearestPlayer(source, 2)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id then
        local identity = vRP.getUserIdentity(nuser_id)
        vRPclient.setDiv(source, "completerg",
            ".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #d1257d; }",
            "<div class=\"local\"><b>Passaporte:</b> ( " .. vRP.format(identity.user_id) .. " )</div>")
        Wait(5000)
        vRPclient.removeDiv(source, "completerg")
    end
end)

local timers = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k, v in pairs(timers) do
            if v > 0 then
                timers[k] = v - 1
            end
        end
    end
end)

local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone", function(veh, doors, placa)
    if not veiculos[placa] then
        TriggerClientEvent("SyncDoorsEveryone", -1, veh, doors)
        veiculos[placa] = true
    end
end)

RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or
        vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "ultimate.permissao") or
        vRP.hasPermission(user_id, "platinum.permissao") or vRP.hasPermission(user_id, "gold.permissao") or
        vRP.hasPermission(user_id, "standard.permissao") then
        DropPlayer(source, "Voce foi desconectado por ficar ausente.")
    end
end)

RegisterCommand('sequestro', function(source, args, rawCommand)
    local nplayer = vRPclient.getNearestPlayer(source, 5)
    if nplayer then
        if not vRPclient.getNoCarro(source) then
            local vehicle = vRPclient.getNearestVehicle(source, 7)
            if vehicle then
                if vRPclient.getCarroClass(source, vehicle) then
                    vRPclient.setMalas(nplayer)
                end
            end
        elseif vRPclient.isMalas(nplayer) then
            vRPclient.setMalas(nplayer)
        end
    end
end)

-- RegisterCommand('reanimar', function(source, args, rawCommand)
--     local user_id = vRP.getUserId(source)
--     local nplayer = vRPclient.getNearestPlayer(source, 2)
--     if nplayer then
--         if vRPclient.isInComa(nplayer) then
--             local identity_user = vRP.getUserIdentity(user_id)
--             local nuser_id = vRP.getUserId(nplayer)
--             local identity_coma = vRP.getUserIdentity(nuser_id)
--             TriggerClientEvent('canceling', source, true)
--             vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@base", "base"}, {"mini@cpr@char_a@cpr_str", "cpr_pumpchest"}}, true)
--             TriggerClientEvent("progress", source, 30000, "reanimando")
--             SetTimeout(30000, function()
--                 vRPclient.killGod(nplayer)
--                 vRPclient._stopAnim(source, false)
--                 TriggerClientEvent("resetBleeding", nplayer)
--                 TriggerClientEvent('canceling', source, false)
--             end)
--         else
--             TriggerClientEvent("Notify", source, "importante", "A pessoa precisa estar em coma para prosseguir.")
--         end
--     end
-- end)

RegisterCommand('reanimar', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source, 2)

    if nplayer then
        -- if vRPclient.isInComa(nplayer) then
        if vRPclient.getHealth(nplayer) <= 102 then
            local identity_user = vRP.getUserIdentity(user_id)
            local nuser_id = vRP.getUserId(nplayer)
            local identity_coma = vRP.getUserIdentity(nuser_id)

            TriggerClientEvent('canceling', source, true)
            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@base", "base"},
                                                {"mini@cpr@char_a@cpr_str", "cpr_pumpchest"}}, true)
            TriggerClientEvent("progress", source, 30000, "reanimando")

            SetTimeout(30000, function()
                vRPclient.killGod(nplayer)
                vRPclient._stopAnim(source, false)
                TriggerClientEvent('canceling', source, false)
            end)

        else
            TriggerClientEvent("Notify", source, "importante", "A pessoa precisa estar em coma para prosseguir.")
        end
    else
        TriggerClientEvent("Notify", source, "importante", "Chegue mais perto do paciente.")
    end
end)

RegisterServerEvent("trytow")
AddEventHandler("trytow", function(nveh, rveh)
    TriggerClientEvent("synctow", -1, nveh, rveh)
end)

RegisterServerEvent("trywins")
AddEventHandler("trywins", function(nveh)
    TriggerClientEvent("syncwins", -1, nveh)
end)

RegisterServerEvent("tryhood")
AddEventHandler("tryhood", function(nveh)
    TriggerClientEvent("synchood", -1, nveh)
end)

RegisterServerEvent("trydoors")
AddEventHandler("trydoors", function(nveh, door)
    TriggerClientEvent("syncdoors", -1, nveh, door)
end)
