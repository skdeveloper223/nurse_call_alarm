import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../service/database_service.dart';

class AuthController extends GetxController {
  final DatabaseService _db = DatabaseService();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  String? email, password, userType;

  @override
  void onInit() {
    // firebaseUser.bindStream(_auth.authStateChanges());
    if (_auth.currentUser == "Patient")
      Get.offNamed("/patient");
    else
      Get.offNamed("/nurse");

    super.onInit();
  }

  void signIn() async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email!, password: password!);
      print(result.toString());
      Get.snackbar('Success', "Login Successfully", snackPosition: SnackPosition.BOTTOM);
      if (_auth.currentUser == "Patient")
        Get.offNamed("/patient");
      else
        Get.offNamed("/nurse");
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void register() async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email!.trim(), password: password!);
      await _auth.currentUser!.updateDisplayName(userType!);
      print(result.toString());
      print("result" + _auth.currentUser.toString());
      UserModel userModel = UserModel(id: _auth.currentUser!.uid, userType: userType!, email: email!.trim());
      await _db.createUser(userModel);
      Get.snackbar('Success', "Register Successfully", snackPosition: SnackPosition.BOTTOM);
      if (_auth.currentUser == "Patient")
        Get.offNamed("/patient");
      else
        Get.offNamed("/nurse");
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
