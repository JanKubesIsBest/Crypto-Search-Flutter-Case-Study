import 'package:crypto_app/model/database/insert_into_database.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

TextEditingController _textFieldController = TextEditingController();

Future<void> showAddListDialog(
    BuildContext context, Function updateList) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('New list.'),
        content: TextField(
          controller: _textFieldController,
          decoration:
              const InputDecoration(hintText: "Write a name for the list"),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Discard'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Add'),
            onPressed: () async {
              addNewList(_textFieldController.value.text).then((value) => {
                    if (value)
                      {
                        Fluttertoast.showToast(msg: "List added"),
                      }
                    else
                      {
                        Fluttertoast.showToast(msg: "Error occured"),
                      },
                    updateList.call(),
                  });

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<bool> addNewList(String listName) async {
  // Add new list.
  Database db = await openMyDatabase();

  bool result = await insertListIntoTheDatabase(db, listName);

  print("Inserted list");

  return result;
}
