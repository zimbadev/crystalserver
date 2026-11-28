function onUpdateDatabase()
	logger.info("Updating database to version 69 (house bid columns hold 64-bit gold values)")

	db.query("UPDATE `houses` SET `highest_bid` = 0 WHERE `highest_bid` < 0")
	db.query("UPDATE `houses` SET `internal_bid` = 0 WHERE `internal_bid` < 0")
	db.query([[
		ALTER TABLE `houses`
		MODIFY `highest_bid` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
		MODIFY `internal_bid` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
	]])
end
