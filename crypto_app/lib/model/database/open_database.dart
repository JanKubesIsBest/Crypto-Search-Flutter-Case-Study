import 'package:crypto_app/model/database/insert_into_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openMyDatabase() async {
  print("Opening database");

  final Database database = await openDatabase(
    join(await getDatabasesPath(), 'appDatabase.db'),
    onCreate: (Database db, int version) {
      print("Creating tables");

      createCoinTable(db);
      createIsConnectedTable(db);
      createListTable(db);
    },
    version: 2,
  );

  print("Created databases");

  return database;
}

Future<void> createCoinTable(Database db) async {
  print("Creating coin table");
  return db.execute(
    'CREATE TABLE coin(id INTEGER PRIMARY KEY, name TEXT, symbol TEXT, coin_id TEXT, image_link TEXT, price REAL, market_cap INT, market_cap_rank INT, todays_high REAL, todays_low REAL, price_change REAL, price_change_perc REAL, total_volume REAL, total_supply REAL, updated TEXT)'
  );
}

Future<void> createIsConnectedTable(Database db) async {
  print("Creating is_connected table");
  return db.execute(
    'CREATE TABLE is_connected(id INTEGER PRIMARY KEY, list_id int, coin_id int)'
  );
}

Future<void> createListTable(Database db) async {
  print("Creating list table");
  await db.execute(
    'CREATE TABLE list(id INTEGER PRIMARY KEY, name TEXT)'
  );

  insertListIntoTheDatabase(db, "Trending");
}