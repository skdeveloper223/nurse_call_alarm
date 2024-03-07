import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../controllers/nurse_controller.dart';

class NurseScreen extends StatelessWidget {
  final NurseController controller = Get.put(NurseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Home'),
        actions: [
          IconButton(
              onPressed: () {
                controller.auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.toNamed("/history");
            },
            child: const Text('History'),
          ),
          Expanded(
            child: Obx(
              () => controller.emergencies.isEmpty
                  ? const Center(
                      child: Text("No Data Found"),
                    )
                  : ListView.builder(
                      itemCount: controller.emergencies.length,
                      itemBuilder: (context, index) {
                        Emergency emergency = controller.emergencies[index];
                        return ListTile(
                          title: Text('User email: ${emergency.type}'),
                          subtitle: Text(emergency.details),
                          trailing: IconButton(
                            icon: Icon(emergency.attended ? Icons.clear : Icons.check),
                            onPressed: () => controller.markEmergencyAsAttended(emergency.id),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
