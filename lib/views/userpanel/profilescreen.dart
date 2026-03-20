// ignore_for_file: unused_import, deprecated_member_use, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/customnavcontroller.dart';
import '../../controllers/googlesignincontroller.dart';
import '../../utils/appconstant.dart';
import '../../widgets/customnavigationbar.dart';
import '../../widgets/homepagewidgets/profileoptiontilewidget.dart';
import '../authui/forgetpasswordscreen.dart';
import '../authui/welcomescreen.dart';
import 'notificationscreen.dart';
import 'registerdoctorscreen.dart';

class ProfileScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());
  final GoogleSignInController googleSignInController =
      Get.put(GoogleSignInController());

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  void showEditBottomSheet({
    required BuildContext context,
    required String title,
    required String currentValue,
    required String fieldKey,
  }) {
    final _controller = TextEditingController(text: currentValue);
    final uid = FirebaseAuth.instance.currentUser!.uid;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit $title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 12),
            TextField(
              cursorColor: AppConstant.Appsecondarycolor,
              controller: _controller,
              decoration: InputDecoration(
                labelText: title,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: AppConstant.Appsecondarycolor),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary: AppConstant.Appsecondarycolor,
                backgroundColor: AppConstant.Appsecondarycolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                final newValue = _controller.text.trim();
                if (newValue.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({
                    fieldKey: newValue,
                  });
                  Get.back(); // Close bottom sheet
                  Get.snackbar("Success", "$title updated successfully");
                }
              },
              child: Text("Save",
                  style: TextStyle(
                      color: Colors.white, fontSize: Get.width * 0.04)),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.previousRoute == '/home') {
          navController.changeIndex(0);
        } else if (Get.previousRoute == '/appointments') {
          navController.changeIndex(1);
        } else if (Get.previousRoute == '/doctors') {
          navController.changeIndex(2);
        } else if (Get.previousRoute == '/Bloodbankscreen') {
          navController.changeIndex(3);
        } else {
          navController.changeIndex(0);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppConstant.Appmaincolor,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          title: Text("Profile",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: AppConstant.Appsecondarycolor,
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                !snapshot.data!.exists) {
              return Center(child: Text("Failed to load user data"));
            }

            final userData = snapshot.data!.data()!;
            final username = userData['username'] ?? "No Name";
            final email = userData['email'] ?? "No Email";
            final city = userData['city'] ?? "No City";

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: Get.width * 0.1,
                    child: Icon(Icons.person, size: 25, color: Colors.white),
                    backgroundColor: AppConstant.Appsecondarycolor,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  Text(username,
                      style: TextStyle(
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.bold)),
                  Text(email,
                      style: TextStyle(
                          color: Colors.grey, fontSize: Get.width * 0.04)),
                  Text(city,
                      style: TextStyle(
                          color: Colors.grey, fontSize: Get.width * 0.04)),
                  // SizedBox(height: Get.height * 0.02),

                  ProfileOptionTile(
                    icon: Icons.medical_services,
                    title: "Register As A Doctor",
                    onTap: () {
                      Get.to(() => RegisterAsDoctorScreen());
                    },
                  ),
                  ProfileOptionTile(
                    icon: Icons.notifications,
                    title: "Notifications",
                    onTap: () {
                      Get.to(() => DoctorNotificationScreen());
                    },
                  ),
                  ProfileOptionTile(
                    icon: Icons.edit,
                    title: "Edit Name",
                    onTap: () {
                      showEditBottomSheet(
                        context: context,
                        title: "Name",
                        currentValue: username,
                        fieldKey: "username",
                      );
                    },
                  ),
                  ProfileOptionTile(
                    icon: Icons.phone,
                    title: "Change Contact",
                    onTap: () {
                      showEditBottomSheet(
                        context: context,
                        title: "Contact",
                        currentValue: userData['contact'] ?? "",
                        fieldKey: "contact",
                      );
                    },
                  ),
                  ProfileOptionTile(
                      icon: Icons.location_on,
                      title: "Change Location",
                      onTap: () {
                        showEditBottomSheet(
                          context: context,
                          title: "Location",
                          currentValue: city,
                          fieldKey: "city",
                        );
                      }),
                  ProfileOptionTile(
                    icon: Icons.lock,
                    title: "Change Password",
                    onTap: () {
                      Get.to(() => Forgetpasswordscreen());
                    },
                  ),
                  ProfileOptionTile(
                    icon: Icons.delete,
                    title: "Delete Account",
                    onTap: () {
                      showDialog(
                        context: Get.context!,
                        builder: (context) => AlertDialog(
                          title: Text("Confirm"),
                          content: Text(
                              "Are you sure you want to delete your account?"),
                          actions: [
                            TextButton(
                              child: Text("No"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: Text("Yes"),
                              onPressed: () async {
                                Navigator.of(context).pop(); // Close dialog

                                final user = FirebaseAuth.instance.currentUser;
                                final uid = user!.uid;

                                try {
                                  // Delete all doctor documents created by this user
                                  final doctorDocs = await FirebaseFirestore
                                      .instance
                                      .collection('doctors')
                                      .where('userId', isEqualTo: uid)
                                      .get();

                                  for (var doc in doctorDocs.docs) {
                                    await doc.reference.delete();
                                  }

                                  // Delete all blood donor records created by this user
                                  final donorDocs = await FirebaseFirestore
                                      .instance
                                      .collection('BloodBank')
                                      .where('userId', isEqualTo: uid)
                                      .get();

                                  for (var doc in donorDocs.docs) {
                                    await doc.reference.delete();
                                  }

                                  // Delete user document
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .delete();

                                  // Delete user auth account
                                  await user.delete();

                                  // Sign out from Google
                                  await googleSignInController.signOut();

                                  Get.offAll(() => Welcomescreen());
                                  Get.snackbar("Deleted",
                                      "Your account and related data have been deleted.");
                                } catch (e) {
                                  print("Error: $e");
                                  Get.snackbar(
                                      "Error", "Failed to delete account.");
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  ProfileOptionTile(
                    icon: Icons.question_answer,
                    title: "FAQs",
                    onTap: () {},
                  ),
                  ProfileOptionTile(
                    icon: Icons.info,
                    title: "About Us",
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      await googleSignInController.signOut();
                      Get.offAll(() => Welcomescreen());
                    },
                    child: Text("Logout",
                        style: TextStyle(
                            color: Colors.red, fontSize: Get.width * 0.045)),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomNavigationBar(),
      ),
    );
  }
}
