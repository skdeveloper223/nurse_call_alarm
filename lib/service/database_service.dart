import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createEmergency(Emergency emergency) async {
    await _db.collection('emergencies').add({
      'userId': emergency.userId,
      'type': emergency.type,
      'details': emergency.details,
      'attended': emergency.attended,
    });
  }

  Stream<List<Emergency>> streamEmergencies(String userId) {
    return _db.collection('emergencies').where('userId', isEqualTo: userId).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Emergency(
              userId: doc['userId'],
              type: doc['type'],
              details: doc['details'],
              attended: doc['attended'],
            ))
        .toList());
  }

  Future<void> markEmergencyAsAttended(String emergencyId) async {
    await _db.collection('emergencies').doc(emergencyId).update({'attended': true});
  }
}
