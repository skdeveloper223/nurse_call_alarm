import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../service/database_service.dart';
import 'auth_controller.dart';

class HistoryController extends GetxController {
  final DatabaseService _db = DatabaseService();
  final AuthController _authController = Get.put<AuthController>(AuthController());
  get auth => _authController;

  RxList<Emergency> histories = <Emergency>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistories();
  }

  void fetchHistories() async {
    String nurseId = _authController.firebaseUser.value!.uid;
    _db.streamHistories(nurseId).listen((data) {
      histories.value = data.cast<Emergency>();
    });
    print(histories.toString());
  }
}
