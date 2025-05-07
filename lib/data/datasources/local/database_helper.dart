import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'hrms.db');
    return await openDatabase(
      path,
      version: 2, // Incremented version number
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createAllTables(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createEmailsTable(db);
    }
  }

  Future<void> _createAllTables(Database db) async {
    await _createAttendanceTable(db);
    await _createLeaveTable(db);
    await _createProfileTable(db);
    await _createNotificationsTable(db);
    await _createEmailsTable(db);
  }

  Future<void> _createAttendanceTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS attendance (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        check_in TEXT,
        check_out TEXT,
        status TEXT
      )
    ''');
  }

  Future<void> _createLeaveTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS leave (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        reason TEXT,
        status TEXT,
        type TEXT,
        created_at TEXT
      )
    ''');
  }

  Future<void> _createProfileTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT,
        department TEXT,
        position TEXT,
        join_date TEXT,
        photo TEXT
      )
    ''');
  }

  Future<void> _createNotificationsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        message TEXT,
        date TEXT,
        is_read INTEGER DEFAULT 0
      )
    ''');
  }

  Future<void> _createEmailsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS emails (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipient TEXT NOT NULL,
        subject TEXT NOT NULL,
        body TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        imagePaths TEXT NOT NULL,
        isSent INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // Add this method to check if table exists
  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'"
    );
    return result.isNotEmpty;
  }
}