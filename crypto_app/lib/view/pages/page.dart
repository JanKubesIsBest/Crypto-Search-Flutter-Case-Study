import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/get_tending.dart';
import 'package:crypto_app/view/pages/listOfCryptos/listOfCryptos.dart';
import 'package:flutter/material.dart';

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
        future: trendingCoins, builder: (BuildContext context, AsyncSnapshot<RetrievedCryptoCoins> snapshot) {
          if (snapshot.hasData && snapshot.data!.sucessful) {
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
        });
  }
}
