function onUpdateDatabase()
	logger.info("Updating database to version 69 (persist house rent warning timing)")

	local column = db.storeQuery([[
		SELECT 1
		FROM information_schema.COLUMNS
		WHERE TABLE_SCHEMA = DATABASE()
			AND TABLE_NAME = 'houses'
			AND COLUMN_NAME = 'last_rent_warning'
	]])
	if column then
		Result.free(column)
		return
	end

	if not db.query("ALTER TABLE `houses` ADD `last_rent_warning` int(10) UNSIGNED NOT NULL DEFAULT '0'") then
		error("Could not add houses.last_rent_warning")
	end
end
