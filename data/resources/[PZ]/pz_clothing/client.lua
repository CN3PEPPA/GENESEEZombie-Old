local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPServer = Tunnel.getInterface("vRP")
pz = {}
Tunnel.bindInterface("pz_clothingSelect", pz)
vSERVER = Tunnel.getInterface("pz_clothingSelect")

local previewPed = nil
local variation = 0

local clothesListMale = {
    masks = {0, 15, 16, 14, 27, 29, 35, 36, 37, 38, 46, 48, 51, 52, 53, 54, 55, 56, 57, 90, 104, 107, 108, 109, 111,
             123, 114, 115, 116, 118, 122, 126, 142, 166, 169, 170, 175, 183, 185},

    pants = {0, 1, 3, 5, 6, 7, 8, 9, 10, 12, 13, 15, 16, 17, 20, 22, 23, 24, 25, 26, 27, 28, 30, 31, 34, 35, 36, 37, 38,
             39, 40, 41, 42, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 60, 62, 63, 64, 71, 72, 73, 74, 75, 76, 78,
             79, 80, 81, 82, 83, 86, 87, 88, 89, 90, 92, 93, 94, 97, 98, 101, 102, 103, 104, 105, 107, 110, 111, 120,
             121, 122, 123, 129, 133, 134, 135, 138},

    shoes = {1, 3, 4, 12, 14, 15, 6, 18, 20, 21, 22, 23, 24, 25, 26, 27, 29, 35, 36, 37, 38, 41, 48, 50, 51, 52, 53, 54,
             56, 57, 60, 61, 62, 63, 65, 66, 69, 70, 71, 72, 73, 81, 84, 85, 86, 96, 97, 98, 99},

    undershirts = {0, 1, 2, 5, 9, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 24, 27, 29, 30, 32, 37, 38, 39, 40, 41, 43,
                   44, 46, 47, 48, 49, 53, 54, 60, 63, 64, 67, 68, 69, 70, 71, 72, 74, 75, 76, 77, 81, 83, 85, 87, 88,
                   89, 98},

    hoods = {0, 1, 3, 5, 6, 7, 8, 9, 13, 14, 15, 16, 17, 25, 26, 29, 33, 34, 36, 37, 38, 39, 40, 41, 42, 43, 44, 47, 49,
             50, 53, 55, 56, 57, 61, 62, 63, 64, 65, 68, 69, 70, 71, 73, 78, 80, 81, 82, 83, 85, 86, 87, 88, 89, 90, 91,
             92, 93, 94, 95, 97, 98, 105, 103, 110, 111, 113, 115, 120, 112, 124, 125, 126, 127, 128, 133, 137, 138,
             139, 142, 146, 147, 153, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172,
             173, 174, 175, 176, 179, 180, 181, 182, 184, 185, 187, 188, 189, 190, 202, 204, 205, 206, 207, 208, 209,
             210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 226, 227, 229, 230, 232, 233,
             234, 237, 238, 239, 240, 241, 242, 243, 244, 247, 248, 249, 250, 251, 252, 253, 257, 258, 262, 263, 264,
             265, 266, 267, 268, 271, 273, 275, 276, 284, 290, 292, 293, 304, 305, 306, 314, 315, 316, 317, 318, 319,
             321, 327, 328, 332, 336, 337, 338, 339, 340, 341, 345, 346, 351, 352, 353, 357, 359, 360, 362, 363, 364,
             365, 366, 367, 368, 379, 381, 384, 385, 386, 387},

    hats = {2, 4, 5, 6, 7, 8, 10, 9, 12, 13, 14, 18, 20, 21, 25, 26, 28, 29, 30, 39, 48, 49, 50, 51, 52, 53, 54, 55, 56,
            58, 59, 60, 61, 62, 63, 64, 67, 68, 69, 70, 71, 72, 74, 73, 75, 82, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95,
            96, 102, 103, 104, 105, 106, 107, 108, 110, 112, 113, 120, 123, 125, 126, 140, 141, 142, 143, 144, 156, 157,
            158},

    glasses = {3, 4, 5, 7, 8, 9, 12, 13, 15, 16, 18, 19, 20, 23, 24, 28, 31, 33, 34, 35, 36, 37, 38, 39},

    hands = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
             29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55,
             56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82,
             83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
             108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128,
             129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149,
             150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 165, 166, 170, 171, 172, 173, 174,
             175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195,
             196}
}

