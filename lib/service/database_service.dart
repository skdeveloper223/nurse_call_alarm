import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../models/user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('user').add(user.toJson());
  }

  Future<void> createEmergency(Emergency emergency) async {
    await _db.collection('emergencies').add(emergency.toJson());
  }

  Stream<List<Emergency>> streamEmergencies() {
    return _db.collection('emergencies').where('attended', isEqualTo: false).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Emergency(
              id: doc['id'],
              userId: doc['userId'],
              nurseId: doc['nurseId'],
              type: doc['type'],
              details: doc['details'],
              attended: doc['attended'],
            ))
        .toList());
  }

  Stream<List<Emergency>> streamHistories(String nurseId) {
    return _db.collection('emergencies').where(['nurseId', 'attended'], isEqualTo: [nurseId, true]).snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Emergency(
              id: doc['id'],
              userId: doc['userId'],
              nurseId: doc['nurseId'],
              type: doc['type'],
              details: doc['details'],
              attended: doc['attended'],
            ))
        .toList());
  }

  Future<void> markEmergencyAsAttended(String emergencyId, id) async {
    // await _db.collection('emergencies').doc(emergencyId).update({'attended': true, 'nurseId': id}).catchError((e) {
    //   print(e);
    // });

    try {
      // Query for emergencies for a specific user
      var querySnapshot = await _db.collection('emergencies').where('id', isEqualTo: emergencyId).get();

      // Loop through the documents and update each one
      for (var doc in querySnapshot.docs) {
        await doc.reference.update({'attended': true, 'nurseId': id});
        print('Emergency marked as attended for user: $id');
      }
    } catch (e) {
      print('Error marking emergency as attended for user: $id, Error: $e');
    }
  }
}
