import 'dart:convert';

import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:http/http.dart' as http;

Future<RetrievedCryptoCoins> getTrendingCoins() async {
  final Map<String, String> headers = <String, String>{ 
    "accept": "application/json",
    "x-cg-pro-api-key" : "CG-738W9EJdfn1DGs8eED84JFBS",
  };

  http.Response http_response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/search/trending",), headers: headers);

  late final RetrievedCryptoCoins response;

  if (http_response.statusCode == 200) {
    final l = json.decode(http_response.body)['coins'];

    // For looking into the data
    print(l[0]);

    List<CryptoCoin> trending_coins = List<CryptoCoin>.from(l.map((element) => CryptoCoin.fromJSON(element)));

    response = RetrievedCryptoCoins(sucessful: true, retrievedCrypto: trending_coins);
  } else {
    response = RetrievedCryptoCoins(sucessful: false, retrievedCrypto: []);
  }
  
  return response;
} 