local ArbazilothImmunity = CreatureEvent("ArbazilothImmunity")

function ArbazilothImmunity.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if creature and creature:isMonster() then
		creature:getPosition():sendMagicEffect(CONST_ME_HITAREA)
	end
	return true
end

ArbazilothImmunity:register()
