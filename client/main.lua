local interiors, inside, currentRoom = {}, false, -1

--[[
    You can add this event when the player joins the server, here are some examples:

    QBCore or QBox | Client
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        TriggerEvent('room-system:playerLoad')
    end)

    Creative | Server
    AddEventHandler("Connect",function(citizenId, source)
        TriggerClientEvent('room-system:playerLoad', source)
    end)
]]


AddEventHandler('room-system:playerLoad', function()

    for k,v in pairs(Config.Interiors) do 
        interiors[GetInteriorAtCoords(v.location.x, v.location.y, v.location.z)] = { rooms = v.rooms, dimension = v.dimension }
    end

    while true do
        local msec = 1000
        local playerPed = PlayerPedId()
        local interiorId = GetInteriorFromEntity(playerPed)
        local roomHash = GetRoomKeyFromEntity(playerPed)
        local roomId = GetInteriorRoomIndexByHash(interiorId, roomHash)
        if (interiorId ~= 0 and roomId > 0) and interiors[interiorId] then 
            if not inside or (currentRoom ~= roomId) then 
                inside = true
                currentRoom = roomId
                local rooms = interiors[interiorId].rooms
                local dimension = interiors[interiorId].dimension
                if rooms[tostring(roomId)] then
                    TriggerServerEvent('room-system:changeDimension', (dimension+roomId))
                else
                    TriggerServerEvent('room-system:changeDimension', dimension+1)
                end
            end
        else
            if inside then 
                inside = false
                TriggerServerEvent('room-system:changeDimension', 0)
            end
        end
        Wait(msec)
    end
end)

RegisterCommand('interiorid', function()
    local playerPed = PlayerPedId()
    local interiorId = GetInteriorFromEntity(playerPed)
    local interiorId2 = GetInteriorAtCoords(GetEntityCoords(playerPed))
    local roomHash = GetRoomKeyFromEntity(playerPed)
    local roomId = GetInteriorRoomIndexByHash(interiorId, roomHash)
    print('interiorId', interiorId)
    print('roomId', roomId)
    if interiorId ~= 0 and roomId ~= 0 then 
        local roomName = GetInteriorRoomName(interiorId, roomId)
        print("current room id is: " .. roomId)
        print("current interior id is: " .. interiorId) 
    end
end)