import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../models/user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('user').add({
      'id': user.id,
      'userType': user.userType,
      'email': user.email,
    });
  }

  Future<void> createEmergency(Emergency emergency) async {
    await _db.collection('emergencies').add({
      'userId': emergency.userId,
      'type': emergency.type,
      'details': emergency.details,
      'attended': emergency.attended,
    });
  }

  Stream<List<Emergency>> streamEmergencies() {
    return _db.collection('emergencies').where('attended', isEqualTo: false).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Emergency(
              userId: doc['userId'],
              type: doc['type'],
              details: doc['details'],
              attended: doc['attended'],
            ))
        .toList());
  }

  Stream<List<Emergency>> streamHistories(String nurseId) {
    return _db.collection('emergencies').where(['nurseId', 'attended'], isEqualTo: [nurseId, true]).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Emergency(
              userId: doc['userId'],
              type: doc['type'],
              details: doc['details'],
              attended: doc['attended'],
            ))
        .toList());
  }

  Future<void> markEmergencyAsAttended(String emergencyId, id) async {
    await _db.collection('emergencies').doc(emergencyId).update({'attended': true, 'nurseId': id}).catchError((e) {
      print(e);
    });
  }
}
