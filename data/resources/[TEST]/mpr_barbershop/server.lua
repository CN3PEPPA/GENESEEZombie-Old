-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

nyoBSClient = Tunnel.getInterface(GetCurrentResourceName())
nyoBSServer = {}
Tunnel.bindInterface(GetCurrentResourceName(),nyoBSServer)

-----------------------------------------------------------------
-- | Functions [1]
-----------------------------------------------------------------
function nyoBSServer.checkout(preco, custom)
	local source = source 
	local user_id = vRP.getUserId(source)
	vRP.setUData(user_id,"currentCharacterMode", custom)
	TriggerClientEvent("Notify",source,"sucesso","Você cortou o cabelo",10000)
end


function nyoBSServer.checkProcurado() 
    local user_id = vRP.getUserId(source)
	return vRP.searchReturn(source,user_id)
end


AddEventHandler("creator-barbershop:init", function(user_id)
	local player = vRP.getUserSource(user_id)
	if player then
		local value = vRP.getUData(user_id,"currentCharacterMode")
		if value ~= nil then
            local custom = json.decode(value) or {}
			nyoBSClient.setCharacter(player,custom)
		end
	end
end)