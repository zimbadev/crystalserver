local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local function sendEffect(playerPosition)
	local positions = {
		Position(playerPosition.x - 1, playerPosition.y, playerPosition.z),
		Position(playerPosition.x, playerPosition.y, playerPosition.z),
		Position(playerPosition.x + 1, playerPosition.y, playerPosition.z),
		Position(playerPosition.x, playerPosition.y + 1, playerPosition.z),
		Position(playerPosition.x + 1, playerPosition.y + 1, playerPosition.z),
	}

	for _, effectPosition in ipairs(positions) do
		effectPosition:sendMagicEffect(CONST_ME_PURPLEENERGY)
	end
end

local showerYalahar = MoveEvent()
function showerYalahar.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local player = creature
	if player:getStorageValue(ShadowsOfYalahar.Mission11) ~= 1 then
		return true
	end

	player:say("You are showered by strange energy!", TALKTYPE_MONSTER_SAY)
	sendEffect(player:getPosition())
	player:setStorageValue(ShadowsOfYalahar.Mission11, 2)
	return true
end

showerYalahar:type("stepin")
showerYalahar:aid(25031)
showerYalahar:register()
