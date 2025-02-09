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

#include "lib/logging/in_memory_logger.hpp"
#include "security/rsa.hpp"

using namespace boost::ut;

suite<"security"> rsaTest = [] {
	test("RSA::start logs error for missing .pem file") = [] {
		di::extension::injector<> injector {};
		DI::setTestContainer(&InMemoryLogger::install(injector));

		DI::create<RSA &>().start();

		auto &logger = dynamic_cast<InMemoryLogger &>(injector.create<Logger &>());

		expect(eq(1, logger.logs.size()) >> fatal);
		expect(
			eq(std::string { "error" }, logger.logs[0].level) and eq(std::string { "File key.pem not found or have problem on loading... Setting standard rsa key\n" }, logger.logs[0].message)
		);
	};
};
