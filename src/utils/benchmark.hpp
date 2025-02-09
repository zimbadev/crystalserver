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

#include <cstdint>
#include <chrono>

class Benchmark {
public:
	Benchmark() noexcept {
		start();
	}

	void start() noexcept {
		startTime = time();
	}

	void end() noexcept {
		if (startTime == -1) {
			return;
		}

		last = static_cast<double>(time() - startTime) / 1000.f;

		startTime = -1;

		if (minTime == -1 || minTime > last) {
			minTime = last;
		}

		if (maxTime == -1 || maxTime < last) {
			maxTime = last;
		}

		total += last;
		++totalExecs;
	}

	double duration() noexcept {
		if (startTime > -1) {
			end();
		}

		return last;
	}

	double min() const noexcept {
		return minTime;
	}

	double max() const noexcept {
		return maxTime;
	}

	double avg() const noexcept {
		return total / totalExecs;
	}

	void reset() noexcept {
		startTime = -1;
		minTime = -1;
		maxTime = -1;
		last = -1;
		total = 0;
		totalExecs = 0;
	}

private:
	static int64_t time() noexcept {
		return std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
	}

	int64_t startTime = -1;
	double minTime = -1;
	double maxTime = -1;
	double last = -1;
	double total = 0;
	uint_fast32_t totalExecs = 0;
};
