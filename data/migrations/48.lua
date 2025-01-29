function onUpdateDatabase()
	logger.info("Updating database to version 48 (player statements)")

	db.query([[
		CREATE TABLE IF NOT EXISTS `player_statements`(
			`id` INT NOT NULL AUTO_INCREMENT,
			`player_id` INT NOT NULL,
			`receiver` TEXT NOT NULL,
			`channel_id` INT NOT NULL DEFAULT 0,
			`text` VARCHAR (255) NOT NULL,
			`date` BIGINT NOT NULL DEFAULT 0,
			PRIMARY KEY (`id`), KEY (`player_id`), KEY (`channel_id`),
			FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
		)
	]])
end
