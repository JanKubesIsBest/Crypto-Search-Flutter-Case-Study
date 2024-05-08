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
  late Future<HistoricalData> historicalPrices;

  // Keep track of this, it is hard coded
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // The 3 year is the first one
    historicalPrices = getHistoricalData(
        widget.coin.symbol,
        DateTime.now()
            .subtract(const Duration(days: 365 * 3))
            .toIso8601String(),
        "7day");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: FutureBuilder<HistoricalData>(
        future: historicalPrices,
        builder:
            (BuildContext context, AsyncSnapshot<HistoricalData> snapshot) {
          if (snapshot.hasData && snapshot.data!.success) {
            print("Building");
            return Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: GraphOfThePrice(
                          prices: snapshot.data!.prices,
                        ),
                      ),
                    ),
                  ),
                  RowForTimeButtons(
                      currentIndex: currentIndex, callback: callBackForTime),
                ],
              ),
            );
          } else if (snapshot.hasData && !snapshot.data!.success) {
            return Container(
              height: 0,
            );
          }
          // Better than circular progress indicator, as I think that for most coins this feature won't work.
          return Container(
            height: 0,
          );
        },
      ),
    );
  }

  void callBackForTime(String from, String timeInterval, int newIndex) {
    setState(() {
      historicalPrices =
          getHistoricalData(widget.coin.symbol, from, timeInterval);
      currentIndex = newIndex;
    });
  }
}

class RowForTimeButtons extends StatelessWidget {
  final int currentIndex;
  final Function callback;

  const RowForTimeButtons(
      {super.key, required this.currentIndex, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      // Sized box is needed due to ListView in column
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            // This is quite awful, hardcoding nightmare
            ButtonForTime(
              callback: () {
                callback(
                  DateTime.now()
                      .subtract(const Duration(days: 365 * 3))
                      .toIso8601String(),
                  "7day",
                  0,
                );
              },
              isSelected: currentIndex == 0,
              text: "3 Year",
            ),
            ButtonForTime(
              callback: () {
                callback(
                  DateTime.now()
                      .subtract(const Duration(days: 365))
                      .toIso8601String(),
                  "7day",
                  1,
                );
              },
              isSelected: currentIndex == 1,
              text: "1 Year",
            ),
            ButtonForTime(
              callback: () {
                callback(
                    DateTime(DateTime.now().year).toIso8601String(), "1day", 2);
              },
              text: "YTD",
              isSelected: currentIndex == 2,
            ),
            ButtonForTime(
              callback: () {
                callback(
                  DateTime.now()
                      .subtract(const Duration(days: 30))
                      .toIso8601String(),
                  "1day",
                  3,
                );
              },
              isSelected: currentIndex == 3,
              text: "1 Month",
            ),
            ButtonForTime(
              callback: () {
                callback(
                  DateTime.now()
                      .subtract(const Duration(days: 7))
                      .toIso8601String(),
                  "1hour",
                  4,
                );
              },
              isSelected: currentIndex == 4,
              text: "1 Week",
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonForTime extends StatelessWidget {
  final Function callback;
  final String text;

  final bool isSelected;

  const ButtonForTime(
      {super.key,
      required this.callback,
      required this.text,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: () => callback(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (Set states) {
              if (isSelected) {
                return Theme.of(context).colorScheme.secondary;
              }
              return null;
            },
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color:
                  isSelected ? Colors.white : Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class HistoricalData {
  final String ticker;
  final bool success;
  final List<HistoricalPrice> prices;

  HistoricalData(
      {required this.ticker, required this.prices, required this.success});
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
