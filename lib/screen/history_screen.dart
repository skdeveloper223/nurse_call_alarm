import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse_call_alarm/models/emergency.dart';

import '../controllers/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call History')),
      body: Obx(
        () => controller.histories.isEmpty
            ? const Center(
                child: Text("No Data Found"),
              )
            : ListView.builder(
                itemCount: controller.histories.length,
                itemBuilder: (context, index) {
                  Emergency emergency = controller.histories[index];
                  return ListTile(
                    title: Text('User email: ${emergency.type}'),
                    subtitle: Text(emergency.details),
                  );
                },
              ),
      ),
    );
  }
}
