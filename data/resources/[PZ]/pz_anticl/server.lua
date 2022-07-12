local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local webhook =
    "https://discord.com/api/webhooks/957698108337299456/erpqoiWrPonkt7GeeeRv2b2RSs0rok2pil_1NEUL2eAZyxFDok03rbeBRSVy9cI4btzu"

RegisterCommand("combat", function(source, args, rawcmd)
    TriggerClientEvent("pz_anticl:show", source)
end)

AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    -- local id = source
    local id = vRP.getUserId(source)
    local identifier = ""
    if Config.UseSteam then
        identifier = GetPlayerIdentifier(source, 0)
    else
        identifier = GetPlayerIdentifier(source, 1)
    end
    TriggerClientEvent("pz_anticl", -1, id, crds, identifier, reason)
    TriggerClientEvent('pz_logs:create', 'O ID: ' .. id .. ' quitou')
    if Config.LogSystem then
        SendLog(source, id, crds, identifier, reason)
    end
    TriggerClientEvent("pz_anticl:show", source)
end)

function SendLog(source, id, crds, identifier, reason)
    local name = GetPlayerName(source)
    local date = os.date('*t')
    if date.month < 10 then
        date.month = '0' .. tostring(date.month)
    end
    if date.day < 10 then
        date.day = '0' .. tostring(date.day)
    end
    if date.hour < 10 then
        date.hour = '0' .. tostring(date.hour)
    end
    if date.min < 10 then
        date.min = '0' .. tostring(date.min)
    end
    if date.sec < 10 then
        date.sec = '0' .. tostring(date.sec)
    end
    local date = ('' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min ..
                     ':' .. date.sec .. '')
    local embeds = {{
        ["title"] = "Player quitou",
        ["type"] = "rich",
        ["color"] = 4777493,
        ["fields"] = {{
            ["name"] = "Identidade",
            ["value"] = identifier,
            ["inline"] = true
        }, {
            ["name"] = "Nickname",
            ["value"] = name,
            ["inline"] = true
        }, {
            ["name"] = "ID do player",
            ["value"] = id,
            ["inline"] = true
        }, {
            ["name"] = "Coordenadas",
            ["value"] = "X: " .. crds.x .. ", Y: " .. crds.y .. ", Z: " .. crds.z,
            ["inline"] = true
        }, {
            ["name"] = "Motivo",
            ["value"] = reason,
            ["inline"] = true
        }},
        ["footer"] = {
            ["icon_url"] = "https://i.imgur.com/TWGFqwj.png",
            ["text"] = "Enviado: " .. date .. ""
        }
    }}
    PerformHttpRequest(webhook, function(err, text, headers)
    end, 'POST', json.encode({
        username = Config.LogBotName,
        embeds = embeds
    }), {
        ['Content-Type'] = 'application/json'
    })
end
