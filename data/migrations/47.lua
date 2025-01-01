function onUpdateDatabase()
	logger.info("Updating database to version 48 (player statements)")

	db.query([[
		CREATE TABLE IF NOT EXISTS `player_statements`(
			`id` INT NOT NULL AUTO_INCREMENT,
			`sender` VARCHAR (255) NOT NULL,
			`receiver` VARCHAR (255) NOT NULL,
			`channel_id` INT NOT NULL DEFAULT 0,
			`text` VARCHAR (255) NOT NULL,
			`date` BIGINT NOT NULL DEFAULT 0,
			PRIMARY KEY (`id`),
			KEY (`channel_id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	]])
	return true
end
