local FrameworkList = {
    ['qbx'] = function()
        exports.qbx_core:SetPlayerBucket(source, dimension)
    end,
    ['qb'] = function(source, dimension)
        local QBCore = exports['qb-core']:GetCoreObject() 
        QBCore.Functions.SetPlayerBucket(source, dimension)
    end,
    ['standalone'] = function(source, dimension)
        SetPlayerRoutingBucket(source, dimension)
    end
}

function ChangePlayerRoutingBucket(...)
    (FrameworkList[Config.Framework] or FrameworkList['standalone'])(...)
end

RegisterNetEvent('room-system:changeDimension', function(dimension)
    local source = source
    ChangePlayerRoutingBucket(...)
end)