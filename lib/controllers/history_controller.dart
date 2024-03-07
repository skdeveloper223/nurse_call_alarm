import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../service/database_service.dart';
import 'auth_controller.dart';

class HistoryController extends GetxController {
  final DatabaseService _db = DatabaseService();
  RxList<Emergency> histories = <Emergency>[].obs;

  void fetchHistories() async {
    try {
      String nurseId = FirebaseAuth.instance.currentUser!.uid;
      _db.streamHistories(nurseId).listen((data) {
        histories.value = data.cast<Emergency>();
      });
    } catch (e) {
      print("oooooooooooppoooopppp " + e.toString());
    }
  }

  @override
  void onReady() {
    fetchHistories();
    // TODO: implement onReady
    super.onReady();
  }
}
