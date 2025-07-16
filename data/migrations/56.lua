function dropForeignKeyIfExists(tableName, fkName)
	local res = db.storeQuery("SELECT CONSTRAINT_NAME FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_NAME = '" .. tableName .. "' AND CONSTRAINT_NAME = '" .. fkName .. "';")
	if res then
		db.query("ALTER TABLE `" .. tableName .. "` DROP FOREIGN KEY `" .. fkName .. "`;")
	end
end

function onUpdateDatabase()
	logger.info("Updating database to version 56 (fixing constraints + delete cascade)")

	-- Drop existing constraints if they exist
	dropForeignKeyIfExists("account_vipgroups", "account_vipgroups_accounts_fk")
	dropForeignKeyIfExists("players_online", "players_online_players_fk")
	dropForeignKeyIfExists("player_kills", "player_kills_players_fk")
	dropForeignKeyIfExists("player_prey", "player_prey_players_fk")
	dropForeignKeyIfExists("player_taskhunt", "player_taskhunt_players_fk")
	dropForeignKeyIfExists("player_bosstiary", "player_bosstiary_players_fk")
	dropForeignKeyIfExists("player_stash", "player_stash_players_fk")
	dropForeignKeyIfExists("account_vipgrouplist", "account_vipgrouplist_vipgroup_fk")

	-- Drop primary key (make sure no FK depends on it)
	db.query([[ALTER TABLE player_taskhunt DROP PRIMARY KEY]])

	-- Add constraints back
	db.query([[ALTER TABLE account_vipgroups ADD CONSTRAINT account_vipgroups_accounts_fk FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE CASCADE]])
	db.query([[ALTER TABLE players_online ADD CONSTRAINT players_online_players_fk FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE]])
	db.query([[ALTER TABLE player_kills ADD CONSTRAINT player_kills_players_fk FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE]])
	db.query([[ALTER TABLE player_prey ADD CONSTRAINT player_prey_players_fk FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE]])
	db.query([[ALTER TABLE player_taskhunt ADD CONSTRAINT player_taskhunt_pk PRIMARY KEY (player_id, slot)]])
	db.query([[ALTER TABLE player_taskhunt ADD CONSTRAINT player_taskhunt_players_fk FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE]])
	db.query([[ALTER TABLE player_bosstiary ADD CONSTRAINT player_bosstiary_players_fk FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE]])
	db.query([[ALTER TABLE player_stash ADD CONSTRAINT player_stash_players_fk FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE]])
	db.query([[ALTER TABLE account_vipgrouplist ADD CONSTRAINT account_vipgrouplist_vipgroup_fk FOREIGN KEY (vipgroup_id) REFERENCES account_vipgroups(id) ON DELETE CASCADE]])
end
