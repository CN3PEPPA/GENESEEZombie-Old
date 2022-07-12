local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

pz = {}
Tunnel.bindInterface("pz_loot", pz)

local cfg = {}

cfg.common = {"agua", "radio", "isca", "sacodelixo", "mascara", "oculos", "blusa", "jaqueta", "calca", "luvas",
            "sapatos", "chapeu", "prego", "parafuso", "alicate", "martelo", "serra", "chave_philips", "graveto",
            "chave_fenda", "placa_plastico","fragmento_plastico", "placa_metal", "fragmento_borracha", "fragmento_metal", "pilha", "fita",
            "corda", "pano", "linha", "agulha", "bau","blueprint"}

cfg.drink = {"leite", "agua", "limonada", "refrigerante", "cafe", "cerveja", "tequila", "vodka", "whisky", "conhaque", "absinto", "energetico"}

cfg.food = {"chocolate", "sardinha", "feijao", "atum", "arroz", "agua","farinha","ovo","acucar"}

cfg.medical = {"paracetamol", "voltarem", "tandrilax", "dorflex", "buscopan", "bandagem", "kit_medico"}

cfg.ammo = {"capsulas", "polvora", "wammoWEAPON_PISTOL_MK2", "wammoWEAPON_COMBATPISTOL", "wammoWEAPON_PISTOL", "wammoWEAPON_PUMPSHOTGUN", "wammoWEAPON_MICROSMG"}

cfg.vehicle = {"oil_lvl_1", "engine_lvl_1", "turbo_lvl_1", "nos_lvl_1", "transmission_lvl_1", "suspension_lvl_1",
            "tires_lvl_1", "brakes_lvl_1", "sparkplugs_lvl_1", "blocomotor", "pistao", "fragmento_borracha",
            "fragmento_metal", "alicate", "martelo", "velaignicao", "chave_fenda"}

cfg.weapon = {"gatilho", "molas", "wbodyWEAPON_PISTOL", "wbodyWEAPON_COMBATPISTOL", "wbodyWEAPON_PISTOL_MK2"}

cfg.miner = {"calcario", "areia", }

looting = {}

cooldownHunt = {}
cooldownWood = {}
cooldownWater = {}
cooldownFuel = {}
cooldownZombie = {}
cooldownDrink = {}
cooldownFood = {}
cooldownMedical = {}
cooldownWeapon = {}
cooldownLoot = {}
cooldownVehicle = {}
cooldownMiner = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k, v in pairs(looting) do

        end
        for k, v in pairs(cooldownHunt) do
            if v > 0 then
                cooldownHunt[k] = v - 1
            else
                cooldownHunt[k] = nil
            end
        end
        for k, v in pairs(cooldownWood) do
            if v > 0 then
                cooldownWood[k] = v - 1
            else
                cooldownWood[k] = nil
            end
        end
        for k, v in pairs(cooldownWater) do
            if v > 0 then
                cooldownWater[k] = v - 1
            else
                cooldownWater[k] = nil

            end
        end
        for k, v in pairs(cooldownFuel) do
            if v > 0 then
                cooldownFuel[k] = v - 1
            else
                cooldownFuel[k] = nil
            end
        end
        for k, v in pairs(cooldownZombie) do
            if v > 0 then
                cooldownZombie[k] = v - 1
            else
                cooldownZombie[k] = nil

            end
        end
        for k, v in pairs(cooldownDrink) do
            if v > 0 then
                cooldownDrink[k] = v - 1
            else
                cooldownDrink[k] = nil

            end
        end
        for k, v in pairs(cooldownFood) do
            if v > 0 then
                cooldownFood[k] = v - 1
            else
                cooldownFood[k] = nil

            end
        end
        for k, v in pairs(cooldownMedical) do
            if v > 0 then
                cooldownMedical[k] = v - 1
            else
                cooldownMedical[k] = nil

            end
        end
        for k, v in pairs(cooldownWeapon) do
            if v > 0 then
                cooldownWeapon[k] = v - 1
            else
                cooldownWeapon[k] = nil
            end
        end
        for k, v in pairs(cooldownLoot) do
            if v > 0 then
                cooldownLoot[k] = v - 1
            else
                cooldownLoot[k] = nil
            end
        end
        for k, v in pairs(cooldownVehicle) do
            if v > 0 then
                cooldownVehicle[k] = v - 1
            else
                cooldownVehicle[k] = nil
            end
        end
        for k, v in pairs(cooldownMiner) do
            if v > 0 then
                cooldownMiner[k] = v - 1
            else
                cooldownMiner[k] = nil
            end
        end
    end
