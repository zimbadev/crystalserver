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

#include "server/network/protocol/protocolgame.hpp"

#include "creatures/players/cyclopedia/player_title.hpp"
#include "creatures/players/player.hpp"
#include "creatures/players/vocations/vocation.hpp"
#include "database/database.hpp"
#include "game/game.hpp"
#include "game/game_definitions.hpp"
#include "kv/kv.hpp"
#include "utils/tools.hpp"

#include <algorithm>
#include <optional>

namespace {
	constexpr uint8_t FriendSystemData = 0x74;
	constexpr uint16_t MaxSocialEntries = 100;
	constexpr uint8_t MaxProfileCharacters = 32;

	enum class SocialAction : uint8_t {
		List = 0,
		Invitations,
		Blacklist,
		Invite,
		Accept,
		Decline,
		Cancel,
		Block,
		Unblock,
		Profile,
		SetGroup,
		Search,
		SetTitle = 14,
		Settings,
		SetSettings,
	};

	enum class SocialData : uint8_t {
		Error,
		NewInvitation,
		List,
		Invitations,
		Blacklist,
		Profile,
		NewFriend = 7,
		Settings,
	};

	struct SocialSettings {
		bool showCharacter = false;
		bool showAccount = false;
		bool allowInspect = false;
	};

	struct SocialCharacter {
		uint32_t id = 0;
		uint32_t account = 0;
		std::string name;
		std::string world;
		std::string vocation;
		uint16_t level = 0;
		uint32_t lastLogin = 0;
		Outfit_t outfit;
	};

	struct SocialRelation {
		uint32_t low = 0;
		uint32_t high = 0;
		uint32_t inviter = 0;
		uint32_t inviterCharacter = 0;
		uint32_t inviteDate = 0;
		uint32_t lowBlockDate = 0;
		uint32_t highBlockDate = 0;
		uint8_t lowGroup = 0;
		uint8_t highGroup = 0;
		bool lowBlocked = false;
		bool highBlocked = false;

		bool friends() const {
			return lowGroup != 0 && highGroup != 0;
		}

		uint8_t &group(uint32_t account) {
			return account == low ? lowGroup : highGroup;
		}

		bool &blocked(uint32_t account) {
			return account == low ? lowBlocked : highBlocked;
		}

		bool isBlocked(uint32_t account) const {
			return account == low ? lowBlocked : highBlocked;
		}

		uint32_t &blockDate(uint32_t account) {
			return account == low ? lowBlockDate : highBlockDate;
		}

		void clearInvitation() {
			inviter = 0;
			inviterCharacter = 0;
			inviteDate = 0;
		}

		bool empty() const {
			return !inviter && !friends() && !lowBlocked && !highBlocked;
		}
	};

	std::shared_ptr<KV> socialSettingsKV(uint32_t account) {
		return g_kv().scoped("social-settings")->scoped(std::to_string(account));
	}

	SocialSettings getSocialSettings(uint32_t account, uint8_t group) {
		const auto value = socialSettingsKV(account)->get(std::to_string(group));
		if (!value) {
			return {};
		}

		const auto mask = static_cast<uint8_t>(value->getNumber());
		return { (mask & 1) != 0, (mask & 2) != 0, (mask & 4) != 0 };
	}

	SocialCharacter readSocialCharacter(const DBResult_ptr &result) {
		const auto vocation = g_vocations().getVocation(result->getNumber<uint16_t>("vocation"));
		const auto world = g_game().worlds().getWorldConfigsById(result->getNumber<uint8_t>("world_id"));
		Outfit_t outfit {};
		outfit.lookType = result->getNumber<uint16_t>("looktype");
		outfit.lookHead = result->getNumber<uint8_t>("lookhead");
		outfit.lookBody = result->getNumber<uint8_t>("lookbody");
		outfit.lookLegs = result->getNumber<uint8_t>("looklegs");
		outfit.lookFeet = result->getNumber<uint8_t>("lookfeet");
		outfit.lookAddons = result->getNumber<uint8_t>("lookaddons");
		return {
			result->getNumber<uint32_t>("id"),
			result->getNumber<uint32_t>("account_id"),
			result->getString("name"),
			world ? world->name : std::string {},
			vocation ? vocation->getVocName() : std::string {},
			static_cast<uint16_t>(std::min<uint32_t>(result->getNumber<uint32_t>("level"), UINT16_MAX)),
			result->getNumber<uint32_t>("lastlogin"),
			outfit,
		};
	}

