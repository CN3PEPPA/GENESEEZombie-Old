CreateThread(function()
    local models = {"hei_prop_drug_statue_box_big", "hei_prop_drug_statue_stack", "hei_prop_heist_box",
                    "prop_rub_cardpile_07", "prop_cratepile_02a", "prop_cratepile_05a", "prop_rub_cage01b",
                    "prop_rub_boxpile_01", "prop_rub_boxpile_10", "prop_rub_boxpile_02", "prop_crate_02a",
                    "prop_skid_trolley_2", "prop_homeles_shelter_02", "prop_cs_cardbox_01", "prop_champ_box_01",
                    "prop_tool_box_07", "prop_cs_rub_box_02", "prop_beer_box_01", "prop_box_wood05a", "v_ret_ta_box",
                    "v_ind_cf_chckbox2", "prop_cardbordbox_03a", "prop_box_wood02a", "prop_boxpile_03a",
                    "prop_boxpile_07d", "prop_cardbordbox_04a", "prop_box_ammo01a", "prop_boxpile_05a",
                    "prop_box_wood02a_pu", "prop_box_wood01a", "v_ret_gc_box1", "v_ind_cs_box01", "prop_box_wood07a",
                    "prop_cardbordbox_02a", "xs_prop_arena_bag_01", "prop_bin_08a", "prop_luggage_08a",
                    "prop_cardbordbox_05a", "prop_luggage_01a", "prop_luggage_02a", "prop_luggage_09a",
                    "v_med_p_tidybox", "v_res_filebox01", "v_corp_tallcabdark01", "v_corp_deskdrawdark01",
                    "v_corp_deskdraw", "v_serv_waste_bin1", "v_res_smallplasticbox", "v_corp_offshelf",
                    "v_ind_rc_workbag", "v_corp_lowcabdark01", "prop_gas_smallbin01", "v_ret_gc_bin",
                    "prop_recyclebin_02_d", "prop_recyclebin_02b", "prop_recyclebin_02a"}

    exports['target']:AddTargetModel(models, { -- Isso define os modelos, pode ser uma string ou uma tabela
        options = { -- Esta é sua tabela de opções, nesta tabela todas as opções serão especificadas para o destino aceitar
        { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "server", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "pz_loot:loot", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
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
