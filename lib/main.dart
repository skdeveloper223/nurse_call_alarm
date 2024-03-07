import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_call_alarm/screen/login_screen.dart';
import 'package:nurse_call_alarm/screen/patient_screen.dart';
import 'package:nurse_call_alarm/screen/register_screen.dart';

import 'screen/nurse_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/patient', page: () => PatientScreen()),
        GetPage(name: '/nurse', page: () => NurseScreen()),
      ],
    );
  }
}
