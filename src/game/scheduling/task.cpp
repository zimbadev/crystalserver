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

#include "game/scheduling/task.hpp"

#include "lib/metrics/metrics.hpp"

#include "utils/tools.hpp"

std::atomic_uint_fast64_t Task::LAST_EVENT_ID = 0;

Task::Task(uint32_t expiresAfterMs, std::function<void(void)> &&f, std::string_view context) :
	func(std::move(f)), context(context), utime(OTSYS_TIME()),
	expiration(expiresAfterMs > 0 ? OTSYS_TIME() + expiresAfterMs : 0) {
	if (this->context.empty()) {
		g_logger().error("[{}]: task context cannot be empty!", __FUNCTION__);
		return;
	}

	assert(!this->context.empty() && "Context cannot be empty!");
}

Task::Task(std::function<void(void)> &&f, std::string_view context, uint32_t delay, bool cycle /* = false*/, bool log /*= true*/) :
	func(std::move(f)), context(context), utime(OTSYS_TIME() + delay), delay(delay),
	cycle(cycle), log(log) {
	if (this->context.empty()) {
		g_logger().error("[{}]: task context cannot be empty!", __FUNCTION__);
		return;
	}

	assert(!this->context.empty() && "Context cannot be empty!");
}

[[nodiscard]] bool Task::hasExpired() const {
	return expiration != 0 && expiration < OTSYS_TIME();
}

bool Task::execute() const {
	metrics::task_latency measure(context);
	if (isCanceled()) {
		return false;
	}

	if (hasExpired()) {
		g_logger().info("The task '{}' has expired, it has not been executed in {}.", getContext(), expiration - utime);
		return false;
	}

	if (log) {
		if (hasTraceableContext()) {
			g_logger().trace("Executing task {}.", getContext());
		} else {
			g_logger().debug("Executing task {}.", getContext());
		}
	}

	func();
	return true;
}

void Task::updateTime() {
	utime = OTSYS_TIME() + delay;
}
