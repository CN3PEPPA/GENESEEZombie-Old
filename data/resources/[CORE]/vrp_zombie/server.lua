local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

pz_zombie = {}
Tunnel.bindInterface("vrp_zombie", pz_zombie)

function pz_zombie.verifyImunePlayers()
  local source = source
  local user_id = vRP.getUserId(source)
  local players = config.imunePlayers
  local imune = false
  for k, v in pairs(players) do
    if v == user_id then
      imune = true
    end
  end
  return imune
end