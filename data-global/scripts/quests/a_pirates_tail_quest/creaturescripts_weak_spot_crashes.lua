local WeakSpotDeath = CreatureEvent("WeakSpotDeath")

function WeakSpotDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature or not creature:getMonster() then
		return true
	end

	creature:say("The weak spot of the gates crashes!", TALKTYPE_MONSTER_SAY)

	return true
end

WeakSpotDeath:register()
