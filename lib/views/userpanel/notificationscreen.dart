import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../controller/doctor/doctor_notification_controller.dart';
import '../../controllers/doctornotifationcontroller.dart';

class DoctorNotificationScreen extends StatelessWidget {
  const DoctorNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorNotificationController());

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Obx(() {
        if (controller.appointments.isEmpty) {
          return const Center(child: Text("No pending appointments."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.appointments.length,
          itemBuilder: (context, index) {
            final a = controller.appointments[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Patient: ${a.patientName}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                        "Date: ${a.appointmentDate.toLocal().toString().split(' ')[0]}"),
                    Text("Time: ${a.appointmentTime}"),
                    Text("Total: Rs ${a.totalAmount.toStringAsFixed(2)}"),
                    Text("Status: ${a.status}",
                        style: TextStyle(
                            color: a.status == 'confirmed'
                                ? Colors.green
                                : Colors.orange)),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.confirmAppointment(a.appointmentId);
                          Get.snackbar("Success", "Appointment Confirmed");
                        },
                        child: const Text("Confirm"),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
