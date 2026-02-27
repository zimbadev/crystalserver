local rottenBloodStartup = GlobalEvent("RottenBloodStartup")

function rottenBloodStartup.onStartup()
	-- Lista de todos los monstruos de bakragore que necesitan los eventos
	local bakragoreMonsters = {
		"sopping corpus",
		"oozing corpus",
		"mycobiontic beetle",
		"bloated man-maggot",
		"walking pillar",
		"darklight matter",
		"darklight source",
		"darklight striker",
		"darklight emitter",
		"darklight construct",
		"wandering pillar",
		"converter",
		"oozing carcass",
		"sopping carcass",
		"rotten man-maggot",
		"meandering mushroom",
	}

	-- Registrar evento de muerte para spawn de Elder Bloodjaw
	for _, monsterName in ipairs(bakragoreMonsters) do
		local mType = MonsterType(monsterName)
		if mType then
			mType:registerEvent("RottenBloodMonsterDeath")
			logger.debug("Registered RottenBloodMonsterDeath event for monster: {}", monsterName)
		else
			logger.error("Monster type not found: {}", monsterName)
		end
	end

	logger.info("Rotten Blood events registered successfully for {} monsters", #bakragoreMonsters)
	return true
end

rottenBloodStartup:register()
