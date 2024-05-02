import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:flutter/material.dart';

class ListOfCryptos extends StatelessWidget {
  List<CryptoCoin> cryptoCoins;

  ListOfCryptos({super.key, required this.cryptoCoins});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: cryptoCoins.length,
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(cryptoCoins[index].name),
      );
    },);
  }

}