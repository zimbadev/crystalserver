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

#include "lib/di/soft_singleton.hpp"

#include "utils/tools.hpp"

SoftSingleton::SoftSingleton(std::string id) :
	id(std::move(id)) { }

void SoftSingleton::increment() {
	instance_count++;
	if (instance_count > 1) {
		logger.warn(
			"{} instances created for {}. This is a soft singleton, you probably want to use g_{} instead.",
			instance_count,
			id,
			asLowerCaseString(id)
		);
	}
}

void SoftSingleton::decrement() {
	instance_count--;
}

SoftSingletonGuard::SoftSingletonGuard(SoftSingleton &t) :
	tracker(t) {
	tracker.increment();
}

SoftSingletonGuard::~SoftSingletonGuard() {
	tracker.decrement();
}
