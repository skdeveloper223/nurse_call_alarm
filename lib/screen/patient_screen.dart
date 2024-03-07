import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patient_controller.dart';

class PatientScreen extends StatelessWidget {
  final PatientController controller = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Home'),
        actions: [
          IconButton(
              onPressed: () {
                controller.auth!.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => controller.createEmergency('Emergency Type', 'Emergency Details'),
              child: Text('Generate Emergency'),
            ),
          ],
        ),
      ),
    );
  }
}
