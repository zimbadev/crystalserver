local dromeCube = 36827
local rewards = {
	{ id = 36723, count = 1 }, -- kooldown-aid
	{ id = 36724, count = 1 }, -- strike enhancement
	{ id = 36725, count = 1 }, -- stamina extension
	{ id = 36726, count = 1 }, -- charm upgrade
	{ id = 36727, count = 1 }, -- wealth duplex
	{ id = 36728, count = 1 }, -- bestiary betterment
	{ id = 36729, count = 1 }, -- fire resilience
	{ id = 36730, count = 1 }, -- ice resilience
	{ id = 36731, count = 1 }, -- earth resilience
	{ id = 36732, count = 1 }, -- energy resilience
	{ id = 36733, count = 1 }, -- holy resilience
	{ id = 36734, count = 1 }, -- death resilience
	{ id = 36735, count = 1 }, -- physical resilience
	{ id = 36736, count = 1 }, -- fire amplification
	{ id = 36737, count = 1 }, -- amplification
	{ id = 36738, count = 1 }, -- earth amplification
	{ id = 36739, count = 1 }, -- energy amplification
	{ id = 36740, count = 1 }, -- holy amplification
	{ id = 36741, count = 1 }, -- holy amplification
	{ id = 36742, count = 1 }, -- physical amplification
}

local randomBox = Action()

function randomBox.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local reward = rewards[math.random(1, #rewards)]

	item:remove(1)

	player:addItem(reward.id)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received a " .. ItemType(reward.id):getName() .. "!")

	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)

	return true
end

randomBox:id(dromeCube)
randomBox:register()
