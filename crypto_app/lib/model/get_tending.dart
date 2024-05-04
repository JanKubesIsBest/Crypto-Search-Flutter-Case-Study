import 'dart:convert';

import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

Future<RetrievedCryptoCoins> getTrendingCoins() async {
  final Map<String, String> headers = <String, String>{ 
    "accept": "application/json",
    "x-cg-api-key" : "CG-738W9EJdfn1DGs8eED84JFBS",
  };

  http.Response http_response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/search/trending",), headers: headers);

  late final RetrievedCryptoCoins response;

  if (http_response.statusCode == 200) {
    final l = json.decode(http_response.body)['coins'];

    // For looking into the data
    // print(l[0]);

    List<CryptoCoin> trending_coins = List<CryptoCoin>.from(l.map((element) => CryptoCoin.fromJSON(element)));

    response = RetrievedCryptoCoins(sucessful: true, online: true, retrievedCrypto: trending_coins);
  } else {
    final Database db = await openMyDatabase();

    // Retrieve from SQLite
    List<FullCryptoCoin> coins = await getCoinsViaList(db, 1);

    response = RetrievedCryptoCoins(sucessful: true, online: false, retrievedCrypto: coins);

    // TODO: handle no query
  }
  
  return response;
} 