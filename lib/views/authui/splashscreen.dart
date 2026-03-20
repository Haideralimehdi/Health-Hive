// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/getuserdatacontroller.dart';
import '../../controllers/googlesignincontroller.dart';
import '../../controllers/usercontroller.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';
import '../../widgets/authuiwidgets/customtextfieldwidget.dart';
import '../userpanel/homepage.dart';
import 'signupscreen.dart';
import 'welcomescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
      final GoogleSignInController  _googleSignInController=Get.put(GoogleSignInController());
  

        User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      loggdin(context);
    });
  }

  Future<void> loggdin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);
      final UserController userController = Get.find<UserController>();
      
userController.loadUserData(user!.uid);
        Get.offAll(() => HomePage());
      
    } else {
      
      Get.to(() => Welcomescreen());
    }
  }

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
        body: Container(
          // color: AppConstant.Appmaincolor,
          // color: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  // color: AppConstant.appSecondaryColor,
                  child: Image.asset(
                      "assets/images/c6e7253632e25d187186ae58039db1bf.png"),
                ),
              ),
             
              Container(
                 margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              width: Get.width,
                child: Text(
                  // textAlign: TextAlign.center,
                  "Welcome to Health Hives",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    // color: AppConstant.appTextColor,
                    color: AppConstant.Appsecondarycolor,
                  ),
                ),
              ),
             
             
             
            ],
          ),
        ),
      ),
    );
  }
}
