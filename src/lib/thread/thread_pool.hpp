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

#include "BS_thread_pool.hpp"

class ThreadPool : public BS::thread_pool {
public:
	explicit ThreadPool(Logger &logger);

	// Ensures that we don't accidentally copy it
	ThreadPool(const ThreadPool &) = delete;
	ThreadPool &operator=(const ThreadPool &) = delete;

	void start() const;
	void shutdown();

	static int16_t getThreadId() {
		static std::atomic_int16_t lastId = -1;
		thread_local static int16_t id = -1;

		if (id == -1) {
			lastId.fetch_add(1);
			id = lastId.load();
		}

		return id;
	}

	bool isStopped() const {
		return stopped;
	}

private:
	std::mutex mutex;
	std::condition_variable condition;

	Logger &logger;
	bool stopped = false;
};
