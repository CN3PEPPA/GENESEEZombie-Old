local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

template = {}
Tunnel.bindInterface("GENESEETemplate", template)
Proxy.addInterface("GENESEETemplate", template)