	constexpr auto SocialCharacterColumns = "p.id, p.account_id, p.name, p.world_id, p.vocation, p.level, p.lastlogin, p.looktype, p.lookhead, p.lookbody, p.looklegs, p.lookfeet, p.lookaddons";

	std::optional<SocialCharacter> findSocialCharacter(const std::string &name) {
		if (name.empty() || name.size() > 32) {
			return std::nullopt;
		}

		const auto row = g_database().storeQuery(fmt::format(
			"SELECT {} FROM players p WHERE p.name = {} AND p.deletion = 0 LIMIT 1",
			SocialCharacterColumns, g_database().escapeString(name)
		));
		return row ? std::optional { readSocialCharacter(row) } : std::nullopt;
	}

	std::vector<SocialCharacter> getSocialCharacters(uint32_t account, uint8_t limit) {
		std::vector<SocialCharacter> characters;
		const auto row = g_database().storeQuery(fmt::format(
			"SELECT {} FROM players p WHERE p.account_id = {} AND p.deletion = 0 ORDER BY p.level DESC, p.id LIMIT {}",
			SocialCharacterColumns, account, limit
		));
		if (row) {
			do {
				characters.push_back(readSocialCharacter(row));
			} while (row->next());
		}
		return characters;
	}

	SocialRelation readSocialRelation(const DBResult_ptr &row, uint32_t low, uint32_t high) {
		SocialRelation relation { low, high };
		if (row) {
			relation.inviter = row->getNumber<uint32_t>("inviter");
			relation.inviterCharacter = row->getNumber<uint32_t>("inviter_character");
			relation.inviteDate = row->getNumber<uint32_t>("invite_date");
			relation.lowBlockDate = row->getNumber<uint32_t>("low_block_date");
			relation.highBlockDate = row->getNumber<uint32_t>("high_block_date");
			relation.lowGroup = row->getNumber<uint8_t>("low_group");
			relation.highGroup = row->getNumber<uint8_t>("high_group");
			relation.lowBlocked = row->getNumber<uint8_t>("low_blocked") != 0;
			relation.highBlocked = row->getNumber<uint8_t>("high_blocked") != 0;
		}
		return relation;
	}

	SocialRelation getSocialRelation(uint32_t first, uint32_t second) {
		const auto [low, high] = std::minmax(first, second);
		const auto row = g_database().storeQuery(fmt::format(
			"SELECT * FROM account_socials WHERE low_account = {} AND high_account = {}", low, high
		));
		return readSocialRelation(row, low, high);
	}

	bool saveSocialRelation(const SocialRelation &relation) {
		if (relation.empty()) {
			return g_database().executeQuery(fmt::format(
				"DELETE FROM account_socials WHERE low_account = {} AND high_account = {}", relation.low, relation.high
			));
		}

		return g_database().executeQuery(fmt::format(
			"INSERT INTO account_socials (low_account, high_account, inviter, inviter_character, invite_date, "
			"low_block_date, high_block_date, low_group, high_group, low_blocked, high_blocked) "
			"VALUES ({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}) ON DUPLICATE KEY UPDATE inviter = VALUES(inviter), "
			"inviter_character = VALUES(inviter_character), invite_date = VALUES(invite_date), "
			"low_block_date = VALUES(low_block_date), high_block_date = VALUES(high_block_date), "
			"low_group = VALUES(low_group), high_group = VALUES(high_group), low_blocked = VALUES(low_blocked), high_blocked = VALUES(high_blocked)",
			relation.low, relation.high, relation.inviter, relation.inviterCharacter, relation.inviteDate,
			relation.lowBlockDate, relation.highBlockDate, relation.lowGroup, relation.highGroup,
			static_cast<uint8_t>(relation.lowBlocked), static_cast<uint8_t>(relation.highBlocked)
		));
	}

