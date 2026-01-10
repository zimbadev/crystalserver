function onUpdateDatabase()
	logger.info("Updating database to version 60 (rename tracker_list column)")
	db.query("ALTER TABLE `player_charms` CHANGE COLUMN `tracker list` `tracker_list` BLOB NULL")
end
