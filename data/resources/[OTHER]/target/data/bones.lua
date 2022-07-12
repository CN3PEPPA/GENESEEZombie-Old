local Bones = {
    Options = {},
    Vehicle = {'chassis', 'windscreen', 'seat_pside_r', 'seat_dside_r', 'bodyshell', 'suspension_lm', 'suspension_lr',
               'platelight', 'attach_female', 'attach_male', 'bonnet', 'boot', 'chassis_dummy', 'chassis_Control',
               'door_dside_f', 'door_dside_r', 'door_pside_f', 'door_pside_r', 'Gun_GripR', 'windscreen_f',
               'platelight', 'VFX_Emitter', 'window_lf', 'window_lr', 'window_rf', 'window_rr', 'engine', 'gun_ammo',
               'ROPE_ATTATCH', 'wheel_lf', 'wheel_lr', 'wheel_rf', 'wheel_rr', 'exhaust', 'overheat', 'seat_dside_f',
               'seat_pside_f', 'Gun_Nuzzle', 'seat_r'}
}

if Config.EnableDefaultOptions then
    local BackEngineVehicles = {
        ['ninef'] = true,
        ['adder'] = true,
        ['vagner'] = true,
        ['t20'] = true,
        ['infernus'] = true,
        ['zentorno'] = true,
        ['reaper'] = true,
        ['comet2'] = true,
        ['comet3'] = true,
        ['jester'] = true,
        ['jester2'] = true,
        ['cheetah'] = true,
        ['cheetah2'] = true,
        ['prototipo'] = true,
        ['turismor'] = true,
        ['pfister811'] = true,
        ['ardent'] = true,
        ['nero'] = true,
        ['nero2'] = true,
        ['tempesta'] = true,
        ['vacca'] = true,
        ['bullet'] = true,
        ['osiris'] = true,
        ['entityxf'] = true,
        ['turismo2'] = true,
        ['fmj'] = true,
        ['re7b'] = true,
        ['tyrus'] = true,
        ['italigtb'] = true,
        ['penetrator'] = true,
        ['monroe'] = true,
        ['ninef2'] = true,
        ['stingergt'] = true,
        ['surfer'] = true,
        ['surfer2'] = true,
        ['gp1'] = true,
        ['autarch'] = true,
        ['tyrant'] = true
    }

    local function ToggleDoor(vehicle, door)
        if GetVehicleDoorLockStatus(vehicle) ~= 2 then
            if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
                SetVehicleDoorShut(vehicle, door, false)
            else
                SetVehicleDoorOpen(vehicle, door, false)
            end
        end
    end

    Bones.Options['engine'] = {
        ["Toggle Bike"] = {
            icon = "fas fa-door-open",
            label = "Trancar/Destrancar veiculo",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'engine') ~= -1
            end,
            action = function(entity)
                SetVehicleDoorsLocked(entity, 0)
            end,
            distance = 0.8
        },
        ["Toggle Bike 2"] = {
            icon = "fas fa-door-open",
            label = "Verificar Motor",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'engine') ~= -1
            end,
            action = function(entity)
                TriggerEvent("core_vehicle:Open")
            end,
            distance = 0.8
        },
        ["Add Fuel"] = {
            icon = "fas fa-gas-pump",
            label = "Abastecer veiculo",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'engine') ~= -1
            end,
            action = function(entity)
                TriggerEvent("pz_fuel:AddFuel",entity)
            end,
            distance = 0.8
        },
    }

    Bones.Options['seat_dside_f'] = {
        ["Toggle Front Door"] = {
            icon = "fas fa-door-open",
            label = "Trancar/Destrancar veiculo",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
            end,
            action = function(entity)
                SetVehicleDoorsLocked(entity, 0)
            end,
            distance = 1.5
        }
    }

    Bones.Options['seat_pside_f'] = {
        ["Toggle Front Door"] = {
            icon = "fas fa-door-open",
            label = "Trancar/Destrancar veiculo",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
            end,
            action = function(entity)
                SetVehicleDoorsLocked(entity, 0)
            end,
            distance = 1.5
        }
    }

    Bones.Options['seat_dside_r'] = {
        ["Toggle Rear Door"] = {
            icon = "fas fa-door-open",
            label = "Trancar/Destrancar veiculo",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
            end,
            action = function(entity)
                SetVehicleDoorsLocked(entity, 0)
            end,
            distance = 1.5
        }
    }

    Bones.Options['seat_pside_r'] = {
        ["Toggle Rear Door"] = {
            icon = "fas fa-door-open",
            label = "Trancar/Destrancar veiculo",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
            end,
            action = function(entity)
                SetVehicleDoorsLocked(entity, 0)
            end,
            distance = 1.5
        }
    }

    Bones.Options['bonnet'] = {
        ["Toggle Hood"] = {
            icon = "fa-duotone fa-engine",
            label = "Abrir/Fechar Capô",
            action = function(entity)
                -- ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 5 or 4)
                TriggerEvent("core_vehicle:Open")
            end,
            distance = 1.5
        }
    }

    Bones.Options['boot'] = {
        ["Toggle Trunk"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Abrir/Fechar Porta-Mala",
            action = function(entity)
                -- ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 4 or 5)
                TriggerEvent("vrp_trunkchest:Open")
            end,
            distance = 1.5
        }
    }
end

return Bones
