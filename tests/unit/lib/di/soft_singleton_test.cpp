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
#include "pch.hpp"

#include <boost/ut.hpp>

#include "lib/di/container.hpp"
#include "lib/di/soft_singleton.hpp"
#include "lib/logging/in_memory_logger.hpp"

using namespace boost::ut;

suite<"lib"> softSingletonTest = [] {
	test("SoftSingleton warns about multiple instances") = [] {
		di::extension::injector<> injector {};
		DI::setTestContainer(&InMemoryLogger::install(injector));

		SoftSingleton softSingleton { "Test" };
		SoftSingletonGuard guard { softSingleton };
		SoftSingletonGuard guard2 { softSingleton };
		softSingleton.increment();

		auto &logger = dynamic_cast<InMemoryLogger &>(injector.create<Logger &>());
		expect(eq(2, logger.logCount()) >> fatal);
		expect(
			eq(std::string { "warning" }, logger.logs[0].level) and eq(std::string { "2 instances created for Test. This is a soft singleton, you probably want to use g_test instead." }, logger.logs[0].message)
		);
		expect(
			eq(std::string { "warning" }, logger.logs[1].level) and eq(std::string { "3 instances created for Test. This is a soft singleton, you probably want to use g_test instead." }, logger.logs[1].message)
		);
	};

	test("SoftSingleton doesn't warn if instance was released") = [] {
		di::extension::injector<> injector {};
		DI::setTestContainer(&InMemoryLogger::install(injector));
		SoftSingleton softSingleton { "Test" };

		[&softSingleton] { SoftSingletonGuard guard { softSingleton }; }();

		// Lambda scope, guard was destructed.
		[&softSingleton] { SoftSingletonGuard guard { softSingleton }; }();

		// Lambda scope, guard2 was destructed.
		softSingleton.increment();
		softSingleton.decrement();

		// Decrement resets the counter;
		softSingleton.increment();

		auto &logger = dynamic_cast<InMemoryLogger &>(injector.create<Logger &>());
		expect(eq(0, logger.logCount()));
	};
};
