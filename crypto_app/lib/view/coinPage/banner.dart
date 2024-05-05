import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:flutter/material.dart';

class MyBanner extends StatelessWidget {
  final FullCryptoCoin coin;

  const MyBanner({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "\$",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      coin.price.toStringAsFixed(4),
                      style: const TextStyle(fontSize: 33),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${coin.stats.priceChangeOverall.toStringAsFixed(3)} ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: coin.stats.priceChangePercentage >= 0
                              ? Colors.green
                              : Colors.red),
                    ),
                    Text(
                      "(${coin.stats.priceChangePercentage.toStringAsFixed(2)}%)",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: coin.stats.priceChangePercentage >= 0
                              ? Colors.green
                              : Colors.red),
                    ),
                    const Text(" 24h",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(170, 0, 0, 0),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 1),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(coin.imageLink),
          ),
        ),
      ],
    );
  }
}
