import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:sqflite/sqflite.dart';

Future<RetrievedCryptoCoins> getCoinsByList(int listId) async {
  final Database db = await openMyDatabase();

  // Get cryptos from database.
  final List<FullCryptoCoin> cryptos = await getCoinsViaList(db, listId);

  // Search for basic data about them.
  try {
    final List<FullCryptoCoin> updatedCoins = [];

    // Get request for fresh data
    for (FullCryptoCoin coin in cryptos) {
      final FullCryptoCoin updatedCoin = await CryptoCoin(symbol: coin.symbol, imageLink: coin.imageLink, id: coin.id, name: coin.name, price: coin.price).getFullCoin();

      updatedCoins.add(updatedCoin);
    }

    return RetrievedCryptoCoins(sucessful: true, retrievedCrypto: updatedCoins, online: true);
  } catch (_) {
    // Error, maybe no internet, return offline version
    print("An error ocured");
    return RetrievedCryptoCoins(sucessful: true, retrievedCrypto: cryptos, online: false);
  }
}
