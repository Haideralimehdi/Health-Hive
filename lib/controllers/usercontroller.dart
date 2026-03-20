// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/usermodel.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reactive user model to hold current user data
  Rxn<UserModel> userModel = Rxn<UserModel>();

  // Fetch user data by UID
  Future<void> loadUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        userModel.value = UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        Get.snackbar("Error", "User data not found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data: $e");
    }
  }

  // Clear user data when logging out
  void clearUserData() {
    userModel.value = null;
  }
}
