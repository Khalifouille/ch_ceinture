ESX = exports['es_extended']:getSharedObject()

local seatbeltStatus = {}

print("Bonne année")

RegisterServerEvent('ch_ceinture:saveSeatbeltStatus')
AddEventHandler('ch_ceinture:saveSeatbeltStatus', function(playerId, status)
    seatbeltStatus[playerId] = status
end)

RegisterCommand('checkcein', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'police' then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Vous n'avez pas la permission d'utiliser cette commande"}
        })
        return
    end

    local targetId = tonumber(args[1])
    if targetId == source then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Tu ne peux pas t'auto check crampté"}
        })
        return
    end

    if targetId then
        local targetPlayer = ESX.GetPlayerFromId(targetId)
        if targetPlayer then
            local sourcePed = GetPlayerPed(source)
            local targetPed = GetPlayerPed(targetId)
            local sourceCoords = GetEntityCoords(sourcePed)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(sourceCoords - targetCoords)

            if distance <= 3.0 then
                if not IsPedInAnyVehicle(targetPed, false) then
                    TriggerClientEvent('chat:addMessage', source, {
                        color = { 255, 0, 0},
                        multiline = true,
                        args = {"System", "Crampté, il n'est pas dans un véhicule"}
                    })
                    return
                end

                if seatbeltStatus[targetId] ~= nil then
                    local status = seatbeltStatus[targetId] and "attachée" or "détachée"
                    TriggerClientEvent('chat:addMessage', source, {
                        color = { 255, 0, 0},
                        multiline = true,
                        args = {"System", "La ceinture du joueur " .. targetId .. " est " .. status}
                    })
                else
                    TriggerClientEvent('chat:addMessage', source, {
                        color = { 255, 0, 0},
                        multiline = true,
                        args = {"System", "État de ceinture inconnu pour le joueur " .. targetId}
                    })
                end
            else
                TriggerClientEvent('chat:addMessage', source, {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {"System", "Vous devez être à proximité (2-3 mètres) du joueur pour vérifier l'état de sa ceinture"}
                })
            end
        else
            TriggerClientEvent('chat:addMessage', source, {
                color = { 255, 0, 0},
                multiline = true,
                args = {"System", "Joueur non trouvé"}
            })
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "ID de joueur invalide"}
        })
    end
end, false)