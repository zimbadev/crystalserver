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

#include "database/database.hpp"
#include "lib/thread/thread_pool.hpp"

class DatabaseTasks {
public:
	DatabaseTasks(ThreadPool &threadPool, Database &db);

	// Ensures that we don't accidentally copy it
	DatabaseTasks(const DatabaseTasks &) = delete;
	DatabaseTasks &operator=(const DatabaseTasks &) = delete;

	static DatabaseTasks &getInstance();

	void execute(const std::string &query, const std::function<void(DBResult_ptr, bool)> &callback = nullptr);
	void store(const std::string &query, const std::function<void(DBResult_ptr, bool)> &callback = nullptr);

private:
	Database &db;
	ThreadPool &threadPool;
};

constexpr auto g_databaseTasks = DatabaseTasks::getInstance;
