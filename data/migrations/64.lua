local function columnExists(tableName, columnName)
	local resultId = db.storeQuery(string.format(
		"SELECT 1 FROM `information_schema`.`COLUMNS` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = '%s' AND `COLUMN_NAME` = '%s' LIMIT 1;",
		tableName, columnName
	))
	if resultId then
		Result.free(resultId)
		return true
	end
	return false
end

local function indexExists(tableName, indexName)
	local resultId = db.storeQuery(string.format(
		"SELECT 1 FROM `information_schema`.`STATISTICS` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = '%s' AND `INDEX_NAME` = '%s' LIMIT 1;",
		tableName, indexName
	))
	if resultId then
		Result.free(resultId)
		return true
	end
	return false
end

function onUpdateDatabase()
	logger.info("Updating database to version 64 (feat: player concurrency lock columns and index)")

	if not columnExists("players", "is_locked") then
		db.query("ALTER TABLE `players` ADD COLUMN `is_locked` tinyint(1) NOT NULL DEFAULT '0';")
	end

	if not columnExists("players", "locked_at") then
		db.query("ALTER TABLE `players` ADD COLUMN `locked_at` bigint(20) NOT NULL DEFAULT '0';")
	end

	if not columnExists("players", "lock_reason") then
		db.query("ALTER TABLE `players` ADD COLUMN `lock_reason` varchar(64) NOT NULL DEFAULT '';")
	end

	if not indexExists("players", "idx_players_concurrency_lock") then
		db.query("ALTER TABLE `players` ADD INDEX `idx_players_concurrency_lock` (`is_locked`, `locked_at`);")
	end
end
