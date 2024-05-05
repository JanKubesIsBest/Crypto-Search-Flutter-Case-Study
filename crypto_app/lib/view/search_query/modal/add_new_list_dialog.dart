import 'package:crypto_app/model/database/insert_into_database.dart';
import 'package:crypto_app/model/database/open_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

TextEditingController _textFieldController = TextEditingController();

Future<void> showAddListDialog(BuildContext context) async {
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
            onPressed: () {
              addNewList(_textFieldController.value.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void addNewList(String listName) async {
  // Add new list.
  Database db = await openMyDatabase();

  bool result = await insertListIntoTheDatabase(db, listName);

  if (result) {
    Fluttertoast.showToast(msg: "List added");
  }
  else {
    Fluttertoast.showToast(msg: "Error occured");
  }
}
