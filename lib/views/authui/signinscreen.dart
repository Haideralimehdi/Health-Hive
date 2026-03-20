// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors_in_immutables, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/signincontroller.dart';
import '../../controllers/usercontroller.dart';
import '../../model/usermodel.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';
import '../../widgets/authuiwidgets/customtextfieldwidget.dart';
import '../userpanel/homepage.dart';
import 'forgetpasswordscreen.dart';
import 'signupscreen.dart';

class SignIn extends StatefulWidget {
  SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final SignInController signInController = Get.put(SignInController());

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
                      "Sign In",
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => TextFormField(
                        controller: password,
                        obscureText: signInController.isPasswordVisible.value,
                        cursorColor: AppConstant.Appsecondarycolor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password,
                              color: AppConstant.Appsecondarycolor),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signInController.isPasswordVisible.toggle();
                            },
                            child: signInController.isPasswordVisible.value
                                ? Icon(Icons.visibility_off,
                                    color: AppConstant.Appsecondarycolor)
                                : Icon(Icons.visibility,
                                    color: AppConstant.Appsecondarycolor),
                          ),
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
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => Forgetpasswordscreen());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: AppConstant.Appsecondarycolor,
                            fontWeight: FontWeight.bold),
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
                    width: Get.width * 0.3,
                    height: Get.height * 0.05,
                    child: TextButton(
                      onPressed: () async {
                        String emailid = email.text.trim();
                        String pass = password.text.trim();

                        if (emailid.isEmpty || pass.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.Appsecondarycolor,
                            colorText: AppConstant.iconTextColor,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signInController.signInMethod(
                                  emailid, pass);

                          if (userCredential != null) {
                            if (userCredential.user!.emailVerified) {
                              Get.snackbar(
                                "Success User Login",
                                "login Successfully!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.Appsecondarycolor,
                                colorText: AppConstant.iconTextColor,
                              );
                              final UserController userController = Get.find<UserController>();
                              userController
                                  .loadUserData(userCredential.user!.uid);
                              Get.offAll(() => HomePage());
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please verify your email before login",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.Appsecondarycolor,
                                colorText: AppConstant.iconTextColor,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please try again",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.Appsecondarycolor,
                              colorText: AppConstant.iconTextColor,
                            );
                          }
                        }
                      },
                      child: Text(
                        "Sign In",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont' have an account? ",
                        // style: TextStyle(color: AppConstant.Appsecondarycolor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUp());
                        },
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                              color: AppConstant.Appsecondarycolor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
