import 'package:sqflite/sqflite.dart';
import '../../domain/entities/attendance.dart';
import '../datasources/local/database_helper.dart';

class AttendanceRepository {
  final DatabaseHelper _databaseHelper;

  AttendanceRepository(this._databaseHelper);

  Future<List<Attendance>> getAttendances() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('attendance');
    return List.generate(maps.length, (i) => Attendance.fromMap(maps[i]));
  }

  Future<void> insertAttendance(Attendance attendance) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'attendance',
      attendance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAttendance(Attendance attendance) async {
    final db = await _databaseHelper.database;
    await db.update(
      'attendance',
      attendance.toMap(),
      where: 'id = ?',
      whereArgs: [attendance.id],
    );
  }

  Future<void> deleteAttendance(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'attendance',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Attendance?> getTodayAttendance() async {
    final db = await _databaseHelper.database;
    final today = DateTime.now().toIso8601String().split('T')[0];
    final List<Map<String, dynamic>> maps = await db.query(
      'attendance',
      where: 'date = ?',
      whereArgs: [today],
    );
    if (maps.isEmpty) return null;
    return Attendance.fromMap(maps.first);
  }
}