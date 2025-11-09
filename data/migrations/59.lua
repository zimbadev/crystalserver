function onUpdateDatabase()
	logger.info("Updating database to version 59 (player charms change to INT size")
	db.query("ALTER TABLE `player_charms` MODIFY COLUMN `charm_points` INT UNSIGNED NOT NULL DEFAULT 0;")
	db.query("ALTER TABLE `player_charms` MODIFY COLUMN `minor_charm_echoes` INT UNSIGNED NOT NULL DEFAULT 0;")
	db.query("ALTER TABLE `player_charms` MODIFY COLUMN `max_charm_points` INT UNSIGNED NOT NULL DEFAULT 0;")
	db.query("ALTER TABLE `player_charms` MODIFY COLUMN `max_minor_charm_echoes` INT UNSIGNED NOT NULL DEFAULT 0;")
end
