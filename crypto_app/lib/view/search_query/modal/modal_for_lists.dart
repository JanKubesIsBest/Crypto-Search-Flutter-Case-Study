import 'package:crypto_app/view/search_query/modal/add_new_list_dialog.dart';
import 'package:crypto_app/view/search_query/modal/listItem.dart';
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
      return ModalBody(coinId: coinId);
    },
  );
}

class ModalBody extends StatefulWidget {
  final String coinId;

  const ModalBody({super.key, required this.coinId});

  @override
  State<StatefulWidget> createState() => _ModalBodyState();
}

class _ModalBodyState extends State<ModalBody> {
  List<MyList> lists_state = [];

  @override
  void initState() {
    super.initState();
    updateList();
  }

  void updateList() async {
    print("Updating list");
    final List<MyList> updatedList = await getListsWithDatabase();
    lists_state.clear();

    print("Updated list");
    print(updatedList);

    setState(() {
      lists_state.addAll(updatedList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 500),
      child: Padding(
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

                  return ListItem(
                    list: list,
                    updateList: updateList,
                    coinId: widget.coinId,
                  );
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: GestureDetector(
                onTap: () {
                  // Show dialog
                  // Add new list
                  showAddListDialog(context, updateList);
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
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<MyList>> getListsWithDatabase() async {
  final Database db = await openMyDatabase();

  List<MyList> lists = await getLists(db);

  return lists;
}
