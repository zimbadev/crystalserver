////////////////////////////////////////////////////////////////////////
// Crystal Server - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////

#include "io/ioweeklytasks.hpp"

#include "config/configmanager.hpp"
#include "creatures/appearance/mounts/mounts.hpp"
#include "database/database.hpp"
#include "database/databasemanager.hpp"
#include "creatures/monsters/monsters.hpp"
#include "creatures/players/player.hpp"
#include "creatures/players/wheel/player_wheel.hpp"
#include "game/game.hpp"
#include "items/containers/depot/depotchest.hpp"
#include "items/containers/inbox/inbox.hpp"
#include "items/item.hpp"
#include "lib/di/container.hpp"
#include "lua/scripts/lua_environment.hpp"
#include "utils/tools.hpp"

constexpr uint32_t WEEK_SECONDS = 7 * 24 * 60 * 60;
constexpr const char* WEEKLY_TASKS_LAST_RESET_CONFIG = "weekly_tasks_last_reset_timestamp";

IOWeeklyTasks &IOWeeklyTasks::getInstance() {
	return inject<IOWeeklyTasks>();
}

void IOWeeklyTasks::checkWeeklyRewardsOnLogin(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();

	// Check if this player was flagged for reward distribution during server save
	// The flag is set by markAllPlayersForRewardDistribution() in the SS globalevent on reset day
	if (weeklyData.needsRewardDistribution) {
		weeklyData.needsRewardDistribution = false;

		if (!weeklyData.killTasks.empty() && weeklyData.weeklyProgressFinished == 0) {
			distributeWeeklyRewards(player);
			resetWeeklyTaskData(player);
		}
	}
}

void IOWeeklyTasks::initializeWeeklyTasks(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();

	// If no tasks exist, the player hasn't selected a difficulty yet
	// (first time or after a reset). Set weeklyProgressFinished = 1 so the client
	// shows the weekly progress / difficulty selection screen.
	if (weeklyData.killTasks.empty()) {
		weeklyData.weeklyProgressFinished = 1;
		return;
	}

	// Check if flagged for reward distribution (same logic as login check)
	if (weeklyData.needsRewardDistribution) {
		weeklyData.needsRewardDistribution = false;

		if (weeklyData.weeklyProgressFinished == 0) {
			distributeWeeklyRewards(player);
			resetWeeklyTaskData(player);
		}
	}
}

void IOWeeklyTasks::generateWeeklyTasks(const std::shared_ptr<Player> &player, uint8_t difficulty) {
	if (!player) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();
	weeklyData.killTasks.clear();
	weeklyData.deliveryTasks.clear();
	weeklyData.weeklyDifficulty = difficulty;
	weeklyData.difficultyMultiplier = std::min(difficulty, static_cast<uint8_t>(DIFFICULTY_MULTIPLIER_MASTER));
	weeklyData.completedKillTasks = 0;
	weeklyData.completedDeliveryTasks = 0;
	weeklyData.weeklyProgressFinished = 0;
	weeklyData.rewardHuntingTasksPoints = 0;
	weeklyData.rewardSoulseals = 0;
	weeklyData.killTaskRewardExp = 0;
	weeklyData.deliveryTaskRewardExp = 0;

	bool hasExpansion = player->hasWeeklyTaskExpansion();
	uint8_t maxKillTasks = hasExpansion ? WEEKLY_KILL_TASKS_EXPANSION : WEEKLY_KILL_TASKS_NORMAL;
	uint8_t maxDeliveryTasks = hasExpansion ? WEEKLY_DELIVERY_TASKS_EXPANSION : WEEKLY_DELIVERY_TASKS_NORMAL;

	const auto &bestiaryList = g_game().getBestiaryList();
	if (bestiaryList.size() < 36) {
		return;
	}

	// Generate kill tasks
	std::vector<uint16_t> blackList;
	auto maxIndex = static_cast<int32_t>(bestiaryList.size() - 1);

	// "Any creature" task - fixed kill counts per difficulty
	// Beginner=1000, Adept=2000, Expert=3000, Master=4000
	weeklyData.anyCreatureTotalKills = getAnyCreatureKillCount(difficulty);
	weeklyData.anyCreatureCurrentKills = 0;

	uint8_t killTasksGenerated = 0;
	uint8_t tries = 0;
	while (killTasksGenerated < maxKillTasks && tries < 200) {
		uint16_t raceId = (*(std::next(bestiaryList.begin(), uniform_random(0, maxIndex)))).first;
		tries++;

		if (std::count(blackList.begin(), blackList.end(), raceId) != 0) {
			continue;
		}

		blackList.push_back(raceId);
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype || mtype->info.experience == 0 || !mtype->info.isPreyable || mtype->info.isPreyExclusive) {
			continue;
		}

		// Filter by bestiary difficulty based on chosen weekly difficulty
		// Beginner: Easy creatures (stars 0-1)
		// Adept: Easy + Medium creatures (stars 0-3)
		// Expert: Medium + Hard creatures (stars 2-5)
		// Master: Hard + Challenging creatures (stars 4-6)
		bool validForDifficulty = false;
		switch (difficulty) {
			case 0: // Beginner
				validForDifficulty = (mtype->info.bestiaryStars <= 1);
				break;
			case 1: // Adept
				validForDifficulty = (mtype->info.bestiaryStars <= 3);
				break;
			case 2: // Expert
				validForDifficulty = (mtype->info.bestiaryStars >= 2 && mtype->info.bestiaryStars <= 5);
				break;
			case 3: // Master
				validForDifficulty = (mtype->info.bestiaryStars >= 4);
				break;
		}

		if (!validForDifficulty) {
			continue;
		}

		WeeklyKillTask task;
		task.raceId = raceId;
		task.totalKills = getTaskKillCount(player->getLevel(), difficulty);
		task.currentKills = 0;
		weeklyData.killTasks.push_back(task);
		killTasksGenerated++;
	}

	// Generate delivery tasks from Lua-loaded delivery items list
	// Source: data/scripts/lib/task_board_delivery_items.lua
	if (deliveryItems.empty()) {
		g_logger().warn("[IOWeeklyTasks::generateWeeklyTasks] - No delivery items loaded from Lua");
	}

	size_t deliveryTasksGenerated = 0;
	std::vector<uint16_t> usedItemIds;
	auto maxAvailableDelivery = std::min(static_cast<size_t>(maxDeliveryTasks), deliveryItems.size());
	while (deliveryTasksGenerated < maxAvailableDelivery) {
		uint16_t randomIndex = uniform_random(0, static_cast<int32_t>(deliveryItems.size() - 1));
		const auto &deliveryItem = deliveryItems[randomIndex];

		if (std::count(usedItemIds.begin(), usedItemIds.end(), deliveryItem.itemId) != 0) {
			continue;
		}
		usedItemIds.push_back(deliveryItem.itemId);

		WeeklyDeliveryTask task;
		task.index = static_cast<uint8_t>(deliveryTasksGenerated);
		task.itemId = deliveryItem.itemId;
		task.totalItems = deliveryItem.count;
		task.collectedItems = 0;
		weeklyData.deliveryTasks.push_back(task);
		deliveryTasksGenerated++;
	}

	// Set reward experience (~1995 * level, same for kill and delivery, capped by difficulty)
	weeklyData.killTaskRewardExp = calculateRewardExp(player->getLevel(), difficulty);
	weeklyData.deliveryTaskRewardExp = calculateRewardExp(player->getLevel(), difficulty);

	// Initialize reward values (0 completed tasks = 0 HTP, 0 soulseals)
	weeklyData.rewardHuntingTasksPoints = 0;
	weeklyData.rewardSoulseals = 0;
}