end)

RegisterServerEvent('pz_loot:hunt')
AddEventHandler('pz_loot:hunt', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    local item = GetSelectedPedWeapon(GetPlayerPed(source)) == GetHashKey("WEAPON_KNIFE")

    if looting[user_id] == nil then
        if item then
            if cooldownHunt[prop] == nil then
                cooldownHunt[prop] = 600
                looting[user_id] = true

                local chances = math.random(1, 100)

                if chances <= 10 then
                    item = 'pele_alta_qualidade'
                elseif chances >= 11 and chances <= 20 then
                    item = 'pele_media_qualidade'
                else
                    item = 'pele_baixa_qualidade'
                end

                vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
                TriggerClientEvent("progress", source, 15000, "Esfolando animal")

                Wait(15000)
                vRPclient._stopAnim(source, false)

                TriggerEvent("DropSystem:create", item, 1, x, y, z, 120)
                TriggerEvent("DropSystem:create", 'carne_caca', 1, x, y, z, 120)
                TriggerClientEvent("GENESEESync:areasmall", -1, x, y, z)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil
            else
                TriggerClientEvent("Notify", source, "aviso", "Você deve aguardar ate o proximo LOOT nesse local")
            end
        else
            TriggerClientEvent("Notify", source, "aviso", "Você precisa de uma <b>Faca</b> para fazer isso.")
        end
    end
end)

RegisterServerEvent('pz_loot:wood')
AddEventHandler('pz_loot:wood', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    local item = GetSelectedPedWeapon(GetPlayerPed(source)) == GetHashKey("WEAPON_HATCHET")

    if looting[user_id] == nil then
        if item then
            if cooldownWood[prop] == nil then
                cooldownWood[prop] = 600
                looting[user_id] = true

                local quantity = math.random(1, 5)

                vRPclient._playAnim(source, false, {{"melee@hatchet@streamed_core", "plyr_front_takedown_b"}}, true)
                TriggerClientEvent("progress", source, 15000, "Cortando madeira")
                
                Wait(15000)
                vRPclient._stopAnim(source, false)

                TriggerEvent("DropSystem:create", 'tora', quantity, x, y, z, 120)
                TriggerClientEvent("GENESEESync:areasmall", -1, x, y, z)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil

            else
                TriggerClientEvent("Notify", source, "aviso", "Você deve aguardar ate o proximo LOOT nesse local")

            end
        else
            TriggerClientEvent("Notify", source, "aviso", "Você precisa de um <b>Machado</b> para isso.")

        end
    end
end)

RegisterServerEvent('pz_loot:water')
AddEventHandler('pz_loot:water', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    local item = GetSelectedPedWeapon(GetPlayerPed(source)) == GetHashKey("WEAPON_KNIFE")
    local itemWater = vRP.getInventoryItemAmount(user_id, 'garrafa-vazia') >= 1

    if looting[user_id] == nil then
        if item then
            if itemWater then
                if cooldownWater[prop] == nil then
                    cooldownWater[prop] = 600
                    looting[user_id] = true

                    local chances = math.random(1, 100)

                    if chances <= 20 then
                        item = 'agua'
                    else
                        item = 'agua-impropria'
                    end

                    vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
                    TriggerClientEvent("progress", source, 15000, "Coletando agua")

                    Wait(15000)
                    vRPclient._stopAnim(source, false)

                    vRP.tryGetInventoryItem(user_id, 'garrafa-vazia', 1)

                    TriggerEvent("DropSystem:create", 'agua', 1, x, y, z, 120)
                    TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                    looting[user_id] = nil

                else
                    TriggerClientEvent("Notify", source, "aviso", "Você deve aguardar ate o proximo LOOT nesse local")

                end
            else
                TriggerClientEvent("Notify", source, "aviso", "Você precisa de uma garrafa vazia")
            end
        else
            TriggerClientEvent("Notify", source, "aviso", "Você precisa de um <b>Faca</b> para isso.")

        end
    end
end)

