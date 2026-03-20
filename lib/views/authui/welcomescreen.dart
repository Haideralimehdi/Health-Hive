// ignore_for_file: avoid_unnecessary_containers
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/googlesignincontroller.dart';
import '../../controllers/usercontroller.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';
import 'signinscreen.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: AppConstant.Appmaincolor,
        // appBar: AppBar(
        //   backgroundColor: AppConstant.Appmaincolor,
        // ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            // color: AppConstant.Appmaincolor,
            // color: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.025, vertical: Get.height * 0.05),
              child: Column(
                children: [
                  Container(
                    // color: Colors.black,
                    height: Get.height * 0.16,
                    alignment: Alignment.center,
                    // color: AppConstant.appSecondaryColor,
                    child: Image.asset(
                        "assets/images/c6e7253632e25d187186ae58039db1bf.png"),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(80), // high value for circle
                    child: Image.asset(
                      "assets/images/welcomescreen.jpg",
                      // width: ,
                      height: Get.height * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    child: Text(
                      textAlign: TextAlign.center,
                      "book your nearest hospitals doctor on your time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        // color: AppConstant.appTextColor,
                        color: AppConstant.Appsecondarycolor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppConstant.Appsecondarycolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: Get.width * 0.4,
                    height: Get.height * 0.055,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => SignIn());
                      },
                      child: Text(
                        "SignIn with Email",
                        style: TextStyle(color: AppConstant.iconTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppConstant.Appsecondarycolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: Get.width * 0.4,
                    height: Get.height * 0.055,
                    child: TextButton(
                      onPressed: () async {
                        _googleSignInController.signInWithGoogle();
                        // After user logs in
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        await Get.find<UserController>().loadUserData(uid);
                      },
                      child: Text(
                        "SignIn with google",
                        style: TextStyle(color: AppConstant.iconTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
