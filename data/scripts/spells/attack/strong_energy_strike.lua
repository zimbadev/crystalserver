local function strikeFormula(level, maglevel, basePower)
	local min, max = calculateMagicSpellDamage(level, maglevel, basePower)
	return -min, -max
end

function onGetFormulaValues(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel, basePower)
end
function onGetFormulaValuesFlames(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel, basePower)
end
function onGetFormulaValuesDecay(player, level, maglevel, basePower)
	return strikeFormula(level, maglevel, basePower)
end

local function createStrikeCombat(combatType, effect, missile, callbackName)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setParameter(COMBAT_PARAM_DISTANCEEFFECT, missile)
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return c
end

local combat = createStrikeCombat(COMBAT_ENERGYDAMAGE, CONST_ME_ENERGYAREA, CONST_ANI_ENERGY, "onGetFormulaValues")
local combatFlames = createStrikeCombat(COMBAT_FIREDAMAGE, 329, 4, "onGetFormulaValuesFlames")
local combatDecay = createStrikeCombat(COMBAT_DEATHDAMAGE, 330, 11, "onGetFormulaValuesDecay")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_FLAMES then
			return combatFlames:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return combatDecay:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack", "special")
spell:id(151)
spell:name("Strong Energy Strike")
spell:words("exori gran vis")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_STRONG_ENERGY_STRIKE)
spell:level(80)
spell:mana(60)
spell:basePower(125)
spell:isPremium(true)
spell:range(7)
spell:needCasterTargetOrDirection(true)
spell:blockWalls(true)
spell:cooldown(8 * 1000)
spell:groupCooldown(2 * 1000, 8 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
