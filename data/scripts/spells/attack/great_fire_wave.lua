-- Vocation Adjustment: a Master Sorcerer's elemental stance reshapes Great Fire Wave (element + the
-- AoE magic EFFECT id):
--   Master of Thunder -> energy, effect 332
--   Master of Decay   -> death,  effect 331
--   Master of Flames / no stance -> base fire (CONST_ME_HITBYFIRE)
local function fireWaveFormula(level, maglevel)
	local min = (calculateBaseDamageHealing(level)) + (maglevel * 2.8) + 16
	local max = (calculateBaseDamageHealing(level)) + (maglevel * 4.4) + 28 -- TODO: Formulas (TibiaWiki says ~Strong Flame Strike but we need more acurracy)
	return -min, -max
end

-- Each combat needs its OWN callback name (Canary won't let two combats share a callback name); all
-- delegate to the same formula.
function onGetFormulaValues(player, level, maglevel, basePower)
	return fireWaveFormula(level, maglevel)
end
function onGetFormulaValuesThunder(player, level, maglevel)
	return fireWaveFormula(level, maglevel)
end
function onGetFormulaValuesDecay(player, level, maglevel)
	return fireWaveFormula(level, maglevel)
end

local area = createCombatArea(AREA_WAVE7, AREADIAGONAL_WAVE7)

local function createFireWaveCombat(combatType, effect, callbackName)
	local c = Combat()
	c:setParameter(COMBAT_PARAM_TYPE, combatType)
	c:setParameter(COMBAT_PARAM_EFFECT, effect)
	c:setArea(area)
	c:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, callbackName)
	return c
end

local combat = createFireWaveCombat(COMBAT_FIREDAMAGE, CONST_ME_HITBYFIRE, "onGetFormulaValues")
local combatThunder = createFireWaveCombat(COMBAT_ENERGYDAMAGE, 332, "onGetFormulaValuesThunder")
local combatDecay = createFireWaveCombat(COMBAT_DEATHDAMAGE, 331, "onGetFormulaValuesDecay")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local player = creature:getPlayer()
	if player then
		local stance = player:getElementalStance()
		if stance == STANCE_MASTER_OF_THUNDER then
			return combatThunder:execute(creature, var)
		elseif stance == STANCE_MASTER_OF_DECAY then
			return combatDecay:execute(creature, var)
		end
	end
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(240)
spell:name("Great Fire Wave")
spell:words("exevo gran flam hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_GREAT_FIRE_WAVE)
spell:level(38)
spell:mana(120)
spell:basePower(100)
spell:isPremium(true)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
