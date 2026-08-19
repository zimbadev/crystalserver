local function tableExists(tableName)
	local resultId = db.storeQuery(string.format(
		"SELECT 1 FROM `information_schema`.`TABLES` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = '%s' LIMIT 1;",
		tableName
	))
	if resultId then
		Result.free(resultId)
		return true
	end
	return false
end

function onUpdateDatabase()
	logger.info("Updating database to version 65 (feat: add market_web_orders table)")

	if not tableExists("market_web_orders") then
		db.query([[
			CREATE TABLE IF NOT EXISTS `market_web_orders` (
				`id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
				`offer_id` INT(11) NOT NULL,
				`buyer_id` INT(11) NOT NULL,
				`buyer_account_id` INT(11) NOT NULL,
				`seller_id` INT(11) NOT NULL,
				`seller_account_id` INT(11) NOT NULL,
				`itemtype` INT(11) NOT NULL,
				`amount` INT(11) NOT NULL,
				`price` BIGINT(20) UNSIGNED NOT NULL,
				`tier` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
				`currency_type` VARCHAR(16) NOT NULL DEFAULT 'gold',
				`world_id` INT(11) NOT NULL DEFAULT 0,
				`status` ENUM('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
				`fail_reason` VARCHAR(255) NOT NULL DEFAULT '',
				`created_at` BIGINT(20) NOT NULL,
				`processed_at` BIGINT(20) NOT NULL DEFAULT 0,
				PRIMARY KEY (`id`),
				INDEX `idx_mwo_world_status_created` (`world_id`, `status`, `created_at`),
				INDEX `idx_mwo_buyer` (`buyer_id`),
				INDEX `idx_mwo_seller` (`seller_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		]])
	end
end
