import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:sqflite/sqflite.dart';

Future<void> updateCoinWithoutDbInParams(FullCryptoCoin coin) async {
  print("Updating coin with db");
  Database db = await openMyDatabase();
  await db.update('coin', coin.toMap(), where: 'coin_id = ?', whereArgs: [coin.id]);
} 

Future<void> updateCoin(Database db, FullCryptoCoin coin) async {
  print("Updating coin");
  await db.update('coin', coin.toMap(), where: 'coin_id = ?', whereArgs: [coin.id]);
}