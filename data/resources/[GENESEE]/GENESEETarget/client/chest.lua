CreateThread(function()
    local models = {"bau"}

    exports['target']:AddTargetModel(models, { -- Isso define os modelos, pode ser uma string ou uma tabela
        options = {{ -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "client", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "GENESEETarget:ChestCL", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-toolbox', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Utilizar Bau' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
        },
                   { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "client", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "GENESEETarget:DeleteChest", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-xmark', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Abandonar Bau' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
        },
                   { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "client", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "GENESEETarget:UpgradeChest", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-wrench', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Upgrade Bau' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
        },
                   { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "client", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "GENESEETarget:RestoreChest", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-rotate', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Restaurar Bau' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
        },
                   { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "client", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "GENESEETarget:LockpickChest", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-unlock-keyhole', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Arrombar Baú', -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
        }},
        distance = 2.5 -- Esta é a distância que você deve estar para o alvo ficar azul, isso está em unidades GTA e tem que ser um valor flutuante
    })
end)

RegisterNetEvent('GENESEETarget:ChestCL')
AddEventHandler('GENESEETarget:ChestCL', function(entity)
    local coords = GetEntityCoords(entity.entity)

    TriggerServerEvent('vrp_chest:openChest', coords.x, coords.y, coords.z)
end)

RegisterNetEvent('GENESEETarget:DeleteChest')
AddEventHandler('GENESEETarget:DeleteChest', function(entity)
    local coords = GetEntityCoords(entity.entity)
    
    TriggerServerEvent('vrp_chest:destroyChest', entity.entity, ObjToNet(entity.entity), coords.x, coords.y, coords.z)
end)

RegisterNetEvent('GENESEETarget:UpgradeChest')
AddEventHandler('GENESEETarget:UpgradeChest', function(entity)
    local coords = GetEntityCoords(entity.entity)
    TriggerServerEvent('vrp_chest:upgradeChest', entity.entity, coords.x, coords.y, coords.z)
end)

RegisterNetEvent('GENESEETarget:LockpickChest')
AddEventHandler('GENESEETarget:LockpickChest', function(entity)
    local coords = GetEntityCoords(entity.entity)
    TriggerServerEvent('vrp_chest:unlockChest', entity.entity, coords.x, coords.y, coords.z)
end)

RegisterNetEvent('GENESEETarget:RestoreChest')
AddEventHandler('GENESEETarget:RestoreChest', function(entity)
    local coords = GetEntityCoords(entity.entity)
    TriggerServerEvent('vrp_chest:resetChest', entity.entity, coords.x, coords.y, coords.z)
end)
