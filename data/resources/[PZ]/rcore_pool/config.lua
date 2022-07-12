Config = {
    NotificationDistance = 10.0,
    PropsToRemove = {
        vector3(1992.803, 3047.312, 46.22865),
        vector3(-36.301, 6391.44, 31.6047),
        vector3(550.147, -174.76, 50.6930),
        vector3(-574.17, 288.834, 79.1766),
    },

    --[[
        -- To use custom notifications, implement client event handler, example:

        AddEventHandler('rcore_pool:notification', function(serverId, message)
            print(serverId, message)
        end)
    ]]
    CustomNotifications = false,

    --[[
        -- To use custom menu, implement following client handlers
        AddEventHandler('rcore_pool:openMenu', function()
            -- open menu with your system
        end)

        AddEventHandler('rcore_pool:closeMenu', function()
            -- close menu, player has walked far from table
        end)


        -- After selecting game type, trigger one of the following setupTable events
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_8_BALL')
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_STRAIGHT_POOL')
    ]]
    CustomMenu = false,

    --[[
        When you want your players to pay to play pool, set this to true
        AND implement the following server handler in your framework of choice.
        The handler MUST deduct money from the player and then CALL the callback
        if the payment is successful, or inform the player of payment failure.

        This script itself DOES NOT implement ESX/vRP logic, you have to do that yourself.

        AddEventHandler('rcore_pool:payForPool', function(playerServerId, cb)
            print("This should be replaced by deducting money from " .. playerServerId)
            cb() -- successfuly set balls on table
        end)
    ]]
    PayForSettingBalls = false,
    BallSetupCost = nil, -- for example: "$1" or "$200" - any text

    --[[
        You can integrate pool cue into your system with

        SERVERSIDE HANDLERS
            - rcore_pool:onReturnCue - called when player takes cue
            - rcore_pool:onTakeCue   - called when player returns cue

        CLIENTSIDE EVENTS
            - rcore_pool:takeCue   - forces player to take cue in hand
            - rcore_pool:removeCue - removes cue from player's hand

        This prevents players from taking cue from cue rack if `false`
    ]]
    AllowTakePoolCueFromStand = true,

    --[[
        This option is for servers whose anticheats prevents
        this script from setting players invisible.

        When player's ped is blocking camera when aiming,
        set this to true
    ]]
    DoNotRotateAroundTableWhenAiming = false,

    MenuColor = {245, 127, 23},
    Keys = {
        BACK = {code = 200, label = 'INPUT_FRONTEND_PAUSE_ALTERNATE'},
        ENTER = {code = 38, label = 'INPUT_PICKUP'},
        SETUP_MODIFIER = {code = 21, label = 'INPUT_SPRINT'},
        CUE_HIT = {code = 179, label = 'INPUT_CELLPHONE_EXTRA_OPTION'},
        CUE_LEFT = {code = 174, label = 'INPUT_CELLPHONE_LEFT'},
        CUE_RIGHT = {code = 175, label = 'INPUT_CELLPHONE_RIGHT'},
        AIM_SLOWER = {code = 21, label = 'INPUT_SPRINT'},
        BALL_IN_HAND = {code = 29, label = 'INPUT_SPECIAL_ABILITY_SECONDARY'},

        BALL_IN_HAND_LEFT = {code = 174, label = 'INPUT_CELLPHONE_LEFT'},
        BALL_IN_HAND_RIGHT = {code = 175, label = 'INPUT_CELLPHONE_RIGHT'},
        BALL_IN_HAND_UP = {code = 172, label = 'INPUT_CELLPHONE_UP'},
        BALL_IN_HAND_DOWN = {code = 173, label = 'INPUT_CELLPHONE_DOWN'},
    },
    Text = {
        BACK = "Voltar",
        HIT = "Bater",
        BALL_IN_HAND = "Pegar bola Branca",
        BALL_IN_HAND_BACK = "Voltar",
        AIM_LEFT = "Esquerda",
        AIM_RIGHT = "Direita",
        AIM_SLOWER = "Mira Lenta",

        POOL = 'Bilhar de Buteco',
        POOL_GAME = 'Pool game',
        POOL_SUBMENU = 'Modo de Jogo',
        TYPE_8_BALL = '8-Ball',
        TYPE_STRAIGHT = 'Straight pool',

        HINT_SETUP = 'Reiniciar/Iniciar Jogada',
        HINT_TAKE_CUE = 'Pegar Taco.',
        HINT_RETURN_CUE = 'Devolver Taco.',
        HINT_HINT_TAKE_CUE = 'Para jogar bilhar você precisa de um taco.',
        HINT_PLAY = 'Iniciar',

        BALL_IN_HAND_LEFT = 'Deixou',
        BALL_IN_HAND_RIGHT = 'Certo',
        BALL_IN_HAND_UP = 'Acima de',
        BALL_IN_HAND_DOWN = 'Abaixo',
        BALL_POCKETED = '%s foi pro buraco, se liga mané!',
        BALL_IN_HAND_NOTIFY = 'Você tem a bola de bilhar',
        BALL_LABELS = {
            [-1] = 'Cue',
            [1] = '~y~Lisa 1~s~',
            [2] = '~b~Lisa 2~s~',
            [3] = '~r~Lisa 3~s~',
            [4] = '~p~Lisa 4~s~',
            [5] = '~o~Lisa 5~s~',
            [6] = '~g~Lisa 6~s~',
            [7] = '~r~Lisa 7~s~',
            [8] = 'Bola Preta 8',
            [9] = '~y~Listrada 9~s~',
            [10] = '~b~Listrada 10~s~',
            [11] = '~r~Listrada 11~s~',
            [12] = '~p~Listrada 12~s~',
            [13] = '~o~Listrada 13~s~',
            [14] = '~g~Listrada 14~s~',
            [15] = '~r~Listrada 15~s~',
         }
    },
}