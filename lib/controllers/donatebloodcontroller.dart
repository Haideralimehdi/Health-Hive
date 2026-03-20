// lib/controllers/addpatientformcontroller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/bloodbankmodel.dart';
import '../utils/appconstant.dart';
import '../views/userpanel/bloodbankscreen.dart';

class Donatebloodcontroller extends GetxController {
  var selectedBloodType = ''.obs;
  var selectedGender = ''.obs;

  void savedonatebloodData(
      {required String name,
      required String location,
      required String phone}) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('BloodBank').doc();
      // ✅ Create PatientModel instance
      final bloodbank = BloodDonorModel(
        donorId: docRef.id,
        name: name,
        phone: phone,
        bloodGroup: selectedBloodType.value,
        donorImage: "",
        location: location,
        city: "",
        isActive: true,
        gender: selectedGender.value,
        userId: FirebaseAuth.instance.currentUser!.uid,
      );

      // ✅ Save using model's toMap()
      await docRef.set(bloodbank.toMap());

// In AddPatientFormScreen, after patient data is filled:
      // Get.find<AddPatientController>().setSelectedPatient(patient);
      // Get.back();
      Get.off(() => BloodBankScreen());
      Get.snackbar("Success", "bloodbank added successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.Appsecondarycolor,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to save patient data.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
