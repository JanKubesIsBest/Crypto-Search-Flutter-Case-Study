import 'package:crypto_app/view/coinPage/graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphOfThePrice extends StatelessWidget {
  final List<HistoricalPrice> prices;
  const GraphOfThePrice({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: LineChart(
        LineChartData(
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(
            show: false,
          ),
          minX: 0,
          minY: 0,
          // This was quite sketchy to find how to do, but this returns what the top box looks like when you hover over graph.
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              // Here I'm trying not to overlap
              fitInsideHorizontally: true,
              tooltipBgColor: Theme.of(context).primaryColor,
              tooltipPadding: const EdgeInsets.all(5),
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map(
                  (barSpot) {
                    DateTime date = DateTime.parse(prices[barSpot.spotIndex].date);
                    return LineTooltipItem(
                        "",
                        children: [
                          TextSpan(
                              text:
                                  "Price: ${prices[barSpot.spotIndex].price.toStringAsFixed(0)}\$ \n"),
                          TextSpan(
                              text: "Date: ${date.day}.${date.month}.${date.year}"),
                        ],
                        const TextStyle(color: Colors.white));
                  },
                ).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: Theme.of(context).primaryColor,
              spots: [...getSpots()],
              isCurved: false,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSpots() {
    final List<FlSpot> returnSpots = [];

    for (int i = 0; i < prices.length; i++) {
      returnSpots.add(FlSpot(i.toDouble(), prices[i].price));

      print(i);
    }

    return returnSpots;
  }
}
