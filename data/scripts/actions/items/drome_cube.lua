local DROME_CUBE_ID = 36827

local dromaCubes = {
    [DROME_CUBE_ID] = {
 		{ id = 36723, name = "kooldown-aid" },
 		{ id = 36724, name = "strike enhancement" },
 		{ id = 36725, name = "stamina extension" },
 		{ id = 36726, name = "charm upgrade" },
 		{ id = 36727, name = "wealth duplex" },
 		{ id = 36728, name = "bestiary betterment" },
 		{ id = 36729, name = "fire resilience" },
 		{ id = 36730, name = "ice resilience" },
 		{ id = 36731, name = "earth resilience" },
 		{ id = 36732, name = "energy resilience" },
 		{ id = 36733, name = "holy resilience" },
 		{ id = 36734, name = "death resilience" },
 		{ id = 36735, name = "physical resilience" },
 		{ id = 36736, name = "fire amplification" },
 		{ id = 36737, name = "ice amplification" },
 		{ id = 36738, name = "earth amplification" },
 		{ id = 36739, name = "energy amplification" },
 		{ id = 36740, name = "holy amplification" },
 		{ id = 36741, name = "death amplification" },
 		{ id = 36742, name = "physical amplification" },
 	},
}

local dromeCube = Action()

function dromeCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local dromaCube = dromaCubes[item.itemid]
	if not dromaCube then
		return false
	end

    local randomIndex = math.random(1, #dromaCube)
	local rewardItem = dromaCube[randomIndex]
	player:addItem(rewardItem.id, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received a " .. rewardItem.name .. ".")

	item:remove(1)
	return true
end

dromeCube:id(DROME_CUBE_ID)
dromeCube:register()
