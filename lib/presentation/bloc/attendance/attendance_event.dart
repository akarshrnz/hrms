abstract class AttendanceEvent {}

class GetAttendances extends AttendanceEvent {}

class GetTodayAttendance extends AttendanceEvent {}

class CheckIn extends AttendanceEvent {
  final String date;
  final String time;

  CheckIn({required this.date, required this.time});
}

class CheckOut extends AttendanceEvent {
  final String date;
  final String time;

  CheckOut({required this.date, required this.time});
}