	bool hasSocialRoom(uint32_t account) {
		const auto row = g_database().storeQuery(fmt::format(
			"SELECT COUNT(*) AS total FROM account_socials "
			"WHERE (low_account = {} AND (inviter <> 0 OR low_group <> 0 OR low_blocked = 1)) "
			"OR (high_account = {} AND (inviter <> 0 OR high_group <> 0 OR high_blocked = 1))",
			account, account
		));
		return row && row->getNumber<uint32_t>("total") < MaxSocialEntries;
	}

	bool changeSocialRelation(SocialAction action, uint32_t account, uint32_t other, uint8_t group, uint32_t actorCharacter) {
		if (other == 0 || other == account || group > 3) {
			return false;
		}

		return DBTransaction::executeWithinTransactionRollbackOnFailure([&] {
			// Serialize changes involving either account, including invitations from different worlds.
			const auto accounts = g_database().storeQuery(fmt::format(
				"SELECT id FROM accounts WHERE id IN ({}, {}) ORDER BY id FOR UPDATE", account, other
			));
			if (!accounts || !accounts->next()) {
				return false;
			}

			auto relation = getSocialRelation(account, other);
			if (relation.empty() && action != SocialAction::Invite && action != SocialAction::Block) {
				return false;
			}

			switch (action) {
				case SocialAction::Invite:
					if (!relation.empty() || !hasSocialRoom(account) || !hasSocialRoom(other)) {
						return false;
					}
					relation.inviter = account;
					relation.inviterCharacter = actorCharacter;
					relation.inviteDate = static_cast<uint32_t>(getTimeNow());
					break;
				case SocialAction::Accept:
					if (relation.inviter != other || group == 0 || relation.blocked(account) || relation.blocked(other)) {
						return false;
					}
					relation.clearInvitation();
					relation.group(account) = group;
					relation.group(other) = 2;
					break;
				case SocialAction::Decline:
				case SocialAction::Cancel:
					if (relation.inviter != (action == SocialAction::Decline ? other : account)) {
						return false;
					}
					relation.clearInvitation();
					break;
				case SocialAction::Block:
					if (!relation.inviter && !relation.friends() && !relation.isBlocked(account) && !hasSocialRoom(account)) {
						return false;
					}
					if (!relation.isBlocked(account)) {
						relation.blockDate(account) = static_cast<uint32_t>(getTimeNow());
					}
					relation.blocked(account) = true;
					relation.clearInvitation();
					relation.lowGroup = relation.highGroup = 0;
					break;
				case SocialAction::Unblock:
					if (!relation.blocked(account)) {
						return false;
					}
					relation.blocked(account) = false;
					relation.blockDate(account) = 0;
					break;
				case SocialAction::SetGroup:
					if (!relation.friends()) {
						return false;
					}
					if (group == 0) {
						relation.lowGroup = relation.highGroup = 0;
					} else {
						relation.group(account) = group;
					}
					break;
				default:
					return false;
			}
			return saveSocialRelation(relation);
		});
	}

	struct SocialEntry {
		SocialCharacter character;
		SocialRelation relation;
		std::string inviterName;
	};

	std::vector<SocialEntry> getSocialEntries(uint32_t account) {
		std::vector<SocialEntry> entries;
		const auto row = g_database().storeQuery(fmt::format(
			"SELECT {}, s.*, COALESCE(sender.name, '') AS inviter_name FROM account_socials s JOIN players p ON p.id = ("
			"SELECT c.id FROM players c WHERE c.account_id = IF(s.low_account = {}, s.high_account, s.low_account) "
			"AND c.deletion = 0 ORDER BY c.level DESC, c.id LIMIT 1) "
			"LEFT JOIN players sender ON sender.id = s.inviter_character AND sender.account_id = s.inviter "
			"WHERE (s.low_account = {} AND (s.inviter <> 0 OR s.low_group <> 0 OR s.low_blocked = 1)) "
			"OR (s.high_account = {} AND (s.inviter <> 0 OR s.high_group <> 0 OR s.high_blocked = 1)) ORDER BY p.name LIMIT {}",
			SocialCharacterColumns, account, account, account, MaxSocialEntries
		));
		if (row) {
			do {
				entries.push_back({
					readSocialCharacter(row),
					readSocialRelation(row, row->getNumber<uint32_t>("low_account"), row->getNumber<uint32_t>("high_account")),
					row->getString("inviter_name"),
				});
			} while (row->next());
		}
		return entries;
	}