void IOWeeklyTasks::onCreatureKill(const std::shared_ptr<Player> &player, uint16_t raceId) {
	if (!player) {
		return;
	}

	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();
	bool updated = false;

	// Update "any creature" counter
	const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
	const auto &bestiaryList = g_game().getBestiaryList();

	bool validBestiaryCreature = mtype
		&& mtype->info.experience > 0
		&& mtype->info.isPreyable
		&& !mtype->info.isPreyExclusive
		&& bestiaryList.find(raceId) != bestiaryList.end();

	if (validBestiaryCreature) {
		if (weeklyData.anyCreatureCurrentKills < weeklyData.anyCreatureTotalKills) {
			weeklyData.anyCreatureCurrentKills++;
			updated = true;

			if (weeklyData.anyCreatureCurrentKills >= weeklyData.anyCreatureTotalKills) {
				weeklyData.completedKillTasks++;
				player->addExperience(nullptr, weeklyData.killTaskRewardExp, false);
				player->sendTextMessage(MESSAGE_STATUS, "You have completed the weekly 'any creature' kill task!");
				player->sendBannerType(BANNER_TYPE_WEEKLY_TASK_ANY_CREATURE);
				recalculateWeeklyRewardValues(player);
			}
		}
	}

	// Update specific creature tasks
	for (auto &task : weeklyData.killTasks) {
		if (task.raceId == raceId && task.currentKills < task.totalKills) {
			task.currentKills++;
			updated = true;
			if (task.currentKills >= task.totalKills) {
				weeklyData.completedKillTasks++;

				// Grant exp immediately per completed task (real Tibia behavior)
				player->addExperience(nullptr, weeklyData.killTaskRewardExp, false);

				player->sendTextMessage(MESSAGE_STATUS, "You have completed a weekly kill task!");
				player->sendScreenshotAndBannerWeeklyTaskSpecificFinished(task.raceId);
				recalculateWeeklyRewardValues(player);
				player->refreshTaskIcons();
			}
			break;
		}
	}

	if (updated) {
		player->sendWeeklyTaskData();
	}
}

void IOWeeklyTasks::deliverWeeklyTask(const std::shared_ptr<Player> &player, uint8_t taskIndex) {
	if (!player) {
		return;
	}

	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();

	if (taskIndex >= weeklyData.deliveryTasks.size()) {
		return;
	}

	auto &task = weeklyData.deliveryTasks[taskIndex];

	// Already delivered
	if (task.delivered != 0) {
		return;
	}

	uint16_t itemId = task.itemId;
	uint32_t required = task.totalItems;

	// Count available items from inventory, stash, and depot (excluding inbox)
	uint32_t inventoryCount = player->getItemTypeCount(itemId, -1);
	uint32_t stashCount = player->getStashItemCount(itemId);
	uint32_t depotCount = getDepotItemCount(player, itemId);
	uint32_t totalAvailable = inventoryCount + stashCount + depotCount;

	if (totalAvailable < required) {
		return;
	}

	// Remove items: inventory first, then stash, then depot
	uint32_t leftToRemove = required;

	if (leftToRemove > 0 && inventoryCount > 0) {
		uint32_t removeFromInventory = std::min(inventoryCount, leftToRemove);
		if (player->removeItemOfType(itemId, removeFromInventory, -1, false)) {
			leftToRemove -= removeFromInventory;
		}
	}

	if (leftToRemove > 0 && stashCount > 0) {
		uint32_t removeFromStash = std::min(stashCount, leftToRemove);
		if (player->withdrawItem(itemId, removeFromStash)) {
			leftToRemove -= removeFromStash;
		}
	}

	if (leftToRemove > 0 && depotCount > 0) {
		uint32_t removedFromDepot = removeDepotItems(player, itemId, leftToRemove);
		leftToRemove -= removedFromDepot;
	}

	if (leftToRemove > 0) {
		// Failed to remove all items, shouldn't happen
		return;
	}

	task.collectedItems = task.totalItems;
	task.delivered = 1;
	weeklyData.completedDeliveryTasks++;

	player->addExperience(nullptr, weeklyData.deliveryTaskRewardExp, false);
	player->sendTextMessage(MESSAGE_STATUS, "You have completed a weekly delivery task!");
	recalculateWeeklyRewardValues(player);

	// Update client
	player->sendWeeklyTaskData();
}

