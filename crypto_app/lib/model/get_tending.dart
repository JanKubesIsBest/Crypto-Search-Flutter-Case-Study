import 'dart:convert';

import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:http/http.dart' as http;

Future<List<CryptoCoin>> getTrendingCoins() async {
  final Map<String, String> headers = <String, String>{ 
    "accept": "application/json",
    "x-cg-pro-api-key" : "CG-738W9EJdfn1DGs8eED84JFBS",
  };

  http.Response response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/search/trending",), headers: headers);


  if (response.statusCode == 200) {
    final l = json.decode(response.body)['coins'];

    List<CryptoCoin> trending_coins = List<CryptoCoin>.from(l.map((element) => CryptoCoin.fromJSON(element)));

    for (CryptoCoin coin in trending_coins){
      print(coin.name);
    }
  } else {
    // TODO: Do this exception.
  }
  
  return [];
} 