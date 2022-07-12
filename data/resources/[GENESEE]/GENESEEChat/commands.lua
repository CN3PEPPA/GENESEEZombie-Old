local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

chat = {}
Tunnel.bindInterface("GENESEEChat", chat)
Proxy.addInterface("GENESEEChat", chat)

local canAdvertise = true

if Config.AllowPlayersToClearTheirChat then
    RegisterCommand(Config.ClearChatCommand, function(source, args, rawCommand)
        TriggerClientEvent('chat:client:ClearChat', source)
    end)
end

if Config.AllowStaffsToClearEveryonesChat then
    RegisterCommand(Config.ClearEveryonesChatCommand, function(source, args, rawCommand)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local time = os.date(Config.DateFormat)

        TriggerClientEvent('chat:client:ClearChat', -1)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">The chat has been cleared!</div></div>',
            args = {time}
        })
    end)
end

if Config.EnableStaffCommand then
    RegisterCommand(Config.StaffCommand, function(source, args, rawCommand)
        local xPlayer = vRP.getUserId(source)
        local length = string.len(Config.StaffCommand)
        local message = rawCommand:sub(length + 1)
        local time = os.date(Config.DateFormat)

        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message staff"><i class="fas fa-shield-alt"></i> <b><span style="color: #ffffff">[STAFF] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
            args = {xPlayer, message, time}
        })
    end)
end

if Config.EnableOOCCommand then
    RegisterCommand(Config.OOCCommand, function(source, args, rawCommand)
        local xPlayer = vRP.getUserId(source)
        local length = string.len(Config.OOCCommand)
        local message = rawCommand:sub(length + 1)
        local time = os.date(Config.DateFormat)
        
        TriggerClientEvent('chat:ooc', -1, source, xPlayer, message, time)
    end)
end
