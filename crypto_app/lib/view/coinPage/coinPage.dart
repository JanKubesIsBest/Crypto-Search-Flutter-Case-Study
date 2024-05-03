import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/view/coinPage/graph.dart';
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
          title: Align(
            alignment: Alignment.center,
            child: Text(widget.coin.name),
          ),
        ),
        body: FutureBuilder<FullCryptoCoin>(
            future: fullCoin,
            builder:
                (BuildContext context, AsyncSnapshot<FullCryptoCoin> snapshot) {
              if (snapshot.hasData && snapshot.data!.sucessful) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Banner(coin: snapshot.data as FullCryptoCoin),
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
            }));
  }
}

class Banner extends StatelessWidget {
  final FullCryptoCoin coin;

  const Banner({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    print(coin.priceChangePercentage);
    return Row(
      children: [
        Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "\$",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      coin.price.toStringAsFixed(4),
                      style: TextStyle(fontSize: 33),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${coin.priceChangeOverall.toStringAsFixed(3)} ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: coin.priceChangePercentage >= 0
                              ? Colors.green
                              : Colors.red),
                    ),
                    Text(
                      "(${coin.priceChangePercentage.toStringAsFixed(2)}%)",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: coin.priceChangePercentage >= 0
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
