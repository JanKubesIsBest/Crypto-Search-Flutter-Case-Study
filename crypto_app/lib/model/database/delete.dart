import 'package:sqflite/sqflite.dart';

Future<void> deleteIsConnectedWhereList(Database db, int listId) async {
  await db.delete('is_connected', where: 'list_id = ?', whereArgs: [listId]);
}

Future<void> deleteListFromDatabase(Database db, int listId) async {
  // Delete list
  await db.delete('list', where: 'list.id = ?', whereArgs: [listId]);

  // Delete is_connected
  await deleteIsConnectedWhereList(db, listId);
}