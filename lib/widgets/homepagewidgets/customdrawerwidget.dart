// ignore_for_file: await_only_futures, sort_child_properties_last, avoid_print, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customnavcontroller.dart';
import '../../controllers/googlesignincontroller.dart';
import '../../utils/appconstant.dart';
import '../../views/authui/welcomescreen.dart';
import '../../views/userpanel/alldoctorscreen.dart';
import '../../views/userpanel/appointmentscreen.dart';
import '../../views/userpanel/bloodbankscreen.dart';
import '../../views/userpanel/homepage.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final NavigationController navController = Get.put(NavigationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInController googleSignInController =
      Get.put(GoogleSignInController());

  String userName = "User";
  String firstLetter = "U";

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null && data['username'] != null) {
          setState(() {
            userName = data['username'];
            firstLetter = userName.isNotEmpty ? userName[0].toUpperCase() : "U";
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("DrawerWidget build method called");
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  userName,
                  style: TextStyle(color: AppConstant.iconTextColor),
                ),
                subtitle: Text(
                  "Version 1.0.1",
                  style: TextStyle(color: AppConstant.iconTextColor),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.Appmaincolor,
                  child: Text(firstLetter, style: TextStyle(color: AppConstant.Appsecondarycolor)),
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: Colors.grey,
            ),
            // 👇 Your drawer items remain the same below this line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => HomePage());
                  navController.changeIndex(0);
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home", style: TextStyle(color: AppConstant.iconTextColor)),
                leading: Icon(Icons.home, color: AppConstant.iconTextColor),
                trailing: Icon(Icons.arrow_forward, color: AppConstant.iconTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => AllDoctorsScreen());
                  navController.changeIndex(2);
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("All Doctor", style: TextStyle(color: AppConstant.iconTextColor)),
                leading: Icon(Icons.person, color: AppConstant.iconTextColor),
                trailing: Icon(Icons.arrow_forward, color: AppConstant.iconTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => BloodBankScreen());
                  navController.changeIndex(3);
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Blood Bank", style: TextStyle(color: AppConstant.iconTextColor)),
                leading: Icon(Icons.bloodtype, color: AppConstant.iconTextColor),
                trailing: Icon(Icons.arrow_forward, color: AppConstant.iconTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  Get.to(() => AppointmentsScreen());
                  navController.changeIndex(1);
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Appointments", style: TextStyle(color: AppConstant.iconTextColor)),
                leading: Icon(Icons.calendar_today, color: AppConstant.iconTextColor),
                trailing: Icon(Icons.arrow_forward, color: AppConstant.iconTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () async {
                  await _auth.signOut();
                  await googleSignInController.signOut();
                  print("logout done");
                  Get.offAll(() => Welcomescreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Logout", style: TextStyle(color: AppConstant.iconTextColor)),
                leading: Icon(Icons.logout, color: AppConstant.iconTextColor),
                trailing: Icon(Icons.arrow_forward, color: AppConstant.iconTextColor),
              ),
            ),
          ],
        ),
        backgroundColor: AppConstant.Appsecondarycolor,
      ),
    );
  }
}
