import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../service/database_service.dart';
import 'auth_controller.dart';

class PatientController extends GetxController {
  final DatabaseService _db = DatabaseService();
  final AuthController _authController = Get.find();

  Future<void> createEmergency(String type, String details) async {
    String userId = _authController.firebaseUser.value!.uid;
    Emergency emergency = Emergency(userId: userId, type: type, details: details);
    await _db.createEmergency(emergency);
  }
}