	// FriendSystemData reads a basic outfit with addons and an item ID only when lookType is zero.
	void addSocialOutfit(NetworkMessage &msg, const Outfit_t &outfit) {
		msg.add<uint16_t>(outfit.lookType);
		if (outfit.lookType == 0) {
			msg.add<uint16_t>(0);
		} else {
			msg.addByte(outfit.lookHead);
			msg.addByte(outfit.lookBody);
			msg.addByte(outfit.lookLegs);
			msg.addByte(outfit.lookFeet);
			msg.addByte(outfit.lookAddons);
		}
	}

	void beginSocialPacket(NetworkMessage &msg, SocialData type) {
		msg.addByte(FriendSystemData);
		msg.addByte(static_cast<uint8_t>(type));
	}
}

void ProtocolGame::sendSocialList(uint8_t type) {
	const auto account = player->getAccountId();
	auto entries = getSocialEntries(account);
	const auto data = static_cast<SocialData>(type);
	std::erase_if(entries, [data, account](const SocialEntry &entry) {
		const auto &relation = entry.relation;
		switch (data) {
			case SocialData::List:
				return !relation.friends();
			case SocialData::Invitations:
				return relation.inviter == 0;
			case SocialData::Blacklist:
				return !relation.isBlocked(account);
			default:
				return true;
		}
	});

	NetworkMessage msg;
	beginSocialPacket(msg, data);
	msg.add<uint16_t>(static_cast<uint16_t>(entries.size()));
	for (auto &[character, relation, inviterName] : entries) {
		if (data == SocialData::Invitations) {
			msg.addByte(relation.inviter == account);
		}
		if (data == SocialData::List) {
			const auto settings = getSocialSettings(character.account, relation.group(character.account));
			const auto online = settings.showCharacter ? g_game().getPlayerByGUID(character.id) : nullptr;
			const bool visibleOnline = online && !online->isInGhostMode();
			msg.add<uint32_t>(character.account);
			msg.add<uint32_t>(character.id);
			msg.addString(character.name);
			msg.addString(visibleOnline ? online->title()->getCurrentTitleName() : std::string {});
			msg.addString(settings.showCharacter ? character.world : std::string {});
			msg.addString(settings.showCharacter ? character.vocation : std::string {});
			msg.add<uint16_t>(settings.showCharacter ? character.level : 0);
			addSocialOutfit(msg, settings.showCharacter ? character.outfit : Outfit_t {});
			msg.addByte(relation.group(account));
			msg.add<uint32_t>(character.account);
		} else {
			// The client uses the first ID for menu actions and the final integer as a Unix timestamp.
			msg.add<uint32_t>(character.account);
			msg.addString(character.name);
			if (data == SocialData::Invitations) {
				msg.addString(""); // Main character title.
				msg.addString(inviterName.empty() ? (relation.inviter == account ? player->getName() : character.name) : inviterName);
				msg.add<uint32_t>(relation.inviteDate);
			} else {
				msg.add<uint32_t>(relation.blockDate(account));
			}
		}
	}
	writeToOutputBuffer(msg);
}

void ProtocolGame::sendSocialSettings() {
	NetworkMessage msg;
	beginSocialPacket(msg, SocialData::Settings);
	msg.addByte(4);
	for (uint8_t group = 0; group < 4; ++group) {
		const auto settings = getSocialSettings(player->getAccountId(), group);
		msg.addByte(group);
		msg.addByte(settings.showCharacter);
		msg.addByte(settings.showAccount);
		msg.addByte(settings.allowInspect);
	}
	writeToOutputBuffer(msg);
}

