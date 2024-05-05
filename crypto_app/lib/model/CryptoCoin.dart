import 'dart:convert';
import 'package:http/http.dart' as http;

class RetrievedCryptoCoins {
  final bool sucessful;
  final bool online;
  final List<CryptoCoin> retrievedCrypto;

  RetrievedCryptoCoins({required this.sucessful, required this.retrievedCrypto, required this.online});
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
    final Map<String, String> headers = <String, String>{
      "accept": "application/json",
      "x-cg-api-key" : "CG-738W9EJdfn1DGs8eED84JFBS",
    };

    http.Response httpResponse = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=$id",), headers: headers);

    if (httpResponse.statusCode == 200) {
      // For looking into data
      // print("Data:");
      print(json.decode(httpResponse.body)[0] as Map<String, dynamic>);
      
      return FullCryptoCoin.fromJSON(json.decode(httpResponse.body)[0] as Map<String, dynamic>);
    }

    InfoAndStats infoAndStats = InfoAndStats(totalSupply: 0, totalVolume: 0, marketCap: 0, marketCapRanking: 0, todaysHigh: 0, todaysLow: 0, priceChangeOverall: 0, priceChangePercentage: 0);
    return FullCryptoCoin(sucessful:false, symbol: symbol, imageLink: imageLink, id: id, name: name, price: price, stats: infoAndStats);
  }
}

class FullCryptoCoin extends CryptoCoin {
  final bool sucessful;
  final InfoAndStats stats;

  FullCryptoCoin({
    required this.stats,

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
      'low_24h': double todaysLow,
      'high_24h': double todaysHigh,
      'market_cap': int marketCap,
      'market_cap_rank': int marketCapRanking,
      'total_supply': double totalSupply,
      'total_volume': int totalVolume,
      } =>
          FullCryptoCoin(id: id, name: name, price: price, imageLink: imageLink, symbol: symbol, sucessful: true, stats: InfoAndStats(marketCap: marketCap, marketCapRanking: marketCapRanking, todaysHigh: todaysHigh, todaysLow: todaysLow, priceChangeOverall: priceChangeOverall, priceChangePercentage: priceChangePercentage, totalSupply: totalSupply, totalVolume: totalVolume)),
      _ => throw const FormatException("Could not load Cryto coin."),
    };
  }

  Map<String, Object?> toMap() {
    return {
      'coin_id': id,
      'name': name,
      'symbol': symbol,
      'image_link': imageLink,
      'price': price,
      'price_change_perc': stats.priceChangePercentage,
      'price_change': stats.priceChangeOverall,
      'todays_low': stats.todaysLow,
      'todays_high': stats.todaysHigh,
      'market_cap': stats.marketCap,
      'market_cap_rank':  stats.marketCapRanking,
      'total_supply':  stats.totalSupply,
      'total_volume':  stats.totalVolume,
      'updated': DateTime.now().toIso8601String(),
    }; 
  }
}

class InfoAndStats {
  final int marketCap;
  final int marketCapRanking;

  final double todaysHigh;
  final double todaysLow;

  final double priceChangeOverall;
  final double priceChangePercentage;

  final int totalVolume;
  final double totalSupply;

  InfoAndStats({required this.totalSupply, required this. totalVolume, required this.marketCap, required this.marketCapRanking, required this.todaysHigh, required this.todaysLow, required this.priceChangeOverall, required this.priceChangePercentage});
}