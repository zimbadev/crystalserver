local BROKEN_MOUNTS = { -- add future incoming color mounts in the future until otcr can handle it
    [1363] = true,
    [1430] = true,
    [1599] = true,
    [1724] = true,
    [1826] = true,
    [1827] = true,
    [1810] = true,
    [1866] = true,
}

local mountColorFix = GlobalEvent("MountColorFix")

function mountColorFix.onThink(interval)
    for _, player in ipairs(Game.getPlayers()) do
        local outfit = player:getOutfit()
        local mountId = outfit.lookMount

        if mountId and mountId > 0 and BROKEN_MOUNTS[mountId] then
            local hasColor = outfit.lookMountHead > 0 or outfit.lookMountBody > 0 or
                              outfit.lookMountLegs > 0 or outfit.lookMountFeet > 0

            if hasColor then
                outfit.lookMountHead = 0
                outfit.lookMountBody = 0
                outfit.lookMountLegs = 0
                outfit.lookMountFeet = 0
                player:setOutfit(outfit)
            end
        end
    end
    return true
end

mountColorFix:interval(250)
mountColorFix:register()