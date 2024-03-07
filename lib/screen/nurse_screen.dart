import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/Emergency.dart';

import '../controllers/nurse_controller.dart';

class NurseScreen extends StatelessWidget {
  final NurseController controller = Get.put(NurseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nurse Home')),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.emergencies.length,
          itemBuilder: (context, index) {
            Emergency emergency = controller.emergencies[index];
            return ListTile(
              title: Text('Emergency Type: ${emergency.type}'),
              subtitle: Text('Details: ${emergency.details}'),
              trailing: IconButton(
                icon: Icon(Icons.check),
                onPressed: () => controller.markEmergencyAsAttended(emergency.userId),
              ),
            );
          },
        ),
      ),
    );
  }
}
