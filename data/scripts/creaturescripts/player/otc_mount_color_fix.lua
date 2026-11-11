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

local function sanitizeMountColor(player)
	local outfit = player:getOutfit()
	if outfit.lookMount and outfit.lookMount > 0 and BROKEN_MOUNTS[outfit.lookMount] then
		if outfit.lookMountHead > 0 or outfit.lookMountBody > 0 or outfit.lookMountLegs > 0 or outfit.lookMountFeet > 0 then
			outfit.lookMountHead = 0
			outfit.lookMountBody = 0
			outfit.lookMountLegs = 0
			outfit.lookMountFeet = 0
			player:setOutfit(outfit)
		end
	end
end

local think = CreatureEvent("StripBrokenMountColorThink")
function think.onThink(player, interval)
	sanitizeMountColor(player)
	return true
end
think:type("think")
think:register()
