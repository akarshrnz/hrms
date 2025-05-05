import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/core/data/repositories/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;

  EmployeeBloc({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(EmployeeInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
    on<SearchEmployees>(_onSearchEmployees);
  }

  Future<void> _onLoadEmployees(
      LoadEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      final employees = await _employeeRepository.getAllEmployees();
      final departmentStats = await _employeeRepository.getDepartmentStats();
      emit(EmployeeLoaded(employees, departmentStats));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  Future<void> _onAddEmployee(
      AddEmployee event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    if (currentState is EmployeeLoaded) {
      emit(EmployeeLoading());
      try {
        await _employeeRepository.addEmployee(event.employee);
        final employees = await _employeeRepository.getAllEmployees();
        final departmentStats = await _employeeRepository.getDepartmentStats();
        emit(EmployeeLoaded(employees, departmentStats));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateEmployee(
      UpdateEmployee event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    if (currentState is EmployeeLoaded) {
      emit(EmployeeLoading());
      try {
        await _employeeRepository.updateEmployee(event.employee);
        final employees = await _employeeRepository.getAllEmployees();
        final departmentStats = await _employeeRepository.getDepartmentStats();
        emit(EmployeeLoaded(employees, departmentStats));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteEmployee(
      DeleteEmployee event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    if (currentState is EmployeeLoaded) {
      emit(EmployeeLoading());
      try {
        await _employeeRepository.deleteEmployee(event.employeeId);
        final employees = await _employeeRepository.getAllEmployees();
        final departmentStats = await _employeeRepository.getDepartmentStats();
        emit(EmployeeLoaded(employees, departmentStats));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    }
  }

  Future<void> _onSearchEmployees(
      SearchEmployees event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    if (currentState is EmployeeLoaded) {
      emit(EmployeeLoading());
      try {
        final employees = await _employeeRepository.searchEmployees(event.query);
        final departmentStats = await _employeeRepository.getDepartmentStats();
        emit(EmployeeLoaded(employees, departmentStats));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    }
  }
}
