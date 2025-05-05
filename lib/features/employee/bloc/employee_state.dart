import 'package:equatable/equatable.dart';
import 'package:hrms/core/data/models/employee_model.dart';

abstract class EmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;
  final Map<String, int> departmentStats;

  EmployeeLoaded(this.employees, this.departmentStats);

  @override
  List<Object?> get props => [employees, departmentStats];
}

class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
