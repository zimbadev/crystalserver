//
// Created by majem on 12.10.2025.
//

#ifndef TASKS_H
#define TASKS_H
#include "utils/tools.hpp"

#include <map>
#include <memory>
#include <string>
struct KosTaskReward {
	uint16_t id;
	uint16_t amount;
};

class KosTask final : public SharedObject {
public:
	KosTask() = default;
	explicit KosTask(std::int16_t id, uint8_t tier, std::string name, uint32_t amount, uint32_t xp, uint32_t money) :
		id(std::move(id)), tier(std::move(tier)), name(std::move(name)), amount(std::move(amount)), xp(std::move(xp)), money(std::move(money)) {
	}

	uint32_t getRequiredKills() const {
		return this->amount;
	}

	uint32_t getRequiredKillsByStage(const uint16_t stage) const {
		return this->amount * stage;
	}

	uint64_t getXpRewardByStage(const uint16_t stage) const {
		return this->xp * stage;
	}

	uint64_t getMoneyRewardByStage(const uint16_t stage) const {
		return this->money * stage;
	}

	std::string getName() const {
		return name;
	}



	std::int16_t getId() const {
		return id;
	}

	void addMonster(const std::string &monsterName) {
		if (monsterName.empty()) {
			return;
		}
		monsters.insert(monsterName);
	}

	bool containsMonster(const std::string &monsterName) const {
		return monsters.contains(monsterName);
	}

	std::unordered_set<std::string> getMonsters() const {
		return monsters;
	}

	void addRewardItem(const uint16_t id, const uint16_t amount) {
		rewards.push_back({ id, amount });
	}

	const std::vector<KosTaskReward> &getRewardItems() const {
		return rewards;
	}

private:
	std::int16_t id;
	std::string name;
	std::uint8_t tier;
	std::uint32_t amount = 0;
	std::uint32_t xp = 0;
	std::uint32_t money;
	std::unordered_set<std::string> monsters;
	std::vector<KosTaskReward> rewards;
};

class KosTasks {
public:
	static KosTasks &getInstance();
	bool loadFromXml();
	std::shared_ptr<KosTask> getTaskByName(const std::string &name);
	std::shared_ptr<KosTask> getTaskById(std::int16_t id);
	static bool isTaskMonster(std::string monsterName);
	const std::map<int16_t, std::shared_ptr<KosTask>> &getTasks() const {
		return tasks;
	}

protected:
	std::map<int16_t, std::shared_ptr<KosTask>> tasks;
	std::map<std::string, int16_t> taskName;
};

#endif // TASKS_H
