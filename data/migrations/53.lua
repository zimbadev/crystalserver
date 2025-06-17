function onUpdateDatabase()
	logger.info("Updating database to version 53 (fix: player_charms foreign key with ON DELETE CASCADE)")

	db.query([[
		ALTER TABLE `player_charms`
		DROP FOREIGN KEY player_charms_players_fk;
	]])

	db.query([[
		ALTER TABLE `player_charms`
		ADD CONSTRAINT player_charms_players_fk
		FOREIGN KEY (player_id)
		REFERENCES players(id)
		ON DELETE CASCADE;
	]])
end
