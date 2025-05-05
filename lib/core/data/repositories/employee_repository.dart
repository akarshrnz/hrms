import 'package:hrms/core/data/database/database_helper.dart';
import 'package:hrms/core/data/models/employee_model.dart';

class EmployeeRepository {
  final DatabaseHelper _databaseHelper;

  EmployeeRepository({DatabaseHelper? databaseHelper})
      : _databaseHelper = databaseHelper ?? DatabaseHelper();

  Future<List<Employee>> getAllEmployees() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    return List.generate(maps.length, (i) => Employee.fromMap(maps[i]));
  }

  Future<Employee> getEmployeeById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      throw Exception('Employee not found');
    }
    return Employee.fromMap(maps.first);
  }

  Future<int> addEmployee(Employee employee) async {
    final db = await _databaseHelper.database;
    return await db.insert('employees', employee.toMap());
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Employee>> searchEmployees(String query) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      where: 'firstName LIKE ? OR lastName LIKE ? OR email LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) => Employee.fromMap(maps[i]));
  }

  Future<Map<String, int>> getDepartmentStats() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT department, COUNT(*) as count
      FROM employees
      GROUP BY department
    ''');
    return Map.fromEntries(
      maps.map((map) => MapEntry(map['department'] as String, map['count'] as int)),
    );
  }
}