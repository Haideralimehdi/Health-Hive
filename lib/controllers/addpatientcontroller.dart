// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/appointmentmodel.dart';
import '../model/doctormodel.dart';
import '../model/patientmodel.dart';
import '../utils/appconstant.dart';
import '../views/userpanel/homepage.dart';
import '../views/userpanel/paymentmethod.dart';

class AddPatientController extends GetxController {
  var consultationFee = 0.0.obs;
  var bookingCharge = 2.50.obs;
  var hospitalCharge = 0.0.obs;

  // Add this observable for patientModel
  Rxn<PatientModel> selectedPatient = Rxn<PatientModel>();

  double get totalAmount =>
      consultationFee.value + bookingCharge.value + hospitalCharge.value;

  void setConsultationFee(double value) {
    consultationFee.value = value;
  }

  void setSelectedPatient(PatientModel patient) {
    selectedPatient.value = patient;
  }

  void clearSelectedPatient() {
    selectedPatient.value = null;
  }

  void saveAppointmentData({
    required DoctorModel doctor,
    required PatientModel patient,
    required selectedDate,
    required String selectedTime,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('appointments') // Changed collection name
          .doc(); // Auto ID for appointment

      final double consultationFee = double.tryParse(doctor.fee) ?? 0.0;
      final double hospitalCharge = 0.0;
      final double bookingCharge = 2.50; // You can adjust this value
      final double totalAmount =
          consultationFee + hospitalCharge + bookingCharge;

      // ✅ Create AppointmentModel instance
      final appointment = AppointmentModel(
        appointmentId: docRef.id,
        doctorId: doctor.userId,
        patientId: patient.patientId,
        doctorName: doctor.name,
        doctorImage: doctor.imageUrl,
        patientName: '${patient.firstName} ${patient.lastName}',
        appointmentDate: selectedDate,
        appointmentTime: selectedTime,
        consultationFee: consultationFee,
        hospitalCharge: hospitalCharge,
        bookingCharge: bookingCharge,
        totalAmount: totalAmount,
        status: 'pending',
      );

      // ✅ Save using model's toJson()
      await docRef.set(appointment.toJson());

      Get.snackbar("Success", "Appointment booked successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.Appsecondarycolor,
          colorText: Colors.white);

      // Navigate to confirmation or appointment summary screen
      // Example: Get.to(() => AppointmentConfirmationScreen(appointment: appointment));
     Get.offAll(()=> HomePage()); 
    } catch (e) {
      print("Error saving appointment data: $e");
      Get.snackbar("Error", "Failed to book appointment.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
