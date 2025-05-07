import 'package:hrms/domain/entities/leave.dart';

abstract class LeaveState {}

class LeaveInitial extends LeaveState {}

class LeaveLoading extends LeaveState {}

class LeaveLoaded extends LeaveState {
  final List<Leave> leaves;

  LeaveLoaded({required this.leaves});
}

class LeaveError extends LeaveState {
  final String message;

  LeaveError(this.message);
}