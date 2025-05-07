class EmailDraft {
  final int? id;
  final String recipient;
  final String subject;
  final String body;
  final DateTime createdAt;
  final List<String> imagePaths;
  final bool isSent;

  EmailDraft({
    this.id,
    required this.recipient,
    required this.subject,
    required this.body,
    DateTime? createdAt,
    required this.imagePaths,
    this.isSent = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipient': recipient,
      'subject': subject,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'imagePaths': imagePaths.join('||'),
      'isSent': isSent ? 1 : 0,
    };
  }

  factory EmailDraft.fromMap(Map<String, dynamic> map) {
    return EmailDraft(
      id: map['id'],
      recipient: map['recipient'],
      subject: map['subject'],
      body: map['body'],
      createdAt: DateTime.parse(map['createdAt']),
      imagePaths: (map['imagePaths'] as String).split('||'),
      isSent: map['isSent'] == 1,
    );
  }
}