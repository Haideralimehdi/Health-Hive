// lib/controllers/addpatientformcontroller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/doctormodel.dart';
import '../model/patientmodel.dart';
import '../utils/appconstant.dart';
import '../views/userpanel/addpatientscreen.dart';
import 'addpatientcontroller.dart';

class AddPatientFormController extends GetxController {
  var selectedGender = ''.obs;
  var selectedRelation = 'Self'.obs;

  void savePatientData({
    required String firstName,
    required String lastName,
    required String day,
    required String month,
    required String year,
    required DoctorModel doctor,
    DateTime? selectedDate,
    required String selectedTime,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('patients')
          .doc();
      // ✅ Create PatientModel instance
      final patient = PatientModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        patientId: docRef.id,
        firstName: firstName,
        lastName: lastName,
        dob: '$day-$month-$year',
        gender: selectedGender.value,
        relation: selectedRelation.value,
        createdAt: DateTime.now(),
      );

      // ✅ Save using model's toMap()
      await docRef.set(patient.toMap());

      Get.snackbar("Success", "Patient added successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.Appsecondarycolor,
          colorText: Colors.white);
// In AddPatientFormScreen, after patient data is filled:
      Get.find<AddPatientController>().setSelectedPatient(patient);
      Get.back();
      Get.off(() => AddPatientScreen(
            doctorModel: doctor,
            selectedTime: selectedTime,
            selectedDate: selectedDate,
            patientModel: patient,
          ));
    } catch (e) {
      Get.snackbar("Error", "Failed to save patient data.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
