import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:flutter/material.dart';

class CoinPage extends StatelessWidget {
  final CryptoCoin coin;

  const CoinPage({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    // Idea: You could add SliverAppBar so there is nice effect, but I'm not sure if it is a fit.
    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name),
      ),
      body: Column(
        children: [
          Text(coin.price.toStringAsFixed(2)),
        ],
      )
    );
  }
}
