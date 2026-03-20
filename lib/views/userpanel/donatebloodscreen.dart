// ignore_for_file: sort_child_properties_last, deprecated_member_use, avoid_print

// import 'package:doctor_app/utils/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customnavcontroller.dart';
import '../../controllers/donatebloodcontroller.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';

class DonateBloodScreen extends StatelessWidget {
  DonateBloodScreen({super.key});

  final NavigationController navController = Get.put(NavigationController());
  final Donatebloodcontroller donatebloodcontroller =
      Get.put(Donatebloodcontroller());
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();

  // final RxString selectedBloodType = ''.obs;
  // final RxString selectedGender = ''.obs;

  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  @override
  Widget build(BuildContext context) {
    double w = Get.width;
    double h = Get.height;

    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.Appsecondarycolor,
          title: Text("Donate Blood", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              SizedBox(height: 20),
              Text("*Name:"),
              TextField(
                cursorColor: AppConstant.Appsecondarycolor,
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppConstant.Appsecondarycolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppConstant.Appsecondarycolor),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("*Location:"),
              TextField(
                cursorColor: AppConstant.Appsecondarycolor,
                keyboardType: TextInputType.streetAddress,
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Enter Location",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppConstant.Appsecondarycolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppConstant.Appsecondarycolor),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("*Select Blood Type:"),
              Obx(() => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: bloodTypes.map((type) {
                      return ChoiceChip(
                        // selectedColor: AppConstant.Appsecondarycolor,
                        label: Text(type),
                        selected:
                            donatebloodcontroller.selectedBloodType.value ==
                                type,
                        onSelected: (_) => donatebloodcontroller
                            .selectedBloodType.value = type,
                      );
                    }).toList(),
                  )),
              SizedBox(height: 15),
              Text("*Phone Details:"),
              TextField(
                cursorColor: AppConstant.Appsecondarycolor,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter Details",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppConstant.Appsecondarycolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppConstant.Appsecondarycolor),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("*Gender:"),
              Obx(() => Row(
                    children: ["Male", "Female"].map((gender) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(gender),
                          selected:
                              donatebloodcontroller.selectedGender.value ==
                                  gender,
                          onSelected: (_) => donatebloodcontroller
                              .selectedGender.value = gender,
                        ),
                      );
                    }).toList(),
                  )),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: h * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isEmpty ||
                        locationController.text.trim().isEmpty ||
                        phoneController.text.trim().isEmpty ||
                        donatebloodcontroller.selectedGender.value.isEmpty ||
                        donatebloodcontroller.selectedBloodType.value.isEmpty) {
                      Get.snackbar(
                          "Missing Info", "Please fill all required fields!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                      return;
                    }

                    donatebloodcontroller.savedonatebloodData(
                      name: nameController.text.trim(),
                      location: locationController.text.trim(),
                      phone: phoneController.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.Appsecondarycolor),
                  child: Text("Apply", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
