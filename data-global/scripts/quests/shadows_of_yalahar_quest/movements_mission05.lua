local ShadowsOfYalahar = Storage.Quest.U8_5.ShadowsOfYalahar
local CHARGES = { "A", "B", "C", "X", "Y", "Z" }
local chargeMachine = MoveEvent()
function chargeMachine.onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end
	local player = creature
	local missionProgress = player:getStorageValue(ShadowsOfYalahar.Mission05)
	if missionProgress >= 1 and missionProgress <= 3 then
		if player:getStorageValue(ShadowsOfYalahar.ChargeCurrent) > 0 then
			player:say("You are already charged. Go deliver it first.", TALKTYPE_MONSTER_SAY)
			return true
		end
		local chargeIndex = math.random(1, #CHARGES)
		player:setStorageValue(ShadowsOfYalahar.ChargeCurrent, chargeIndex)
		player:getPosition():sendMagicEffect(CONST_ME_YELLOWENERGY)
		player:say("You have gained a charge!", TALKTYPE_MONSTER_SAY)
	end
	return true
end
chargeMachine:type("stepin")
chargeMachine:aid(25030)
chargeMachine:register()
