// ignore_for_file: unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appconstant.dart';

class SpecialtiesScreen extends StatefulWidget {
  @override
  State<SpecialtiesScreen> createState() => _SpecialtiesScreenState();
}

class _SpecialtiesScreenState extends State<SpecialtiesScreen> {
  final List<Map<String, String>> specialties = [
    {
      "title": "General",
      "image": "assets/images/general.jpeg",
      "description":
          "Cardiology is a medical specialty and a branch of internal medicine concerned with disorders of the heart."
    },
    {
      "title": "Cardiologist",
      "image": "assets/images/cardiologist.jpeg",
      "description":
          "Cardiology is a medical specialty and a branch of internal medicine concerned with disorders of the heart."
    },
    {
      "title": "Nephrologists",
      "image": "assets/images/nephrologists.jpeg",
      "description":
          "Cardiology is a medical specialty and a branch of internal medicine concerned with disorders of the heart."
    },
    {
      "title": "Gynecologists",
      "image": "assets/images/gynecologists.jpeg",
      "description":
          "Cardiology is a medical specialty and a branch of internal medicine concerned with disorders of the heart."
    },
    {
      "title": "Pediatrician",
      "image": "assets/images/pediatrician.jpeg",
      "description":
          "Cardiology is a medical specialty and a branch of internal medicine concerned with disorders of the heart."
    },
    {
      "title": "Dentists",
      "image": "assets/images/dentists.jpeg",
      "description":
          "Cardiology is a medical specialty and a branch of internal medicine concerned with disorders of the heart."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Specialties",
        ),
        backgroundColor: AppConstant.Appsecondarycolor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.02,
          vertical: Get.height * 0.015,
        ),
        child: ListView.builder(
          itemCount: specialties.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.013,
                  horizontal: Get.width * 0.03,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    specialties[index]["image"]!,
                    width: Get.width * 0.17,
                    height: Get.width * 0.17,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  specialties[index]["title"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.045,
                  ),
                ),
                subtitle: Text(
                  specialties[index]["description"]!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize:  Get.width * 0.035),
                ),
                onTap: () {
                  // Get.toNamed('/specialtyDetail', arguments: specialties[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