uint32_t IOWeeklyTasks::getDepotItemCount(const std::shared_ptr<Player> &player, uint16_t itemId) {
	uint32_t count = 0;
	const auto &depotItems = player->getDepotChestItemsId();
	const auto it = depotItems.find(itemId);
	if (it != depotItems.end()) {
		for (const auto &[tier, tierCount] : it->second) {
			count += tierCount;
		}
	}
	return count;
}

uint32_t IOWeeklyTasks::removeDepotItems(const std::shared_ptr<Player> &player, uint16_t itemId, uint32_t amount) {
	uint32_t removed = 0;

	// Iterate all depot chests (0-20)
	for (uint32_t depotId = 0; depotId <= 20; ++depotId) {
		if (removed >= amount) {
			break;
		}

		auto depotChest = player->getDepotChest(depotId, false);
		if (!depotChest) {
			continue;
		}

		const auto &container = depotChest->getContainer();
		if (!container) {
			continue;
		}

		std::vector<std::shared_ptr<Item>> itemsToRemove;
		for (ContainerIterator it = container->iterator(); it.hasNext(); it.advance()) {
			const auto &item = *it;
			if (item && item->getID() == itemId) {
				itemsToRemove.push_back(item);
			}
		}

		for (const auto &item : itemsToRemove) {
			if (removed >= amount) {
				break;
			}

			uint32_t itemCount = Item::countByType(item, -1);
			uint32_t toRemove = std::min(itemCount, amount - removed);

			if (toRemove >= itemCount) {
				g_game().internalRemoveItem(item);
				removed += itemCount;
			} else {
				g_game().internalRemoveItem(item, toRemove);
				removed += toRemove;
			}
		}
	}

	return removed;
}

bool IOWeeklyTasks::shouldResetWeekly() const {
	auto now = std::chrono::system_clock::now();
	auto time_t_now = std::chrono::system_clock::to_time_t(now);
	std::tm tm_buf {};
#ifdef _WIN32
	gmtime_s(&tm_buf, &time_t_now);
#else
	gmtime_r(&time_t_now, &tm_buf);
#endif
	std::tm* tm_now = &tm_buf;

	// Reset on configured day during server save window
	int resetDay = parseDayOfWeek(g_configManager().getString(WEEKLY_TASKS_RESET_DAY));
	return tm_now->tm_wday == resetDay && tm_now->tm_hour < 1;
}

void IOWeeklyTasks::performWeeklyReset(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	// Distribute pending rewards (soulseals + HTP at Monday server save)
	distributeWeeklyRewards(player);

	// Reset to empty state - player must choose difficulty again
	resetWeeklyTaskData(player);
}

void IOWeeklyTasks::resetWeeklyTaskData(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	// Mark as finished but keep old task data visible so the client shows
	// the "finished" screen with the previous week's results.
	// Tasks will be cleared when generateWeeklyTasks() is called after
	// the client sends the new difficulty selection byte.
	auto &weeklyData = player->getWeeklyTaskData();
	weeklyData.weeklyProgressFinished = 1;
}

uint32_t IOWeeklyTasks::getHTPPerKillTask(uint8_t difficulty) {
	// HTP awarded per completed kill task, based on difficulty
	// Beginner: 25, Adept: 50, Expert: 100, Master: 110
	switch (difficulty) {
		case 0:
			return 25;
		case 1:
			return 50;
		case 2:
			return 100;
		case 3:
			return 110;
		default:
			return 25;
	}
}

uint8_t IOWeeklyTasks::getHTPMultiplier(uint8_t completedTasks) {
	// Real Tibia HTP multiplier based on total completed tasks in the week
	// Weekly Progress milestones: 0-4(x1), 5-8(x2), 9-12(x3), 13-16(x4), 17-18(x8)
	// Max possible tasks: 18 (9 kill + 9 delivery with expansion)
	if (completedTasks >= 17) {
		return 8;
	}
	if (completedTasks >= 13) {
		return 5;
	}
	if (completedTasks >= 9) {
		return 3;
	}
	if (completedTasks >= 5) {
		return 2;
	}
	return 1;
}

void IOWeeklyTasks::distributeWeeklyRewards(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();
	uint8_t totalCompleted = weeklyData.completedKillTasks + weeklyData.completedDeliveryTasks;

	if (totalCompleted == 0) {
		return;
	}

	// Calculate HTP reward:
	// Kill task HTP depends on difficulty: Beginner=25, Adept=50, Expert=100, Master=110
	// Delivery task = 75 HTP each
	// Then apply reward multiplier based on total completed
	uint32_t htpPerKillTask = getHTPPerKillTask(weeklyData.weeklyDifficulty);
	uint32_t baseHTP = (weeklyData.completedKillTasks * htpPerKillTask) + (weeklyData.completedDeliveryTasks * 75);
	uint8_t multiplier = getHTPMultiplier(totalCompleted);
	uint32_t totalHTP = baseHTP * multiplier;

	// Soulseals: 1 per completed task (no multiplier applied)
	uint32_t soulseals = totalCompleted;

	// Grant hunting task points
	if (totalHTP > 0) {
		player->addTaskHuntingPoints(totalHTP);
	}

	// Grant soulseals to the player
	if (soulseals > 0) {
		player->addSoulsealsPoints(soulseals);
	}

	// Notify the player about received rewards
	player->sendTextMessage(MESSAGE_EVENT_ADVANCE, fmt::format("[Weekly Tasks] Week ended! You completed {} tasks.\n  Hunting Task Points: +{}\n  Soulseals: +{}", totalCompleted, totalHTP, soulseals));

	// Update resource balance on the client
	player->sendTaskBoardResourceBalance();
}

