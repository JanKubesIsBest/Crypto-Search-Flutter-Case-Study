import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/database/delete.dart';
import 'package:crypto_app/model/get_coins_by_list.dart';
import 'package:crypto_app/model/database/insert_into_database.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:crypto_app/model/database/update.dart';
import 'package:crypto_app/model/get_tending.dart';
import 'package:crypto_app/view/pages/listOfCryptos/listOfCryptos.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MyPage extends StatefulWidget {
  final int index;
  const MyPage({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _PageState();
}

// Page is going to load needed information.
class _PageState extends State<MyPage> {
  late Future<RetrievedCryptoCoins> trendingCoins;

  @override
  void initState() {
    super.initState();
    
    print(widget.index);

    // If is trending
    if (widget.index == 1) {
      trendingCoins = getTrendingCoins();
    }
    // Get List by its id.
    else {
      // get list
      // Database is in the fucniton itself
      trendingCoins = getCoinsByList(widget.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RetrievedCryptoCoins>(
      future: trendingCoins,
      builder:
          (BuildContext context, AsyncSnapshot<RetrievedCryptoCoins> snapshot) {
        if (snapshot.hasData && snapshot.data!.sucessful) {
          if (snapshot.data!.online && widget.index == 1) {
            // If the data is fresh, insert them.
            insertCoins(snapshot.data!.retrievedCrypto);
          }

          return ListOfCryptos(
            cryptoCoins: snapshot.data!.retrievedCrypto,
          );
        } else if (snapshot.hasData && !snapshot.data!.sucessful) {
          // TODO: Load last
          return const Text("Could not load data");
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<void> insertCoins(List<CryptoCoin> coins) async {
  final Database db = await openMyDatabase();

  // Trending list is always created first
  const int trending = 1;

  // Delete all is_connected
  await deleteIsConnectedWhereList(db, trending);

  for (CryptoCoin coin in coins) {
    List<FullCryptoCoin> databaseCoins = await getCoin(db, coin.id);

    InfoAndStats zeroInfoAndStats = InfoAndStats(
        totalSupply: 0,
        totalVolume: 0,
        marketCap: 0,
        marketCapRanking: 0,
        todaysHigh: 0,
        todaysLow: 0,
        priceChangeOverall: 0,
        priceChangePercentage: 0);

    final FullCryptoCoin newCrypto = FullCryptoCoin(
        stats: zeroInfoAndStats,
        sucessful: true,
        symbol: coin.symbol,
        imageLink: coin.imageLink,
        id: coin.id,
        name: coin.name,
        price: coin.price);

    // Look if it is inserted
    if (databaseCoins.isNotEmpty) {
      // Update it
      await updateCoin(db, newCrypto);
    } else {
      // Insert it
      await insertCoinIntoDatabase(db, newCrypto);
    }

    // Add
    insertIsConnectedIntoDatabase(db, coin.id, trending);
  }
}
