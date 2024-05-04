import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:sqflite/sqflite.dart';

Future<void> updateCoin(Database db, FullCryptoCoin coin) async {
  print("Updating coin");
  await db.update('coin', coin.toMap(), where: 'coin_id = ?', whereArgs: [coin.id]);
}