void IOWeeklyTasks::claimWeeklyRewards(const std::shared_ptr<Player> &player) {
	distributeWeeklyRewards(player);
}

const std::vector<HuntingTaskShopOffer> &IOWeeklyTasks::getShopOffers() const {
	return shopOffers;
}

void IOWeeklyTasks::buyShopOffer(const std::shared_ptr<Player> &player, uint8_t offerIndex) {
	if (!player || offerIndex >= shopOffers.size()) {
		g_logger().warn("[IOWeeklyTasks::buyShopOffer] - Invalid: player={}, offerIndex={}, shopSize={}", player ? player->getName() : "null", offerIndex, shopOffers.size());
		return;
	}

	const auto &offer = shopOffers[offerIndex];
	g_logger().debug("[IOWeeklyTasks::buyShopOffer] - Player {} buying offer #{}: '{}' (type={}, itemId={}, price={})", player->getName(), offerIndex, offer.name, static_cast<int>(offer.offerType), offer.looktypeOrItemId, offer.price);

	// For Bonus Promotion, price is progressive: cost(n) = 100 + 50 * n * (n - 1)
	// where n = next point number (alreadyPurchased + 1)
	uint32_t actualPrice = offer.price;
	if (offer.offerType == HUNTING_SHOP_OFFER_BONUS_PROMOTION) {
		uint16_t alreadyPurchased = player->wheel()->getExtraPointsFromHuntingTaskShop();
		if (alreadyPurchased >= 50) {
			player->sendMessageDialog("You have already purchased the maximum number of promotion points.");
			player->sendHuntingTaskShopData();
			return;
		}
		uint32_t n = alreadyPurchased + 1;
		actualPrice = 100 + 50 * n * (n - 1);
	}

	uint64_t points = player->getTaskHuntingPoints();
	if (points < actualPrice) {
		player->sendMessageDialog("You don't have enough Hunting Task Points to purchase this offer.");
		player->sendHuntingTaskShopData();
		return;
	}

	// Check if already purchased (one-time purchases)
	if (offer.offerType == HUNTING_SHOP_OFFER_WEEKLY_EXPANSION && player->hasWeeklyTaskExpansion()) {
		player->sendMessageDialog("You already have the Permanent Weekly Task Expansion.");
		player->sendHuntingTaskShopData();
		return;
	}

	if (offer.offerType == HUNTING_SHOP_OFFER_MOUNT) {
		auto mount = g_game().mounts->getMountByClientID(static_cast<uint16_t>(offer.looktypeOrItemId));
		if (mount && player->hasMount(mount)) {
			player->sendMessageDialog("You already have this mount.");
			player->sendHuntingTaskShopData();
			return;
		}
	}

	if (offer.offerType == HUNTING_SHOP_OFFER_OUTFIT) {
		if (player->canWearOutfit(static_cast<uint16_t>(offer.looktypeOrItemId), offer.addon)) {
			player->sendMessageDialog("You already have this outfit.");
			player->sendHuntingTaskShopData();
			return;
		}
	}

	player->useTaskHuntingPoints(actualPrice);

	// Helper: create an item suitable for the inbox (decoration kit if not pickupable)
	auto createItemForInbox = [](uint16_t itemId) -> std::shared_ptr<Item> {
		// First try with createWrappableItem=true (handles wrapable items automatically)
		auto item = Item::CreateItem(itemId, 1, nullptr, true);
		if (!item) {
			return nullptr;
		}
		// If the item is already pickupable, it's fine for the inbox
		if (item->isPickupable()) {
			return item;
		}
		// Not pickupable (e.g. bed parts) — create a decoration kit manually
		const ItemType &it = Item::items[itemId];
		auto kit = std::make_shared<Item>(ITEM_DECORATION_KIT, 1);
		kit->setCustomAttribute("unWrapId", static_cast<int64_t>(itemId));
		kit->setAttribute(ItemAttribute_t::DESCRIPTION, "Unwrap it in your own house to create a <" + it.name + ">.");
		return kit;
	};

	switch (offer.offerType) {
		case HUNTING_SHOP_OFFER_ITEM: {
			auto item = createItemForInbox(static_cast<uint16_t>(offer.looktypeOrItemId));
			if (!item) {
				g_logger().warn("[IOWeeklyTasks::buyShopOffer] - Failed to create item with id {}", offer.looktypeOrItemId);
				player->sendMessageDialog("Failed to create item. Please contact an administrator.");
				break;
			}
			auto inbox = player->getInbox();
			if (!inbox) {
				g_logger().warn("[IOWeeklyTasks::buyShopOffer] - Player {} has no inbox", player->getName());
				player->sendMessageDialog("Your inbox is not available. Please relog and try again.");
				break;
			}
			uint32_t remainderCount = 0;
			auto ret = g_game().internalAddItem(std::static_pointer_cast<Cylinder>(inbox), item, INDEX_WHEREEVER, FLAG_NOLIMIT, false, remainderCount);
			if (ret != RETURNVALUE_NOERROR) {
				g_logger().warn("[IOWeeklyTasks::buyShopOffer] - Failed to add item {} to inbox of {}: {}", offer.looktypeOrItemId, player->getName(), static_cast<int>(ret));
				player->sendMessageDialog("Failed to deliver item to your inbox.");
				break;
			}
			player->sendTextMessage(MESSAGE_STATUS, "You have purchased: " + offer.name + ". Check your Store inbox.");
			break;
		}
		case HUNTING_SHOP_OFFER_ITEM_DOUBLE: {
			// Beds and similar double items: send a single decoration kit for the primary part (headboard).
			// When unwrapped in a house, the game places both parts automatically.
			auto inbox = player->getInbox();
			if (!inbox) {
				g_logger().warn("[IOWeeklyTasks::buyShopOffer] - Player {} has no inbox", player->getName());
				player->sendMessageDialog("Your inbox is not available. Please relog and try again.");
				break;
			}
			auto item = createItemForInbox(static_cast<uint16_t>(offer.looktypeOrItemId));
			if (!item) {
				g_logger().warn("[IOWeeklyTasks::buyShopOffer] - Failed to create item with id {}", offer.looktypeOrItemId);
				player->sendMessageDialog("Failed to create item. Please contact an administrator.");
				break;
			}
			uint32_t remainderCount = 0;
			auto ret = g_game().internalAddItem(std::static_pointer_cast<Cylinder>(inbox), item, INDEX_WHEREEVER, FLAG_NOLIMIT, false, remainderCount);
			if (ret != RETURNVALUE_NOERROR) {
				g_logger().warn("[IOWeeklyTasks::buyShopOffer] - Failed to add item {} to inbox of {}: {}", offer.looktypeOrItemId, player->getName(), static_cast<int>(ret));
				player->sendMessageDialog("Failed to deliver item to your inbox.");
				break;
			}
			player->sendTextMessage(MESSAGE_STATUS, "You have purchased: " + offer.name + ". Check your Store inbox.");
			break;
		}
		case HUNTING_SHOP_OFFER_MOUNT: {
			// Unlock mount for the player
			auto mount = g_game().mounts->getMountByClientID(static_cast<uint16_t>(offer.looktypeOrItemId));
			if (mount) {
				player->tameMount(mount->id);
			}
			player->sendTextMessage(MESSAGE_STATUS, "You have unlocked the mount: " + offer.name);
			break;
		}
		case HUNTING_SHOP_OFFER_OUTFIT: {
			// Unlock outfit/addon for the player
			player->addOutfit(static_cast<uint16_t>(offer.looktypeOrItemId), offer.addon);
			player->sendTextMessage(MESSAGE_STATUS, "You have unlocked the outfit: " + offer.name);
			break;
		}
		case HUNTING_SHOP_OFFER_BONUS_PROMOTION: {
			player->wheel()->addExtraPointsFromHuntingTaskShop(1);
			player->wheel()->saveKVHuntingTaskShopExtraPoints();
			player->sendTextMessage(MESSAGE_STATUS, "You have purchased an extra Wheel of Destiny promotion point.");
			break;
		}
		case HUNTING_SHOP_OFFER_WEEKLY_EXPANSION: {
			player->setWeeklyTaskExpansion(true);
			player->sendTextMessage(MESSAGE_STATUS, "You have purchased the Permanent Weekly Task Expansion! Your weekly tasks will now have 9 slots instead of 6.");
			break;
		}
		default:
			break;
	}

	player->sendHuntingTaskShopData();
}

