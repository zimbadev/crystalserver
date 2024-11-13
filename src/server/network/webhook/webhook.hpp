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

#include "lib/thread/thread_pool.hpp"

struct WebhookTask {
	std::string payload;
	std::string url;
};

class Webhook {
public:
	static constexpr size_t DEFAULT_DELAY_MS = 1000;

	explicit Webhook(ThreadPool &threadPool);

	// Singleton - ensures we don't accidentally copy it
	Webhook(const Webhook &) = delete;
	void operator=(const Webhook &) = delete;

	static Webhook &getInstance();

	void run();

	void sendPayload(const std::string &payload, const std::string &url);
	void sendMessage(const std::string &title, const std::string &message, int color, std::string url = "", bool embed = true);
	void sendMessage(const std::string &message, std::string url = "");

private:
	std::mutex taskLock;
	ThreadPool &threadPool;
	std::deque<std::shared_ptr<WebhookTask>> webhooks;
	curl_slist* headers = nullptr;

	void sendWebhook();

	int sendRequest(const char* url, const char* payload, std::string* response_body) const;
	static size_t writeCallback(void* contents, size_t size, size_t nmemb, void* userp);
	std::string getPayload(const std::string &title, const std::string &message, int color, bool embed = true) const;
};

constexpr auto g_webhook = Webhook::getInstance;