void ProtocolGame::sendSocialProfile(uint32_t other, const std::string &name) {
	auto match = findSocialCharacter(name);
	if (match) {
		other = match->account;
	}

	const auto account = player->getAccountId();
	auto relation = other != 0 ? getSocialRelation(account, other) : SocialRelation {};
	const bool self = other == account;
	const bool known = self || match || !relation.empty();
	const bool visible = known && !relation.isBlocked(other);
	auto characters = visible ? getSocialCharacters(other, MaxProfileCharacters) : std::vector<SocialCharacter> {};
	const bool found = !characters.empty();
	const auto settings = self ? SocialSettings { true, true, true } : getSocialSettings(other, relation.group(other));
	const bool showCharacter = found && settings.showCharacter;
	const bool showAccount = found && settings.showAccount;

	std::shared_ptr<Player> online;
	if (showAccount || showCharacter) {
		for (const auto &character : characters) {
			if (const auto candidate = g_game().getPlayerByGUID(character.id); candidate && !candidate->isInGhostMode()) {
				online = candidate;
				break;
			}
		}
	}

	NetworkMessage msg;
	beginSocialPacket(msg, SocialData::Profile);
	msg.add<uint32_t>(found ? other : 0);
	msg.addByte(self || relation.friends() || relation.inviter != 0);
	msg.addByte(relation.isBlocked(account));
	msg.addByte(showAccount);
	if (showAccount) {
		msg.addByte(online != nullptr);
		msg.add<uint32_t>(characters.front().lastLogin);
		msg.addByte(online && online->isPremium());
		msg.addString(online ? online->getLoyaltyTitle() : std::string {});
		msg.addByte(0); // No public badges are shared by this response.
	}

	if (found) {
		if (!showCharacter) {
			const auto displayCharacter = match ? *match : characters.front();
			characters = { displayCharacter };
		}
		const auto mainCharacter = characters.front().id;
		if (showCharacter && match && std::ranges::none_of(characters, [&match](const SocialCharacter &character) { return character.id == match->id; })) {
			characters.back() = *match;
		}

		msg.addByte(static_cast<uint8_t>(characters.size()));
		for (const auto &character : characters) {
			const auto live = showCharacter ? g_game().getPlayerByGUID(character.id) : nullptr;
			const bool visibleOnline = live && !live->isInGhostMode();
			msg.add<uint32_t>(character.id);
			msg.addString(character.name);
			msg.addByte(character.id == mainCharacter);
			msg.addString(visibleOnline ? live->title()->getCurrentTitleName() : std::string {});
			msg.addString(showCharacter ? character.world : std::string {});
			msg.addString(showCharacter ? character.vocation : std::string {});
			msg.add<uint16_t>(showCharacter ? character.level : 0);
			msg.addByte(visibleOnline);
			addSocialOutfit(msg, showCharacter ? character.outfit : Outfit_t {});
		}
	} else {
		msg.addByte(0); // Character count is present even when the account was not found.
	}
	writeToOutputBuffer(msg);
}

void ProtocolGame::inspectSocialCharacter(uint32_t characterId) {
	const auto target = g_game().getPlayerByGUID(characterId);
	if (!target || target->isInGhostMode()) {
		sendCyclopediaCharacterNoData(CYCLOPEDIA_CHARACTERINFO_INSPECTION, 1);
		return;
	}

	const auto account = player->getAccountId();
	const auto other = target->getAccountId();
	if (account != other) {
		auto relation = getSocialRelation(account, other);
		if (relation.isBlocked(account) || relation.isBlocked(other) || !getSocialSettings(other, relation.group(other)).allowInspect) {
			sendCyclopediaCharacterNoData(CYCLOPEDIA_CHARACTERINFO_INSPECTION, 3);
			return;
		}
	}

	sendCyclopediaCharacterInspection(target);
}

void ProtocolGame::sendSocialBadges() {
	// Tibia 15.30 FriendSystemData (0x74), badge catalog (0x06).
	const auto badges = g_game().getBadges();
	const auto &playerBadge = player->badge();

	NetworkMessage msg;
	msg.addByte(0x74);
	msg.addByte(0x06);
	msg.addByte(static_cast<uint8_t>(badges.size()));
	for (const auto &badge : badges) {
		const bool unlocked = playerBadge->hasBadge(badge.m_id);
		msg.add<uint32_t>(badge.m_id);
		msg.addString(badge.m_name);
		msg.addString(badge.getDescription());
		msg.addByte(unlocked);
		msg.addByte(unlocked && playerBadge->isVisible(badge.m_id));
	}
	writeToOutputBuffer(msg);
}