void IOWeeklyTasks::initializeShopOffers() {
	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	shopOffers.clear();

	lua_State* L = g_luaEnvironment().getLuaState();
	if (!L) {
		g_logger().warn("[IOWeeklyTasks::initializeShopOffers] - Lua state not available");
		return;
	}

	lua_getglobal(L, "HUNT_TASK_SHOP_OFFERS");
	if (!lua_istable(L, -1)) {
		lua_pop(L, 1);
		g_logger().warn("[IOWeeklyTasks::initializeShopOffers] - HUNT_TASK_SHOP_OFFERS table not found in Lua, "
		                "check data/scripts/lib/task_board_shop.lua");
		return;
	}

	lua_pushnil(L);
	while (lua_next(L, -2) != 0) {
		if (lua_istable(L, -1)) {
			HuntingTaskShopOffer offer;

			lua_getfield(L, -1, "offerType");
			offer.offerType = static_cast<HuntingTaskShopOfferType_t>(lua_tointeger(L, -1));
			lua_pop(L, 1);

			lua_getfield(L, -1, "name");
			if (lua_isstring(L, -1)) {
				offer.name = lua_tostring(L, -1);
			}
			lua_pop(L, 1);

			lua_getfield(L, -1, "description");
			if (lua_isstring(L, -1)) {
				offer.description = lua_tostring(L, -1);
			}
			lua_pop(L, 1);

			lua_getfield(L, -1, "looktypeOrItemId");
			offer.looktypeOrItemId = static_cast<uint32_t>(lua_tointeger(L, -1));
			lua_pop(L, 1);

			lua_getfield(L, -1, "addon");
			if (lua_isnumber(L, -1)) {
				offer.addon = static_cast<uint8_t>(lua_tointeger(L, -1));
			}
			lua_pop(L, 1);

			lua_getfield(L, -1, "itemId2");
			if (lua_isnumber(L, -1)) {
				offer.itemId2 = static_cast<uint32_t>(lua_tointeger(L, -1));
			}
			lua_pop(L, 1);

			lua_getfield(L, -1, "price");
			offer.price = static_cast<uint32_t>(lua_tointeger(L, -1));
			lua_pop(L, 1);

			// Validate mount looktype
			if (offer.offerType == HUNTING_SHOP_OFFER_MOUNT) {
				auto mount = g_game().mounts->getMountByClientID(static_cast<uint16_t>(offer.looktypeOrItemId));
				if (!mount) {
					g_logger().warn("[IOWeeklyTasks::initializeShopOffers] - Mount offer '{}' has invalid clientId {}, skipping", offer.name, offer.looktypeOrItemId);
					lua_pop(L, 1);
					continue;
				}
			}

			// Validate outfit looktype
			if (offer.offerType == HUNTING_SHOP_OFFER_OUTFIT) {
				if (!g_game().isLookTypeRegistered(static_cast<uint16_t>(offer.looktypeOrItemId))) {
					g_logger().warn("[IOWeeklyTasks::initializeShopOffers] - Outfit offer '{}' has unregistered looktype {}, skipping", offer.name, offer.looktypeOrItemId);
					lua_pop(L, 1);
					continue;
				}
			}

			shopOffers.push_back(offer);
		}
		lua_pop(L, 1);
	}

	lua_pop(L, 1);

	g_logger().info("Loaded {} weekly task shop offers from Lua", shopOffers.size());
}

