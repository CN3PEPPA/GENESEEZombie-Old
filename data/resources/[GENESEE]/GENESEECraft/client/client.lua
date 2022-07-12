local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

passos = Tunnel.getInterface("GENESEECraft")

local labels = {}
local craftingQueue = {}

function isNearWorkbench()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local near = false

    for _, v in ipairs(Config.Workbenches) do
        local dst = #(coords - v.coords)
        if dst < v.radius then
            near = true
        end
    end

    if near then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        if craftingQueue[1] ~= nil then
            if not Config.CraftingStopWithDistance or (Config.CraftingStopWithDistance and isNearWorkbench()) then
                craftingQueue[1].time = craftingQueue[1].time - 1

                SendNUIMessage({
                    type = "addqueue",
                    item = craftingQueue[1].item,
                    time = craftingQueue[1].time,
                    id = craftingQueue[1].id
                })

                if craftingQueue[1].time == 0 then
                    TriggerServerEvent("GENESEECraft:itemCrafted", craftingQueue[1].item, craftingQueue[1].count)
                    table.remove(craftingQueue, 1)
                end
            end
        end
    end
end)

local aberto = false
local liberado = true

function openWorkbench(val)
    if liberado then
        aberto = true
        local nome, quantidade = passos.getInvPlayer()

        if nome or quantidade ~= nil then
            local inv = {}
            local recipes = {}
            inv[nome] = quantidade
            SetNuiFocus(true, true)
            TriggerScreenblurFadeIn(1000)
            if #val.recipes > 0 then
                for _, g in ipairs(val.recipes) do
                    recipes[g] = Config.Recipes[g]
                end
            else
                recipes = Config.Recipes
            end
            SendNUIMessage({
                type = "open",
                recipes = recipes,
                names = Config.ItemsNames,
                level = passos.getXP(),
                inventory = inv,
                job = nil,
                grade = nil,
                hidecraft = Config.HideWhenCantCraft,
                categories = Config.Categories
            })
        else
            local inv = {}
            local recipes = {}
            SetNuiFocus(true, true)
            TriggerScreenblurFadeIn(1000)
            if #val.recipes > 0 then
                for _, g in ipairs(val.recipes) do
                    recipes[g] = Config.Recipes[g]
                end
            else
                recipes = Config.Recipes
            end
            SendNUIMessage({
                type = "open",
                recipes = recipes,
                names = Config.ItemsNames,
                level = passos.getXP(),
                inventory = inv,
                job = nil,
                grade = nil,
                hidecraft = Config.HideWhenCantCraft,
                categories = Config.Categories
            })
        end
    else
        -- TriggerEvent("GENESEECraft:sendMessage", Config.Text["not_liberated"])
        TriggerEvent("Notifty", source, 'aviso', Config.Text["not_liberated"])
    end
end

RegisterNetEvent('GENESEECraft:OpenNUI')
AddEventHandler('GENESEECraft:OpenNUI', function()
    for _, v in ipairs(Config.Workbenches) do
        openWorkbench(v)
    end
end)

RegisterNetEvent("GENESEECraft:craftStart")
AddEventHandler("GENESEECraft:craftStart", function(item, count)
    local id = math.random(000, 999)

    table.insert(craftingQueue, {
        time = Config.Recipes[item].Time,
        item = item,
        count = count,
        id = id
    })

    SendNUIMessage({
        type = "crafting",
        item = item
    })

    SendNUIMessage({
        type = "addqueue",
        item = item,
        time = Config.Recipes[item].Time,
        id = id
    })
end)

RegisterNetEvent("GENESEECraft:sendMessage")
AddEventHandler("GENESEECraft:sendMessage", function(msg)
    SendTextMessage(msg)
end)

RegisterNUICallback("close", function(data)
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    aberto = false
    liberado = false
    Wait(500)
    liberado = true
end)

RegisterNUICallback("reopen", function(data)

    aberto = false
    liberado = false
    Wait(500)
    liberado = true

    TriggerEvent('GENESEECraft:OpenNUI')
end)

RegisterNUICallback("craft", function(data)
    local item = data["item"]
    TriggerServerEvent("GENESEECraft:craft", item, false)
end)

function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
