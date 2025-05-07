abstract class LeaveEvent {}

class GetLeaves extends LeaveEvent {}

class AddLeave extends LeaveEvent {
  final String startDate;
  final String endDate;
  final String? reason;
  final String? type;

  AddLeave({
    required this.startDate,
    required this.endDate,
    this.reason,
    this.type,
  });
}

class UpdateLeave extends LeaveEvent {
  final int id;
  final String startDate;
  final String endDate;
  final String? reason;
  final String? type;

  UpdateLeave({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.reason,
    this.type,
  });
}

class DeleteLeave extends LeaveEvent {
  final int id;

  DeleteLeave({required this.id});
}