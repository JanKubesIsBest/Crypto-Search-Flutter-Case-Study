import 'package:sqflite/sqflite.dart';

Future<void> deleteIsConnectedWhereList(Database db, int listId) async {
  await db.delete('is_connected', where: 'list_id = ?', whereArgs: [listId]);
}