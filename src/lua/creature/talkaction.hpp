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

#include "account/account.hpp"
#include "utils/utils_definitions.hpp"
#include "declarations.hpp"

class Player;
class LuaScriptInterface;
class TalkAction;
using TalkAction_ptr = std::shared_ptr<TalkAction>;

class TalkAction final {
public:
	const std::string &getWords() const {
		return m_word;
	}

	void setWords(const std::vector<std::string> &newWords) {
		for (const auto &word : newWords) {
			if (!m_word.empty()) {
				m_word.append(", ");
			}
			m_word.append(word);
		}
	}

	const std::string &getDescription() const {
		return m_description;
	}

	void setDescription(const std::string &stringDescription) {
		m_description = stringDescription;
	}

	std::string getSeparator() const {
		return separator;
	}
	void setSeparator(std::string sep) {
		separator = std::move(sep);
	}

	// scripting
	bool executeSay(const std::shared_ptr<Player> &player, const std::string &words, const std::string &param, SpeakClasses type) const;
	//

	void setGroupType(uint8_t newGroupType);
	const uint8_t &getGroupType() const;

	LuaScriptInterface* getScriptInterface() const;
	bool loadScriptId();
	int32_t getScriptId() const;
	void setScriptId(int32_t newScriptId);
	bool isLoadedScriptId() const;

private:
	int32_t m_scriptId {};

	std::string m_word;
	std::string m_description;
	std::string separator = "\"";
	uint8_t m_groupType = 0;
};

class TalkActions {
public:
	TalkActions();
	~TalkActions();

	// non-copyable
	TalkActions(const TalkActions &) = delete;
	TalkActions &operator=(const TalkActions &) = delete;

	static TalkActions &getInstance();

	bool checkWord(const std::shared_ptr<Player> &player, SpeakClasses type, const std::string &words, std::string_view word, const TalkAction_ptr &talkActionPtr) const;
	TalkActionResult_t checkPlayerCanSayTalkAction(const std::shared_ptr<Player> &player, SpeakClasses type, const std::string &words) const;

	bool registerLuaEvent(const TalkAction_ptr &talkAction);
	void clear();

	const std::map<std::string, std::shared_ptr<TalkAction>> &getTalkActionsMap() const {
		return talkActions;
	};

private:
	std::map<std::string, std::shared_ptr<TalkAction>> talkActions;
};

constexpr auto g_talkActions = TalkActions::getInstance;
