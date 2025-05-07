import 'package:sqflite/sqflite.dart';
import '../../domain/entities/email_draft.dart';
import '../datasources/local/database_helper.dart';

class EmailRepository {
  final DatabaseHelper _databaseHelper;

  EmailRepository(this._databaseHelper);

  Future<List<EmailDraft>> getAllEmails() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('emails');
      return maps.map((map) => EmailDraft.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Failed to load emails: $e");
    }
  }

  Future<int> saveEmail(EmailDraft email) async {
    try {
      final db = await _databaseHelper.database;
      return await db.insert('emails', email.toMap());
    } catch (e) {
      throw Exception("Failed to save email: $e");
    }
  }

  Future<void> deleteEmail(int id) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(
        'emails',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Failed to delete email: $e");
    }
  }
}