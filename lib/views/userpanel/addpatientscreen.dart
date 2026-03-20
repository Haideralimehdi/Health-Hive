// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/addpatientcontroller.dart';
import '../../controllers/addpatientformcontroller.dart';
import '../../model/doctormodel.dart';
import '../../model/patientmodel.dart';
import '../../utils/appconstant.dart';
import '../../widgets/existingpatientbottomsheet.dart';
import 'addpatientformscreen.dart';
import 'paymentmethod.dart';

class AddPatientScreen extends StatefulWidget {
  final DoctorModel doctorModel;
  String selectedTime;
  DateTime? selectedDate;
  final PatientModel? patientModel;

  AddPatientScreen({
    required this.doctorModel,
    required this.selectedTime,
    required this.selectedDate,
    this.patientModel,
  });

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final AddPatientController controller = Get.put(AddPatientController());

  @override
  void initState() {
    super.initState();
    controller
        .setConsultationFee(double.tryParse(widget.doctorModel.fee) ?? 0.0);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Proceed", style: TextStyle(color: Colors.white)),
        backgroundColor: AppConstant.Appsecondarycolor,
        leading: BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: Get.width * 0.08,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: Image.network(
                      widget.doctorModel.imageUrl,
                      fit: BoxFit.cover,
                      width: Get.width * 0.16,
                      height: Get.width * 0.16,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: Get.width * 0.08,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.doctorModel.name,
                          style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold)),
                      Text(widget.doctorModel.specialty,
                          style: TextStyle(fontSize: screenWidth * 0.035)),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: screenWidth * 0.04, color: Colors.grey),
                          SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              widget.doctorModel.hospital,
                              style: TextStyle(fontSize: screenWidth * 0.032),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            // Patient Details
            Text("Patient Details",
                style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600)),

            SizedBox(height: 10),

            Obx(
              () => controller.selectedPatient.value == null
                  ? GestureDetector(
                      onTap: () async {
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        final patientDocs = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('patients')
                            .get();

                        if (patientDocs.docs.isNotEmpty) {
                          // Show existing patients in dialog
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (_) => ExistingPatientsBottomSheet(
                              patientDocs: patientDocs.docs,
                              doctorModel: widget.doctorModel,
                              selectedTime: widget.selectedTime,
                              selectedDate: widget.selectedDate,
                            ),
                          );
                        } else {
                          // No patient exists, go to add form
                          Get.to(() => AddPatientFormScreen(
                                doctorModel: widget.doctorModel,
                                selectedTime: widget.selectedTime,
                                selectedDate: widget.selectedDate,
                              ));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: AppConstant.Appsecondarycolor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.person_add_alt_1,
                                size: Get.width * 0.08, color: Colors.white),
                            SizedBox(height: 5),
                            Text("Add Patient",
                                style: TextStyle(
                                    fontSize: Get.width * 0.04,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow("FirstName",
                              controller.selectedPatient.value!.firstName),
                          _buildInfoRow("LastName",
                              controller.selectedPatient.value!.lastName),
                          _buildInfoRow("Gender",
                              controller.selectedPatient.value!.gender),
                          _buildInfoRow("Booking For",
                              controller.selectedPatient.value!.relation),
                        ],
                      ),
                    ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Payment Details
            Text("Payment Details",
                style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 10),

            Obx(() => Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      _buildRow("Consultation Fee",
                          controller.consultationFee.toStringAsFixed(2)),
                      _buildRow("Booking Charge",
                          controller.bookingCharge.value.toStringAsFixed(2)),
                      _buildRow(
                          "Hospital Charge",
                          controller.hospitalCharge.value == 0.0
                              ? "--"
                              : controller.hospitalCharge.value
                                  .toStringAsFixed(2)),
                      Divider(thickness: 1),
                      _buildRow("Total Amount",
                          controller.totalAmount.toStringAsFixed(2),
                          isBold: true),
                    ],
                  ),
                )),

            SizedBox(height: screenHeight * 0.02),

            Center(
              child: Text(
                "Terms And Conditions\nThe Document Governing The Contractual Relationship Between The Provider Of A Service And Its User.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: screenWidth * 0.03, color: Colors.grey[600]),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
        child: ElevatedButton(
          onPressed: () {
            if (controller.selectedPatient.value != null) {
              controller.saveAppointmentData(
                doctor: widget.doctorModel,
                patient: controller.selectedPatient.value!,
                selectedDate: widget.selectedDate,
                selectedTime: widget.selectedTime,
              );
              // controller.clearSelectedPatient();
            } else {
              Get.snackbar(
                  "Error", "Please select a patient before proceeding.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstant.Appsecondarycolor,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text("Book Appointment",
              style: TextStyle(
                  fontSize: screenWidth * 0.045, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: Get.width * 0.035,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(amount,
              style: TextStyle(
                  fontSize: Get.width * 0.035,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text("$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis)),
      ],
    ),
  );
}
