import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model/appointmentmodel.dart';

class DoctorNotificationController extends GetxController {
  var appointments = <AppointmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }

  void fetchAppointments() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (!userDoc.exists || !(userDoc.data()?['isDoctor'] ?? false)) return;

    final doctorSnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('userId', isEqualTo: currentUser.uid)
        .limit(1)
        .get();

    if (doctorSnapshot.docs.isEmpty) return;

    final doctorId = doctorSnapshot.docs.first['userId'];

    final appointmentSnapshot = await FirebaseFirestore.instance
        .collectionGroup('appointments')
        .where('doctorId', isEqualTo: doctorId)
        .get();

    appointments.value = appointmentSnapshot.docs
        .map((doc) => AppointmentModel.fromJson(doc.data()))
        .where((a) => a.status == 'pending') // Show only pending
        .toList();
  }

  Future<void> confirmAppointment(String appointmentId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('appointments')
          .where('appointmentId', isEqualTo: appointmentId)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.update({'status': 'confirmed'});
      }

      fetchAppointments(); // 🔁 Refresh list after confirmation
    } catch (e) {
      print("Error confirming appointment: $e");
    }
  }
}
