Config = {

    -------------------------------------------------------------
    -- IMPORTANT  
    -- All parts need to be added to inventory
    -- Custom vehicle sounds for engines (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
    -------------------------------------------------------------

    WearRate = 70000, -- A taxa de desgaste das peças (maior o valor menos desgaste das peças)
    UseMiles = false, -- Se definido como falso, usará quilômetros
    UseRelativeValues = true, -- Se definido como verdadeiro, o desempenho dos carros não seria afetado com peças de estoque. Caso contrário, as peças do stock car tornarão o carro mais lento
    DetectDistance = 3.0, -- Distância onde os veículos estão sendo detectados

    -- Tempos para reparar/instalar certas peças em milissegundos
    EngineRepairTime = 10000,
    EngineInstallTime = 15000,

    TurboRepairTime = 10000,
    TurboInstallTime = 15000,

    NitroInstallTime = 10000,

    OilInstallTime = 5000,

    TransmissionInstallTime = 14000,
    TransmissionRepairTime = 10000,

    TireRepairTime = 3000,
    TireInstallTime = 3000,

    BreaksInstallTime = 4000,
    BreaksRepairTime = 4000,

    SuspensionInstallTime = 5000,
    SuspensionRepairTime = 5000,

    SparkPlugsInstallTime = 5000,
    SparkPlugsRepairTime = 5000,

    -- MechanicWorkshop = { -- Mechanic Workshops where mechanics can use MechanicWorkshopAccess
    -- {
    --     coords = vector3(110.22, 6626.44, 31.79),
    --     radius = 20.0
    -- }},

    -- Verifique o motor, óleo baixo, localização da quilometragem na tela
    InfoBottom = 1,
    InfoRight = 1,

    -- Partes do veículo certas condições podem acessar! Por exemplo, com a caixa de ferramentas mecânica, você poderá acessar as peças mencionadas em Ferramentas Mecânicas
    -- LISTA DE PEÇAS (motor, óleo, freios, suspensão)

    BearHandsAccessCommand = 'verificar',

    BearHandsAccess = {
        ['oil'] = true
    },

    ToolBoxAccess = {
        ['oil'] = true,
        ['nitro'] = true,
        ['tires'] = true,
        ['sparkplugs'] = true
    },

    MechanicToolsAccess = {
        ['oil'] = true,
        ['nitro'] = true,
        ['tires'] = true,
        ['brakes'] = true,
        ['suspension'] = true,
        ['sparkplugs'] = true
    },

    MechanicWorkshopAccess = {
        ['oil'] = true,
        ['nitro'] = true,
        ['tires'] = true,
        ['brakes'] = true,
        ['suspension'] = true,
        ['engine'] = true,
        ['transmission'] = true,
        ['turbo'] = true,
        ['sparkplugs'] = true
    },

    -- Peças que seu veículo poderá usar para modificar seu desempenho na estrada. Essas peças também precisam ser adicionadas ao banco de dados de itens.
    -- usability - é excluir algumas peças para serem usadas em alguns veículos exclusivo geralmente é o código de spawn do carro
    -- power - depende se estiver usando valores relativos, mas aumentará a potência dos veículos
    -- durability - (IMPORTANTE) Insira o valor de 0 a 100. 100 significa que a peça nunca quebrará
    -- repair - insira os ingredientes para consertar a peça. De parte está em 0 por cento, você precisará substituir.

    Turbos = { -- Turbos afetam a velocidade do seu carro em rotações mais altas. Quando os turbos quebram você perde potência

        ['turbo_lvl_1'] = { -- ID da tabela de itens
            label = "Turbo", -- Nome que aparece na NUI
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            power = 100.0, -- Força
            durability = 40.0, -- Durabilidade
            repair = { -- Item nescessario para reparo
                ['fragmento_metal'] = { -- ID da tabela de itens
                    amount = 50, -- Quantidade
                    label = "Fragmentos de Metal", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                },
                ['alicate'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Alicate", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                },
                ['chave_fenda'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Chave de Fenda", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                }
            }
        }
    },

    NitroKey = 'LEFTSHIFT', -- Key to use nitro when available

    Nitros = {
        ['nos_lvl_1'] = {
            label = "NOS",
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            power = 100.0,
            durability = 30.0 -- Here enter seconds until nitro will run out
        }
    },

    Transmissions = {

        ['transmission_lvl_1'] = { -- ID da tabela de itens
            label = "Transmissão", -- Nome que aparece na NUI
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            shiftingtime = 0.9, -- tempo de mudança de marcha
            drivingwheels = 'DEFAULT', -- FWD RWD AWD
            durability = 80.0, -- Durabilidade
            repair = {
                ['fragmento_metal'] = { -- ID da tabela de itens
                    amount = 20, -- Quantidade
                    label = "Fragmentos de Metal", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                },
                ['alicate'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Alicate", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                },
                ['chave_fenda'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Chave de Fenda", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                }
            }
        }
    },

    Suspensions = {

        ['suspension_lvl_1'] = { -- ID da tabela de itens
            label = "Suspensão", -- Nome que aparece na NUI
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            height = 0, -- Altura
            traction = 0, -- Tração
            durability = 80.0, -- Durabilidade
            repair = {
                ['fragmento_metal'] = { -- ID da tabela de itens
                    amount = 20, -- Quantidade
                    label = "Fragmentos de Metal", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                },
                ['alicate'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Alicate", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                },
                ['chave_fenda'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Chave de Fenda", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                }
            }
        }
    },

    Oils = {

        ['oil_lvl_1'] = { -- ID da tabela de itens
            label = "Óleo", -- Nome que aparece na NUI
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            durability = 10.0 -- Durabilidade
        }
    },

    Engines = {

        ['engine_lvl_1'] = { -- ID da tabela de itens
            label = "Motor", -- Nome que aparece na NUI
            power = 0.0, -- Força
            durability = 80.0, -- Durabilidade
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            sound = "DEFAULT", -- Som do motor
            repair = {
                ['fragmento_metal'] = { -- ID da tabela de itens
                    amount = 50, -- Quantidade
                    label = "Fragmentos de Metal", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                },
                ['pistao'] = {
                    amount = 4,
                    label = "Pistão",
                    reusable = false
                },
                ['blocomotor'] = {
                    amount = 1,
                    label = "Bloco de Motor",
                    reusable = false
                }
            }
        },
        ['engine_lvl_2'] = { -- ID da tabela de itens
            label = "Motor Melhorado", -- Nome que aparece na NUI
            power = 40.0, -- Força
            durability = 90.0, -- Durabilidade
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            sound = "DEFAULT", -- Som do motor
            repair = {
                ['fragmento_metal'] = { -- ID da tabela de itens
                    amount = 50, -- Quantidade
                    label = "Fragmentos de Metal", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                },
                ['pistao'] = {
                    amount = 4,
                    label = "Pistão",
                    reusable = false
                },
                ['blocomotor'] = {
                    amount = 1,
                    label = "Bloco de Motor",
                    reusable = false
                }
            }
        },
    },

    Tires = {

        ['tires_lvl_1'] = { -- ID da tabela de itens
            label = "Pneus", -- Nome que aparece na NUI
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            traction = -0.04, -- Tração
            width = 0.5, -- Peso
            size = 0.2, -- Tamanho
            lowspeedtraction = 0.0, -- Tração de baixa velocidade
            durability = 80.0, -- Durabilidade
            repair = {
                ['fragmento_borracha'] = { -- ID da tabela de itens
                    amount = 10, -- Quantidade
                    label = "Fragmentos de Borracha", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                }
            }
        }
    },

    Brakes = {

        ['brakes_lvl_1'] = { -- ID da tabela de itens
            label = "Freios", -- Nome que aparece na NUI
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            power = 1.0, -- Força
            durability = 30.0, -- Durabilidade
            repair = {
                ['fragmento_borracha'] = { -- ID da tabela de itens
                    amount = 10, -- Quantidade
                    label = "Fragmentos de Borracha", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                },
                ['fragmento_metal'] = { -- ID da tabela de itens
                    amount = 15, -- Quantidade
                    label = "Fragmentos de Metal", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                },
                ['alicate'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Alicate", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                },
                ['martelo'] = { -- ID da tabela de itens
                    amount = 1, -- Quantidade
                    label = "Martelo", -- Nome que aparece na NUI
                    reusable = true -- reutilizável ? sim ou nao
                }
            }
        }
    },

    SparkPlugs = {
        ['sparkplugs_lvl_1'] = { -- ID da tabela de itens
            label = "Velas de Ignição", -- Nome que aparece na NUI
            usability = {
                exclusive = {},
                vehicletypes = {}
            },
            durability = 50.0, -- (IMPORTANTE) Insira um valor de 0 a 100. 100 significa que a peça nunca quebrará
            startbreak = 25.0, -- a saúde definida quando o motor começa a mudar de forma aleatória. Com < 1 de saúde, o motor não liga novamente. Valores de 1 a 100 são permitidos
            minfail = 10000, -- min tempo quando o motor desliga em ms
            maxfail = 50000, -- tempo máximo quando o motor desliga em ms
            repair = {
                ['velaignicao'] = { -- ID da tabela de itens
                    amount = 2, -- Quantidade
                    label = "Velas de Ignição", -- Nome que aparece na NUI
                    reusable = false -- reutilizável ? sim ou nao
                }
            }
        }
    },

    -- en
    Text = {

        ['hood_closed'] = 'O capô do veículo está fechado!',
        ['mechanic_action_complete'] = 'Você consertou um veículo!',
        ['mechanic_action_started'] = 'Você vai consertar um veículo!',
        ['wrong_job'] = 'Permissões Insuficientes',
        ['not_enough'] = 'Esse item não está na sua mochila.',

        -- Added
        ['vehicle_locked'] = 'Esse veículo está trancado!',
        ['vehicle_nearby'] = 'Nenhum veículo próximo de você!',
        ['vehicle_notonlift'] = 'O veículo não está no elevador!',
        ['vehicle_notoncarjack'] = 'O veículo não pode ser roubado!',

        -- Parts Stuff
        ['install_engine'] = '[~r~E~w~] Instalar Motor',
        ['repair_engine'] = '[~r~E~w~] Consertar Motor',
        ['installing_engine'] = '~r~O motor está sendo instalado.',
        ['repairing_engine'] = '~r~O motor está sendo consertado.',
        ['install_turbo'] = '[~r~E~w~] Instalar Turbo',
        ['repair_turbo'] = '[~r~E~w~] Trocar Turbo',
        ['installing_turbo'] = '~r~O turbo está sendo instalado.',
        ['repairing_turbo'] = '~r~O turbo está sendo trocado.',
        ['install_nitro'] = '[~r~E~w~] Instalar Nitro',
        ['repair_nitro'] = '[~r~E~w~] Trocar Nitro',
        ['installing_nitro'] = '~r~O nitro está sendo instalado.',
        ['repairing_nitro'] = '~r~O nitro está sendo trocado.',
        ['exchange_oil'] = '[~r~E~w~] Trocar óleo',
        ['refill_oil'] = '[~r~E~w~] Reabastecer óleo',
        ['refilling_oil'] = '~r~O óleo está sendo reabastecido.',
        ['exchanging_oil'] = '~r~O óleo está sendo trocado.',
        ['install_transmission'] = '[~r~E~w~] Instalar Transmissão',
        ['repair_transmission'] = '[~r~E~w~] Consertando Transmissão',
        ['installing_transmission'] = '~r~A transmissão está sendo instalada',
        ['repairing_transmission'] = '~r~A transmissão está sendo consertada.',
        ['install_tire'] = '[~r~E~w~] Colocar Pneus',
        ['install_brakes'] = '[~r~E~w~] Instalar Freios',
        ['install_suspension'] = '[~r~E~w~] Instalar Suspensão',

        -- New
        ['install_sparkplugs'] = '[~r~E~w~] Instalar Velas',
        ['installing_sparklugs'] = '~r~A vela está sendo instalada.'
    }

}
