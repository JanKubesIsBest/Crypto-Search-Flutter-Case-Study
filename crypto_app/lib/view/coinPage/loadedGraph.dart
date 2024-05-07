import 'package:crypto_app/view/coinPage/graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphOfThePrice extends StatelessWidget {
  final List<HistoricalPrice> prices;
  const GraphOfThePrice({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      minY: 0,
      titlesData: const FlTitlesData(
        show: true,
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
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
    ));
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