void IOWeeklyTasks::initializeDeliveryItems() {
	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	deliveryItems.clear();

	lua_State* L = g_luaEnvironment().getLuaState();
	if (!L) {
		g_logger().warn("[IOWeeklyTasks::initializeDeliveryItems] - Lua state not available");
		return;
	}

	lua_getglobal(L, "WEEKLY_DELIVERY_ITEMS");
	if (!lua_istable(L, -1)) {
		lua_pop(L, 1);
		g_logger().warn("[IOWeeklyTasks::initializeDeliveryItems] - WEEKLY_DELIVERY_ITEMS table not found in Lua, "
		                "check data/scripts/lib/task_board_delivery_items.lua");
		return;
	}

	lua_pushnil(L);
	while (lua_next(L, -2) != 0) {
		if (lua_istable(L, -1)) {
			DeliveryItemDef item;

			lua_getfield(L, -1, "itemId");
			item.itemId = static_cast<uint16_t>(lua_tointeger(L, -1));
			lua_pop(L, 1);

			lua_getfield(L, -1, "count");
			item.count = static_cast<uint16_t>(lua_tointeger(L, -1));
			lua_pop(L, 1);

			if (item.itemId > 0 && item.count > 0) {
				deliveryItems.push_back(item);
			}
		}
		lua_pop(L, 1);
	}

	lua_pop(L, 1);

	g_logger().info("Loaded {} weekly task delivery items from Lua", deliveryItems.size());
}

void IOWeeklyTasks::initializeResetTimestamp() {
	globalResetTimestamp = getNextResetTimestamp();
	const uint32_t now = static_cast<uint32_t>(std::time(nullptr));
	const std::string remaining = formatTimeUntilReset(now, globalResetTimestamp);
	g_logger().info(
		"Next weekly reset: {} (timestamp: {}, in: {})",
		formatDate(static_cast<time_t>(globalResetTimestamp)),
		globalResetTimestamp,
		remaining
	);
}

void IOWeeklyTasks::checkWeeklyResetOnStartup() {
	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	const auto now = static_cast<uint32_t>(std::time(nullptr));
	const uint32_t nextResetTimestamp = getNextResetTimestamp();
	if (nextResetTimestamp < WEEK_SECONDS) {
		return;
	}

	// "Current reset" is the most recent reset boundary already reached.
	const uint32_t currentResetTimestamp = nextResetTimestamp - WEEK_SECONDS;

	// If we've not reached this reset boundary yet, nothing to process.
	if (now < currentResetTimestamp) {
		return;
	}

	int32_t lastProcessedReset = 0;
	if (!DatabaseManager::getDatabaseConfig(WEEKLY_TASKS_LAST_RESET_CONFIG, lastProcessedReset)) {
		lastProcessedReset = 0;
	}

	if (static_cast<uint32_t>(lastProcessedReset) >= currentResetTimestamp) {
		return;
	}

	markAllPlayersForRewardDistribution();
	DatabaseManager::registerDatabaseConfig(WEEKLY_TASKS_LAST_RESET_CONFIG, static_cast<int32_t>(currentResetTimestamp));
	g_logger().info(
		"Processed weekly reset boundary {} and marked active players",
		currentResetTimestamp
	);
}

uint32_t IOWeeklyTasks::getResetTimestamp() const {
	return globalResetTimestamp;
}

uint32_t IOWeeklyTasks::getNextResetTimestamp() {
	auto time_t_now = std::time(nullptr);
	std::tm tm_buf {};
#ifdef _WIN32
	localtime_s(&tm_buf, &time_t_now);
#else
	localtime_r(&time_t_now, &tm_buf);
#endif
	std::tm* tm_now = &tm_buf;

	// Get configured reset day from config string (e.g. "monday", "tuesday", etc.)
	int resetDay = parseDayOfWeek(g_configManager().getString(WEEKLY_TASKS_RESET_DAY));

	// Parse server save time from config (e.g. "16:20:00") — this is LOCAL time
	const auto serverSaveTime = g_configManager().getString(GLOBAL_SERVER_SAVE_TIME);
	std::vector<int32_t> timeParams = vectorAtoi(explodeString(serverSaveTime, ":"));
	int32_t saveHour = timeParams.size() > 0 ? timeParams[0] : 6;
	int32_t saveMin = timeParams.size() > 1 ? timeParams[1] : 0;
	int32_t saveSec = timeParams.size() > 2 ? timeParams[2] : 0;

	// Calculate days until next reset day
	// tm_wday: 0=Sunday, 1=Monday, ..., 6=Saturday
	int daysUntilReset = (7 + resetDay - tm_now->tm_wday) % 7;
	if (daysUntilReset == 0) {
		// Today IS the reset day — check if SS already passed
		std::tm todaySS = *tm_now;
		todaySS.tm_hour = saveHour;
		todaySS.tm_min = saveMin;
		todaySS.tm_sec = saveSec;
		todaySS.tm_isdst = -1;
		auto todaySSTimeT = std::mktime(&todaySS);
		if (time_t_now >= todaySSTimeT) {
			// Already past SS → next reset is next week
			daysUntilReset = 7;
		}
		// else: before SS → next reset is TODAY (daysUntilReset stays 0)
	}

	// Build next reset day at server save time (local time)
	std::tm nextReset = *tm_now;
	nextReset.tm_mday += daysUntilReset;
	nextReset.tm_hour = saveHour;
	nextReset.tm_min = saveMin;
	nextReset.tm_sec = saveSec;
	nextReset.tm_isdst = -1;

	// mktime normalizes the struct and converts local time → time_t (UTC epoch)
	auto nextResetTimeT = std::mktime(&nextReset);
	return static_cast<uint32_t>(nextResetTimeT);
}

