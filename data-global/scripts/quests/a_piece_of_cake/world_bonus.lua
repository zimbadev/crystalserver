--	A Piece of Cake - World Bonus

local expBonus = EventCallback("CakeQuestExpBonus")

function expBonus.playerOnGainExperience(player, target, exp, rawExp)
	if player:isPremium() and os.time() < CakeQuest.get(CakeQuest.Keys.WorldBonusUntil, 0) then
		exp = exp + math.floor(exp * (CakeQuest.Config.EXP_BONUS_PERCENT / 100))
	end
	return exp
end

expBonus:register()

function CakeQuest.applyRegenBonus(player)
	local bonusUntil = CakeQuest.get(CakeQuest.Keys.WorldBonusUntil, 0)
	local remaining = bonusUntil - os.time()
	if remaining <= 0 then
		return
	end

	local vocation = player:getVocation()
	if not vocation then
		return
	end

	local healthGain = vocation:getHealthGainAmount() or 0
	local healthTicks = vocation:getHealthGainTicks() or 1000
	local manaGain = vocation:getManaGainAmount() or 0
	local manaTicks = vocation:getManaGainTicks() or 1000

	local extraHealthGain = healthGain > 0 and math.max(1, math.floor(healthGain * (CakeQuest.Config.REGEN_BONUS_PERCENT / 100))) or 0
	local extraManaGain = manaGain > 0 and math.max(1, math.floor(manaGain * (CakeQuest.Config.REGEN_BONUS_PERCENT / 100))) or 0

	if extraHealthGain <= 0 and extraManaGain <= 0 then
		return
	end

	local condition = Condition(CONDITION_REGENERATION, CONDITIONID_COMBAT)
	condition:setParameter(CONDITION_PARAM_TICKS, remaining * 1000)
	if extraHealthGain > 0 then
		condition:setParameter(CONDITION_PARAM_HEALTHGAIN, extraHealthGain)
		condition:setParameter(CONDITION_PARAM_HEALTHTICKS, healthTicks)
	end
	if extraManaGain > 0 then
		condition:setParameter(CONDITION_PARAM_MANAGAIN, extraManaGain)
		condition:setParameter(CONDITION_PARAM_MANATICKS, manaTicks)
	end
	player:addCondition(condition)
end

local regenBonusLogin = CreatureEvent("CakeQuestWorldBonusLogin")

function regenBonusLogin.onLogin(player)
	CakeQuest.applyRegenBonus(player)
	if os.time() < CakeQuest.get(CakeQuest.Keys.WorldBonusUntil, 0) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You still feel the effects of the World Quest cake: bonus regeneration and (if premium) bonus experience are active!")
	end
	return true
end

regenBonusLogin:register()
