import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:sqflite/sqflite.dart';

// If we are inserting from trending, we will make the missing values zero.
Future<void> insertCoinIntoDatabase(Database db, FullCryptoCoin coin) async {
  print("Inserting coin");
  await db.insert('coin', coin.toMap());
}

Future<void> insertIsConnectedIntoDatabase(Database db, int coin_id, int list_id) async {
  print("Inserting is_connected");
  await db.insert('is_connected', {'coin_id': coin_id, 'list_id': list_id});
}

Future<void> insertListIntoTheDatabase(Database db, String list) async {
  print("Inserting list");
  await db.insert('list', {'name': list},);
}