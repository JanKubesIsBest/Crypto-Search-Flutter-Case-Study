import 'package:crypto_app/model/CryptoCoin.dart';
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
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(radius: 48,backgroundImage: NetworkImage(coin.imageLink,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coin.name,
                            style: const TextStyle(fontSize: 17),
                          ),
                          Text(
                            coin.symbol,
                            style: const TextStyle(
                                fontSize: 10, color: Color.fromARGB(159, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      '\$',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      coin.price.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
