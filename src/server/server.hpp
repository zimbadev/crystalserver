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

#include "lib/metrics/metrics.hpp"
#include "server/network/connection/connection.hpp"
#include "server/signals.hpp"

class Protocol;

class ServiceBase {
public:
	virtual ~ServiceBase() = default;
	virtual bool is_single_socket() const = 0;
	virtual bool is_checksummed() const = 0;
	virtual uint8_t get_protocol_identifier() const = 0;
	virtual const char* get_protocol_name() const = 0;

	virtual Protocol_ptr make_protocol(const Connection_ptr &c) const = 0;
};

template <typename ProtocolType>
class Service final : public ServiceBase {
public:
	bool is_single_socket() const override {
		return ProtocolType::SERVER_SENDS_FIRST;
	}
	bool is_checksummed() const override {
		return ProtocolType::USE_CHECKSUM;
	}
	uint8_t get_protocol_identifier() const override {
		return ProtocolType::PROTOCOL_IDENTIFIER;
	}
	const char* get_protocol_name() const override {
		return ProtocolType::protocol_name();
	}

	Protocol_ptr make_protocol(const Connection_ptr &c) const override {
		return std::make_shared<ProtocolType>(c);
	}
};

class ServicePort : public std::enable_shared_from_this<ServicePort> {
public:
	explicit ServicePort(asio::io_service &init_io_service) :
		io_service(init_io_service) { }
	~ServicePort();

	// non-copyable
	ServicePort(const ServicePort &) = delete;
	ServicePort &operator=(const ServicePort &) = delete;

	static void openAcceptor(const std::weak_ptr<ServicePort> &weak_service, uint16_t port);
	void open(uint16_t port);
	void close() const;
	bool is_single_socket() const;
	std::string get_protocol_names() const;

	bool add_service(const Service_ptr &new_svc);
	Protocol_ptr make_protocol(bool checksummed, NetworkMessage &msg, const Connection_ptr &connection) const;

	void onStopServer() const;
	void onAccept(const Connection_ptr &connection, const std::error_code &error);

private:
	void accept();

	asio::io_service &io_service;
	std::unique_ptr<asio::ip::tcp::acceptor> acceptor;
	std::vector<Service_ptr> services;

	uint16_t serverPort = 0;
	bool pendingStart = false;
};

class ServiceManager {
public:
	ServiceManager() = default;
	~ServiceManager();

	// non-copyable
	ServiceManager(const ServiceManager &) = delete;
	ServiceManager &operator=(const ServiceManager &) = delete;

	void run();
	void stop();

	template <typename ProtocolType>
	bool add(uint16_t port);

	bool is_running() const {
		return acceptors.empty() == false;
	}

private:
	void die();

	phmap::flat_hash_map<uint16_t, ServicePort_ptr> acceptors;

	asio::io_service io_service;
	Signals signals { io_service };
	asio::high_resolution_timer death_timer { io_service };
	bool running = false;
};

template <typename ProtocolType>
bool ServiceManager::add(uint16_t port) {
	if (port == 0) {
		g_logger().error("[ServiceManager::add] - "
		                 "No port provided for service {}, service disabled",
		                 ProtocolType::protocol_name());
		return false;
	}

	ServicePort_ptr service_port;

	const auto foundServicePort = acceptors.find(port);

	if (foundServicePort == acceptors.end()) {
		service_port = std::make_shared<ServicePort>(io_service);
		service_port->open(port);
		acceptors[port] = service_port;
	} else {
		service_port = foundServicePort->second;

		if (service_port->is_single_socket() || ProtocolType::SERVER_SENDS_FIRST) {
			g_logger().error("[ServiceManager::add] - "
			                 "{} and {} cannot use the same port {}",
			                 ProtocolType::protocol_name(), service_port->get_protocol_names(), port);
			return false;
		}
	}

	return service_port->add_service(std::make_shared<Service<ProtocolType>>());
}
