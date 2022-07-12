CreateThread(function()
    local models = {"prop_rub_carwreck_2", "prop_rub_carwreck_3", "prop_rub_carwreck_5", "prop_rub_carwreck_7",
                    "prop_rub_carwreck_8", "prop_rub_carwreck_9", "prop_rub_carwreck_10", "prop_rub_carwreck_11",
                    'prop_rub_carwreck_12', "prop_rub_carwreck_14", "prop_rub_carwreck_15", "prop_rub_carwreck_16",
                    "prop_rub_buswreck_06", "prop_tanktrailer_01a", "prop_gas_pump_old2", "prop_gas_pump_1a",
                    "prop_gas_pump_old3", "prop_gas_pump_1c", "prop_gas_pump_1b", "prop_gas_pump_1b"}

    exports['target']:AddTargetModel(models, { -- Isso define os modelos, pode ser uma string ou uma tabela
        options = { -- Esta é sua tabela de opções, nesta tabela todas as opções serão especificadas para o destino aceitar
        { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "server", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "pz_loot:fuel", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-gas-pump', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Procurar Gasolina' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
            -- targeticon = 'fa-solid fa-gas-pump' -- Este é o ícone do próprio alvo, o ícone muda para isso quando fica azul nesta opção específica, isso é OPCIONAL

            -- item = 'handcuffs' -- Este é o item que ele deve verificar, esta opção só aparecerá se o jogador tiver este item, isso é OPCIONAL
            -- action = function(entity) -- Esta é a ação que ele deve realizar, isso SUBSTITUI o evento e isso é OPCIONAL
            --    if IsPedAPlayer(entity) then
            --        return false
            --    end -- Isso retornará false se a entidade com a qual interagiu for um jogador e, caso contrário, retornará true
            --    TriggerEvent('testing:event', 'test') -- Aciona um evento de cliente chamado testing:event e envia o argumento 'test' com ele
            -- end,
            -- canInteract = function(entity, distance, data) -- Isso verificará se você pode interagir com ele, isso não aparecerá se retornar falso, isso é OPCIONAL
            --    if IsPedAPlayer(entity) then
            --        return false
            --    end -- Isso retornará false se a entidade com a qual interagiu for um jogador e, caso contrário, retornará true
            --    return true
            -- end,
        }},
        distance = 1.5 -- Esta é a distância que você deve estar para o alvo ficar azul, isso está em unidades GTA e tem que ser um valor flutuante
    })
end)

RegisterNetEvent('GENESEETarget:FuelCL')
AddEventHandler('GENESEETarget:FuelCL', function()

end)
