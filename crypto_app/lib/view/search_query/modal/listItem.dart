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
  bool isInTheList = false;

  @override
  void initState() {
    super.initState();
    checkIfIsInTheList();
  }

  Future checkIfIsInTheList() async {
    Database db = await openMyDatabase();
    bool isInTheListFuture =
        await checkIfTheCoinIsInTheList(db, widget.list.id, widget.coinId);

    setState(() {
      isInTheList = isInTheListFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // If is not in the list, add it, else, remove it
        if (isInTheList) {
          // Add is_connected for the crypto
          // If the crypto is not in the database yet, the function will add it.
          await addCoinToTheDatabase(widget.coinId, widget.list.id);
          checkIfIsInTheList();
        } else {
          // Remove crypto
        }
      },
      child: Card(
        color: isInTheList ? Colors.green : Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.list.name,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    isInTheList
                        ? "Click to remove from the list"
                        : "Click to add",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            "Do you really want to delete this list?"),
                        content: const Text(
                            'If you delete this, all cryptos stored in there will be lost.'),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('Delete'),
                            onPressed: () {
                              deleteList();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteList() async {
    // Delete (is_connected deletion is handle by this function also)
    final Database db = await openMyDatabase();
    await deleteListFromDatabase(db, widget.list.id);

    widget.updateList();

    checkIfIsInTheList();

    Fluttertoast.showToast(msg: "Delete list");
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
