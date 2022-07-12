local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent("pz_kits:open")
AddEventHandler("pz_kits:open", function(type, user_id)

  local kits
  if type == "small" then
    kits = config.small
  elseif type == "medium" then
    kits = config.medium
  else
    kits = config.big
  end

  for _, kit in ipairs(kits) do
    
    local drop = math.random(1,2)
    if drop == 1 then
      vRP.giveInventoryItem(user_id, kit[1], parseInt(kit[2]))
    end
  end
end)