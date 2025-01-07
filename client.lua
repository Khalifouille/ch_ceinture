ESX = exports['es_extended']:getSharedObject()

local isSeatbeltOn = false
local showSeatbeltIcon = false

function toggleSeatbelt()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        isSeatbeltOn = not isSeatbeltOn
        TriggerServerEvent('ch_ceinture:saveSeatbeltStatus', GetPlayerServerId(PlayerId()), isSeatbeltOn)
        if isSeatbeltOn then
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"System", "Ceinture attachée"}
            })
            showSeatbeltIcon = false
        else
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"System", "Ceinture détachée"}
            })
            showSeatbeltIcon = true
        end
        SendNuiMessage(json.encode({ type = 'toggleSeatbeltIcon', show = showSeatbeltIcon }))
    end
end

RegisterKeyMapping('ceinture', 'Retirer la ceinture', 'keyboard', 'K')

ESX.RegisterInput('ceinture', 'Retirer la ceinture', 'keyboard', 'K', function()
    toggleSeatbelt()
end, nil)

RegisterCommand('ceinture', function()
    toggleSeatbelt()
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            if not isSeatbeltOn then
                showSeatbeltIcon = true
            else
                showSeatbeltIcon = false
            end
        else
            showSeatbeltIcon = false
        end
        SendNuiMessage(json.encode({ type = 'toggleSeatbeltIcon', show = showSeatbeltIcon }))
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if not IsPedInAnyVehicle(playerPed, false) and isSeatbeltOn then
            isSeatbeltOn = false
            showSeatbeltIcon = false
            TriggerServerEvent('ch_ceinture:saveSeatbeltStatus', GetPlayerServerId(PlayerId()), isSeatbeltOn)
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"System", "Ceinture détachée automatiquement"}
            })
            SendNuiMessage(json.encode({ type = 'toggleSeatbeltIcon', show = showSeatbeltIcon }))
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) and not isSeatbeltOn then
            Citizen.Wait(3000)
            if IsPedInAnyVehicle(playerPed, false) and not isSeatbeltOn then
                SendNuiMessage(json.encode({ type = 'toggleSeatbeltIcon', show = true }))
                for i = 1, 5 do
                    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
                    Citizen.Wait(1000)
                end
                if not isSeatbeltOn then
                    SendNuiMessage(json.encode({ type = 'toggleSeatbeltIcon', show = false }))
                end
            end
        end
    end
end)