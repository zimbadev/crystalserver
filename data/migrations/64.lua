function onUpdateDatabase()
	logger.info("Updating database to version 64 (open pvp: frag share weight columns)")

	if not db.query("ALTER TABLE `player_kills` ADD COLUMN `weight` smallint(5) UNSIGNED NOT NULL DEFAULT 100") then
		logger.warn("Column weight may already exist on player_kills.")
	end
end
