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
          'small': String imageLink,
          'data': {
            'price': double price,
          }
        }
      } => 
      CryptoCoin(id: id, name: name, price: price, imageLink: imageLink, symbol: symbol),
      _ => throw const FormatException("Could not load Cryto coin."),
    };
  }
}