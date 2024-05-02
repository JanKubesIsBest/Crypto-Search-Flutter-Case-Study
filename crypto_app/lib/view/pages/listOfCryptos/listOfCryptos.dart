import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/view/pages/listOfCryptos/cryptoCoinListItem.dart';
import 'package:flutter/material.dart';

class ListOfCryptos extends StatelessWidget {
  final List<CryptoCoin> cryptoCoins;

  const ListOfCryptos({super.key, required this.cryptoCoins});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: cryptoCoins.length,
      itemBuilder: (BuildContext context, int index) {
        final CryptoCoin coin = cryptoCoins[index];

        // Maybe wrap this into ListTile?
        return CryptoCoinListItem(coin: coin,);
      },
    );
  }
}
