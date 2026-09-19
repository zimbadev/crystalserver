function onUpdateDatabase()
	logger.info("Updating database to version 62 (feat: soul seals points column)")

	db.query([[
		CREATE TABLE IF NOT EXISTS `player_bounty_tasks` (
			`player_id` int NOT NULL,
			`state` tinyint NOT NULL DEFAULT 0,
			`difficulty` tinyint NOT NULL DEFAULT 0,
			`bounty_points` int NOT NULL DEFAULT 0,
			`reroll_tokens` tinyint NOT NULL DEFAULT 0,
			`free_reroll` bigint NOT NULL DEFAULT 0,
			`active_raceid` int NOT NULL DEFAULT 0,
			`active_kills` int NOT NULL DEFAULT 0,
			`active_required_kills` int NOT NULL DEFAULT 0,
			`active_reward_exp` int NOT NULL DEFAULT 0,
			`active_reward_points` tinyint NOT NULL DEFAULT 0,
			`active_task_grade` tinyint NOT NULL DEFAULT 0,
			`active_task_difficulty` tinyint NOT NULL DEFAULT 0,
			`talisman_damage_level` tinyint NOT NULL DEFAULT 0,
			`talisman_lifeleech_level` tinyint NOT NULL DEFAULT 0,
			`talisman_loot_level` tinyint NOT NULL DEFAULT 0,
			`talisman_bestiary_level` tinyint NOT NULL DEFAULT 0,
			`preferred_lists` BLOB NULL,
			`current_creatures_list` BLOB NULL,
			CONSTRAINT `player_bounty_tasks_pk` PRIMARY KEY (`player_id`),
			CONSTRAINT `player_bounty_tasks_players_fk`
				FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
				ON DELETE CASCADE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	]])

	db.query([[
		CREATE TABLE IF NOT EXISTS `player_weekly_tasks` (
			`player_id` int NOT NULL,
			`has_expansion` BOOLEAN NOT NULL DEFAULT FALSE,
			`difficulty` tinyint NOT NULL DEFAULT 0,
			`any_creature_total_kills` int NOT NULL DEFAULT 0,
			`any_creature_current_kills` int NOT NULL DEFAULT 0,
			`completed_kill_tasks` tinyint NOT NULL DEFAULT 0,
			`completed_delivery_tasks` tinyint NOT NULL DEFAULT 0,
			`kill_task_reward_exp` int NOT NULL DEFAULT 0,
			`delivery_task_reward_exp` int NOT NULL DEFAULT 0,
			`reward_hunting_points` int NOT NULL DEFAULT 0,
			`reward_soulseals` int NOT NULL DEFAULT 0,
			`soulseals_points` int NOT NULL DEFAULT 0,
			`needs_reward` tinyint NOT NULL DEFAULT 0,
			`weekly_progress_finished` tinyint NOT NULL DEFAULT 0,
			`kill_tasks` BLOB NULL,
			`delivery_tasks` BLOB NULL,
			CONSTRAINT `player_weekly_tasks_pk` PRIMARY KEY (`player_id`),
			CONSTRAINT `player_weekly_tasks_players_fk`
				FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
				ON DELETE CASCADE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	]])
end