local clothesListFemale = {
    masks = {0, 15, 16, 14, 27, 29, 35, 36, 37, 38, 46, 48, 51, 52, 53, 54, 55, 56, 57, 90, 104, 107, 108, 109, 111,
             123, 114, 115, 116, 118, 122, 126, 142, 166, 169, 170, 175, 183, 185},

    pants = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
             29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55,
             56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82,
             83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
             108, 109, 110, 111, 112, 114, 117, 118, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 133, 134, 135,
             136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150},

    shoes = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
             29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 49, 50, 51, 52, 53, 54, 55, 56,
             57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84,
             85, 86, 88, 89, 90, 91, 92, 93, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105},

    undershirts = {0, 1, 2, 5, 9, 12, 13, 14, 15, 16, 17, 18, 21, 22, 23, 24, 27, 29, 30, 32, 37, 38, 39, 40, 41, 43,
                   44, 46, 47, 48, 49, 53, 54, 60, 63, 64, 67, 68, 69, 70, 71, 72, 74, 75, 76, 77, 81, 83, 85, 87, 88,
                   89, 98},

    hoods = {0, 1, 3, 5, 6, 7, 8, 9, 13, 14, 15, 16, 17, 25, 26, 29, 33, 34, 36, 37, 38, 39, 40, 41, 42, 43, 44, 47, 49,
             50, 53, 55, 56, 57, 61, 62, 63, 64, 65, 68, 69, 70, 71, 73, 78, 80, 81, 82, 83, 85, 86, 87, 88, 89, 90, 91,
             92, 93, 94, 95, 97, 98, 105, 103, 110, 111, 113, 115, 120, 112, 124, 125, 126, 127, 128, 133, 137, 138,
             139, 142, 146, 147, 153, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172,
             173, 174, 175, 176, 179, 180, 181, 182, 184, 185, 187, 188, 189, 190, 202, 204, 205, 206, 207, 208, 209,
             210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 226, 227, 229, 230, 232, 233,
             234, 237, 238, 239, 240, 241, 242, 243, 244, 247, 248, 249, 250, 251, 252, 253, 257, 258, 259, 262, 263, 264,
             265, 266, 267, 268, 271, 273, 275, 276, 284, 290, 292, 293, 304, 305, 306, 314, 315, 316, 317, 318, 319,
             321, 327, 328, 332, 336, 337, 338, 339, 340, 341, 345, 346, 351, 352, 353, 357, 359, 360, 362, 363, 364,
             365, 366, 367, 368, 379, 381, 384, 385, 386, 387},

    hats = {2, 4, 5, 6, 7, 8, 10, 9, 12, 13, 14, 18, 20, 21, 25, 26, 28, 29, 30, 39, 48, 49, 50, 51, 52, 53, 54, 55, 56,
            58, 59, 60, 61, 62, 63, 64, 67, 68, 69, 70, 71, 72, 74, 73, 75, 82, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95,
            96, 102, 103, 104, 105, 106, 107, 108, 110, 112, 113, 120, 123, 125, 126, 140, 141, 142, 143, 144, 156, 157,
            158},

    glasses = {3, 4, 5, 7, 8, 9, 12, 13, 15, 16, 18, 19, 20, 23, 24, 28, 31, 33, 34, 35, 36, 37, 38, 39},

    hands = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
             29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55,
             56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82,
             83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
             108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128,
             129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149,
             150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
             171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191,
             192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 206, 207, 211, 212, 213, 214, 215, 216,
             217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237,
             238, 239, 240, 241}
}

function pz.SendNuiMessage(functionName, functionParameters, functionExtras)
    SendNUIMessage({
        type = functionName,
        content = functionParameters,
        extras = functionExtras
    })
end

function closeNUI()
    pz.SendNuiMessage("showMenu", false)
    SetNuiFocus(false, false)
    destroyPedScreen()
end

RegisterNUICallback("close", function()
    closeNUI()
end)

RegisterNUICallback("previewClothing", function(data)
    if data.category == 'p0' then
        SetPedPropIndex(previewPed, 0, tonumber(data.id), tonumber(data.variation), 1)
    elseif data.category == 'p1' then
        SetPedPropIndex(previewPed, 1, tonumber(data.id), tonumber(data.variation), 1)
    else
        SetPedComponentVariation(previewPed, tonumber(data.category), tonumber(data.id), tonumber(data.variation), 2)
    end
    Wait(100)
end)

RegisterNUICallback("saveClothing", function(data)

    if data.category == 'p0' then
        SetPedPropIndex(PlayerPedId(), 0, tonumber(data.id), tonumber(data.variation), 1)
    elseif data.category == 'p1' then
        SetPedPropIndex(PlayerPedId(), 1, tonumber(data.id), tonumber(data.variation), 1)
    else
        SetPedComponentVariation(PlayerPedId(), tonumber(data.category), tonumber(data.id), tonumber(data.variation), 2)
    end
    Wait(100)

    closeNUI()

    local item
    if tonumber(data.category) == 1 then
        item = 'mascara'
    elseif tonumber(data.category) == 3 then
        item = 'luvas'
    elseif tonumber(data.category) == 4 then
        item = 'calca'
    elseif tonumber(data.category) == 6 then
        item = 'sapatos'
    elseif tonumber(data.category) == 8 then
        item = 'blusa'
    elseif tonumber(data.category) == 11 then
        item = 'jaqueta'
    elseif data.category == 'p0' then
        item = 'chapeu'
    elseif data.category == 'p1' then
        item = 'oculos'
    end
    TriggerServerEvent("deleteInventoryItem", item)
    TriggerEvent('Notify', 'sucesso', "Você vestiu a roupa")
end)

