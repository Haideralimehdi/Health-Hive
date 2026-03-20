// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_super_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doctor_app/model/appointmentmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/customnavcontroller.dart';
import '../../model/appointmentmodel.dart';
import '../../utils/appconstant.dart';
import 'thankyoupage.dart';

class ChoosePaymentMethodScreen extends StatefulWidget {
  final AppointmentModel appointmentModel;
  const ChoosePaymentMethodScreen({Key? key, required this.appointmentModel})
      : super(key: key);
  @override
  State<ChoosePaymentMethodScreen> createState() =>
      _ChoosePaymentMethodScreenState();
}

class _ChoosePaymentMethodScreenState extends State<ChoosePaymentMethodScreen> {
  final NavigationController navController =
      Get.put(NavigationController()); // Inject Controller

  String selectedPayment = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return WillPopScope(
      onWillPop: () async {
        // Jab user back press kare, tu index home ka set kar do
        if (Get.previousRoute == '/home') {
          navController.changeIndex(0);
        } else if (Get.previousRoute == '/appointments') {
          navController.changeIndex(1);
        } else if (Get.previousRoute == '/doctors') {
          navController.changeIndex(2);
        } else if (Get.previousRoute == '/bloodbankscreen') {
          navController.changeIndex(3);
        } else if (Get.previousRoute == '/profile') {
          navController.changeIndex(4);
        } else {
          navController.changeIndex(0);
        }
        return true; // true ka matlab: allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text("Book Appointment", style: TextStyle(color: Colors.white)),
          backgroundColor: AppConstant.Appsecondarycolor,
          leading: BackButton(color: Colors.white),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Choose A Payment Method",
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 20),
              _paymentOption("Direct Payment"),
              SizedBox(height: 10),
              _paymentCardOption("Card Payment", ["Debit Card", "Credit Card"]),
              SizedBox(height: 10),
              _singleOption("Net Banking"),
              SizedBox(height: 10),
              _paymentOption("Phone Pe", icon: Icons.phone_android),
              _paymentOption("Google Pay", icon: Icons.payment),
              _paymentOption("Amazon Pay", icon: Icons.account_balance_wallet),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
          child: ElevatedButton(
            onPressed: () {
              if (selectedPayment.isEmpty) {
                Get.snackbar('Error', 'Please select a payment method');
                return;
              }

              // Show confirmation popup
              Get.defaultDialog(
                title: "Confirm Payment",
                middleText: "Are you sure you want to confirm the payment?",
                textConfirm: "Yes",
                textCancel: "Cancel",
                backgroundColor: AppConstant.Appsecondarycolor,
                titleStyle: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold),
                middleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400),
                    
                confirmTextColor: AppConstant.appTextColor,
                cancelTextColor: Colors.white,
                buttonColor: AppConstant.Appmaincolor,
                onConfirm: () async {
                  Get.back(); // Close dialog
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null &&
                        widget.appointmentModel.appointmentId.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('appointments')
                          .doc(widget.appointmentModel.appointmentId)
                          .update({'status': 'confirmed'});
                      Get.to(() => ThankYouScreen(appointment: widget.appointmentModel,));
                    } else {
                      Get.snackbar('Error',
                          'User not logged in or invalid appointment ID');
                    }
                  } catch (e) {
                    Get.snackbar('Error', 'Failed to confirm appointment: $e');
                  }
                },
                onCancel: () {
                  // Optional: you can add a snackbar or leave it empty
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstant.Appsecondarycolor,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text("Pay Now",
                style: TextStyle(
                    fontSize: screenWidth * 0.045, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _paymentOption(String title, {IconData? icon}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = title;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selectedPayment == title ? Colors.teal[100] : Colors.grey[200],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.black54),
            if (icon != null) SizedBox(width: 10),
            Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
            Radio<String>(
              value: title,
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentCardOption(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: 8),
        ...options.map((opt) => Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child: _paymentOption(opt),
            )),
      ],
    );
  }

  Widget _singleOption(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}