RegisterServerEvent('pz_loot:fuel')
AddEventHandler('pz_loot:fuel', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownFuel[prop] == nil then
            cooldownFuel[prop] = 3600
            looting[user_id] = true

            vRPclient._playAnim(source, false, {{"amb@medic@standing@kneel@enter", "enter"}}, true)
            TriggerClientEvent("progress", source, 15000, "Procurando gasolina")

            Wait(15000)
            vRPclient._stopAnim(source, false)

            local quantity = math.random(1, 10)
            local chances = math.random(1, 100)

            if chances <= 10 then
                TriggerEvent("DropSystem:create", 'gasolina', quantity, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso",
                    "Você encontrou <b>" .. quantity .. "</b> litros de gasolina.")

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil

            else
                TriggerClientEvent("Notify", source, "negado", "Você não encontrou combustível")

                looting[user_id] = nil

            end
        else
            TriggerClientEvent("Notify", source, "aviso", "Você deve aguardar até o proximo LOOT nesse local")

        end
    end
end)

RegisterServerEvent('pz_loot:zombie')
AddEventHandler('pz_loot:zombie', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownZombie[prop] == nil then
            cooldownZombie[prop] = 60
            looting[user_id] = true

            local chances = math.random(1, 100)

            local item = math.random(1, #cfg.common)
            local itemName = vRP.itemNameList(cfg.common[item])

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 4000, "Revistando zombie")

            Wait(4000)
            vRPclient._stopAnim(source, false)

            if itemName == "radio" or "chave" or "mascara" or "oculos" or "blusa" or "jaqueta" or "calca" or "luvas" or
                "sapatos" or "chapeu" or "prego" or "parafuso" or "alicate" or "martelo" or "serra" or "chave_philips" or
                "chave_fenda" then
                quantity = "1"
            else
                quantity = math.random(1, 2)
            end

            if chances <= 30 then
                TriggerEvent("DropSystem:create", cfg.common[item], quantity, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso",
                    "Você encontrou <b>" .. quantity .. "x</b> " .. itemName)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil
            elseif chances <= 45 and chances <= 50 then
                TriggerEvent("DropSystem:create", 'zcola', 1, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>1x</b> ZCola")

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil
            else
                TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                looting[user_id] = nil

            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar ate o proximo LOOT nesse local")
        end
    end
end)

RegisterServerEvent('pz_loot:drink')
AddEventHandler('pz_loot:drink', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownDrink[prop] == nil then
            cooldownDrink[prop] = 300
            looting[user_id] = true

            local chances = math.random(1, 100)

            local item = math.random(1, #cfg.drink)
            local itemName = vRP.itemNameList(cfg.drink[item])

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 4000, "Procurando bebidas")

            Wait(4000)
            vRPclient._stopAnim(source, false)

            if chances <= 30 then
                TriggerEvent("DropSystem:create", cfg.drink[item], 1, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>1x</b> " .. itemName)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil
                
            elseif chances <= 45 and chances <= 50 then
                TriggerEvent("DropSystem:create", 'zcola', 1, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>1x</b> ZCola")

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil

            else
                TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                looting[user_id] = nil

            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar ate o proximo LOOT nesse local")

        end
    end
end)

RegisterServerEvent('pz_loot:miner')
AddEventHandler('pz_loot:miner', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownMiner[prop] == nil then
            cooldownMiner[prop] = 300
            looting[user_id] = true

            local item = math.random(1, #cfg.miner)
            local itemName = vRP.itemNameList(cfg.miner[item])

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 15000, "Minerando")

            Wait(15000)
            vRPclient._stopAnim(source, false)

            TriggerEvent("DropSystem:create", cfg.miner[item], 3, x, y, z, 120)

            TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>3x</b> " .. itemName)

            TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

            looting[user_id] = nil
        else
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar ate o proximo LOOT nesse local")
        end
    end
end)

RegisterServerEvent('pz_loot:medical')
AddEventHandler('pz_loot:medical', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownMedical[prop] == nil then
            cooldownMedical[prop] = 900
            looting[user_id] = true

            local chances = math.random(1, 100)

            local item = math.random(1, #cfg.medical)
            local itemName = vRP.itemNameList(cfg.medical[item])

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 4000, "Vasculhando")

            Wait(4000)
            vRPclient._stopAnim(source, false)

            if chances <= 30 then
                TriggerEvent("DropSystem:create", cfg.medical[item], 1, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>1x</b> " .. itemName)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil

            else
                TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                looting[user_id] = nil

            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar ate o proximo LOOT nesse local")

        end
    end
end)

RegisterServerEvent('pz_loot:food')
AddEventHandler('pz_loot:food', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownFood[prop] == nil then
            cooldownFood[prop] = 300
            looting[user_id] = true

            local quantity = math.random(1, 3)
            local chances = math.random(1, 100)

            local item = math.random(1, #cfg.food)
            local itemName = vRP.itemNameList(cfg.food[item])

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 4000, "Vasculhando")

            Wait(4000)
            vRPclient._stopAnim(source, false)

            if chances <= 30 then
                TriggerEvent("DropSystem:create", cfg.food[item], quantity, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso",
                    "Você encontrou <b>" .. quantity .. "x</b> " .. itemName)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil

            else
                TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                looting[user_id] = nil

            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar ate o proximo LOOT nesse local")

        end
    end
end)

RegisterServerEvent('pz_loot:loot')
AddEventHandler('pz_loot:loot', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownLoot[prop] == nil then
            cooldownLoot[prop] = 600
            looting[user_id] = true

            local chances = math.random(1, 100)

            local item = math.random(1, #cfg.common)
            local itemName = vRP.itemNameList(cfg.common[item])

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 4000, "Vasculhando")

            Wait(4000)
            vRPclient._stopAnim(source, false)

            if itemName == "radio" or "chave" or "mascara" or "oculos" or "blusa" or "jaqueta" or "calca" or "luvas" or
                "sapatos" or "chapeu" or "prego" or "parafuso" or "alicate" or "martelo" or "serra" or "chave_philips" or
                "chave_fenda" then
                quantity = "1"
            else
                quantity = math.random(1, 2)
            end

            if chances >= 30 then
                TriggerEvent("DropSystem:create", cfg.common[item], quantity, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso",
                    "Você encontrou <b>" .. quantity .. "x</b> " .. itemName)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil

            else
                TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                looting[user_id] = nil

            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar ate o proximo LOOT nesse local")

        end
    end
end)

RegisterServerEvent('pz_loot:weapon')
AddEventHandler('pz_loot:weapon', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownWeapon[prop] == nil then
            cooldownWeapon[prop] = 1800
            looting[user_id] = true

            local category = math.random(1, 2)

            local chances = math.random(1, 100)

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 4000, "Vasculhando")

            Wait(4000)
            vRPclient._stopAnim(source, false)

            if (category == 1) then
                local item = math.random(1, #cfg.weapon)
                local itemName = vRP.itemNameList(cfg.weapon[item])

                if chances <= 5 then
                    TriggerEvent("DropSystem:create", cfg.weapon[item], 1, x, y, z, 120)

                    TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>1x</b> " .. itemName)

                    TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                    looting[user_id] = nil

                else
                    TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                    looting[user_id] = nil

                end
            else
                local item = math.random(1, #cfg.ammo)
                local itemName = vRP.itemNameList(cfg.ammo[item])

                if chances <= 5 then
                    TriggerEvent("DropSystem:create", cfg.ammo[item], 5, x, y, z, 120)

                    TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>5x</b> " .. itemName)

                    TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                    looting[user_id] = nil

                else
                    TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                    looting[user_id] = nil

                end
            end
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar até o proximo LOOT nesse local")

        end
    end
end)

RegisterServerEvent('pz_loot:vehicle')
AddEventHandler('pz_loot:vehicle', function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)

    local info = json.encode(entity.entity)
    local prop = info .. "_" .. user_id

    if looting[user_id] == nil then
        if cooldownVehicle[prop] == nil then
            cooldownVehicle[prop] = 600
            looting[user_id] = true

            local chances = math.random(1, 100)

            local item = math.random(1, #cfg.vehicle)
            local itemName = vRP.itemNameList(cfg.vehicle[item])

            vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@idle_a", "idle_a"}}, true)
            TriggerClientEvent("progress", source, 4000, "Vasculhando")

            Wait(4000)
            vRPclient._stopAnim(source, false)

            quantity = math.random(1, 2)

            if chances >= 30 then
                TriggerEvent("DropSystem:create", cfg.vehicle[item], quantity, x, y, z, 120)

                TriggerClientEvent("Notify", source, "sucesso",
                    "Você encontrou <b>" .. quantity .. "x</b> " .. itemName)

                TriggerEvent('GENESEEExperience:addSV', source, 35, user_id)

                looting[user_id] = nil

            else
                TriggerClientEvent("Notify", source, "negado", "Você não encontrou nada")

                looting[user_id] = nil

            end
        else
            TriggerClientEvent("Notify", source, "negado", "Você deve aguardar ate o proximo LOOT nesse local")

        end
    end
end)
