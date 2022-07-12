RegisterKeyMapping('vrp_inventory:openInv', 'Inventário', 'keyboard', binds.inventory)

RegisterCommand('vrp_inventory:openInv', function()
    TriggerEvent('vrp_inventory:openInv')
end)

----------------------------------------------------------------------------------------------------

RegisterKeyMapping('vrp_hud:belt', 'Cinto de segurança', 'keyboard', binds.belt)

RegisterCommand('vrp_hud:belt', function()
    TriggerEvent('vrp_hud:belt')
end)
