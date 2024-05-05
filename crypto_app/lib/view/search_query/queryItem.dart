import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/search_coin.dart';
import 'package:crypto_app/view/coinPage/coinPage.dart';
import 'package:crypto_app/view/search_query/modal/modal_for_lists.dart';
import 'package:flutter/material.dart';

class CryptoQueryItem extends StatefulWidget {
  final CryptoCoinQuery coin;

  const CryptoQueryItem({super.key, required this.coin});

  @override
  State<StatefulWidget> createState() => _CryptoQueryItemState();
}

class _CryptoQueryItemState extends State<CryptoQueryItem> {
  late CryptoCoinQuery coin;

  @override
  void initState() {
    super.initState();
    coin = widget.coin;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Price is not used, so we can just pass 0.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoinPage(
              coin: CryptoCoin(
                symbol: coin.symbol,
                imageLink: coin.imageLink,
                id: coin.id,
                name: coin.name,
                price: 0,
              ),
            ),
          ),
        ),
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircleAvatar(
                        radius: 48,
                        backgroundImage: NetworkImage(
                          coin.imageLink,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coin.name.length > 14
                              ? "${coin.name.substring(0, 14)}..."
                              : coin.name,
                          style: const TextStyle(fontSize: 25),
                        ),
                        Text(
                          coin.symbol,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(159, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // Add to list.
                  // Show modal bottom sheet.
                  // Add to list.
                  // Contains also create new list option.
                  showAddModalBottomSheet(context, coin.id);
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}