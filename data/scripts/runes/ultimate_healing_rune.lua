local healingCombat = Combat()
healingCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
healingCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
healingCombat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
healingCombat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
healingCombat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetHealingValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 7.3) + 42
	local max = (level / 5) + (maglevel * 12.4) + 90
	return min, max
end
healingCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetHealingValues")

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	local target = Creature(var:getNumber()) or creature:getTarget()

	if not target or not target:isCreature() then
		return false
	end

	if target:isMonster() and target:getName():lower() == "leiden" then
		local damage = -((creature:getLevel() / 5) + (creature:getMagicLevel() * 12.4) + 90)
		target:addHealth(damage)
		target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		return true
	end

	if target:isMonster() then
		return false
	end

	return healingCombat:execute(creature, Variant(target:getId()))
end

rune:id(5)
rune:group("healing")
rune:name("ultimate healing rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_ULTIMATE_HEALING_RUNE)
rune:runeId(3160)
rune:allowFarUse(true)
rune:charges(1)
rune:level(24)
rune:magicLevel(4)
rune:cooldown(1 * 1000)
rune:groupCooldown(1 * 1000)
rune:isAggressive(false)
rune:needTarget(true)
rune:isBlocking(true)
rune:register()