void IOWeeklyTasks::markAllPlayersForRewardDistribution() {
	Database &db = Database::getInstance();
	// Set needs_reward = 1 for all players who have active weekly tasks (kill_tasks not empty)
	if (!db.executeQuery("UPDATE `player_weekly_tasks` SET `needs_reward` = 1 WHERE LENGTH(`kill_tasks`) > 0")) {
		g_logger().warn("Failed to mark players for reward distribution");
	} else {
		g_logger().info("Marked all active players for weekly reward distribution");
	}
}

uint16_t IOWeeklyTasks::getAnyCreatureKillCount(uint8_t difficulty) {
	// Fixed kill counts per difficulty: Beginner=1000, Adept=2000, Expert=3000, Master=4000
	switch (difficulty) {
		case 0:
			return 1000;
		case 1:
			return 2000;
		case 2:
			return 3000;
		case 3:
			return 4000;
		default:
			return 1000;
	}
}

uint16_t IOWeeklyTasks::getTaskKillCount(uint32_t /*playerLevel*/, uint8_t difficulty) const {
	// Kill counts per difficulty - random within range (same pattern as bounty tasks)
	// Beginner: 50-100, Adept: 100-200, Expert: 200-300, Master: 300-600
	uint16_t minKills = 50;
	uint16_t maxKills = 100;

	switch (difficulty) {
		case 0: // Beginner
			minKills = 50;
			maxKills = 100;
			break;
		case 1: // Adept
			minKills = 100;
			maxKills = 200;
			break;
		case 2: // Expert
			minKills = 200;
			maxKills = 300;
			break;
		case 3: // Master
			minKills = 300;
			maxKills = 600;
			break;
	}

	return static_cast<uint16_t>(uniform_random(minKills, maxKills));
}

uint32_t IOWeeklyTasks::calculateRewardExp(uint32_t playerLevel, uint8_t difficulty) const {
	// XP per task formula (from Tibia Wiki):
	// Level <= 82:    25L^2 - 75L + 100
	// Level 83-999:   ROUND(1994.008 * L)
	// Level >= 1000:  2L^2 - 6L + 8
	// Difficulty only defines the XP cap
	uint64_t L = playerLevel;
	uint32_t exp;

	if (L <= 82) {
		exp = static_cast<uint32_t>(25 * L * L - 75 * L + 100);
	} else if (L < 1000) {
		exp = static_cast<uint32_t>(std::lround(1994.008 * L));
	} else {
		exp = static_cast<uint32_t>(2 * L * L - 6 * L + 8);
	}

	// Apply XP cap based on difficulty
	// Beginner: max 200,000 / Adept: max 800,000 / Expert: max 3,000,000 / Master: no limit
	uint32_t expCap = getExpCap(difficulty);
	if (expCap > 0 && exp > expCap) {
		exp = expCap;
	}

	return exp;
}

uint32_t IOWeeklyTasks::getExpCap(uint8_t difficulty) {
	switch (difficulty) {
		case 0:
			return 200000; // Beginner
		case 1:
			return 800000; // Adept
		case 2:
			return 3000000; // Expert
		case 3:
			return 0; // Master: no limit
		default:
			return 200000;
	}
}

uint32_t IOWeeklyTasks::getMinLevelForDifficulty(uint8_t difficulty) {
	switch (difficulty) {
		case 0:
			return 8; // Beginner
		case 1:
			return 30; // Adept
		case 2:
			return 150; // Expert
		case 3:
			return 300; // Master
		default:
			return 8;
	}
}

uint8_t IOWeeklyTasks::getUnlockedDifficulty(uint32_t playerLevel) {
	// Beginner(lvl 8), Adept(lvl 30), Expert(lvl 150), Master(lvl 300)
	if (playerLevel >= 300) {
		return 3; // Master
	} else if (playerLevel >= 150) {
		return 2; // Expert
	} else if (playerLevel >= 30) {
		return 1; // Adept
	}
	return 0; // Beginner
}

void IOWeeklyTasks::recalculateWeeklyTaskRewards(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	if (!g_configManager().getBoolean(WEEKLY_TASKS_ENABLED)) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();

	// Only recalculate if the player has active weekly tasks
	if (weeklyData.killTasks.empty()) {
		return;
	}

	// Recalculate XP reward based on current level
	weeklyData.killTaskRewardExp = calculateRewardExp(player->getLevel(), weeklyData.weeklyDifficulty);
	weeklyData.deliveryTaskRewardExp = calculateRewardExp(player->getLevel(), weeklyData.weeklyDifficulty);
}

void IOWeeklyTasks::recalculateWeeklyRewardValues(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();
	uint8_t totalCompleted = weeklyData.completedKillTasks + weeklyData.completedDeliveryTasks;

	// HTP = (completedKillTasks * htpPerKill + completedDeliveryTasks * 75) * multiplier
	uint32_t htpPerKillTask = getHTPPerKillTask(weeklyData.weeklyDifficulty);
	uint32_t baseHTP = (weeklyData.completedKillTasks * htpPerKillTask) + (weeklyData.completedDeliveryTasks * 75);
	uint8_t multiplier = getHTPMultiplier(totalCompleted);
	weeklyData.rewardHuntingTasksPoints = baseHTP * multiplier;

	// Soulseals = total completed tasks
	weeklyData.rewardSoulseals = totalCompleted;
}

