#include "pch.hpp"

#include <boost/ut.hpp>

#include "creatures/combat/combat.hpp"

using namespace boost::ut;

// Decision-matrix coverage for pvpModeAllows: the pure allow/deny core of Combat::checkExpertPvpMode.
// Each row locks in one Open/Expert PvP rule so a future refactor cannot silently change who may attack whom.
suite<"combat"> pvpModeAllowsTest = [] {
	struct Case {
		std::string name;
		PvpMode_t mode;
		PvpFacts facts;
		bool expected;
	};

	const std::vector<Case> cases {
		// Dove: pacifist, only genuine self-defense is allowed.
		{ "dove denies a neutral", PVP_MODE_DOVE, PvpFacts {}, false },
		{ "dove allows when the target attacked me", PVP_MODE_DOVE, PvpFacts { .targetAttackedMe = true }, true },
		{ "dove allows inside an existing pvp situation", PVP_MODE_DOVE, PvpFacts { .inSituation = true }, true },
		{ "dove ignores an attacked ally", PVP_MODE_DOVE, PvpFacts { .attackedAllyOfMe = true }, false },
		{ "dove ignores a skulled target", PVP_MODE_DOVE, PvpFacts { .targetSkulled = true }, false },

		// White hand: self-defense plus defending party/guild members.
		{ "white hand denies a neutral", PVP_MODE_WHITE_HAND, PvpFacts {}, false },
		{ "white hand allows self-defense", PVP_MODE_WHITE_HAND, PvpFacts { .targetAttackedMe = true }, true },
		{ "white hand defends an attacked ally", PVP_MODE_WHITE_HAND, PvpFacts { .attackedAllyOfMe = true }, true },
		{ "white hand ignores a skulled target", PVP_MODE_WHITE_HAND, PvpFacts { .targetSkulled = true }, false },

		// Yellow hand: white hand plus skulled players are fair game.
		{ "yellow hand denies a neutral", PVP_MODE_YELLOW_HAND, PvpFacts {}, false },
		{ "yellow hand allows self-defense", PVP_MODE_YELLOW_HAND, PvpFacts { .targetAttackedMe = true }, true },
		{ "yellow hand defends an attacked ally", PVP_MODE_YELLOW_HAND, PvpFacts { .attackedAllyOfMe = true }, true },
		{ "yellow hand attacks a skulled target", PVP_MODE_YELLOW_HAND, PvpFacts { .targetSkulled = true }, true },

		// Red fist: attack everyone except own party/guild, even in a self-defense context.
		{ "red fist attacks a neutral", PVP_MODE_RED_FIST, PvpFacts {}, true },
		{ "red fist spares a party member", PVP_MODE_RED_FIST, PvpFacts { .partner = true }, false },
		{ "red fist spares a guild mate", PVP_MODE_RED_FIST, PvpFacts { .guildMate = true }, false },
		{ "red fist still spares party even under attack", PVP_MODE_RED_FIST, PvpFacts { .targetAttackedMe = true, .partner = true }, false },
	};

	for (const auto &c : cases) {
		test(c.name) = [&c] {
			expect(eq(c.expected, pvpModeAllows(c.mode, c.facts))) << c.name;
		};
	}
};
