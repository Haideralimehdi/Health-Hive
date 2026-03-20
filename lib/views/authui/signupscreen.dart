// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../utils/managekeyboard.dart';
import '../../controllers/googlesignincontroller.dart';
import '../../controllers/signupcontroller.dart';
import '../../utils/appconstant.dart';
import '../../widgets/authuiwidgets/customtextfieldwidget.dart';
import 'signinscreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());
  final SignUpController _signUpController = Get.put(SignUpController());

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return GestureDetector(
          onTap: () {
            KeyboardUtil.hideKeyboard(context);
          },
          child: Scaffold(
            backgroundColor: AppConstant.Appmaincolor,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.025,
                      vertical: Get.height * 0.05),
                  child: Column(
                    children: [
                      // image icon
                      isKeyboardVisible
                          ? SizedBox.shrink()
                          : Container(
                              height: Get.height * 0.16,
                              alignment: Alignment.center,
                              child: Image.asset(
                                  "assets/images/c6e7253632e25d187186ae58039db1bf.png"),
                            ),

                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            // color: AppConstant.appTextColor,
                            color: AppConstant.Appsecondarycolor,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: Get.height * 0.02,
                      // ),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: username,
                          cursorColor: AppConstant.Appsecondarycolor,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "UserName",
                            prefixIcon: Icon(Icons.person,
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

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(
                      //     controller: city,
                      //     cursorColor: AppConstant.Appsecondarycolor,
                      //     keyboardType: TextInputType.streetAddress,
                      //     decoration: InputDecoration(
                      //       hintText: "City",
                      //       prefixIcon: Icon(Icons.location_pin,
                      //           color: AppConstant.Appsecondarycolor),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //         borderSide: const BorderSide(
                      //             color: AppConstant.Appsecondarycolor),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: phone,
                          cursorColor: AppConstant.Appsecondarycolor,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            prefixIcon: Icon(Icons.phone,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => TextFormField(
                            controller: password,
                            obscureText:
                                _signUpController.isPasswordVisible.value,
                            cursorColor: AppConstant.Appsecondarycolor,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password,
                                  color: AppConstant.Appsecondarycolor),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _signUpController.isPasswordVisible.toggle();
                                },
                                child: _signUpController.isPasswordVisible.value
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
                      Container(
                        decoration: BoxDecoration(
                          color: AppConstant.Appsecondarycolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: Get.width * 0.3,
                        height: Get.height * 0.05,
                        child: TextButton(
                          onPressed: () async {
                            String name = username.text.trim();
                            String emailId = email.text.trim();
                            String phonenumber = phone.text.trim();
                            String pass = password.text.trim();
                            String deviceToken = "";
                            if (name.isEmpty ||
                                emailId.isEmpty ||
                                phonenumber.isEmpty ||
                                pass.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Please enter all details",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: AppConstant.iconTextColor,
                              );
                            } else {
                              UserCredential? userCredential =
                                  await _signUpController.signUpMethod(
                                      name, emailId, phonenumber, pass, "");

                              if (userCredential != null) {
                                Get.snackbar(
                                  "Verification email sent.",
                                  "Please check your email.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstant.Appsecondarycolor,
                                  colorText: AppConstant.iconTextColor,
                                );

                                FirebaseAuth.instance.signOut();
                                Get.offAll(() => SignIn());
                              }
                            }
                          },
                          child: Text(
                            "Sign UP",
                            style: TextStyle(color: AppConstant.iconTextColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.035,
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.02),
                            child: Text('connect with'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _googleSignInController.signInWithGoogle();
                            },
                            child: Image.asset(
                              "assets/images/google.png",
                              width: Get.width * 0.14,
                              color: AppConstant.Appsecondarycolor,
                            ),
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
                        height: Get.height * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "already have an account? ",

                            // style: TextStyle(color: AppConstant.Appsecondarycolor),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignIn());
                            },
                            child: Text(
                              "LOGIN",
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
      },
    );
  }
}