uint8_t IOWeeklyTasks::getPlayerOfferStatus(const std::shared_ptr<Player> &player, const HuntingTaskShopOffer &offer) const {
	if (!player) {
		return HUNTING_SHOP_STATUS_NOT_AVAILABLE;
	}

	switch (offer.offerType) {
		case HUNTING_SHOP_OFFER_OUTFIT: {
			// Check if player already has this outfit with the specific addon
			if (player->canWearOutfit(static_cast<uint16_t>(offer.looktypeOrItemId), offer.addon)) {
				return HUNTING_SHOP_STATUS_BOUGHT;
			}
			// Addon 1 or 2: check if player has the base outfit
			if (offer.addon > 0 && !player->canWearOutfit(static_cast<uint16_t>(offer.looktypeOrItemId), 0)) {
				return HUNTING_SHOP_STATUS_REQUIRES_OUTFIT; // "Requires base outfit"
			}
			return HUNTING_SHOP_STATUS_AVAILABLE;
		}
		case HUNTING_SHOP_OFFER_MOUNT: {
			auto mount = g_game().mounts->getMountByClientID(static_cast<uint16_t>(offer.looktypeOrItemId));
			if (mount && player->hasMount(mount)) {
				return HUNTING_SHOP_STATUS_BOUGHT;
			}
			return HUNTING_SHOP_STATUS_AVAILABLE;
		}
		case HUNTING_SHOP_OFFER_WEEKLY_EXPANSION: {
			if (player->hasWeeklyTaskExpansion()) {
				return HUNTING_SHOP_STATUS_BOUGHT;
			}
			return HUNTING_SHOP_STATUS_AVAILABLE;
		}
		case HUNTING_SHOP_OFFER_ITEM:
		case HUNTING_SHOP_OFFER_ITEM_DOUBLE: {
			return HUNTING_SHOP_STATUS_AVAILABLE;
		}
		default:
			return HUNTING_SHOP_STATUS_NOT_AVAILABLE;
	}
}

void IOWeeklyTasks::ensureWeeklyTaskCount(const std::shared_ptr<Player> &player) {
	if (!player) {
		return;
	}

	auto &weeklyData = player->getWeeklyTaskData();

	// Only adjust if tasks have been generated (non-empty state)
	if (weeklyData.killTasks.empty() && weeklyData.deliveryTasks.empty()) {
		return;
	}

	bool hasExpansion = player->hasWeeklyTaskExpansion();
	uint8_t maxKillTasks = hasExpansion ? WEEKLY_KILL_TASKS_EXPANSION : WEEKLY_KILL_TASKS_NORMAL;
	uint8_t maxDeliveryTasks = hasExpansion ? WEEKLY_DELIVERY_TASKS_EXPANSION : WEEKLY_DELIVERY_TASKS_NORMAL;

	// === Kill Tasks ===
	if (weeklyData.killTasks.size() > maxKillTasks) {
		weeklyData.killTasks.resize(maxKillTasks);
	} else if (weeklyData.killTasks.size() < maxKillTasks) {
		// Build blacklist from existing tasks
		std::vector<uint16_t> blackList;
		for (const auto &task : weeklyData.killTasks) {
			blackList.push_back(task.raceId);
		}

		const auto &bestiaryList = g_game().getBestiaryList();
		if (!bestiaryList.empty()) {
			auto maxIndex = static_cast<int32_t>(bestiaryList.size() - 1);
			uint16_t tries = 0;
			while (weeklyData.killTasks.size() < maxKillTasks && tries < 500) {
				uint16_t raceId = (*(std::next(bestiaryList.begin(), uniform_random(0, maxIndex)))).first;
				tries++;

				if (std::count(blackList.begin(), blackList.end(), raceId) != 0) {
					continue;
				}

				blackList.push_back(raceId);
				const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
				if (!mtype || mtype->info.experience == 0 || !mtype->info.isPreyable || mtype->info.isPreyExclusive) {
					continue;
				}

				bool validForDifficulty = false;
				switch (weeklyData.weeklyDifficulty) {
					case 0:
						validForDifficulty = (mtype->info.bestiaryStars <= 1);
						break;
					case 1:
						validForDifficulty = (mtype->info.bestiaryStars <= 3);
						break;
					case 2:
						validForDifficulty = (mtype->info.bestiaryStars >= 2 && mtype->info.bestiaryStars <= 5);
						break;
					case 3:
						validForDifficulty = (mtype->info.bestiaryStars >= 4);
						break;
				}

				if (!validForDifficulty) {
					continue;
				}

				WeeklyKillTask task;
				task.raceId = raceId;
				task.totalKills = getTaskKillCount(player->getLevel(), weeklyData.weeklyDifficulty);
				task.currentKills = 0;
				weeklyData.killTasks.push_back(task);
			}
		}
	}

	// === Delivery Tasks ===
	if (weeklyData.deliveryTasks.size() > maxDeliveryTasks) {
		weeklyData.deliveryTasks.resize(maxDeliveryTasks);
	} else if (weeklyData.deliveryTasks.size() < maxDeliveryTasks && !deliveryItems.empty()) {
		// Build blacklist from existing delivery tasks
		std::vector<uint16_t> usedItemIds;
		for (const auto &task : weeklyData.deliveryTasks) {
			usedItemIds.push_back(task.itemId);
		}

		uint16_t tries = 0;
		while (weeklyData.deliveryTasks.size() < maxDeliveryTasks && tries < 500) {
			uint16_t randomIndex = uniform_random(0, static_cast<int32_t>(deliveryItems.size() - 1));
			const auto &deliveryItem = deliveryItems[randomIndex];
			tries++;

			if (std::count(usedItemIds.begin(), usedItemIds.end(), deliveryItem.itemId) != 0) {
				continue;
			}
			usedItemIds.push_back(deliveryItem.itemId);

			WeeklyDeliveryTask task;
			task.index = static_cast<uint8_t>(weeklyData.deliveryTasks.size());
			task.itemId = deliveryItem.itemId;
			task.totalItems = deliveryItem.count;
			task.collectedItems = 0;
			task.delivered = 0;
			weeklyData.deliveryTasks.push_back(task);
		}
	}
}
