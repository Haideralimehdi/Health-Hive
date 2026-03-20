// lib/views/userpanel/add_patient_form_screen.dart

// ignore_for_file: must_be_immutable

// import 'package:doctor_app/utils/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/addpatientformcontroller.dart';
import '../../model/doctormodel.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';

class AddPatientFormScreen extends StatefulWidget {
  final DoctorModel doctorModel;
  String selectedTime;
  DateTime? selectedDate;

   AddPatientFormScreen({
    super.key,
    required this.doctorModel,
    required this.selectedTime,
    required this.selectedDate,
  });

  @override
  State<AddPatientFormScreen> createState() => _AddPatientFormScreenState();
}

class _AddPatientFormScreenState extends State<AddPatientFormScreen> {
  final AddPatientFormController controller =
      Get.put(AddPatientFormController());

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController dayController = TextEditingController();

  final TextEditingController monthController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  final List<String> genders = ['Male', 'Female', 'Others'];

  final List<String> relations = [
    'Self',
    'Father',
    'Mother',
    'Sibling',
    'Spouse',
    'Child'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: AppConstant.Appmaincolor,
        appBar: AppBar(
          title: Text("Add Patient"),
          backgroundColor: AppConstant.Appsecondarycolor,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              TextField(
                cursorColor: AppConstant.Appsecondarycolor,
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
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
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 12),

              // Last Name
              TextField(
                cursorColor: AppConstant.Appsecondarycolor,
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: "Last Name (Optional)",
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
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 12),

              // DOB Fields
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: AppConstant.Appsecondarycolor,
                      controller: dayController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "DD",
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
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      cursorColor: AppConstant.Appsecondarycolor,
                      controller: monthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "MM",
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
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      cursorColor: AppConstant.Appsecondarycolor,
                      controller: yearController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "YYYY",
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
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Gender Selector
              Text("Gender:"),
              Obx(() => Wrap(
                    spacing: 10,
                    children: genders.map((gender) {
                      return ChoiceChip(
                       
                        label: Text(gender),
                        selected: controller.selectedGender.value == gender,
                        onSelected: (_) =>
                            controller.selectedGender.value = gender,
                      );
                    }).toList(),
                  )),
              SizedBox(height: 12),

              // Relation Dropdown
              Text("Relation:"),
              Obx(() => DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedRelation.value,
                    items: relations.map((rel) {
                      return DropdownMenuItem(
                        value: rel,
                        child: Text(rel),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        controller.selectedRelation.value = val!,
                  )),
              SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (firstNameController.text.trim().isEmpty ||
                        dayController.text.trim().isEmpty ||
                        monthController.text.trim().isEmpty ||
                        yearController.text.trim().isEmpty ||
                        controller.selectedGender.value.isEmpty ||
                        controller.selectedRelation.value.isEmpty) {
                      Get.snackbar(
                          "Missing Info", "Please fill all required fields!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                      return;
                    }

                    controller.savePatientData(
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                      day: dayController.text.trim(),
                      month: monthController.text.trim(),
                      year: yearController.text.trim(),
                         doctor: widget.doctorModel,
                         selectedTime: widget.selectedTime,
                      selectedDate: widget.selectedDate,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.Appsecondarycolor),
                  child: Text("Save",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
