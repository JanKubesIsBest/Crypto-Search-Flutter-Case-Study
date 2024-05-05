import 'package:http/http.dart' as http;
import 'dart:convert';


Future<RetrievedCryptoCoinsQuery> search_coins(String searchQuery) async {
  late final RetrievedCryptoCoinsQuery response;
  print("Searching");

  try {
    final Map<String, String> headers = <String, String>{
      "accept": "application/json",
      "x-cg-api-key": "CG-738W9EJdfn1DGs8eED84JFBS",
    };

    http.Response httpResponse = await http.get(
        Uri.parse(
          "https://api.coingecko.com/api/v3/search?query=$searchQuery",
        ), 
        headers: headers,
    );

    if (httpResponse.statusCode == 200) {
      final l = json.decode(httpResponse.body)['coins'];

      // For looking into the data
      print(l[0]);

      List<CryptoCoinQuery> trendingCoins = List<CryptoCoinQuery>.from(
          l.map((element) => CryptoCoinQuery.fromJSON(element)));

      response = RetrievedCryptoCoinsQuery(
          sucessful: true, online: true, retrievedCrypto: trendingCoins);
    }
  } catch (_) {
    response = RetrievedCryptoCoinsQuery(
        sucessful: false, online: false, retrievedCrypto: []);
  }

  return response;
}

// I know this is weird, but Coingecko api search query does not come with price :(
class RetrievedCryptoCoinsQuery {
  final bool sucessful;
  final bool online;
  final List<CryptoCoinQuery> retrievedCrypto;
  
  RetrievedCryptoCoinsQuery({required this.sucessful, required this.retrievedCrypto, required this.online});
}

class CryptoCoinQuery {
  final String id;
  final String name;

  final String symbol;
  final String imageLink;

  CryptoCoinQuery({required this.symbol, required this.imageLink, required this.id, required this.name,});

    factory CryptoCoinQuery.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {

          'id': String id,
          'name': String name,
          'symbol': String symbol,
          'large': String imageLink,
      } => 
      CryptoCoinQuery(id: id, name: name, imageLink: imageLink, symbol: symbol),
      _ => throw const FormatException("Could not load Cryto coin."),
    };
  }

}