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

#include "crystalserver.hpp"
#include "lib/di/container.hpp"

#ifndef USE_PRECOMPILED_HEADERS
	#include <span>
	#include <string_view>
#endif

namespace {
	constexpr std::string_view GenerateLuaApiDocsOnlyArgument = "--generate-lua-api-docs-only";

	bool hasArgument(const std::span<char*> arguments, const std::string_view expectedArgument) {
		for (std::size_t index = 1; index < arguments.size(); ++index) {
			if (std::string_view(arguments[index]) == expectedArgument) {
				return true;
			}
		}
		return false;
	}
}

int main(int argc, char* argv[]) {
	auto &server = inject<CrystalServer>();
	const std::span<char*> arguments(argv, static_cast<std::size_t>(argc));
	if (hasArgument(arguments, GenerateLuaApiDocsOnlyArgument)) {
		return server.generateLuaApiDocsOnly();
	}

	return server.run();
}
