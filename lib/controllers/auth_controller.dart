import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  String? email, password, userType;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  void signIn() async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email!, password: password!);
      print(result.toString());
      Get.snackbar('Success', "Login Successfully", snackPosition: SnackPosition.BOTTOM);
      Get.toNamed("/patient");
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void register() async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      await _auth.currentUser!.updateDisplayName(userType!);
      print(result.toString());
      Get.snackbar('Success', "Register Successfully", snackPosition: SnackPosition.BOTTOM);
      Get.toNamed("/nurse");
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
