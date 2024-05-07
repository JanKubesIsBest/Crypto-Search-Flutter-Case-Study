import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/coinAPI/get_historical_data.dart';
import 'package:crypto_app/view/coinPage/loadedGraph.dart';
import 'package:flutter/material.dart';

class PriceGraph extends StatefulWidget {
  final FullCryptoCoin coin;

  const PriceGraph({super.key, required this.coin});

  @override
  State<StatefulWidget> createState() => _PriceGraphState();
}

class _PriceGraphState extends State<PriceGraph> {
  late final Future<HistoricalData> historicalPrices;

  @override
  void initState() {
    super.initState();
    historicalPrices = getHistoricalData(widget.coin.symbol, "2023-01-01", "7day");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: FutureBuilder<HistoricalData>(
          future: historicalPrices,
          builder: (BuildContext context, AsyncSnapshot<HistoricalData> snapshot) {
            if (snapshot.hasData && snapshot.data!.success) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: ClipRRect(borderRadius: BorderRadius.circular(6), child: GraphOfThePrice(prices: snapshot.data!.prices,),),
                  ),
                ),
              );
            } else if (snapshot.hasData && !snapshot.data!.success) {
              return Container(height: 0,);
            }
            // Better than circular progress indicator, as I think that for most coins this feature won't work.
            return Container(height: 0,);
          }),
    );
  }
}

class HistoricalData {
  final String ticker;
  final bool success;
  final List<HistoricalPrice> prices;

  HistoricalData({required this.ticker, required this.prices, required this.success});
}

class HistoricalPrice {
  final String date;
  final double price; // Close price in the api response

  HistoricalPrice({required this.date, required this.price});

  factory HistoricalPrice.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {
        'date': String date,
        'close': double price,
      } =>
        HistoricalPrice(price: price, date: date),
      _ => throw const FormatException("Could not load"),
    };
  }
}
