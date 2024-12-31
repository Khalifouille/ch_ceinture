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
            showSeatbeltIcon = true
        else
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"System", "Ceinture détachée"}
            })
            showSeatbeltIcon = false
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

        if showSeatbeltIcon then
            DrawSeatbeltIcon()
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
                for i = 1, 5 do
                    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
                    Citizen.Wait(1000)
                end
            end
        end
    end
end)

function DrawSeatbeltIcon()
    local dict = "image"
    local icon = "image"

    if not HasStreamedTextureDictLoaded(dict) then
        RequestStreamedTextureDict(dict, true)
        while not HasStreamedTextureDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end

    if HasStreamedTextureDictLoaded(dict) then
        local x, y = 0.9, 0.9
        local width, height = 0.1, 0.1

        DrawSprite(dict, icon, x, y, width, height, 0.0, 255, 255, 255, 255)
    else
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawSeatbeltIcon()
    end
end)