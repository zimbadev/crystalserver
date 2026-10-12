#include <boost/ut.hpp>

#include "account/account_repository_db.hpp"
#include "database/database.hpp"
#include "lib/logging/in_memory_logger.hpp"
#include "utils/tools.hpp"
#include "enums/account_type.hpp"
#include "account/account_info.hpp"

using namespace boost::ut;

auto databaseTest(Database &db, const std::function<void(void)> &load) {
    return [&db, load] {
        expect(&db == &g_database()) << "Fixture must use the injected database";
        bool completed = false;
        DBTransaction::executeWithinTransactionRollbackOnFailure([&] {
            load();
            completed = true;
            // False requests rollback of the connection pinned by DBTransaction.
            return false;
        });
        expect(completed) << "Test callback did not complete inside a transaction";
    };
}

void createAccount(Database &db) {
	db.executeQuery(
		"INSERT INTO `accounts` "
		"(`id`, `name`, `email`, `password`, `type`, `premdays`, `lastday`, `premdays_purchased`, `creation`) "
		"VALUES(111, 'test', '@test', '', 3, 11, 1293912, 11, 42183281)"
	);

	db.executeQuery(fmt::format(
		"INSERT INTO `account_sessions` (`id`, `account_id`, `expires`) "
		"VALUES ('{}', 111, 1337)",
		transformToSHA1("test")
	));
}

void assertAccountLoad(const AccountInfo &acc) {
	expect(eq(acc.id, 111));
	expect(eq(acc.accountType, AccountType::ACCOUNT_TYPE_SENIORTUTOR));
	// lastday is an expired timestamp; legacy premdays must not grant premium.
	expect(eq(acc.premiumRemainingDays, 0));
	expect(eq(acc.premiumLastDay, 1293912));
	expect(eq(acc.players.size(), 0));
	expect(eq(acc.oldProtocol, false));
	expect(eq(acc.premiumDaysPurchased, 11));
	expect(approx(acc.creationTime, 42183281, 60 * 60 * 1000));
}

int main() {
	struct DbConfig {
	public:
		std::string host = "127.0.0.1";
		std::string user = "root";
		std::string password = "root";
		std::string database = "crystalserver";
		uint32_t port = 3306;
		std::string sock;
    };
    di::extension::injector<> injector {};
    InMemoryLogger::install(injector);
    injector.install(di::bind<Database>.to<Database>().in(di::singleton));
    DI::setTestContainer(&injector);
    struct ResetTestContainer {
        ~ResetTestContainer() { DI::setTestContainer(nullptr); }
    } resetTestContainer;
    auto &db = g_database();
    DbConfig dbConfig{};

	if (!db.connect(
		&dbConfig.host,
		&dbConfig.user,
		&dbConfig.password,
		&dbConfig.database,
		dbConfig.port,
		&dbConfig.sock
	)) {
        return 1;
    }

	test("AccountRepositoryDB::loadByID") = databaseTest(db, [&db] {
		auto &logger = dynamic_cast<InMemoryLogger &>(g_logger()).reset();
		AccountRepositoryDB accRepo{};
		createAccount(db);

		AccountInfo acc;
		accRepo.loadByID(111, acc);
		assertAccountLoad(acc);
		expect(eq(acc.sessionExpires, 0));
	});

	test("AccountRepositoryDB::loadByEmailOrName") = databaseTest(db, [&db] {
		auto &logger = dynamic_cast<InMemoryLogger &>(g_logger()).reset();
		AccountRepositoryDB accRepo {};
		createAccount(db);

		AccountInfo acc;
		accRepo.loadByEmailOrName(false, "@test", acc);
		assertAccountLoad(acc);
		expect(eq(acc.sessionExpires, 0));
	});

	test("AccountRepositoryDB::loadBySession") = databaseTest(db, [&db] {
		auto &logger = dynamic_cast<InMemoryLogger &>(g_logger()).reset();
		AccountRepositoryDB accRepo {};
		createAccount(db);

		AccountInfo acc;
		accRepo.loadBySession("test", acc);

		assertAccountLoad(acc);
		expect(eq(acc.sessionExpires, 1337));
	});

	test("AccountRepositoryDB load sets premium day purchased = remaining days, if needed") = databaseTest(db, [&db] {
		auto &logger = dynamic_cast<InMemoryLogger &>(g_logger()).reset();
		AccountRepositoryDB accRepo{};

		AccountInfo acc;
		accRepo.loadByID(1, acc);
		acc.premiumRemainingDays = 10;
		acc.premiumLastDay = getTimeNow() + 10 * 86400 + 43200;
		accRepo.save(acc);

		accRepo.loadByID(1, acc);

		expect(eq(acc.premiumDaysPurchased, 10));
	});

	test("AccountRepositoryDB::getPassword") = databaseTest(db, [&db] {
		auto &logger = dynamic_cast<InMemoryLogger &>(g_logger()).reset();
		AccountRepositoryDB accRepo {};

		std::string password;

		expect(accRepo.getPassword(1, password));
		expect(eq(password, std::string { "21298df8a3277357ee55b01df9530b535cf08ec1" }));
	});

	test("AccountRepositoryDB::getPassword logs on failure") = databaseTest(db, [&db] {
		auto &logger = dynamic_cast<InMemoryLogger &>(g_logger()).reset();
		AccountRepositoryDB accRepo {};

		std::string password;

		expect(!accRepo.getPassword(891237, password));
        expect(logger.hasLogEntry("error", "Failed to get account:[891237] password!"));
	});

	test("AccountRepositoryDB::save") = databaseTest(db, [&db] {
		auto &logger = dynamic_cast<InMemoryLogger &>(g_logger()).reset();
		AccountRepositoryDB accRepo {};

		AccountInfo acc;
		acc.id = 1;
		acc.accountType = AccountType::ACCOUNT_TYPE_SENIORTUTOR;
		acc.premiumRemainingDays = 10;
		acc.premiumLastDay = getTimeNow() + 10 * 86400 + 43200;
		acc.sessionExpires = 99999999;
		expect(accRepo.save(acc));

		AccountInfo acc2;
		accRepo.loadByID(1, acc2);
		expect(eq(acc2.id, 1));
		expect(eq(acc2.accountType, AccountType::ACCOUNT_TYPE_SENIORTUTOR));
		expect(eq(acc2.premiumRemainingDays, 10));
		expect(eq(acc2.premiumLastDay, acc.premiumLastDay));
		// sessionExpires is not saved
		expect(eq(acc2.sessionExpires, 0));
	});
    test("Database integration fixture rolls back rows with a connection pool") = [&db] {
        databaseTest(db, [&db] { createAccount(db); })();
        const auto result = db.storeQuery("SELECT COUNT(*) AS row_count FROM accounts WHERE id = 111");
        expect(result != nullptr) << "Rollback verification query must succeed";
        if (result) {
            expect(eq(result->getNumber<uint32_t>("row_count"), uint32_t{0}));
        }
    };

}
