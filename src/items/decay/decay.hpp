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

class Item;

class Decay {
public:
	Decay() = default;

	Decay(const Decay &) = delete;
	void operator=(const Decay &) = delete;

	static Decay &getInstance();

	void startDecay(const std::shared_ptr<Item> &item);
	void stopDecay(const std::shared_ptr<Item> &item);

private:
	void checkDecay();
	static void internalDecayItem(const std::shared_ptr<Item> &item);

	uint32_t eventId { 0 };
	// order is important, so we use an std::map
	std::map<int64_t, std::vector<std::shared_ptr<Item>>> decayMap;
};

constexpr auto g_decay = Decay::getInstance;
