local oneSync = false
ESX = nil

Citizen.CreateThread(function()
    if GetConvar("onesync") ~= 'off' then
        oneSync = true
    end
    TriggerEvent('esx:getSharedObject', function(obj)
        ESX = obj;
    end)
end)

local Webhook =
    'https://discordapp.com/api/webhooks/947582175786717194/rGx8uShUDnU8atJgz8Ss3RlT36ErWgU9uqRsI-HiRPX-57i8ZbJzBW8lvtRAWbKtaw0H'
local staffs = {}
local FeedbackTable = {}

RegisterNetEvent("GENESEEReports:NewFeedback")
AddEventHandler("GENESEEReports:NewFeedback", function(data)
    local identifierlist = ExtractIdentifiers(source)
    local newFeedback = {
        feedbackid = #FeedbackTable + 1,
        playerid = source,
        identifier = identifierlist.license:gsub("license2:", ""),
        subject = data.subject,
        information = data.information,
        category = data.category,
        concluded = false,
        discord = "<@" .. identifierlist.discord:gsub("discord:", "") .. ">"
    }

    FeedbackTable[#FeedbackTable + 1] = newFeedback

    TriggerClientEvent("GENESEEReports:NewFeedback", -1, newFeedback)

    if Webhook ~= '' then
        newFeedbackWebhook(newFeedback)
    end
end)

RegisterNetEvent("GENESEEReports:FetchFeedbackTable")
AddEventHandler("GENESEEReports:FetchFeedbackTable", function()
    local staff = hasPermission(source)
    if staff then
        staffs[source] = true
        TriggerClientEvent("GENESEEReports:FetchFeedbackTable", source, FeedbackTable, staff, oneSync)
    end
end)

RegisterNetEvent("GENESEEReports:AssistFeedback")
AddEventHandler("GENESEEReports:AssistFeedback", function(feedbackId, canAssist)
    if staffs[source] then
        if canAssist then
            local id = FeedbackTable[feedbackId].playerid
            if GetPlayerPing(id) > 0 then
                local ped = GetPlayerPed(id)
                local playerCoords = GetEntityCoords(ped)
                local pedSource = GetPlayerPed(source)
                local identifierlist = ExtractIdentifiers(source)
                local assistFeedback = {
                    feedbackid = feedbackId,
                    discord = "<@" .. identifierlist.discord:gsub("discord:", "") .. ">"
                }

                SetEntityCoords(pedSource, playerCoords.x, playerCoords.y, playerCoords.z)
                -- TriggerClientEvent('okokNotify:Alert', source, "REPORT", "You are assisting FEEDBACK #" .. feedbackId .. "!", 20000, 'info')
                -- TriggerClientEvent('okokNotify:Alert', id, "REPORT", "An admin arrived!", 20000, 'info')
                TriggerClientEvent("Notify", source, "sucesso", "Você está ajudando o FEEDBACK #" .. feedbackId .. "!")
                TriggerClientEvent("Notify", id, "sucesso", "Chegou um administrador!")

                if Webhook ~= '' then
                    assistFeedbackWebhook(assistFeedback)
                end
            else
                -- TriggerClientEvent('okokNotify:Alert', id, "REPORT", "That player is no longer in the server!", 20000,'error')
                TriggerClientEvent("Notify", source, "erro", "Esse jogador não está mais no servidor!")
            end
            if not FeedbackTable[feedbackId].concluded then
                FeedbackTable[feedbackId].concluded = "assisting"
            end
            TriggerClientEvent("GENESEEReports:FeedbackConclude", -1, feedbackId, FeedbackTable[feedbackId].concluded)
        end
    end
end)

RegisterNetEvent("GENESEEReports:FeedbackConclude")
AddEventHandler("GENESEEReports:FeedbackConclude", function(feedbackId, canConclude)
    if staffs[source] then
        local feedback = FeedbackTable[feedbackId]
        local identifierlist = ExtractIdentifiers(source)
        local concludeFeedback = {
            feedbackid = feedbackId,
            discord = "<@" .. identifierlist.discord:gsub("discord:", "") .. ">"
        }

        if feedback then
            if feedback.concluded ~= true or canConclude then
                if canConclude then
                    if FeedbackTable[feedbackId].concluded == true then
                        FeedbackTable[feedbackId].concluded = false
                    else
                        FeedbackTable[feedbackId].concluded = true
                    end
                else
                    FeedbackTable[feedbackId].concluded = true
                end
                TriggerClientEvent("GENESEEReports:FeedbackConclude", -1, feedbackId,
                    FeedbackTable[feedbackId].concluded)

                if Webhook ~= '' then
                    concludeFeedbackWebhook(concludeFeedback)
                end
            end
        end
    end
end)

function hasPermission(id)
    local staff = false

    if Config.ESX then
        local player = ESX.GetPlayerFromId(id)
        local playerGroup = player.getGroup()

        if playerGroup ~= nil and playerGroup == "superadmin" or playerGroup == "admin" or playerGroup == "mod" then
            staff = true
        end
    else
        for i, a in ipairs(Config.AdminList) do
            for x, b in ipairs(GetPlayerIdentifiers(id)) do
                if string.lower(b) == string.lower(a) then
                    staff = true
                end
            end
        end
    end

    return staff
end

function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end

function newFeedbackWebhook(data)
    if data.category == 'player_report' then
        category = 'Reporte Player'
    elseif data.category == 'question' then
        category = 'Questão'
    else
        category = 'Bug'
    end

    local information = {{
        ["color"] = Config.NewFeedbackWebhookColor,
        ["author"] = {
            ["icon_url"] = Config.IconURL,
            ["name"] = Config.ServerName .. ' - Logs'
        },
        ["title"] = 'NOVO FEEDBACK #' .. data.feedbackid,
        ["description"] = '**Categoria:** ' .. category .. '\n**Assunto:** ' .. data.subject .. '\n**Informação:** ' ..
            data.information .. '\n\n**ID:** ' .. data.playerid .. '\n**Identificação:** ' .. data.identifier ..
            '\n**Discord:** ' .. data.discord,
        ["footer"] = {
            ["text"] = os.date(Config.DateFormat)
        }
    }}
    PerformHttpRequest(Webhook, function(err, text, headers)
    end, 'POST', json.encode({
        username = Config.BotName,
        embeds = information
    }), {
        ['Content-Type'] = 'application/json'
    })
end

function assistFeedbackWebhook(data)
    local information = {{
        ["color"] = Config.AssistFeedbackWebhookColor,
        ["author"] = {
            ["icon_url"] = Config.IconURL,
            ["name"] = Config.ServerName .. ' - Logs'
        },
        ["description"] = '**FEEDBACK #' .. data.feedbackid .. '** está sendo auxiliado pelo ' .. data.discord,
        ["footer"] = {
            ["text"] = os.date(Config.DateFormat)
        }
    }}
    PerformHttpRequest(Webhook, function(err, text, headers)
    end, 'POST', json.encode({
        username = Config.BotName,
        embeds = information
    }), {
        ['Content-Type'] = 'application/json'
    })
end

function concludeFeedbackWebhook(data)
    local information = {{
        ["color"] = Config.ConcludeFeedbackWebhookColor,
        ["author"] = {
            ["icon_url"] = Config.IconURL,
            ["name"] = Config.ServerName .. ' - Logs'
        },
        ["description"] = '**FEEDBACK #' .. data.feedbackid .. '** foi concluído pelo ' .. data.discord,
        ["footer"] = {
            ["text"] = os.date(Config.DateFormat)
        }
    }}
    PerformHttpRequest(Webhook, function(err, text, headers)
    end, 'POST', json.encode({
        username = Config.BotName,
        embeds = information
    }), {
        ['Content-Type'] = 'application/json'
    })
end
