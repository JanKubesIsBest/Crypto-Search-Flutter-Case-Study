import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:sqflite/sqflite.dart';

// If we are inserting from trending, we will make the missing values zero.
Future<int> insertCoinIntoDatabase(Database db, FullCryptoCoin coin) async {
  print("Inserting coin");
  return await db.insert('coin', coin.toMap());
}

// I know that this looks weird, but I would have trouble making this by coin database id, and I won't think it is that much of an issue
// PS: If there is someone reading this, I know it looks bad, but the SQLite library is pretty fast and atleast on my device it does not make any probles.
Future<void> insertIsConnectedIntoDatabase(Database db, String coin_coin_id, int list_id) async {
  final int coin_id = await getIdOfACoin(db, coin_coin_id);
  
  print("Inserting is_connected");
  await db.insert('is_connected', {'coin_id': coin_id, 'list_id': list_id});
}

Future<void> insertListIntoTheDatabase(Database db, String list) async {
  print("Inserting list");
  await db.insert('list', {'name': list},);
}