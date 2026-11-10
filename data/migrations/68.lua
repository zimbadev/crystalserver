function onUpdateDatabase()
	logger.info("Updating database to version 68 (add account Socials relationships)")

	if
		not db.query([[
		CREATE TABLE IF NOT EXISTS `account_socials` (
			`low_account` int(11) UNSIGNED NOT NULL,
			`high_account` int(11) UNSIGNED NOT NULL,
			`inviter` int(11) UNSIGNED NOT NULL DEFAULT 0,
			`inviter_character` int(11) UNSIGNED NOT NULL DEFAULT 0,
			`invite_date` int(11) UNSIGNED NOT NULL DEFAULT 0,
			`low_block_date` int(11) UNSIGNED NOT NULL DEFAULT 0,
			`high_block_date` int(11) UNSIGNED NOT NULL DEFAULT 0,
			`low_group` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
			`high_group` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
			`low_blocked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
			`high_blocked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
			PRIMARY KEY (`low_account`, `high_account`),
			KEY `account_socials_high` (`high_account`),
			FOREIGN KEY (`low_account`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
			FOREIGN KEY (`high_account`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	]])
	then
		error("Could not create account_socials")
	end

	for _, column in ipairs({ "inviter_character", "invite_date", "low_block_date", "high_block_date" }) do
		local existing = db.storeQuery(string.format(
			[[
			SELECT 1 FROM information_schema.COLUMNS
			WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'account_socials' AND COLUMN_NAME = '%s'
		]],
			column
		))
		if existing then
			Result.free(existing)
		elseif not db.query(string.format("ALTER TABLE `account_socials` ADD COLUMN `%s` int(11) UNSIGNED NOT NULL DEFAULT 0", column)) then
			error("Could not add account_socials." .. column)
		end
	end
end
