function onUpdateDatabase()
	logger.info("Updating database to version 65 (feat: char bazaar auction flag on players)")

	if not db.query([[
		ALTER TABLE `players`
		ADD COLUMN `charbazaar` tinyint(1) NOT NULL DEFAULT 0;
	]]) then
		logger.warn("Column charbazaar may already exist on players.")
	end
end