RegisterNetEvent('openClothingMenu')
AddEventHandler('openClothingMenu', function(part)
    local data = {}

    createPedScreen() 

    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
        if part == 'luvas' then
            data = {
                list = clothesListMale.hands,
                sex = 'Male',
                category = 3,
                prefix = 'M',
                variation = 0
            }
        elseif part == 'calca' then
            data = {
                list = clothesListMale.pants,
                sex = 'Male',
                category = 4,
                prefix = 'M',
                variation = 0
            }
        elseif part == 'sapatos' then
            data = {
                list = clothesListMale.shoes,
                sex = 'Male',
                category = 6,
                prefix = 'M',
                variation = 0
            }
        elseif part == 'blusa' then
            data = {
                list = clothesListMale.undershirts,
                sex = 'Male',
                category = 8,
                prefix = 'M',
                variation = 0
            }
        elseif part == 'jaqueta' then
            data = {
                list = clothesListMale.hoods,
                sex = 'Male',
                category = 11,
                prefix = 'M',
                variation = 0
            }
        elseif part == 'chapeu' then
            data = {
                list = clothesListMale.hats,
                sex = 'Male',
                category = 'p0',
                prefix = 'M',
                variation = 0
            }
        elseif part == 'oculos' then
            data = {
                list = clothesListMale.glasses,
                sex = 'Male',
                category = 'p1',
                prefix = 'M',
                variation = 0
            }
        elseif part == 'mascara' then
            data = {
                list = clothesListMale.masks,
                sex = 'Male',
                category = 1,
                prefix = 'M',
                variation = 0
            }
        end

    else

        if part == 'luvas' then
            data = {
                list = clothesListFemale.hands,
                sex = 'Female',
                category = 3,
                prefix = 'F',
                variation = 0
            }
        elseif part == 'calca' then
            data = {
                list = clothesListFemale.pants,
                sex = 'Female',
                category = 4,
                prefix = 'F',
                variation = 0
            }
        elseif part == 'sapatos' then
            data = {
                list = clothesListFemale.shoes,
                sex = 'Female',
                category = 6,
                prefix = 'F',
                variation = 0
            }
        elseif part == 'blusa' then
            data = {
                list = clothesListFemale.undershirts,
                sex = 'Female',
                category = 8,
                prefix = 'F',
                variation = 0
            }
        elseif part == 'jaqueta' then
            data = {
                list = clothesListFemale.hoods,
                sex = 'Female',
                category = 11,
                prefix = 'F',
                variation = 0
            }
        elseif part == 'chapeu' then
            data = {
                list = clothesListFemale.hats,
                sex = 'Female',
                category = 'p0',
                prefix = 'F',
                variation = 0
            }
        elseif part == 'oculos' then
            data = {
                list = clothesListFemale.glasses,
                sex = 'Female',
                category = 'p1',
                prefix = 'F',
                variation = 0
            }
        elseif part == 'mascara' then
            data = {
                list = clothesListFemale.masks,
                sex = 'Female',
                category = 1,
                prefix = 'F',
                variation = 0
            }
        end
    end

    SetNuiFocus(true, true)
    pz.SendNuiMessage('showMenu', true, data)
end)

function createPedScreen() 

    CreateThread(function()

        heading = GetEntityHeading(PlayerPedId())

        SetFrontendActive(true)

        ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_EMPTY_NO_BACKGROUND"), true, -1)

        Wait(100)

        N_0x98215325a695e78a(false)

        PlayerPedPreview = ClonePed(PlayerPedId(), heading, true, false)

        local x,y,z = table.unpack(GetEntityCoords(PlayerPedPreview))

        SetEntityCoords(PlayerPedPreview, x,y,z-10)

        FreezeEntityPosition(PlayerPedPreview, true)

        SetEntityVisible(PlayerPedPreview, false, false)

        NetworkSetEntityInvisibleToNetwork(PlayerPedPreview, false)

        Wait(200)

        SetPedAsNoLongerNeeded(PlayerPedPreview)

        GivePedToPauseMenu(PlayerPedPreview, 2)

        SetPauseMenuPedLighting(true)

        SetPauseMenuPedSleepState(true)

        ReplaceHudColourWithRgba(117, 0, 0, 0, 0)

        previewPed = PlayerPedPreview

    end)
end

function destroyPedScreen()
    DeleteEntity(previewPed)
    DeletePed(previewPed)
    SetPauseMenuPedLighting(false)
    SetPauseMenuPedSleepState(false)
    SetFrontendActive(false)
end