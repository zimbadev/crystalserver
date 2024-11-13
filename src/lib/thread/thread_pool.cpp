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

#include "lib/thread/thread_pool.hpp"

#include "game/game.hpp"
#include "utils/tools.hpp"

/**
 * Regardless of how many cores your computer have, we want at least
 * 4 threads because, even though they won't improve processing they
 * will make processing non-blocking in some way and that would allow
 * single core computers to process things concurrently, but not in parallel.
 */

#ifndef DEFAULT_NUMBER_OF_THREADS
	#define DEFAULT_NUMBER_OF_THREADS 4
#endif

ThreadPool::ThreadPool(Logger &logger) :
	BS::thread_pool(std::max<int>(getNumberOfCores(), DEFAULT_NUMBER_OF_THREADS)), logger(logger) {
	start();
}

void ThreadPool::start() const {
	logger.info("Running with {} threads.", get_thread_count());
}

void ThreadPool::shutdown() {
	if (stopped) {
		return;
	}

	logger.info("Shutting down thread pool...");
	{
		std::unique_lock<std::mutex> lock(mutex);
		stopped = true;
		condition.notify_all();
	}

	wait();
	logger.info("Thread pool shutdown complete.");
}
