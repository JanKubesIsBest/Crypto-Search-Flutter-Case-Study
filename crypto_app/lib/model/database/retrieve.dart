import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:sqflite/sqflite.dart';

Future<List<FullCryptoCoin>> getCoin(Database db, String cryptoId) async {
  final List<Map<String, Object?>> coinsMap = await db.query('coin', where: 'coin_id = ?', whereArgs: [cryptoId]);

  return [
    for (final {
      'coin_id': id as String,
      'name': name as String,
      'symbol': symbol as String,
      'image_link': imageLink as String,
      'price': price as double,
      'price_change_perc': priceChangePercentage as double,
      'price_change': priceChangeOverall as double,
      'todays_low': todaysLow as double,
      'todays_high': todaysHigh as double,
      'market_cap': marketCap as int,
      'market_cap_rank':  marketCapRanking as int,
      'total_supply':  totalSupply as double,
      'total_volume':  totalVolume as double,
    } in coinsMap)
    FullCryptoCoin(stats: InfoAndStats(totalSupply: totalSupply, totalVolume: totalVolume.toInt(), marketCap: marketCap, marketCapRanking: marketCapRanking, todaysHigh: todaysHigh, todaysLow: todaysLow, priceChangeOverall: priceChangeOverall, priceChangePercentage: priceChangePercentage), sucessful: true, symbol: symbol, imageLink: imageLink, id: id, name: name, price: price)
  ];
}

Future<int> getIdOfACoin(Database db, String coinCoinId) async {
  final List<Map<String, Object?>> coinsMap = await db.query('coin', where: 'coin_id = ?', whereArgs: [coinCoinId]);
  
  try {
    return coinsMap[0]['id'] as int;
  } catch (error) {
    print("Error, returning zero");
    return 0;
  }
}