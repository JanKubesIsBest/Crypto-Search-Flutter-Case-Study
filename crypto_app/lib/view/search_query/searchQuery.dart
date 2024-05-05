import 'package:crypto_app/model/search_coin.dart';
import 'package:crypto_app/view/search_query/queryItem.dart';
import 'package:flutter/material.dart';

class SearchQuery extends StatefulWidget {
  final String searchedCrypto;

  const SearchQuery({super.key, required this.searchedCrypto});
  @override
  State<StatefulWidget> createState() => _SearchQueryState();
}

class _SearchQueryState extends State<SearchQuery> {
  late Future<RetrievedCryptoCoinsQuery> cryptos;

  /// This way we can keep the state of the cryptos, so the user can see the query 
  /// and not circular progress.
  List<CryptoCoinQuery> alreadyRetrievedCryptos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cryptos = search_coins(widget.searchedCrypto);
    return FutureBuilder<RetrievedCryptoCoinsQuery>(
      future: cryptos,
      builder: (BuildContext context,
          AsyncSnapshot<RetrievedCryptoCoinsQuery> snapshot) {
        if (snapshot.hasData && snapshot.data!.sucessful) {
          alreadyRetrievedCryptos = snapshot.data!.retrievedCrypto;
        } 
        else if (snapshot.hasData && !snapshot.data!.sucessful) {
          return const Align(
            alignment: Alignment.center,
            child: Text("Could not load data"),
          );
        } 

        return ListOfCryptosQuery(cryptos: alreadyRetrievedCryptos);
      },
    );
  }
}

class ListOfCryptosQuery extends StatelessWidget {
  final List<CryptoCoinQuery> cryptos;

  const ListOfCryptosQuery({super.key, required this.cryptos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CryptoQueryItem(coin: cryptos[index]);
      },
      itemCount: cryptos.length,
    );
  }
}