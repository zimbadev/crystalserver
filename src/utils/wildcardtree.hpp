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

#include "declarations.hpp"

class WildcardTreeNode final : public SharedObject {
public:
	explicit WildcardTreeNode(bool initBreakpoint) :
		breakpoint(initBreakpoint) { }
	WildcardTreeNode(WildcardTreeNode &&other) noexcept = default;

	// non-copyable
	WildcardTreeNode(const WildcardTreeNode &) = delete;
	WildcardTreeNode &operator=(const WildcardTreeNode &) = delete;

	std::shared_ptr<WildcardTreeNode> getChild(char ch);
	std::shared_ptr<WildcardTreeNode> getChild(char ch) const;
	std::shared_ptr<WildcardTreeNode> addChild(char ch, bool breakpoint);

	void insert(const std::string &str);
	void remove(const std::string &str);

	ReturnValue findOne(const std::string &query, std::string &result) const;

private:
	std::map<char, std::shared_ptr<WildcardTreeNode>> children;
	bool breakpoint;
};
