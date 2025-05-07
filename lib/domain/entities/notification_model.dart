class NotificationModel {
  final int id;
  final String? title;
  final String? message;
  final String? date;
  final bool isRead;

  NotificationModel({
    required this.id,
    this.title,
    this.message,
    this.date,
    this.isRead = false,
  });

  
  NotificationModel copyWith({
    int? id,
    String? title,
    String? message,
    String? date,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'date': date,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      date: json['date'],
      isRead: json['isRead'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Notification(id: $id, title: $title, message: $message, date: $date, isRead: $isRead)';
  }
}