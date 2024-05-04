import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/view/coinPage/infoAndStats/customPaintForPriceRange.dart';
import 'package:flutter/material.dart';

class InfoAndStatsView extends StatefulWidget {
  final FullCryptoCoin coin;

  const InfoAndStatsView({super.key, required this.coin});

  @override
  State<StatefulWidget> createState() => _InfoAndStatsViewState();
}

class _InfoAndStatsViewState extends State<InfoAndStatsView> {
  late final FullCryptoCoin coin;
  late final InfoAndStats stats;

  @override
  void initState() {
    super.initState();

    coin = widget.coin;
    stats = coin.stats;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Info & Stats",
            style: TextStyle(fontSize: 30),
          ),
          Row(
            children: [
              Text(
                "\$" + stats.todaysLow.toStringAsFixed(2),
                style: TextStyle(fontSize: 23),
              ),
              Spacer(),
              Text(
                "Day's range",
                style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
              ),
              Spacer(),
              Text(
                "\$" + stats.todaysHigh.toStringAsFixed(2),
                style: TextStyle(fontSize: 23),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomPaint(
              painter: PriceRange(
                low: stats.todaysLow,
                high: stats.todaysHigh,
                priceRightNow: coin.price,
              ),
            ),
          ),
          Metrics(coin: coin),
        ],
      ),
    );
  }
}

class Metrics extends StatelessWidget {
  final FullCryptoCoin coin;

  const Metrics({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    print("hello");
    return Column(children: [
      Row(
        children: [
          InfoCard(description: "Market Cap", data: coin.stats.marketCap > 1000000 ? "\$" + (coin.stats.marketCap/1000000).toStringAsFixed(2) + "M" : "\$" + coin.stats.marketCap.toString()),
          InfoCard(description: "Market Cap Ranking", data: coin.stats.marketCapRanking.toString() + ".")
        ],
      ),
            Row(
        children: [
          InfoCard(description: "Total Supply", data: coin.stats.totalSupply > 1000000 ? (coin.stats.totalSupply/1000000).toStringAsFixed(2) + "M" : coin.stats.marketCap.toString()),
          InfoCard(description: "Total Volume", data: coin.stats.totalVolume > 1000000 ? "\$" + (coin.stats.totalVolume/1000000).toStringAsFixed(2) + "M" : "\$" + coin.stats.totalVolume.toString()),
        ],
            ),
      Row(
        children: [
          InfoCard(description: "Price Change", data:  "\$" + coin.stats.priceChangeOverall.toStringAsFixed(2)),
          InfoCard(description: "Price Change Percentage", data: coin.stats.priceChangeOverall.toStringAsFixed(2) + "%")
        ],
      ),
    ]);
  }
}

class InfoCard extends StatelessWidget {
  final String description;
  final String data;

  const InfoCard({super.key, required this.description, required this.data});
  
  @override
  Widget build(BuildContext context) {
    return 
       Expanded(
        child: SizedBox(
          height: 100,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(description, style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),),
                Text(data, style: TextStyle(fontSize: 20),),
              ],),
            ),
          ),
        ),
    );
  }
}
