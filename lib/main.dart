import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_call_alarm/screen/login_screen.dart';
import 'package:nurse_call_alarm/screen/patient_screen.dart';
import 'package:nurse_call_alarm/screen/register_screen.dart';

import 'controllers/auth_controller.dart';
import 'controllers/nurse_controller.dart';
import 'controllers/patient_controller.dart';
import 'screen/nurse_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginScreen(),
          binding: BindingsBuilder(() {
            Get.put<AuthController>(AuthController());
          }),
        ),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(
          name: '/patient',
          page: () => PatientScreen(),
          binding: BindingsBuilder(() {
            Get.put<PatientController>(PatientController());
          }),
        ),
        GetPage(
          name: '/nurse',
          page: () => NurseScreen(),
          binding: BindingsBuilder(() {
            Get.put<NurseController>(NurseController());
          }),
        ),
      ],
    );
  }
}
