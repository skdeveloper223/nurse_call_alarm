class Emergency {
  final String userId;
  final String nurseId;
  final String type;
  final String details;
  final bool attended;

  Emergency({required this.userId, required this.type, required this.details, this.attended = false, this.nurseId = ""});
}
