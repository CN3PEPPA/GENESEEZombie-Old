local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local cfg = module(GetCurrentResourceName(), "sv_config")
local src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)
local vRPclient = Tunnel.getInterface("vRP")

local playersInChannel = {} -- vou precisar? Em pesquisa, fazer depois.

function src.CheckRadioItem()
    local user_id = vRP.getUserId(source)
    if user_id then
        return vRP.getInventoryItemAmount(user_id, cfg.radio_item) >= 1
    end
    return false
end

function src.checkFrequency(freq)
    freq = tonumber(freq)
    local user_id = vRP.getUserId(source)
    if user_id then
        if cfg.frequency[freq] then
            if vRP.hasPermission(user_id, cfg.frequency[freq]) then
                local k = "f_" .. freq
                if not playersInChannel[k] then
                    playersInChannel[k] = {}
                end
                local ui = vRP.getUserIdentity(user_id)
                local player_name = ui.firstname .. " " .. ui.lastname
                playersInChannel[k][user_id] = player_name
                return true
            end
        else
            if freq > 0 and freq <= 9999 then
                return true
            end
        end
    end
    return false
end

RegisterNetEvent("vrp_radio:RemovePlayerFromChannel", function(freq, user_id)
    if playersInChannel["f_" .. freq] then
        playersInChannel["f_" .. freq][user_id] = nil
    end
end)