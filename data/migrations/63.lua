function onUpdateDatabase()
	logger.info("Updating database to version 63 (fix: player_weekly_tasks weekly_progress_finished column)")

	if not db.query([[
		ALTER TABLE `player_weekly_tasks`
		ADD COLUMN `weekly_progress_finished` tinyint NOT NULL DEFAULT 0 AFTER `needs_reward`;
	]]) then
		logger.warn("Column weekly_progress_finished may already exist on player_weekly_tasks.")
	end
end
