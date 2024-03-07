import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patient_controller.dart';

class PatientScreen extends StatelessWidget {
  final PatientController controller = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Home'),
        actions: [
          IconButton(
              onPressed: () {
                controller.auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => controller.createEmergency('Emergency Type', 'Emergency Required'),
              child: const Text('Generate Emergency'),
            ),
          ],
        ),
      ),
    );
  }
}
