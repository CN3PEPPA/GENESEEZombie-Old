CreateThread(function()
    local models = {"ex_prop_crate_closed_ms", "ex_prop_crate_highend_pharma_sc", "ba_prop_battle_crate_m_medical",
                    "ba_prop_battle_crate_med_bc", "xm_prop_smug_crate_s_medical", "ex_prop_crate_med_sc",
                    "ex_prop_crate_pharma_bc", "sm_prop_smug_crate_l_medical", "sm_prop_smug_crate_m_medical",
                    "sm_prop_smug_crate_s_medical", "v_med_trolley", "v_med_bench1 ", "v_med_cor_wallunita",
                    "v_med_cor_wallunitb", "v_med_lab_fridge", "v_med_cor_cembin", "v_med_bottles1", "v_med_bottles3",
                    "v_med_cor_fileboxa", "v_40_receptiondesk2", "v_med_trolley2", "v_med_latexgloveboxblue",
                    "v_med_lab_wallcab", "v_med_bench2", "xm_prop_x17_bag_med_01a"}

    exports['target']:AddTargetModel(models, { -- Isso define os modelos, pode ser uma string ou uma tabela
        options = { -- Esta é sua tabela de opções, nesta tabela todas as opções serão especificadas para o destino aceitar
        { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "server", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "pz_loot:medical", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-pen-ruler', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Vasculhar' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
            -- targeticon = 'fa-solid fa-gas-pump' -- Este é o ícone do próprio alvo, o ícone muda para isso quando fica azul nesta opção específica, isso é OPCIONAL

            -- item = 'handcuffs' -- Este é o item que ele deve verificar, esta opção só aparecerá se o jogador tiver este item, isso é OPCIONAL
            -- action = function(entity) -- Esta é a ação que ele deve realizar, isso SUBSTITUI o evento e isso é OPCIONAL
            --    if IsPedAPlayer(entity) then
            --        return false
            --    end -- Isso retornará false se a entidade com a qual interagiu for um jogador e, caso contrário, retornará true
            --    TriggerEvent('testing:event', 'test') -- Aciona um evento de cliente chamado testing:event e envia o argumento 'test' com ele
            -- end,
            -- canInteract = function(entity, distance, data) -- Isso verificará se você pode interagir com ele, isso não aparecerá se retornar falso, isso é OPCIONAL
            --    if GetEntityHealth(entity) <= 101 then
            --        return true
            --    else
            --        return false
            --    end
            -- end
        }},
        distance = 1.5 -- Esta é a distância que você deve estar para o alvo ficar azul, isso está em unidades GTA e tem que ser um valor flutuante
    })
end)

RegisterNetEvent('GENESEETarget:AnimalsCL')
AddEventHandler('GENESEETarget:AnimalsCL', function()

end)
