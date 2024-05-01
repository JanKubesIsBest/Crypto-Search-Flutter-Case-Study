class CryptoCoin {
  // Three data I'm going to show in the menu (?)
  final String id;
  final String name;
  final double price;

  CryptoCoin({required this.id, required this.name, required this.price});

  factory CryptoCoin.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {
        'item': {
          'id': String id,
          'name': String name,
          'data': {
            'price': double price,
          }
        }
      } => 
      CryptoCoin(id: id, name: name, price: price),
      _ => throw const FormatException("Could not load Cryto coin."),
    };
  }
}