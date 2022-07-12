CreateThread(function()
    local models = {"prop_toolchest_01", "prop_toolchest_02","prop_toolchest_03","prop_toolchest_04","prop_toolchest_05","prop_toolchest_03_l2"}

    exports['target']:AddTargetModel(models, { -- Isso define os modelos, pode ser uma string ou uma tabela
        options = { -- Esta é sua tabela de opções, nesta tabela todas as opções serão especificadas para o destino aceitar
        { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "server", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "pz_loot:vehicle", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-box-open', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Vasculhar' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
            -- targeticon = 'fa-solid fa-treasure-chest' -- Este é o ícone do próprio alvo, o ícone muda para isso quando fica azul nesta opção específica, isso é OPCIONAL

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
