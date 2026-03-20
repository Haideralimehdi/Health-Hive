// import 'package:doctor_app/controllers/doctor_registration_controller.dart';
// import 'package:doctor_app/utils/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customnavcontroller.dart';
import '../../controllers/registerasdoctorcontroller.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';

class RegisterAsDoctorScreen extends StatelessWidget {
  RegisterAsDoctorScreen({super.key});

  final DoctorRegistrationController controller =
      Get.put(DoctorRegistrationController());
  final NavigationController navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text("Register as Doctor", style: TextStyle(color: Colors.white)),
          backgroundColor: AppConstant.Appsecondarycolor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildField("Name", controller.nameController),
                        buildField("Phone", controller.phoneController),
                        buildField("Qualification",
                            controller.qualificationController),
                        buildField("Specialty", controller.specialtyController),
                        buildField(
                            "Experience", controller.experienceController),
                        buildField("Hospital", controller.hospitalController),
                        buildField("Fee", controller.feeController),
                        const SizedBox(height: 16),
                        Text("Available Slots",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.slotController,
                                decoration: InputDecoration(
                                  labelText:
                                      "Enter Slot (e.g. 10:00 AM - 11:00 AM)",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppConstant.Appsecondarycolor),
                              onPressed: controller.addSlot,
                              child: Text("Add",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(() => ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.availableSlots.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(controller.availableSlots[index]),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        controller.removeSlot(index),
                                  ),
                                );
                              },
                            )),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstant.Appsecondarycolor),
                          onPressed: () => controller.registerDoctor(context),
                          child: Text("Submit",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter $label' : null,
      ),
    );
  }
}
