// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxInt notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotificationCount(); // initial call
  }

  Future<void> fetchNotificationCount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        notificationCount.value = 0;
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists || !(userDoc.data()?['isDoctor'] ?? false)) {
        notificationCount.value = 0;
        return;
      }

      final doctorSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('userId', isEqualTo: currentUser.uid)
          .limit(1)
          .get();

      if (doctorSnapshot.docs.isEmpty) {
        notificationCount.value = 0;
        return;
      }

      final doctorId = doctorSnapshot.docs.first['userId'];

      final appointmentSnapshot = await FirebaseFirestore.instance
          .collectionGroup('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .where('status', isEqualTo: 'pending')
          .get();

      notificationCount.value = appointmentSnapshot.size;
    } catch (e) {
      print("Error fetching notification count: $e");
      notificationCount.value = 0;
    }
  }
}
