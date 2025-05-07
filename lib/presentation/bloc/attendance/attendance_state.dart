import 'package:hrms/domain/entities/attendance.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> attendances;
  final Attendance? todayAttendance;

  AttendanceLoaded({
    required this.attendances,
    this.todayAttendance,
  });
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}