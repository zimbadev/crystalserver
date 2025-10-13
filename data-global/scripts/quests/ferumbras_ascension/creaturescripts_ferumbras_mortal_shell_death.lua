local ferumbrasMortalShell = CreatureEvent("FerumbrasMortalShell")

local config = AscendingFerumbrasConfig

_G.ferumbrasMortalShellSpawning = _G.ferumbrasMortalShellSpawning or false

function ferumbrasMortalShell.onDeath(creature, corpse, lasthitkiller, mostdamagekiller, lasthitunjustified, mostdamageunjustified)
	if creature:getName():lower() ~= "destabilized ferumbras" then
		return true
	end

	if _G.ferumbrasMortalShellSpawning then
		return true
	end

	_G.ferumbrasMortalShellSpawning = true

	local monster = Game.createMonster("Ferumbras Mortal Shell", config.bossPos, true, true)
	if not monster then
		_G.ferumbrasMortalShellSpawning = false
		return true
	end

	monster:say("AAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHH!", TALKTYPE_MONSTER_SAY)
	lasthitkiller:say("FINALY YOU FORCED FERUMBRAS BACK INTO A MORTAL FORM - HE IS NOT AMUSED!", TALKTYPE_MONSTER_SAY, nil, nil, config.bossPos)

	addEvent(function()
		_G.ferumbrasMortalShellSpawning = false
	end, 2000)

	return true
end

ferumbrasMortalShell:register()
