import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/get_tending.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

// Page is going to load needed information.
class _PageState extends State<MyPage> {
  Future<List<CryptoCoin>> trendingCoins = getTrendingCoins();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CryptoCoin>>(
        future: trendingCoins, builder: (BuildContext context, AsyncSnapshot<List<CryptoCoin>> snapshot) {
          if (snapshot.hasData) {
            return const Text("Loaded");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
