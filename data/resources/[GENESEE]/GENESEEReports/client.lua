Citizen.CreateThread(function()
    Wait(1000)
    TriggerServerEvent("GENESEEReports:FetchFeedbackTable")
end)

-------------------------- VARS

local oneSync = false
local staff = false
local FeedbackTable = {}
local canFeedback = true
local timeLeft = Config.FeedbackCooldown

-------------------------- COMMANDS

RegisterCommand(Config.FeedbackClientCommand, function(source, args, rawCommand)
    if canFeedback then
        FeedbackMenu(false)
    else
        -- exports['okokNotify']:Alert("REPORT", "You can't report so quickly!", 10000, 'warning')
        TriggerEvent("Notify", "negado", "Você não pode relatar tão rapidamente!")
    end
end, false)

RegisterCommand(Config.FeedbackAdminCommand, function(source, args, rawCommand)
    if staff then
        FeedbackMenu(true)
    end
end, false)

-------------------------- MENU

function FeedbackMenu(showAdminMenu)
    SetNuiFocus(true, true)
    if showAdminMenu then
        SendNUIMessage({
            action = "updateFeedback",
            FeedbackTable = FeedbackTable
        })
        SendNUIMessage({
            action = "OpenAdminFeedback"
        })
    else
        SendNUIMessage({
            action = "ClientFeedback"
        })
    end
end

-------------------------- EVENTS

RegisterNetEvent('GENESEEReports:NewFeedback')
AddEventHandler('GENESEEReports:NewFeedback', function(newFeedback)
    if staff then
        FeedbackTable[#FeedbackTable + 1] = newFeedback
        -- exports['okokNotify']:Alert("REPORT", "New Report Some one needs help!", 20000, 'success')
        TriggerEvent("Notify", "sucesso", "Novo relatório Alguém precisa de ajuda!")
        SendNUIMessage({
            action = "updateFeedback",
            FeedbackTable = FeedbackTable
        })
    end
end)

RegisterNetEvent('GENESEEReports:FetchFeedbackTable')
AddEventHandler('GENESEEReports:FetchFeedbackTable', function(feedback, admin, oneS)
    FeedbackTable = feedback
    staff = admin
    oneSync = oneS
end)

RegisterNetEvent('GENESEEReports:FeedbackConclude')
AddEventHandler('GENESEEReports:FeedbackConclude', function(feedbackID, info)
    local feedbackid = FeedbackTable[feedbackID]
    feedbackid.concluded = info

    SendNUIMessage({
        action = "updateFeedback",
        FeedbackTable = FeedbackTable
    })
end)

-------------------------- ACTIONS

RegisterNUICallback("action", function(data)
    if data.action ~= "concludeFeedback" then
        SetNuiFocus(false, false)
    end

    if data.action == "newFeedback" then
        -- exports['okokNotify']:Alert("REPORT", "Report successfully sent to the STAFF!", 20000, 'success')
        TriggerEvent("Notify", "sucesso", "Relatório enviado com sucesso para o STAFF!")

        local feedbackInfo = {
            subject = data.subject,
            information = data.information,
            category = data.category
        }
        TriggerServerEvent("GENESEEReports:NewFeedback", feedbackInfo)

        local time = Config.FeedbackCooldown * 60
        local pastTime = 0
        canFeedback = false

        while (time > pastTime) do
            Citizen.Wait(1000)
            pastTime = pastTime + 1
            timeLeft = time - pastTime
        end
        canFeedback = true
    elseif data.action == "assistFeedback" then
        if FeedbackTable[data.feedbackid] then
            if oneSync then
                TriggerServerEvent("GENESEEReports:AssistFeedback", data.feedbackid, true)
            else
                local playerFeedbackID = FeedbackTable[data.feedbackid].playerid
                local playerID = GetPlayerFromServerId(playerFeedbackID)
                local playerOnline = NetworkIsPlayerActive(playerID)
                if playerOnline then
                    SetEntityCoords(PlayerPedId(),
                        GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerFeedbackID))))
                    TriggerServerEvent("GENESEEReports:AssistFeedback", data.feedbackid, true)
                else
                    -- exports['okokNotify']:Alert("REPORT", "That player is no longer in the server!", 20000, 'error')
                    TriggerEvent("Notify", "negado", "Esse jogador não está mais no servidor!")
                end
            end
        end
    elseif data.action == "concludeFeedback" then
        local feedbackID = data.feedbackid
        local canConclude = data.canConclude
        local feedbackInfo = FeedbackTable[feedbackID]
        if feedbackInfo then
            if feedbackInfo.concluded ~= true or canConclude then
                TriggerServerEvent("GENESEEReports:FeedbackConclude", feedbackID, canConclude)
                -- exports['okokNotify']:Alert("FEEDBACK", "Feedback #" .. feedbackID .. " concluded!", 20000, 'success')
                TriggerEvent("Notify", "sucesso", "Feedback #" .. feedbackID .. " concluido!")
            end
        end
    end
end)
