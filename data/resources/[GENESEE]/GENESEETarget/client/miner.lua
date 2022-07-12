local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

target = {}
Tunnel.bindInterface("GENESEETarget", target)
Proxy.addInterface("GENESEETarget", target)

CreateThread(function()
    local models = {'prop_rock_1_a','prop_rock_1_b','prop_rock_1_c','prop_rock_1_d','prop_rock_1_e','prop_rock_1_f','prop_rock_1_g','prop_rock_1_h','prop_rock_1_i','prop_rock_1_j',
    'prop_rock_2_a','prop_rock_2_c','prop_rock_2_d','prop_rock_2_f','prop_rock_2_g','prop_rock_3_a','prop_rock_3_b','prop_rock_3_c','prop_rock_3_d','prop_rock_3_e','prop_rock_3_f',
    'prop_rock_3_g','prop_rock_3_h','prop_rock_3_i','prop_rock_3_j','prop_rock_4_a','prop_rock_4_b','prop_rock_4_big','prop_rock_4_big2','prop_rock_4_c','prop_rock_4_c_2',
    'prop_rock_4_cl_1','prop_rock_4_cl_2','prop_rock_4_d','prop_rock_4_e','prop_rock_5_b','prop_rock_5_c','prop_rock_5_d','prop_rock_5_e','prop_rock_5_smash1','prop_rock_5_smash2',
    'prop_rock_5_smash3','rock_4_cl_2_1','rock_4_cl_2_2'}

    exports['target']:AddTargetModel(models, { -- Isso define os modelos, pode ser uma string ou uma tabela
        options = { -- Esta é sua tabela de opções, nesta tabela todas as opções serão especificadas para o destino aceitar
        { -- Esta é a primeira tabela com opções, você pode fazer quantas opções quiser dentro da tabela de opções
            type = "server", -- Isso especifica o tipo de evento que o alvo deve acionar ao clicar, pode ser "cliente", "servidor" ou "comando", isso é OPCIONAL e só funcionará se o evento também for especificado
            event = "pz_loot:miner", -- Este é o evento que será acionado ao clicar, este pode ser um evento de cliente, evento de servidor ou comando
            icon = 'fa-solid fa-screwdriver-wrench', -- Este é o ícone que será exibido ao lado desta opção de gatilho
            label = 'Minerar' -- Este é o rótulo desta opção que você poderá clicar para acionar tudo, isso tem que ser uma string
            -- targeticon = 'fa-solid fa-gas-pump' -- Este é o ícone do próprio alvo, o ícone muda para isso quando fica azul nesta opção específica, isso é OPCIONAL

            -- item = 'handcuffs' -- Este é o item que ele deve verificar, esta opção só aparecerá se o jogador tiver este item, isso é OPCIONAL
            -- action = function(entity) -- Esta é a ação que ele deve realizar, isso SUBSTITUI o evento e isso é OPCIONAL
            --    if IsPedAPlayer(entity) then
            --        return false
            --    end -- Isso retornará false se a entidade com a qual interagiu for um jogador e, caso contrário, retornará true
            --    TriggerEvent('testing:event', 'test') -- Aciona um evento de cliente chamado testing:event e envia o argumento 'test' com ele
            -- end,
            -- canInteract = function(entity, distance, data) -- Isso verificará se você pode interagir com ele, isso não aparecerá se retornar falso, isso é OPCIONAL
            --    if GetEntityHealth(entity) == 0 then
            --        return true
            --    else
            --        return false
            --    end
            -- end
        }},
        distance = 1.5 -- Esta é a distância que você deve estar para o alvo ficar azul, isso está em unidades GTA e tem que ser um valor flutuante
    })
end)

RegisterNetEvent('GENESEETarget:MinerCL')
AddEventHandler('GENESEETarget:MinerCL', function()

end)
