import 'package:firebase_auth/firebase_auth.dart';
import 'package:nurse_call_alarm/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserModel?> user(userType) {
    return _auth.authStateChanges().map((user) {
      if (user == null) {
        return null;
      } else {
        return UserModel(id: user.uid, email: user.email!, userType: userType); // Set default user type as patient
      }
    });
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Sign in successful
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  Future<String?> registerWithEmailAndPassword(String email, String password, String userType) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser!.updateDisplayName(userType); // Set user's display name as userType
      return null; // Registration successful
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
