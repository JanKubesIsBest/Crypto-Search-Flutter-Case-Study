import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/view/coinPage/banner.dart';
import 'package:crypto_app/view/coinPage/infoAndStats/infoAndStats.dart';

import 'package:flutter/material.dart';

class CoinPage extends StatefulWidget {
  final CryptoCoin coin;

  const CoinPage({super.key, required this.coin});

  @override
  State<StatefulWidget> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  late final Future<FullCryptoCoin> fullCoin;

  @override
  void initState() {
    super.initState();

    fullCoin = widget.coin.getFullCoin();
  }

  @override
  Widget build(BuildContext context) {
    // Idea: You could add SliverAppBar so there is nice effect, but I'm not sure if it is a fit.
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.coin.name),
      ),
      body: FutureBuilder<FullCryptoCoin>(
        future: fullCoin,
        builder:
            (BuildContext context, AsyncSnapshot<FullCryptoCoin> snapshot) {
          if (snapshot.hasData && snapshot.data!.sucessful) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyBanner(coin: snapshot.data as FullCryptoCoin),
                  InfoAndStatsView(coin: snapshot.data as FullCryptoCoin),
                ],
              ),
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
      ),
    );
  }
}
