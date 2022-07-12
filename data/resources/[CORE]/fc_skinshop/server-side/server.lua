-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("fc_skinshop",cnVRP)
vCLIENT = Tunnel.getInterface("fc_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO 
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"mod.permissao") then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui permissão para fazer essa ação.") 
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.updateClothes(clothes,demand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if demand then
		 	local valor = math.random(50,125)
		 	if vRP.tryFullPayment(user_id,valor) then
		 		TriggerClientEvent("Notify",source,"sucesso","Voce pagou $"..valor.." em roupas.",5000)
		 	else
		 		TriggerClientEvent("Notify",source,"negado","Voce nao tem dinheiro.",5000)
		 	end
		end
		vRP.setUData(user_id,"Clothings",clothes)
	end
end