class Emergency {
  final String id;
  final String userId;
  final String nurseId;
  final String type;
  final String details;
  final bool attended;

  Emergency({required this.id, required this.userId, required this.type, required this.details, this.attended = false, this.nurseId = ""});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'details': details,
      'attended': attended,
      'nurseId': nurseId,
    };
  }
}
