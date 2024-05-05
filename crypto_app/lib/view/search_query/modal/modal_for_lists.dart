import 'package:crypto_app/view/search_query/modal/add_new_list_dialog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto_app/model/database/retrieve.dart';
import 'package:crypto_app/model/List.dart';
import 'package:crypto_app/model/database/open_database.dart';

import 'package:flutter/material.dart';

void showAddModalBottomSheet(BuildContext context) {
  Future<List<MyList>> lists = getListsWithDatabase();

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: const BoxConstraints(minHeight: 100),
          child: FutureBuilder<List<MyList>>(
            builder:
                (BuildContext context, AsyncSnapshot<List<MyList>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name),
                        );
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: GestureDetector(
                        onTap: () {
                          // Show dialog
                          // Add new list
                          showAddListDialog(context);
                        },
                        child: SizedBox(
                          child: Card(
                            color: Theme.of(context).secondaryHeaderColor,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text("Add new list", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500, fontSize: 20),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
      });
}

Future<List<MyList>> getListsWithDatabase() async {
  final Database db = await openMyDatabase();

  List<MyList> lists = await getLists(db);

  return lists;
}