void ProtocolGame::parseFriendSystemAction(NetworkMessage &msg) {
	if (oldProtocol) {
		return;
	}

	const auto rawAction = msg.getByte();
	if (rawAction == 0x0C) {
		sendSocialBadges();
		return;
	}
	if (rawAction == 0x0D) {
		const auto badgeId = msg.get<uint32_t>();
		const auto visible = msg.getByte();
		if (!msg.isOverrun() && visible <= 1) {
			player->badge()->setVisible(badgeId, visible != 0);
			sendSocialBadges();
		}
		return;
	}

	const auto action = static_cast<SocialAction>(rawAction);
	if (msg.isOverrun()) {
		return;
	}

	switch (action) {
		case SocialAction::List:
		case SocialAction::Invitations:
		case SocialAction::Blacklist:
			sendSocialList(static_cast<uint8_t>(action) + static_cast<uint8_t>(SocialData::List));
			return;
		case SocialAction::Search: {
			const auto name = msg.getString();
			if (!msg.isOverrun()) {
				sendSocialProfile(0, name);
			}
			return;
		}
		case SocialAction::Profile: {
			const auto account = msg.get<uint32_t>();
			if (!msg.isOverrun()) {
				sendSocialProfile(account, "");
			}
			return;
		}
		case SocialAction::SetTitle: {
			const auto title = msg.getByte();
			if (!msg.isOverrun()) {
				g_game().playerFriendSystemAction(player, static_cast<uint8_t>(action), title);
			}
			return;
		}
		case SocialAction::Settings:
			sendSocialSettings();
			return;
		case SocialAction::SetSettings: {
			const auto group = msg.getByte();
			const auto showCharacter = msg.getByte();
			const auto showAccount = msg.getByte();
			const auto allowInspect = msg.getByte();
			if (!msg.isOverrun() && group < 4 && showCharacter <= 1 && showAccount <= 1 && allowInspect <= 1) {
				socialSettingsKV(player->getAccountId())->set(std::to_string(group), showCharacter | (showAccount << 1) | (allowInspect << 2));
				sendSocialSettings();
			}
			return;
		}
		case SocialAction::Invite:
		case SocialAction::Accept:
		case SocialAction::Decline:
		case SocialAction::Cancel:
		case SocialAction::Block:
		case SocialAction::Unblock:
		case SocialAction::SetGroup:
			break;
		default:
			return;
	}

	const auto other = msg.get<uint32_t>();
	const uint8_t group = action == SocialAction::Accept || action == SocialAction::SetGroup ? msg.getByte() : 0;
	if (msg.isOverrun()) {
		return;
	}

	const auto account = player->getAccountId();
	if (!changeSocialRelation(action, account, other, group, player->getGUID())) {
		NetworkMessage reply;
		beginSocialPacket(reply, SocialData::Error);
		reply.addByte(1);
		reply.addString("This Socials action could not be completed.");
		writeToOutputBuffer(reply);
		return;
	}

	const auto refresh = [](ProtocolGame &protocol) {
		protocol.sendSocialList(static_cast<uint8_t>(SocialData::List));
		protocol.sendSocialList(static_cast<uint8_t>(SocialData::Invitations));
		protocol.sendSocialList(static_cast<uint8_t>(SocialData::Blacklist));
	};
	refresh(*this);
	for (const auto &[id, target] : g_game().getPlayers()) {
		if (target == player || !target->client || target->client->oldProtocol) {
			continue;
		}

		const auto targetAccount = target->getAccountId();
		if (targetAccount != other && targetAccount != account) {
			continue;
		}
		refresh(*target->client);
		if (targetAccount == other && (action == SocialAction::Invite || action == SocialAction::Accept)) {
			NetworkMessage notification;
			beginSocialPacket(notification, action == SocialAction::Invite ? SocialData::NewInvitation : SocialData::NewFriend);
			target->client->writeToOutputBuffer(notification);
		}
	}
}
