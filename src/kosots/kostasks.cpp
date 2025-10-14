//
// Created by majem on 12.10.2025.
//

#include "kostasks.h"

#include "config/configmanager.hpp"
#include "lib/di/container.hpp"
#include "utils/pugicast.hpp"
#include "utils/tools.hpp"

#include <pugixml.hpp>
#include <fmt/base.h>
std::unordered_map<int16_t, std::shared_ptr<KosTask>> tasks;
std::unordered_map<std::string, int16_t> taskNames;
std::unordered_set<std::string> taskMonsters;
KosTasks &KosTasks::getInstance() {
	return inject<KosTasks>();
}
bool KosTasks::loadFromXml() {
	pugi::xml_document doc;
	auto folder = g_configManager().getString(CORE_DIRECTORY) + "/XML/tasks.xml";
	pugi::xml_parse_result result = doc.load_file(folder.c_str());
	if (!result) {
		printXMLError(__FUNCTION__, folder, result);
		return false;
	}
	g_logger().info("[{}] Loading Tasks", __FUNCTION__);


	for (pugi::xml_node taskNode : doc.child("tasks").children("task")) {

		if (!(taskNode.attribute("id"))) {
			g_logger().warn("[{}] Missing task id", __FUNCTION__);
			continue;
		}
		if (!(taskNode.attribute("tier"))) {
			g_logger().warn("[{}] Missing task tier", __FUNCTION__);
			continue;
		}
		if (!(taskNode.attribute("name"))) {
			g_logger().warn("[{}] Missing task name", __FUNCTION__);
			continue;
		}


		pugi::xml_node monstersNode = taskNode.child("monsters");

		if (!monstersNode) {
			g_logger().warn("[{}] Missing task monsters list", __FUNCTION__);
			continue;
		}

		if (!monstersNode.child("monster")) {
			g_logger().warn("[{}] Monster list is empty", __FUNCTION__);
			continue;
		}

		// Create task object
		const auto task = std::make_shared<KosTask>(
			taskNode.attribute("id").as_int(),
			taskNode.attribute("tier").as_uint(),
			taskNode.attribute("name").as_string(),
			taskNode.attribute("amount").as_uint(),
			taskNode.attribute("xp").as_uint(),
			taskNode.attribute("money").as_uint()
		);

		for (pugi::xml_node monsterNode : monstersNode.children("monster")) {
			const char* monsterName = monsterNode.text().as_string();

			if (!monsterName || !*monsterName) {
				g_logger().warn("[{}] Invalid monster name in task {}", __FUNCTION__, task->getName());
				continue;
			}
			task->addMonster(monsterName);
			if (!taskMonsters.contains(monsterName)) {
				taskMonsters.insert(monsterName);
			}
		}


		// Adding reward to task
		for (pugi::xml_node rewardNode : taskNode.child("rewards").children("item")) {
			if (!(rewardNode.attribute("id"))) {
				g_logger().warn("[{}] Invalid item id in task {}", __FUNCTION__, task->getName());
				continue;
			}

			if (!(rewardNode.attribute("amount"))) {
				g_logger().warn("[{}] Invalid item amount in task {}", __FUNCTION__, task->getName());
				continue;
			}

			const uint16_t rewardId = rewardNode.attribute("id").as_int();
			const int8_t amount = rewardNode.attribute("amount").as_int();
			task->addRewardItem(rewardId, amount);

		}


		std::string taskNameLower = asLowerCaseString(task->getName());
		tasks[task->getId()] = task;
		taskNames[taskNameLower] =task->getId();
		g_logger().info("KosTaskSystem - Added {} task", taskNameLower);

	}

	return true;
}
std::shared_ptr<KosTask> KosTasks::getTaskByName(const std::string &name) {
	if (taskNames.contains(name)) {
		return tasks[taskNames[name]];
	}
	return nullptr;
}
std::shared_ptr<KosTask> KosTasks::getTaskById(const std::int16_t id) {
	if (tasks.contains(id)) {
		return tasks[id];
	}
	return nullptr;
}
bool KosTasks::isTaskMonster(std::string monsterName) {
	return taskMonsters.contains(monsterName);
}
