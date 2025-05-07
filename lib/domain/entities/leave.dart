class Leave {
  final int? id;
  final String startDate;
  final String endDate;
  final String? reason;
  final String? status;
  final String? type;
  final String? createdAt;

  Leave({
    this.id,
    required this.startDate,
    required this.endDate,
    this.reason,
    this.status,
    this.type,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_date': startDate,
      'end_date': endDate,
      'reason': reason,
      'status': status,
      'type': type,
      'created_at': createdAt,
    };
  }

  factory Leave.fromMap(Map<String, dynamic> map) {
    return Leave(
      id: map['id'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      reason: map['reason'],
      status: map['status'],
      type: map['type'],
      createdAt: map['created_at'],
    );
  }
}