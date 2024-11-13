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

#pragma once

class Dispatcher;

class Task {
public:
	Task(uint32_t expiresAfterMs, std::function<void(void)> &&f, std::string_view context);

	Task(std::function<void(void)> &&f, std::string_view context, uint32_t delay, bool cycle = false, bool log = true);

	~Task() = default;

	uint64_t getId() {
		if (id == 0) {
			if (++LAST_EVENT_ID == 0) {
				LAST_EVENT_ID = 1;
			}
			id = LAST_EVENT_ID;
		}
		return id;
	}

	[[nodiscard]] uint32_t getDelay() const {
		return delay;
	}

	[[nodiscard]] std::string_view getContext() const {
		return context;
	}

	[[nodiscard]] auto getTime() const {
		return utime;
	}

	[[nodiscard]] bool hasExpired() const;

	[[nodiscard]] bool isCycle() const {
		return cycle;
	}

	[[nodiscard]] bool isCanceled() const {
		return func == nullptr;
	}

	void cancel() {
		func = nullptr;
	}

	bool execute() const;

private:
	static std::atomic_uint_fast64_t LAST_EVENT_ID;

	void updateTime();

	bool hasTraceableContext() const {
		const static std::unordered_set<std::string_view> tasksContext = {
			"Decay::checkDecay",
			"Dispatcher::asyncEvent",
			"Game::checkCreatureAttack",
			"Game::checkCreatureWalk",
			"Game::checkCreatures",
			"Game::checkImbuements",
			"Game::checkLight",
			"Game::createFiendishMonsters",
			"Game::createInfluencedMonsters",
			"Game::updateCreatureWalk",
			"Game::updateForgeableMonsters",
			"GlobalEvents::think",
			"LuaEnvironment::executeTimerEvent",
			"Modules::executeOnRecvbyte",
			"OutputMessagePool::sendAll",
			"ProtocolGame::addGameTask",
			"ProtocolGame::parsePacketFromDispatcher",
			"Raids::checkRaids",
			"SpawnMonster::checkSpawnMonster",
			"SpawnMonster::scheduleSpawn",
			"SpawnMonster::startup",
			"SpawnNpc::checkSpawnNpc",
			"Webhook::run",
			"Protocol::sendRecvMessageCallback",
			"Player::addInFightTicks"
		};

		return tasksContext.contains(context);
	}

	struct Compare {
		bool operator()(const std::shared_ptr<Task> &a, const std::shared_ptr<Task> &b) const {
			return a->getTime() < b->getTime();
		}
	};

	std::function<void(void)> func;
	std::string context;

	int64_t utime = 0;
	int64_t expiration = 0;
	uint64_t id = 0;
	uint32_t delay = 0;
	bool cycle = false;
	bool log = true;

	friend class Dispatcher;
};
