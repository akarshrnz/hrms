import 'package:sqflite/sqflite.dart';
import '../../domain/entities/leave.dart';
import '../datasources/local/database_helper.dart';

class LeaveRepository {
  final DatabaseHelper _databaseHelper;

  LeaveRepository(this._databaseHelper);

  Future<List<Leave>> getLeaves() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('leave');
    return List.generate(maps.length, (i) => Leave.fromMap(maps[i]));
  }

  Future<void> insertLeave(Leave leave) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'leave',
      leave.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateLeave(Leave leave) async {
    final db = await _databaseHelper.database;
    await db.update(
      'leave',
      leave.toMap(),
      where: 'id = ?',
      whereArgs: [leave.id],
    );
  }

  Future<void> deleteLeave(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'leave',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Leave?> getLeaveById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'leave',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Leave.fromMap(maps.first);
  }
}