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

class SoftSingleton {
public:
	explicit SoftSingleton(std::string id);

	// non-copyable
	SoftSingleton(const SoftSingleton &) = delete;
	void operator=(const SoftSingleton &) = delete;

	void increment();

	void decrement();

private:
	Logger &logger = g_logger();
	std::string id;
	int instance_count = 0;
};

class SoftSingletonGuard {
public:
	explicit SoftSingletonGuard(SoftSingleton &t);

	// non-copyable
	SoftSingletonGuard(const SoftSingletonGuard &) = delete;
	void operator=(const SoftSingletonGuard &) = delete;

	~SoftSingletonGuard();

private:
	SoftSingleton &tracker;
};
