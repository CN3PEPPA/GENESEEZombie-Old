CreateThread(function()
    local models = {"prop_bin_01a", "prop_bin_03a", "prop_bin_05a", "prop_dumpster_01a", "prop_dumpster_02a",
                    "prop_dumpster_02b", "prop_dumpster_4a", "prop_dumpster_4b", "prop_rub_binbag_03b",
                    "prop_rub_binbag_01b", "prop_bin_06a", "prop_rub_binbag_05", "prop_bin_02a",
                    "prop_rub_binbag_04", "prop_rub_binbag_06", "prop_skip_04", "prop_cs_bin_02", "prop_skip_03"}

    exports['target']:AddTargetModel(models, { -- Isso define os modelos, pode ser uma string ou uma tabela
        options = { -- Esta é sua tabela de opções, nesta tabela todas as opções serão especificadas para o destino aceitar
        { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "server", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "pz_loot:loot", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-trash', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Vasculhar', -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
            -- targeticon = 'fa-solid fa-trash-can' -- Este é o ícone do próprio alvo, o ícone muda para isso quando fica azul nesta opção específica, isso é OPCIONAL

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

RegisterNetEvent('GENESEETarget:TrashCL')
AddEventHandler('GENESEETarget:TrashCL', function()

end)
