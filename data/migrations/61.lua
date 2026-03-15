function onUpdateDatabase()
	logger.info("Updating database to version 61 (player binary save/load)")
	db.query("ALTER TABLE `players` ADD `spells` blob DEFAULT NULL")
	db.query("ALTER TABLE `players` ADD `storages` mediumblob DEFAULT NULL")
	db.query("ALTER TABLE `players` ADD `items` longblob DEFAULT NULL")
	db.query("ALTER TABLE `players` ADD `depotitems` longblob DEFAULT NULL")
	db.query("ALTER TABLE `players` ADD `inboxitems` longblob DEFAULT NULL")
	db.query("ALTER TABLE `players` ADD `stashitems` longblob DEFAULT NULL")
end
