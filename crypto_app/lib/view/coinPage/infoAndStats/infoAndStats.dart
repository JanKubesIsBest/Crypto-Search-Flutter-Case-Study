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
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              painter: PriceRange(
                low: stats.todaysLow,
                high: stats.todaysHigh,
                priceRightNow: coin.price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
