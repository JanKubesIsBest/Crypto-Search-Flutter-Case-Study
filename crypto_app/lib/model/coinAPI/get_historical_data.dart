import 'dart:convert';

import 'package:crypto_app/view/coinPage/graph.dart';
import 'package:http/http.dart' as http;

/// Get historical data of a coin, uses different api.
Future<HistoricalData> getHistoricalData(String ticker, String startDate, String frequency) async {
    late final HistoricalData response;

    print("Getting historical data");

    final Map<String, String> headers = <String, String>{
      "accept": "application/json",
    };

    http.Response httpResponse = await http.get(
        Uri.parse(
          // I have to search for the assets... I know that btc and eth are working.
          "https://api.tiingo.com/tiingo/crypto/prices\?tickers=${ticker.toLowerCase()}usd&startDate=${startDate}&resampleFreq=${frequency}&token=73e353ed523d45950f87e74ee40db0dbf76bb700",
        ),
        headers: headers,
    );
    try {
    if (httpResponse.statusCode == 200) {
      final l = json.decode(httpResponse.body)[0];
      final priceData = l['priceData'];

      // For looking into the data
      // print(l[0]);
      // print(priceData);

      List<HistoricalPrice> historicalPrices = List<HistoricalPrice>.from(
        priceData.map((element) => HistoricalPrice.fromJSON(element))
      );

      //print(historicalPrices);

      response = HistoricalData(ticker: l['ticker'], prices: historicalPrices, success: true);
    } else {
       response = HistoricalData(ticker: '', prices: [], success: false);
    }
    } catch (_) {
      response = HistoricalData(ticker: '', prices: [], success: false);
    }

    return response;
}