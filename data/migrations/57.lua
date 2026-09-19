function onUpdateDatabase()
	logger.info("Updating database to version 57 (loyalty highscore)")
	db.query("ALTER TABLE `players` ADD `loyalty_points` int(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `boss_points`")
end
