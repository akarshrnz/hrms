import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String position;
  final String department;
  final DateTime joiningDate;
  final double salary;
  final String status;

  const Employee({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.position,
    required this.department,
    required this.joiningDate,
    required this.salary,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'position': position,
      'department': department,
      'joiningDate': joiningDate.toIso8601String(),
      'salary': salary,
      'status': status,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int?,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      position: map['position'] as String,
      department: map['department'] as String,
      joiningDate: DateTime.parse(map['joiningDate'] as String),
      salary: map['salary'] as double,
      status: map['status'] as String,
    );
  }

  Employee copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? position,
    String? department,
    DateTime? joiningDate,
    double? salary,
    String? status,
  }) {
    return Employee(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      position: position ?? this.position,
      department: department ?? this.department,
      joiningDate: joiningDate ?? this.joiningDate,
      salary: salary ?? this.salary,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        position,
        department,
        joiningDate,
        salary,
        status,
      ];
}