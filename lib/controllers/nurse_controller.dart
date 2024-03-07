import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../service/database_service.dart';
import 'auth_controller.dart';

class NurseController extends GetxController {
  final DatabaseService _db = DatabaseService();
  final AuthController _authController = Get.find();
  get auth => _authController;

  RxList<Emergency> emergencies = <Emergency>[].obs;
  final AudioPlayer audioplayer = AudioPlayer();
  @override
  void onInit() {
    super.onInit();
    fetchEmergencies();
  }

  void fetchEmergencies() async {
    _db.streamEmergencies().listen((data) {
      audioplayer.setAsset("sound/noti.mp3");
      audioplayer.setClip(start: Duration(seconds: 0), end: Duration(seconds: 60));
      audioplayer.play();
      emergencies.value = data.cast<Emergency>();
    });
    print(emergencies.toString());
  }

  void markEmergencyAsAttended(String emergencyId) {
    audioplayer.pause();
    String nurseId = _authController.firebaseUser.value!.uid;
    _db.markEmergencyAsAttended(emergencyId, nurseId);
    Get.snackbar('Success', "Patient Attended", snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void dispose() {
    audioplayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
