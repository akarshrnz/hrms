// import 'package:sqflite/sqflite.dart';
// import '../../domain/entities/notification.dart';
// import '../datasources/local/database_helper.dart';

// class NotificationRepository {
//   final DatabaseHelper _databaseHelper;

//   NotificationRepository(this._databaseHelper);

//   Future<List<Notification>> getNotifications() async {
//     final db = await _databaseHelper.database;
//     final List<Map<String, dynamic>> maps = await db.query('notifications');
//     return List.generate(maps.length, (i) => Notification.fromMap(maps[i]));
//   }

//   Future<void> insertNotification(Notification notification) async {
//     final db = await _databaseHelper.database;
//     await db.insert(
//       'notifications',
//       notification.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> updateNotification(Notification notification) async {
//     final db = await _databaseHelper.database;
//     await db.update(
//       'notifications',
//       notification.toMap(),
//       where: 'id = ?',
//       whereArgs: [notification.id],
//     );
//   }

//   Future<void> deleteNotification(int id) async {
//     final db = await _databaseHelper.database;
//     await db.delete(
//       'notifications',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<void> markAsRead(int id) async {
//     final db = await _databaseHelper.database;
//     await db.update(
//       'notifications',
//       {'is_read': 1},
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<void> markAllAsRead() async {
//     final db = await _databaseHelper.database;
//     await db.update(
//       'notifications',
//       {'is_read': 1},
//     );
//   }

//   Future<int> getUnreadCount() async {
//     final db = await _databaseHelper.database;
//     final result = await db.rawQuery(
//       'SELECT COUNT(*) as count FROM notifications WHERE is_read = 0',
//     );
//     return Sqflite.firstIntValue(result) ?? 0;
//   }
// }