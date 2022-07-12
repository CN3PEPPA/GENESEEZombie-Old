Config = {

    CraftingStopWithDistance = false,
    HideWhenCantCraft = false,

    Categories = {
        ['outros'] = {
            Label = 'Extras',
            Image = 'placa_metal',
            Jobs = {}
        },
        ['mochilas'] = {
            Label = 'Mochilas',
            Image = 'mochila_g',
            Jobs = {}
        },
        ['veiculo'] = {
            Label = 'Veiculo',
            Image = 'pneus',
            Jobs = {}
        },
        ['bebidas'] = {
            Label = 'Bebidas',
            Image = 'limonada',
            Jobs = {}
        },
        ['comidas'] = {
            Label = 'Comidas',
            Image = 'sanduiche',
            Jobs = {}
        },
        ['ferramentas'] = {
            Label = 'Ferramentas',
            Image = 'vara_pesca',
            Jobs = {}
        },
        ['materiaprima'] = {
            Label = 'Matéria Prima',
            Image = 'parafuso',
            Jobs = {}
        },
        ['construcao'] = {
            Label = 'Construção',
            Image = 'parede_madeira',
            Jobs = {}
        },
        ['armabranca'] = {
            Label = 'Arma Branca',
            Image = 'faca',
            Jobs = {}
        },
        ['pecaarma'] = {
            Label = 'Peças de Arma',
            Image = 'gatilho',
            Jobs = {}
        },
        ['armafogo'] = {
            Label = 'Armas de Fogo',
            Image = 'pt92af',
            Jobs = {}
        },
        ['municao'] = {
            Label = 'Munição',
            Image = 'capsulas',
            Jobs = {}
        },
        ['medico'] = {
            Label = 'Médico',
            Image = 'bandagem',
            Jobs = {}
        }
        -- ['reciclagem'] = {
        --    Label = 'Reciclagem',
        --    Image = 'pano',
        --    Jobs = {}
        -- }
    },

    PermanentItems = { -- Itens que não são removidos ao criar
        -- ['nome'] = true
        ['agulha'] = true,
        ['faca'] = true,
        ['serra'] = true,
        ['martelo'] = true,
        ['tesoura'] = true,
        ['alicate'] = true
    },

    ItemsNames = { -- Nome dos itens que vão aparecer na NUI
        ----------------------------------------------------------
        -- [ Ultilitários ]----------------------------------------
        ----------------------------------------------------------
        ["mochila_p"] = "Mochila Pequena",
        ["mochila_m"] = "Mochila Média",
        ["mochila_g"] = "Mochila Grande",
        ["radio"] = "Rádio",
        ["colete"] = "Colete",
        ["repairkit"] = "Kit de Reparos",
        ["isca"] = "Isca",
        ["algema"] = "Algema",
        ["capuz"] = "Capuz",
        ["sacodelixo"] = "Saco de lixo",
        ["radioqueimado"] = "Rádio Queimado",
        ["corda"] = "Corda",
        ["agulha"] = "Agulha",
        ["bussola"] = "Bússola",
        ["pneus"] = "Conjunto de Pneus",
        -----------------------------------------------------------
        -- [ Peixes ]-----------------------------------------------
        -----------------------------------------------------------
        ["dourado"] = "Dourado",
        ["corvina"] = "Corvina",
        ["salmao"] = "Salmão",
        ["pacu"] = "Pacu",
        ["pintado"] = "Pintado",
        ["pirarucu"] = "Pirarucu",
        ["tilapia"] = "Tilápia",
        ["tucunare"] = "Tucunaré",
        -----------------------------------------------------------
        -- [ Bebidas ]----------------------------------------------
        -----------------------------------------------------------
        ["leite"] = "Leite",
        ["agua"] = "Água",
        ["limonada"] = "Limonada",
        ["refrigerante"] = "Refrigerante",
        ["cafe"] = "Café",
        ["cerveja"] = "Cerveja",
        ["tequila"] = "Tequila",
        ["vodka"] = "Vodka",
        ["whisky"] = "Whisky",
        ["conhaque"] = "Conhaque",
        ["absinto"] = "Absinto",
        ["energetico"] = "Energético",
        -----------------------------------------------------------
        -- [ Comida ]-----------------------------------------------
        -----------------------------------------------------------
        ["pao"] = "Pão",
        ["sanduiche"] = "Sanduiche",
        ["chocolate"] = "Chocolate",
        ["sardinha"] = "Sardinha Enlatada",
        ["feijao"] = "Feijão Enlatado",
        ["atum"] = "Atum Enlatado",
        ["arroz"] = "Pacote de Arroz",
        ["carne_cozida"] = "Carne Cozida",
        -----------------------------------------------------------
        -- [ Agricultura ]------------------------------------------
        -----------------------------------------------------------
        ["adubo"] = "Adubo",
        ["fertilizante"] = "Fertilizante",
        ["semente_cannabis"] = "Semente de Cannabis",
        ["semente_tomate"] = "Semente de Tomate",
        ["semente_alface"] = "Semente de Alface",
        -----------------------------------------------------------
        -- [ Caça ]-------------------------------------------------
        -----------------------------------------------------------
        ["pele_baixa_qualidade"] = "Pele de Baixa Qualidade",
        ["pele_media_qualidade"] = "Pele de Média Qualidade",
        ["pele_alta_qualidade"] = "Pele de Alta Qualidade",
        ["carne_caca"] = "Carne de Caça",
        -----------------------------------------------------------
        -- [ Combustível ]------------------------------------------
        -----------------------------------------------------------
        ["gasolina"] = "Gasolina",
        ---------------------------------------------------------
        -- [ Construções ]----------------------------------------
        ---------------------------------------------------------
        ["mout_base"] = "Fundação 1",
        ["mout_base_02"] = "Fundação 2",
        ["mout_base_03"] = "Fundação 3",
        ["mout_base_large"] = "Fundação Grande",
        ["mout_base_large_02"] = "Fundação Grande 2",
        ["mout_base_raised"] = "Fundação Suspensa",
        ["mout_base_raised_02"] = "Fundação Suspensa 2",
        ["mout_base_raised_tall"] = "Fundação Suspensa Alta",
        ["mout_base_raised_tall_02"] = "Fundação Suspensa Alta 2",
        ["mout_shutter_wood"] = "Porta de Madeira Pequena",
        ["mout_shutter_metal"] = "Porta de Metal Pequena",
        ["mout_ext_stair"] = "Escada de Metal",
        ["mout_ext_steps"] = "Escada de Metal Peq.",
        ["mout_ext_cover_01"] = "Barricada de Metal 1",
        ["mout_ext_cover_02"] = "Barricada de Metal 2",
        ["mout_ext_cover_03"] = "Barricada de Metal 3",
        ["mout_ext_cover_04"] = "Barricada de Madeira 1",
        ["mout_ext_cover_05"] = "Barricada de Madeira 2",
        ["mout_ext_cover_06"] = "Barricada de Madeira 3",
        ["mout_cap_wall"] = "Bloco de Base 1",
        ["mout_cap_wall_02"] = "Bloco de Base 2",
        ["mout_cap_wall_03"] = "Bloco de Base 3",
        ["mout_cap_stair"] = "Bloco de Base 4",
        ["mout_cap_stair_02"] = "Bloco de 5",
        ["mout_cap_stair_03"] = "Bloco de Base 6",
        ["mout_cap_door_01"] = "Bloco de Base 7",
        ["mout_cap_door_02"] = "Bloco de Base 8",
        ["mout_cap_door_03"] = "Bloco de Base 9",
        ["mout_cap_door_04"] = "Bloco de Base 10",
        ["mout_cap_door_05"] = "Bloco de Base 11",
        ["mout_cap_door_06"] = "Bloco de Base 12",
        ["mout_cap_window_01"] = "Bloco de Base 13",
        ["mout_cap_window_02"] = "Bloco de Base 14",
        ["mout_cap_window_03"] = "Bloco de Base 15",
        ["mout_cap_window_04"] = "Bloco de Base 16",
        ["mout_cap_window_05"] = "Bloco de Base 17",
        ["mout_cap_garage_01"] = "Bloco de Base 18",
        ["mout_cap_garage_02"] = "Bloco de Base 19",
        ["mout_cap_garage_03"] = "Bloco de Base 20",
        ["mout_cap_garage_04"] = "Bloco de Base 21",
        ["mout_cap_garage_05"] = "Bloco de Base 22",
        ["mout_cap_garage_06"] = "Bloco de Base 23",
        ["mout_mid_wall"] = "Bloco de Base 24",
        ["mout_mid_wall_02"] = "Bloco de Base 25",
        ["mout_mid_door"] = "Bloco de Base 26",
        ["mout_mid_door_02"] = "Bloco de Base 27",
        ["mout_mid_window"] = "Bloco de Base 28",
        ["mout_mid_window_02"] = "Bloco de Base 29",
        ["bau"] = "Baú",
        ["concreto"] = "Concreto",
        ["areia"] = "Areia",
        ["calcario"] = "Calcário",
        ["barraca"] = "Barraca",
        ---------------------------------------------------------
        -- [ Remédios ]-------------------------------------------
        ---------------------------------------------------------
        ["paracetamol"] = "Paracetamol",
        ["voltarem"] = "Voltarem",
        ["tandrilax"] = "Tandrilax",
        ["dorflex"] = "Dorflex",
        ["buscopan"] = "Buscopan",
        ["bandagem"] = "Bandagem",
        ["kit_medico"] = "Kit Médico",
        ---------------------------------------------------------
        -- [ Maconha ]--------------------------------------------
        ---------------------------------------------------------
        ["maconha"] = "Maconha",
        ["pe_maconha"] = "Pé de Maconha",
        ---------------------------------------------------------
        -- [ Craft de Armas ]-------------------------------------
        ---------------------------------------------------------
        ["molas"] = "molas",
        ["placa_metal"] = "Placa de Metal",
        ["gatilho"] = "Gatilho",
        ["capsulas"] = "Cápsulas",
        ["polvora"] = "Pólvora",
        ---------------------------------------------------------
        -- [ Peças de Veículos ]----------------------------------
        ---------------------------------------------------------
        ["velaignicao"] = "Vela de Ignição",
        ["pistao"] = "Pistão",
        ["embreagem"] = "Sistema de Embreagem",
        ["bateria"] = "Bateria",
        ["alternador"] = "Alternador",
        ["blocomotor"] = "Bloco de Motor",
        ---------------------------------------------------------
        -- [ Farms ]----------------------------------------------
        ---------------------------------------------------------
        ["tora"] = "Tora de Madeira",
        ["tabua"] = "Tábua de Madeira",
        ["prego"] = "Pregos",
        ["parafuso"] = "Parafusos",
        ["fragmento_metal"] = "Fragmento de Metal",
        ["fragmento_plastico"] = "Fragmento de Plástico",
        ["placa_plastico"] = "Placa de Plástico",
        ["chapa_metal"] = "Chapa de Metal",
        ["fita"] = "Fita Adesiva",
        ["graveto"] = "Graveto",
        ["pilha"] = "Pilha",
        ["fragmento_borracha"] = "Fragmento de Borracha",
        ---------------------------------------------------------
        -- [ Ferramentas ]----------------------------------------
        ---------------------------------------------------------
        ["martelo"] = "Martelo",
        ["chave_fenda"] = "Chave de Fenda",
        ["chave_philips"] = "Chave Philips",
        ["alicate"] = "Alicate",
        ["serra"] = "Serra",
        ["vara_pesca"] = "Vara de Pescar",
        ["violao"] = "Violão",
        ["tesoura"] = "Tesoura",
        ---------------------------------------------------------
        -- [ Matérias Primas ]------------------------------------
        ---------------------------------------------------------
        ["ovo"] = "Ovo",
        ["farinha"] = "Farinha",
        ["acucar"] = "Açucar",
        ["po_cafe"] = "Pó de Café",
        ["limao"] = "Limão",
        ["tomate"] = "Tomate",
        ["alface"] = "Alface",
        ["pano"] = "Pano",
        ["linha"] = "Linha",
        ["garrafa-vazia"] = "Garrafa Vazia",
        ["silenciador"] = "Silenciador",

        ["wbodyWEAPON_KNIFE"] = "Faca",
        ["wbodyWEAPON_DAGGER"] = "Adaga",
        ["wbodyWEAPON_KNUCKLE"] = "Soco-Inglês",
        ["wbodyWEAPON_MACHETE"] = "Machete",
        ["wbodyWEAPON_HATCHET"] = "Machado",
        ["wbodyWEAPON_FLASHLIGHT"] = "Lanterna",
        ["wbodyWEAPON_BAT"] = "Taco de Beisebol",

        ["wbodyWEAPON_COMBATPISTOL"] = "PX4",
        ["wbodyWEAPON_PISTOL_MK2"] = "CZ P-09",
        ["wbodyWEAPON_REVOLVER"] = "Magnum 44",
        ["wbodyWEAPON_ASSAULTRIFLE"] = "AK-74",
        ["wbodyWEAPON_CARBINERIFLE"] = "M4A4",
        ["wbodyWEAPON_PUMPSHOTGUN"] = "Remington 12",
        ["wbodyWEAPON_SNIPERRIFLE"] = "Rifle M24",

        ["wammoWEAPON_COMBATPISTOL"] = "Munição de PX4",
        ["wammoWEAPON_PISTOL_MK2"] = "Munição de PT",
        ["wammoWEAPON_ASSAULTRIFLE"] = "Munição de AK-74",
        ["wammoWEAPON_CARBINERIFLE"] = "Munição de M4-A4",
        ["wammoWEAPON_PUMPSHOTGUN"] = "Munição de Mossberg 590",
        ["wammoWEAPON_REVOLVER"] = "Munição de Magnum 44",
        ["wammoWEAPON_SNIPERRIFLE"] = "Munição de Rifle M24"
    },

    Recipes = {
        --------------------------------------------------
        -- Mochilas
        --------------------------------------------------
        ['mochila_p'] = {
            Level = 3,
            Category = 'mochilas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['pano'] = 5
            }
        },
        ['mochila_m'] = {
            Level = 6,
            Category = 'mochilas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['pano'] = 10,
                ['agulha'] = 1,
                ['linha'] = 4
            }
        },
        ['mochila_g'] = {
            Level = 10,
            Category = 'mochilas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['pano'] = 20,
                ['agulha'] = 1,
                ['linha'] = 10
            }
        },
        --------------------------------------------------
        -- Extras
        --------------------------------------------------
        ['chapa_metal'] = {
            Level = 8,
            Category = 'outros',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 2
            }
        },
        ['placa_metal'] = {
            Level = 15,
            Category = 'outros',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['fragmento_metal'] = 20
            }
        },
        ['placa_plastico'] = {
            Level = 15,
            Category = 'outros',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['fragmento_plastico'] = 20
            }
        },
        --------------------------------------------------
        -- Veiculo
        --------------------------------------------------
        ['pneus'] = {
            Level = 31,
            Category = 'veiculo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 4,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['fragmento_borracha'] = 40
            }
        },
        --------------------------------------------------
        -- Bebidas
        --------------------------------------------------
        ['cafe'] = {
            Level = 1,
            Category = 'bebidas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['agua'] = 1,
                ['po_cafe'] = 1
            }
        },
        ['limonada'] = {
            Level = 1,
            Category = 'bebidas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['limao'] = 2,
                ['agua'] = 1
            }
        },
        --------------------------------------------------
        -- Comidas
        --------------------------------------------------
        ['pao'] = {
            Level = 3,
            Category = 'comidas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['farinha'] = 2,
                ['leite'] = 2,
                ['agua'] = 1,
                ['ovo'] = 2
            }
        },
        ['sanduiche'] = {
            Level = 1,
            Category = 'comidas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 2,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['pao'] = 1,
                ['carne_cozida'] = 2,
                ['tomate'] = 1,
                ['alface'] = 2
            }
        },
        ['carne_cozida'] = {
            Level = 1,
            Category = 'comidas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['carne_caca'] = 1
            }
        },
        --------------------------------------------------
        -- Ferramentas
        --------------------------------------------------
        ['vara_pesca'] = {
            Level = 5,
            Category = 'ferramentas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['graveto'] = 2,
                ['corda'] = 1,
                ['fragmento_metal'] = 1
            }
        },
        ['violao'] = {
            Level = 6,
            Category = 'ferramentas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['tabua'] = 10,
                ['corda'] = 6,
                ['fragmento_metal'] = 2,
                ['fragmento_plastico'] = 8
            }
        },
        ['tesoura'] = {
            Level = 6,
            Category = 'ferramentas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['fragmento_metal'] = 15,
                ['fragmento_plastico'] = 8
            }
        },
        --------------------------------------------------
        -- Roupas
        --------------------------------------------------
        ['colete'] = {
            Level = 30,
            Category = 'roupas',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['pano'] = 50,
                ['linha'] = 25,
                ['placa_metal'] = 8,
                ['fragmento_metal'] = 5,
                ['agulha'] = 1
            }
        },
        --------------------------------------------------
        -- Matéria Prima
        --------------------------------------------------
        ['parafuso'] = {
            Level = 6,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 2,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['fragmento_metal'] = 4
            }
        },
        ['prego'] = {
            Level = 6,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 2,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['fragmento_metal'] = 4
            }
        },
        ['corda'] = {
            Level = 2,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['linha'] = 25
            }
        },
        ['pele_media_qualidade'] = {
            Level = 17,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['pele_baixa_qualidade'] = 5,
                ['linha'] = 5,
                ['agulha'] = 1
            }
        },
        ['pele_alta_qualidade'] = {
            Level = 19,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['pele_media_qualidade'] = 5,
                ['linha'] = 8,
                ['pano'] = 8,
                ['agulha'] = 1
            }
        },
        ['tabua'] = {
            Level = 1,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 4,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['tora'] = 1,
                ['serra'] = 1
            }
        },
        ['fragmento_metal'] = {
            Level = 2,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 18,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['placa_metal'] = 1,
                ['martelo'] = 1
            }
        },
        ['concreto'] = {
            Level = 5,
            Category = 'materiaprima',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['calcario'] = 5,
                ['areia'] = 5,
                ['agua'] = 5
            }
        },
        ['fragmento_plastico'] = {
            Level = 15,
            Category = 'outros',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 20,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_plastico'] = 1
            }
        },
        --------------------------------------------------
        -- Construção
        --------------------------------------------------
        ['barraca'] = {
            Level = 5,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 45,
            Ingredients = {
                ['pano'] = 20,
                ['prego'] = 10,
                ['martelo'] = 1
            }
        },
        ['mout_base'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 10,
                ['parafuso'] = 12,
                ['chave_fenda'] = 1,
                ['chapa_metal'] = 4
            }
        },
        ['mout_base_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 10,
                ['parafuso'] = 12,
                ['chave_fenda'] = 1,
                ['chapa_metal'] = 4
            }
        },
        ['mout_base_03'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 10,
                ['parafuso'] = 12,
                ['chave_fenda'] = 1,
                ['chapa_metal'] = 4
            }
        },
        ['mout_base_large'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 20,
                ['parafuso'] = 20,
                ['chave_fenda'] = 1,
            }
        },
        ['mout_base_large_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 20,
                ['parafuso'] = 20,
                ['chave_fenda'] = 1,
            }
        },
        ['mout_base_raised'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 15,
                ['parafuso'] = 20,
                ['chave_fenda'] = 1,
            }
        },
        ['mout_base_raised_tall'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 25,
                ['parafuso'] = 25,
                ['tabua'] = 20,
                ['chave_fenda'] = 1,
                ['martelo'] = 1,
            }
        },
        ['mout_base_raised_tall_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 25,
                ['parafuso'] = 25,
                ['tabua'] = 20,
                ['chave_fenda'] = 1,
                ['martelo'] = 1,
            }
        },
        ['mout_shutter_wood'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['tabua'] = 20,
            }
        },
        ['mout_shutter_metal'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['placa_metal'] = 20,
            }
        },
        ['mout_ext_stair'] = {
            Level = 15,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['placa_metal'] = 15,
                ['parafuso'] = 10,
            }
        },
        ['mout_ext_steps'] = {
            Level = 15,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['placa_metal'] = 15,
                ['parafuso'] = 10,
            }
        },
        ['mout_ext_cover_01'] = {
            Level = 15,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['placa_metal'] = 8,
                ['parafuso'] = 10,
            }
        },
        ['mout_ext_cover_02'] = {
            Level = 18,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['placa_metal'] = 8,
                ['parafuso'] = 10,
            }
        },
        ['mout_ext_cover_03'] = {
            Level = 18,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['placa_metal'] = 20,
                ['parafuso'] = 25,
            }
        },
        ['mout_ext_cover_04'] = {
            Level = 18,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 25,
                ['prego'] = 25,
            }
        },
        ['mout_ext_cover_05'] = {
            Level = 18,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 50,
                ['prego'] = 45,
            }
        },
        ['mout_ext_cover_06'] = {
            Level = 18,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 80,
                ['prego'] = 45,
            }
        },
        ['mout_cap_wall'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['concreto'] = 15,
                ['chave_fenda'] = 1,
                ['chapa_metal'] = 3,
                ['parafuso'] = 10,
            }
        },
        ['mout_cap_wall_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 30,
                ['prego'] = 40,
            }
        },
        ['mout_cap_wall_03'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 30,
                ['prego'] = 40,
            }
        },
        ['mout_cap_stair'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['prego'] = 20,
                ['tabua'] = 15,
                ['chapa_metal'] = 20,
                ['parafuso'] = 10,
                ['chave_fenda'] = 1,
            }
        },
        ['mout_cap_stair_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['prego'] = 20,
                ['tabua'] = 15,
                ['chapa_metal'] = 2,
            }
        },
        ['mout_cap_stair_03'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['prego'] = 20,
                ['concreto'] = 25,
                ['tabua'] = 15,
            }
        },
        ['mout_cap_door_01'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['chapa_metal'] = 20,
                ['parafuso'] = 25,
            }
        },
        ['mout_cap_door_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['chapa_metal'] = 20,
                ['parafuso'] = 25,
            }
        },
        ['mout_cap_door_03'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['chapa_metal'] = 20,
                ['parafuso'] = 25,
            }
        },
        ['mout_cap_door_04'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 20,
                ['prego'] = 25,
            }
        },
        ['mout_cap_door_05'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 20,
                ['prego'] = 25,
            }
        },
        ['mout_cap_door_06'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 20,
                ['prego'] = 25,
            }
        },
        ['mout_cap_window_01'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
                ['chapa_metal'] = 10,
            }
        },
        ['mout_cap_window_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
                ['chapa_metal'] = 10,
            }
        },
        ['mout_cap_window_03'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 20,
                ['prego'] = 10,
            }
        },
        ['mout_cap_window_04'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 20,
                ['prego'] = 10,
            }
        },
        ['mout_cap_window_05'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
            }
        },
        ['mout_cap_garage_01'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
                ['chapa_metal'] = 10,
            }
        },
        ['mout_cap_garage_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
                ['chapa_metal'] = 10,
            }
        },
        ['mout_cap_garage_03'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
                ['chapa_metal'] = 10,
            }
        },
        ['mout_cap_garage_04'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
                ['chapa_metal'] = 10,
            }
        },
        ['mout_cap_garage_05'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 40,
                ['prego'] = 25,
            }
        },
        ['mout_cap_garage_06'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 40,
                ['prego'] = 25,
            }
        },
        ['mout_mid_wall'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['concreto'] = 20,
                ['parafuso'] = 10,
            }
        },
        ['mout_mid_wall_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 45,
                ['prego'] = 10,
            }
        },
        ['mout_mid_door'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['parafuso'] = 45,
                ['chapa_metal'] = 15,
            }
        },
        ['mout_mid_door_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 45,
                ['prego'] = 15,
            }
        },
        ['mout_mid_window'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['chave_fenda'] = 1,
                ['parafuso'] = 45,
                ['chapa_metal'] = 15,
            }
        },
        ['mout_mid_window_02'] = {
            Level = 10,
            Category = 'construcao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 60,
            Ingredients = {
                ['martelo'] = 1,
                ['tabua'] = 45,
                ['prego'] = 15,
            }
        },
        --------------------------------------------------
        -- Armas Brancas
        --------------------------------------------------
        ['wbodyWEAPON_KNIFE'] = {
            Level = 6,
            Category = 'armabranca',
            isGun = true,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['placa_metal'] = 1,
                ['prego'] = 2,
                ['placa_plastico'] = 1
            }
        },
        ['wbodyWEAPON_DAGGER'] = {
            Level = 20,
            Category = 'armabranca',
            isGun = true,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['placa_metal'] = 2,
                ['prego'] = 2,
                ['placa_plastico'] = 1
            }
        },
        ['wbodyWEAPON_KNUCKLE'] = {
            Level = 7,
            Category = 'armabranca',
            isGun = true,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['placa_metal'] = 2
            }
        },
        ['wbodyWEAPON_MACHETE'] = {
            Level = 9,
            Category = 'armabranca',
            isGun = true,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['placa_metal'] = 4,
                ['prego'] = 3,
                ['tabua'] = 2
            }
        },
        ['wbodyWEAPON_HATCHET'] = {
            Level = 4,
            Category = 'armabranca',
            isGun = true,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['fragmento_metal'] = 10,
                ['corda'] = 1,
                ['graveto'] = 3
            }
        },
        ['wbodyWEAPON_FLASHLIGHT'] = {
            Level = 2,
            Category = 'armabranca',
            isGun = true,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['placa_metal'] = 2,
                ['pilha'] = 2,
                ['placa_plastico'] = 2
            }
        },
        ['wbodyWEAPON_BAT'] = {
            Level = 2,
            Category = 'armabranca',
            isGun = true,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['placa_metal'] = 10
            }
        },
        --------------------------------------------------
        -- Peças de Armas
        --------------------------------------------------
        ['gatilho'] = {
            Level = 11,
            Category = 'pecaarma',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['fragmento_metal'] = 4,
                ['parafuso'] = 2,
                ['chave_philips'] = 1
            }
        },
        ['molas'] = {
            Level = 27,
            Category = 'pecaarma',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 1,
                ['fragmento_metal'] = 2
            }
        },
        --------------------------------------------------
        -- Armas de Fogo
        --------------------------------------------------
        ['wbodyWEAPON_COMBATPISTOL'] = {
            Level = 30,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 5,
                ['fragmento_metal'] = 10,
                ['gatilho'] = 1,
                ['molas'] = 2,
                ['placa_plastico'] = 2
            }
        },
        ['wbodyWEAPON_PISTOL'] = {
            Level = 32,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 8,
                ['fragmento_metal'] = 15,
                ['gatilho'] = 1,
                ['molas'] = 3,
                ['placa_plastico'] = 3
            }
        },
        ['wbodyWEAPON_PISTOL_MK2'] = {
            Level = 34,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 10,
                ['fragmento_metal'] = 25,
                ['gatilho'] = 1,
                ['molas'] = 5
            }
        },
        ['wbodyWEAPON_REVOLVER'] = {
            Level = 42,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 15,
                ['fragmento_metal'] = 30,
                ['gatilho'] = 1,
                ['molas'] = 1
            }
        },
        ['wbodyWEAPON_ASSAULTRIFLE'] = {
            Level = 49,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 30,
                ['fragmento_metal'] = 60,
                ['gatilho'] = 1,
                ['molas'] = 8,
                ['placa_plastico'] = 5
            }
        },
        ['wbodyWEAPON_CARBINERIFLE'] = {
            Level = 45,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 30,
                ['fragmento_metal'] = 40,
                ['gatilho'] = 1,
                ['molas'] = 2,
                ['placa_plastico'] = 5
            }
        },
        ['wbodyWEAPON_PUMPSHOTGUN'] = {
            Level = 35,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 25,
                ['fragmento_metal'] = 30,
                ['gatilho'] = 1,
                ['molas'] = 4,
                ['placa_plastico'] = 6
            }
        },
        ['wbodyWEAPON_SNIPERRIFLE'] = {
            Level = 50,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['placa_metal'] = 25,
                ['fragmento_metal'] = 50,
                ['gatilho'] = 1,
                ['molas'] = 4,
                ['placa_plastico'] = 25
            }
        },
        ['silenciador'] = {
            Level = 20,
            Category = 'armafogo',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['garrafa-vazia'] = 1,
                ['pano'] = 10,
            }
        },
        --------------------------------------------------
        -- Munições
        --------------------------------------------------
        ['capsulas'] = {
            Level = 15,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['fragmento_metal'] = 5
            }
        },
        ['wammoWEAPON_COMBATPISTOL'] = {
            Level = 30,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 2,
                ['polvora'] = 2
            }
        },
        ['wammoWEAPON_PISTOL'] = {
            Level = 32,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 2,
                ['polvora'] = 2
            }
        },
        ['wammoWEAPON_PISTOL_MK2'] = {
            Level = 34,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 2,
                ['polvora'] = 4
            }
        },
        ['wammoWEAPON_REVOLVER'] = {
            Level = 42,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 2,
                ['polvora'] = 8
            }
        },
        ['wammoWEAPON_ASSAULTRIFLE'] = {
            Level = 49,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 5,
                ['polvora'] = 20
            }
        },
        ['wammoWEAPON_CARBINERIFLE'] = {
            Level = 45,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 5,
                ['polvora'] = 15
            }
        },
        ['wammoWEAPON_PUMPSHOTGUN'] = {
            Level = 35,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 5,
                ['polvora'] = 30
            }
        },
        ['wammoWEAPON_SNIPERRIFLE'] = {
            Level = 50,
            Category = 'municao',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 5,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 30,
            Ingredients = {
                ['capsulas'] = 5,
                ['polvora'] = 50
            }
        },
        --------------------------------------------------
        -- Medico
        --------------------------------------------------
        ['bandagem'] = {
            Level = 1,
            Category = 'medico',
            isGun = false,
            Jobs = {},
            JobGrades = {},
            Amount = 1,
            SuccessRate = 100,
            requireBlueprint = false,
            Time = 15,
            Ingredients = {
                ['pano'] = 5
            }
        }
    },

    Workbenches = { -- Em cada local de bancada, deixe {} para trabalhos se quiser que todos acessem
    {
        coords = vector3(101.92, 6616.0, 32.44),
        jobs = {},
        blip = true,
        recipes = {},
        radius = 3.0
    }},

    Text = {
        ['not_enough_ingredients'] = 'Você não possui os ingredientes necessários para fazer isso.',
        ['not_level'] = 'Você não tem level o suficiente para fazer esse item.',
        ['not_liberated'] = 'Espere um pouco para poder abrir a mesa de crafting novamente.',
        ['item_crafted'] = 'Você criou um item com sucesso.',
        ['wrong_job'] = 'Você não pode abrir esta mesa de craft.',
        ['wrong_usage'] = 'Algo deu errado, tente novamente.',
        ['inv_limit_exceed'] = 'Você não possui mais espaço em sua mochila.',
        ['crafting_failed'] = 'Você errou, tente novamente.'
    }
}

function SendTextMessage(msg)

    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0, 1)

end
