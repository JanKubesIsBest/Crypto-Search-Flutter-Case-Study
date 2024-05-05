import 'package:crypto_app/model/database/delete.dart';
import 'package:crypto_app/model/database/insert_into_database.dart';
import 'package:crypto_app/model/search_coin.dart';
import 'package:crypto_app/view/search_query/modal/add_new_list_dialog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:crypto_app/model/List.dart';
import 'package:crypto_app/model/database/open_database.dart';

import 'package:flutter/material.dart';

void showAddModalBottomSheet(BuildContext context, String coinId) {
  Future<List<MyList>> lists = getListsWithDatabase();
  List<MyList> lists_state = [];

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void updateList() async {
            final List<MyList> updatedList = await getListsWithDatabase();
            lists_state.clear();

            setState((){
              lists_state.addAll(updatedList);
            });
          }

          return Container(
            constraints: const BoxConstraints(minHeight: 100, maxHeight: 500),
            child: FutureBuilder<List<MyList>>(
              builder:
                  (BuildContext context, AsyncSnapshot<List<MyList>> snapshot) {
                if (snapshot.hasData) {
                  lists_state.clear();
                  lists_state.addAll(snapshot.data as Iterable<MyList>);

                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          // This should be something that does not overflow on devices, need to test more
                          height: 390,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: lists_state.length,
                            itemBuilder: (context, index) {
                              final MyList list = lists_state[index];

                              return GestureDetector(
                                onTap: () async {
                                  // Add is_connected for the crypto
                                  // If the crypto is not in the database yet, the function will add it.
                                  final Database db = await openMyDatabase();
                                  insertIsConnectedIntoDatabase(db, coinId, list.id);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(list.name, style: TextStyle(fontSize: 15),),
                                            const Text("Click to add", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color.fromARGB(150, 0, 0, 0)),),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () async {
                                            // Delete (is_connected deletion is handle by this function also)
                                            final Database db =
                                                await openMyDatabase();
                                            await deleteListFromDatabase(db, list.id);
                                
                                            updateList();
                                          },
                                          icon: const Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: GestureDetector(
                            onTap: () async {
                              // Show dialog
                              // Add new list
                              await showAddListDialog(context);

                              // Update current list
                              updateList();
                            },
                            child: SizedBox(
                              child: Card(
                                color: Theme.of(context).secondaryHeaderColor,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Add new list",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              },
              future: lists,
            ),
          );
        },
      );
    },
  );
}

Future<List<MyList>> getListsWithDatabase() async {
  final Database db = await openMyDatabase();

  List<MyList> lists = await getLists(db);

  return lists;
}
