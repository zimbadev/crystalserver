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

#include "lib/thread/thread_pool.hpp"

class KVStore;
class Logger;
class Game;
class Player;
class Guild;

class SaveManager {
public:
	explicit SaveManager(ThreadPool &threadPool, KVStore &kvStore, Logger &logger, Game &game);

	SaveManager(const SaveManager &) = delete;
	void operator=(const SaveManager &) = delete;

	static SaveManager &getInstance();

	void saveAll();
	void scheduleAll();

	bool savePlayer(std::shared_ptr<Player> player);
	void saveGuild(std::shared_ptr<Guild> guild);

private:
	void saveMap();
	void saveKV();

	void schedulePlayer(std::weak_ptr<Player> player);
	bool doSavePlayer(std::shared_ptr<Player> player);

	std::atomic<std::chrono::steady_clock::time_point> m_scheduledAt;
	phmap::parallel_flat_hash_map<uint32_t, std::chrono::steady_clock::time_point> m_playerMap;

	ThreadPool &threadPool;
	KVStore &kv;
	Logger &logger;
	Game &game;
};

constexpr auto g_saveManager = SaveManager::getInstance;
