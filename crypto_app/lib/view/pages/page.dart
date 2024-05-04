import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/database/insert_into_database.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:crypto_app/model/database/update.dart';
import 'package:crypto_app/model/get_tending.dart';
import 'package:crypto_app/view/pages/listOfCryptos/listOfCryptos.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

// Page is going to load needed information.
class _PageState extends State<MyPage> {
  Future<RetrievedCryptoCoins> trendingCoins = getTrendingCoins();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RetrievedCryptoCoins>(
        future: trendingCoins,
        builder: (BuildContext context, AsyncSnapshot<RetrievedCryptoCoins> snapshot) {
          if (snapshot.hasData && snapshot.data!.sucessful) {
            insertCoins(snapshot.data!.retrievedCrypto);
            return ListOfCryptos(cryptoCoins: snapshot.data!.retrievedCrypto,);
          } else if (snapshot.hasData && !snapshot.data!.sucessful) {
            // TODO: Load last
            return const Text("Could not load data");
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        );
  }
}

Future<void> insertCoins(List<CryptoCoin> coins) async {
  final Database db = await openMyDatabase();

  for (CryptoCoin coin in coins) {
    List<FullCryptoCoin> databaseCoins = await getCoin(db, coin.id);

    InfoAndStats zeroInfoAndStats = InfoAndStats(totalSupply: 0, totalVolume: 0, marketCap: 0, marketCapRanking: 0, todaysHigh: 0, todaysLow: 0, priceChangeOverall: 0, priceChangePercentage: 0);

    // Look if it is inserted
    if (databaseCoins.length > 0) {
      // Update it
      updateCoin(db, FullCryptoCoin(stats: zeroInfoAndStats, sucessful: true, symbol: coin.symbol, imageLink: coin.imageLink, id: coin.id, name: coin.name, price: coin.price));
    } else {
      // Insert it
      insertCoinIntoDatabase(db, FullCryptoCoin(stats: zeroInfoAndStats, sucessful: true, symbol: coin.symbol, imageLink: coin.imageLink, id: coin.id, name: coin.name, price: coin.price));
    }
  }
}