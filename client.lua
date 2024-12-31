local isSeatbeltOn = false

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
        else
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"System", "Ceinture détachée"}
            })
        end
    end
end

RegisterCommand('ceinture', function()
    toggleSeatbelt()
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if isSeatbeltOn and IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if GetEntitySpeed(vehicle) > 20.0 then
                SetPedConfigFlag(playerPed, 32, true)
            else
                SetPedConfigFlag(playerPed, 32, false)
            end
        else
            SetPedConfigFlag(playerPed, 32, false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if not IsPedInAnyVehicle(playerPed, false) and isSeatbeltOn then
            isSeatbeltOn = false
            TriggerServerEvent('ch_ceinture:saveSeatbeltStatus', GetPlayerServerId(PlayerId()), isSeatbeltOn)
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"System", "Ceinture détachée automatiquement"}
            })
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
                --TriggerEvent('chat:addMessage', {
                --    color = { 255, 0, 0},
                --    multiline = true,
                --    args = {"System", "Bip bip bip! Mettez votre ceinture!"}
                --})
                for i = 1, 5 do
                    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
                    Citizen.Wait(1000)
                end
            end
        end
    end
end)