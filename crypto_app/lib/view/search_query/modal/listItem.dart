import 'package:crypto_app/model/CryptoCoin.dart';
import 'package:crypto_app/model/List.dart';
import 'package:crypto_app/model/database/delete.dart';
import 'package:crypto_app/model/database/insert_into_database.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class ListItem extends StatefulWidget {
  final MyList list;
  final Function updateList;
  final String coinId;

  const ListItem(
      {super.key,
      required this.list,
      required this.updateList,
      required this.coinId});

  @override
  State<StatefulWidget> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Add is_connected for the crypto
        // If the crypto is not in the database yet, the function will add it.
        addCoinToTheDatabase(widget.coinId, widget.list.id);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.list.name,
                    style: TextStyle(fontSize: 15),
                  ),
                  const Text(
                    "Click to add",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(150, 0, 0, 0)),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  // Delete (is_connected deletion is handle by this function also)
                  final Database db = await openMyDatabase();
                  await deleteListFromDatabase(db, widget.list.id);

                  widget.updateList();
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> addCoinToTheDatabase(String coinId, int listId) async {
  try {
    final Database db = await openMyDatabase();

    // Get id.
    final int coinDatabaseId = await getIdOfACoin(db, coinId);

    if (coinDatabaseId == 0) {
      // If its equal zero, search for the coin
      // getFullCoin function needs only id, so this should work fine.
      FullCryptoCoin fullCryptoCoin = await CryptoCoin(
              symbol: '', imageLink: '', id: coinId, name: '', price: 0)
          .getFullCoin();

      // Add it to the database
      int newCoinId = await insertCoinIntoDatabase(db, fullCryptoCoin);
      await db
          .insert('is_connected', {'coin_id': newCoinId, 'list_id': listId});
    } else {
      await db.insert(
          'is_connected', {'coin_id': coinDatabaseId, 'list_id': listId});
    }

    Fluttertoast.showToast(msg: "Added");
  } catch (_) {
    Fluttertoast.showToast(msg: "Error occured");
  }
}
