class Attendance {
  final int? id;
  final String date;
  final String? checkIn;
  final String? checkOut;
  final String? status;

  Attendance({
    this.id,
    required this.date,
    this.checkIn,
    this.checkOut,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'check_in': checkIn,
      'check_out': checkOut,
      'status': status,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      date: map['date'],
      checkIn: map['check_in'],
      checkOut: map['check_out'],
      status: map['status'],
    );
  }
}