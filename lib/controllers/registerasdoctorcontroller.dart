// lib/controllers/doctor_registration_controller.dart

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/doctormodel.dart';

class DoctorRegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final qualificationController = TextEditingController();
  final specialtyController = TextEditingController();
  final experienceController = TextEditingController();
  final hospitalController = TextEditingController();
  final feeController = TextEditingController();
  final slotController = TextEditingController();

  var availableSlots = <String>[].obs;
  var isLoading = false.obs;

  void addSlot() {
    final slot = slotController.text.trim();
    if (slot.isNotEmpty) {
      availableSlots.add(slot);
      slotController.clear();
    }
  }

  void removeSlot(int index) {
    availableSlots.removeAt(index);
  }

  Future<void> registerDoctor(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Step 1: Check if user is already a doctor
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists && userDoc.data() != null) {
      final userData = userDoc.data()!;
      final isAlreadyDoctor = userData['isDoctor'] ?? false;

      if (isAlreadyDoctor) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You are already registered as a doctor.")),
        );
        return;
      }
    }

    // Step 2: Validate the form
    if (!formKey.currentState!.validate()) return;

    if (availableSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please add at least one slot")));
      return;
    }

    isLoading.value = true;

    try {
      final docId = FirebaseFirestore.instance.collection('doctors').doc().id;

      final doctor = DoctorModel(
        doctorId: docId,
        userId: userId,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        qualification: qualificationController.text.trim(),
        specialty: specialtyController.text.trim(),
        experience: experienceController.text.trim(),
        hospital: hospitalController.text.trim(),
        fee: feeController.text.trim(),
        imageUrl: '',
        rating: 0.0,
        availableslots: availableSlots,
      );

      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(docId)
          .set(doctor.toMap());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'isDoctor': true});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Doctor profile created successfully!")),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    qualificationController.dispose();
    specialtyController.dispose();
    experienceController.dispose();
    hospitalController.dispose();
    feeController.dispose();
    slotController.dispose();
    super.onClose();
  }
}
