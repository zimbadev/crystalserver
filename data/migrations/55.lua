function onUpdateDatabase()
	logger.info("Updating database to version 55 (missing constraints + delete cascade)")

	-- this one had wrong name, just correcting it
	db.query([[
		ALTER TABLE `player_taskhunt`
		DROP PRIMARY KEY
	]])

	-- this one had wrong name, just correcting it
	db.query([[
		ALTER TABLE `account_vipgrouplist` DROP FOREIGN KEY `account_vipgrouplist_vipgroup_fk`;
	]])

	db.query([[
		ALTER TABLE account_vipgroups
		ADD CONSTRAINT account_vipgroups_accounts_fk
			FOREIGN KEY (account_id) REFERENCES accounts (id)
			ON DELETE CASCADE
	]])

	db.query([[
		ALTER TABLE players_online
		ADD CONSTRAINT players_online_players_fk
			FOREIGN KEY (player_id) REFERENCES players (id)
			ON DELETE CASCADE
	]])

	db.query([[
		ALTER TABLE player_kills
		ADD CONSTRAINT `player_kills_players_fk`
			FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
			ON DELETE CASCADE
	]])

	db.query([[
		ALTER TABLE player_prey
		ADD CONSTRAINT `player_prey_players_fk`
			FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
			ON DELETE CASCADE
	]])

	db.query([[
		ALTER TABLE player_taskhunt
		ADD CONSTRAINT `player_taskhunt_pk` PRIMARY KEY (`player_id`, `slot`),
		ADD CONSTRAINT `player_taskhunt_players_fk`
			FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
			ON DELETE CASCADE
	]])

	db.query([[
		ALTER TABLE player_bosstiary
		ADD CONSTRAINT `player_bosstiary_players_fk`
			FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
			ON DELETE CASCADE
	]])

	db.query([[
		ALTER TABLE player_stash
		ADD CONSTRAINT `player_stash_players_fk`
			FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
			ON DELETE CASCADE
	]])

	db.query([[
		ALTER TABLE `account_vipgrouplist`
		ADD CONSTRAINT `account_vipgrouplist_vipgroup_fk`
			FOREIGN KEY (`vipgroup_id`) REFERENCES `account_vipgroups` (`id`)
			ON DELETE CASCADE
	]])
end
