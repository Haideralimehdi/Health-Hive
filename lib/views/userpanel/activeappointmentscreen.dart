// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor_app/views/userpanel/paymentmethod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import '../../model/appointmentmodel.dart';
import '../../utils/appconstant.dart';

class ActiveAppointments extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('appointments')
          .where('status', isEqualTo: 'pending')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error loading appointments"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No active appointments"));
        }

        final List<AppointmentModel> appointments = snapshot.data!.docs
            .map((doc) =>
                AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];

            return SwipeActionCell(
              key: ObjectKey(appointment.appointmentId),
              trailingActions: [
                SwipeAction(
                  title: "Cancel",
                  performsFirstActionWithFullSwipe: true,
                  onTap: (handler) async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .collection('appointments')
                        .doc(appointment.appointmentId)
                        .delete();

                    Get.snackbar(
                      "Deleted",
                      "Appointment cancelled successfully",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  },
                ),
              ],
              child: Card(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor Image
                      CircleAvatar(
                        radius: screenWidth * 0.08,
                        backgroundColor: Colors.grey[200],
                        child: ClipOval(
                          child: Image.network(
                            appointment.doctorImage,
                            fit: BoxFit.cover,
                            width: screenWidth * 0.16,
                            height: screenWidth * 0.16,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.person, size: screenWidth * 0.08),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),

                      // Expanded Detail Area
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.doctorName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text("Patient: ${appointment.patientName}",
                                style: TextStyle(fontSize: screenWidth * 0.035),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1),
                            Text(
                                "Date: ${appointment.appointmentDate.toLocal().toString().split(" ")[0]}",
                                style:
                                    TextStyle(fontSize: screenWidth * 0.035)),
                            Text("Time: ${appointment.appointmentTime}",
                                style:
                                    TextStyle(fontSize: screenWidth * 0.035)),
                            Text(
                                "Total: PKR ${appointment.totalAmount.toStringAsFixed(1)}",
                                style:
                                    TextStyle(fontSize: screenWidth * 0.035)),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              "Status: Pending",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.037),
                            ),
                          ],
                        ),
                      ),

                      // // Pay Now Button
                      // Column(
                      //   children: [
                      //     ElevatedButton(
                      //       onPressed: () {
                      //         Get.to(() => ChoosePaymentMethodScreen(
                      //               appointmentModel: appointment,
                      //             ));
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.green,
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: screenWidth * 0.03,
                      //             vertical: screenHeight * 0.012),
                      //       ),
                      //       child: Text("Pay Now",
                      //           style: TextStyle(
                      //               fontSize: screenWidth * 0.035,
                      //               color: Colors.white)),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
