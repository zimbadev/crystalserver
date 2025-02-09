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

#include "lua/functions/core/network/webhook_functions.hpp"

#include "server/network/webhook/webhook.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void WebhookFunctions::init(lua_State* L) {
	Lua::registerTable(L, "Webhook");
	Lua::registerMethod(L, "Webhook", "sendMessage", WebhookFunctions::luaWebhookSendMessage);
}

int WebhookFunctions::luaWebhookSendMessage(lua_State* L) {
	// Webhook.sendMessage(title, message, color, url = "WEBHOOK_DISCORD_URL") |
	// Webhook.sendMessage(message, url = "WEBHOOK_DISCORD_URL")
	const std::string title = Lua::getString(L, 1);
	const std::string message = Lua::getString(L, 2);
	const auto color = Lua::getNumber<uint32_t>(L, 3, 0);
	const std::string url = Lua::getString(L, -1);
	if (url == title) {
		g_webhook().sendMessage(title);
	} else if (url == message) {
		g_webhook().sendMessage(title, url);
	} else {
		g_webhook().sendMessage(title, message, color, url);
	}
	lua_pushnil(L);

	return 1;
}
