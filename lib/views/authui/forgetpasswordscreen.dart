// ignore_for_file: avoid_unnecessary_containers

// import 'package:doctor_app/views/userpanel/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/forgetpasswordcontroller.dart';
import '../../controllers/signincontroller.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';
import '../../widgets/authuiwidgets/customtextfieldwidget.dart';
import 'signupscreen.dart';

class Forgetpasswordscreen extends StatefulWidget {
  const Forgetpasswordscreen({super.key});

  @override
  State<Forgetpasswordscreen> createState() => _ForgetpasswordscreenState();
}

class _ForgetpasswordscreenState extends State<Forgetpasswordscreen> {
  final SignInController signInController = Get.put(SignInController());
  final ForgerPasswordController forgerPasswordController = Get.put(ForgerPasswordController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                    height: Get.height * 0.01,
                  ),
                  Container(
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        // color: AppConstant.appTextColor,
                        color: AppConstant.Appsecondarycolor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      cursorColor: AppConstant.Appsecondarycolor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email,
                            color: AppConstant.Appsecondarycolor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppConstant.Appsecondarycolor),
                        ),
                      ),
                    ),
                  ),
                 
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                 
                  Container(
                    decoration: BoxDecoration(
                      color: AppConstant.Appsecondarycolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: Get.width * 0.43,
                    height: Get.height * 0.055,
                    child: TextButton(
                      onPressed: () async {
                       
                          String emailid = email.text.trim();

                      if (emailid.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.Appsecondarycolor,
                          colorText: AppConstant.appTextColor,
                        );
                      } else {
                        String emailid = email.text.trim();
                        forgerPasswordController.ForgetPasswordMethod(emailid);
                      }
                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(color: AppConstant.iconTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        child: Text('connect with'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        width: Get.width * 0.14,
                        color: AppConstant.Appsecondarycolor,
                      ),
                      SizedBox(width: Get.width * 0.09),
                      Image.asset(
                        "assets/images/facebook.png",
                        width: Get.width * 0.14,
                        color: AppConstant.Appsecondarycolor,
                      ),
                      SizedBox(width: Get.width * 0.09),
                      Image.asset(
                        "assets/images/twitter.png",
                        width: Get.width * 0.14,
                        color: AppConstant.Appsecondarycolor,
                      ),
                    ],
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
