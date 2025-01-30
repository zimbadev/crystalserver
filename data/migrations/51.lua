function onUpdateDatabase()
	logger.info("Updating database to version 51 (Player Old Names)")

	db.query([[ 
		CREATE TABLE `player_oldnames` (
			`id` int(11) NOT NULL AUTO_INCREMENT,
			`player_id` int(11) NOT NULL,
			`former_name` varchar(255) NOT NULL DEFAULT '',
			`name` varchar(255) NOT NULL,
			`old_name` varchar(255) NOT NULL,
			`date` int(11) NOT NULL,
			PRIMARY KEY (`id`),
			INDEX `player_id_index` (`player_id`)
		)
	]])
end
