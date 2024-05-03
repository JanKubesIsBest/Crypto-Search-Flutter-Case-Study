import 'dart:convert';

import 'package:http/http.dart' as http;

class RetrievedCryptoCoins {
  final bool sucessful;
  final List<CryptoCoin> retrievedCrypto;

  RetrievedCryptoCoins({required this.sucessful, required this.retrievedCrypto});
}

class CryptoCoin {
  // Three data I'm going to show in the menu (?)
  final String id;
  final String name;
  final double price;

  final String symbol;
  final String imageLink;

  CryptoCoin({required this.symbol, required this.imageLink, required this.id, required this.name, required this.price});

  factory CryptoCoin.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {
        'item': {
          'id': String id,
          'name': String name,
          'symbol': String symbol,
          'large': String imageLink,
          'data': {
            'price': double price,
          }
        }
      } => 
      CryptoCoin(id: id, name: name, price: price, imageLink: imageLink, symbol: symbol),
      _ => throw const FormatException("Could not load Cryto coin."),
    };
  }

  Future<FullCryptoCoin> getFullCoin() async {
    print("Retrieving");

    final Map<String, String> headers = <String, String>{
      "accept": "application/json",
      "x-cg-pro-api-key" : "CG-738W9EJdfn1DGs8eED84JFBS",
    };

    http.Response http_response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=$id",), headers: headers);

    if (http_response.statusCode == 200) {
      // For looking into data
      // print(json.decode(http_response.body)[0] as Map<String, dynamic>);
      return FullCryptoCoin.fromJSON(json.decode(http_response.body)[0] as Map<String, dynamic>);
    }

    return FullCryptoCoin(sucessful:false, priceChangeOverall: 0, symbol: symbol, imageLink: imageLink, id: id, name: name, price: price, priceChangePercentage: 0);
  }
}

class FullCryptoCoin extends CryptoCoin {
  final bool sucessful;
  final double priceChangePercentage;
  final double priceChangeOverall;

  FullCryptoCoin({
    required this.priceChangeOverall,
    required this.priceChangePercentage,
    required this.sucessful,
    required super.symbol,
    required super.imageLink,
    required super.id,
    required super.name,
    required super.price,
  });

  factory FullCryptoCoin.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': String id,
      'name': String name,
      'symbol': String symbol,
      'image': String imageLink,
      'current_price': double price,
      'price_change_percentage_24h': double priceChangePercentage,
      'price_change_24h': double priceChangeOverall,
      } =>
          FullCryptoCoin(priceChangeOverall: priceChangeOverall, id: id, name: name, price: price, imageLink: imageLink, symbol: symbol, sucessful: true, priceChangePercentage: priceChangePercentage),
      _ => throw const FormatException("Could not load Cryto coin."),
    };
  }
}