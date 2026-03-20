// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';

// import '../../utils/appconstant.dart';
// import '../../utils/managekeyboard.dart';

class OTPVerificationScreen extends StatefulWidget {
  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: AppConstant.Appmaincolor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.height * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.black,
                  height: Get.height * 0.12,
                  alignment: Alignment.center,
                  // color: AppConstant.appSecondaryColor,
                  child: Image.asset(
                      "assets/images/c6e7253632e25d187186ae58039db1bf.png"),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Image.asset(
                  'assets/images/otp.png', // Replace with your image asset
                  height: Get.height * 0.25,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  "OTP verification",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppConstant.Appsecondarycolor),
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  "We sent an OTP on your registered number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: Get.height * 0.03),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(20),
                    fieldHeight: 43,
                    fieldWidth: 40,
                    // activeFillColor: AppConstant.appTextColor,
                    selectedColor: AppConstant.Appsecondarycolor,
                    inactiveColor: AppConstant.Appsecondarycolor,
                    activeColor: AppConstant.Appsecondarycolor,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  onChanged: (value) {},
                  appContext: context,
                ),
                SizedBox(height: Get.height * 0.03),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.Appsecondarycolor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        color: AppConstant.iconTextColor, fontSize: 18),
                  ),
                ),
                SizedBox(height: Get.height * 0.035),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "didn't receive the verification otp? ",
                         style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.to(() => SignUp());
                        },
                        child: Text(
                          "Re-Send",
                          style: TextStyle(
                            fontSize: 16,
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
    );
  }
}
