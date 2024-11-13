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

enum class CommandType {
	start,
	load,
	run,
	shutdown,
};

using ICommand = Message<CommandType>;
using CommandHandler = MessageHandler<CommandType>;
using CommandPolicy = MessagePolicy<CommandType>;
using CommandListener = IMessageListener<CommandType>;
using CommandListeners = MessageListeners<CommandType>;
using CommandDispatcher = MessageDispatcher<CommandType>;
using CommandRemover = MessageRemover<CommandType>;

inline ICommand command(CommandType type) {
	return ICommand { type };
}
#define commandCallback(block) [this](const ICommand &) block
#define appendCommandListener(type, block) dispatcher.appendListener(type, commandCallback(block))
