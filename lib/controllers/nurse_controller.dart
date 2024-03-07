import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/Emergency.dart';

import '../service/database_service.dart';
import 'auth_controller.dart';

class NurseController extends GetxController {
  final DatabaseService _db = DatabaseService();
  final AuthController _authController = Get.find();
  get auth => _authController;

  final RxList<Emergency> emergencies = <Emergency>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmergencies();
  }

  void fetchEmergencies() async {
    String userId = _authController.firebaseUser.value!.uid;
    _db.streamEmergencies(userId).listen((data) {
      emergencies.value = data.cast<Emergency>();
    });
    print(emergencies.toString());
  }

  void markEmergencyAsAttended(String emergencyId) {
    _db.markEmergencyAsAttended(emergencyId);
    Get.snackbar('Success', "Patient Attended", snackPosition: SnackPosition.BOTTOM);
  }
}
