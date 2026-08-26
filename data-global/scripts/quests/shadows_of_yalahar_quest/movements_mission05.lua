local KV_SCOPE = "shadows-of-yalahar"
local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar

local CHARGES = { "A", "B", "C", "X", "Y", "Z" }

local chargeMachine = MoveEvent()
function chargeMachine.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local player = creature
	if player:getStorageValue(ShadowsOfYalahar.Mission05) ~= 1 then
		return true
	end

	local charge = CHARGES[math.random(1, #CHARGES)]

	local kv = player:kv():scoped(KV_SCOPE)
	kv:set("charge", charge)

	player:getPosition():sendMagicEffect(CONST_ME_YELLOWENERGY)
	player:say("You have gained a charge!", TALKTYPE_MONSTER_SAY)

	return true
end

chargeMachine:type("stepin")
chargeMachine:aid(25030)
chargeMachine:register()
