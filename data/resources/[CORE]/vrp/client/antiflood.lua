local webhook_antiflood = ""
local delayflood = {}
local flood = {}

function vRP.antiflood(source, key, limite)
    if (flood[key] == nil or delayflood[key] == nil) then
        flood[key] = {}
        delayflood[key] = {}
    end
    if (flood[key][source] == nil) then
        flood[key][source] = 1
        delayflood[key][source] = os.time()
    else
        if (os.time() - delayflood[key][source] < 1) then
            flood[key][source] = flood[key][source] + 1
            if (flood[key][source] == limite) then
                local user_id = vRP.getUserId(source)
                vRP.setBanned(user_id, true)
                
                DropPlayer(source, "Hoje não!")

                mensagem =
                    "[ID]: " .. user_id .. " \n[ANTI-FLOOD] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") ..
                        "FLOOD :" .. key
                PerformHttpRequest(webhook_antiflood, function(err, text, headers)
                end, 'POST', json.encode({
                    content = mensagem
                }), {
                    ['Content-Type'] = 'application/json'
                })
            end
        else
            flood[key][source] = nil
            delayflood[key][source] = nil
        end
        delayflood[key][source] = os.time()
    end
end
