import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../service/database_service.dart';
import 'auth_controller.dart';

class NurseController extends GetxController {
  final DatabaseService _db = DatabaseService();
  final AuthController _authController = Get.find();
  get auth => _authController;

  RxList<Emergency> emergencies = <Emergency>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmergencies();
  }

  void fetchEmergencies() async {
    _db.streamEmergencies().listen((data) {
      emergencies.value = data.cast<Emergency>();
    });
    print(emergencies.toString());
  }

  void markEmergencyAsAttended(String emergencyId) {
    String nurseId = _authController.firebaseUser.value!.uid;
    _db.markEmergencyAsAttended(emergencyId, nurseId);
    Get.snackbar('Success', "Patient Attended", snackPosition: SnackPosition.BOTTOM);
  }
}
