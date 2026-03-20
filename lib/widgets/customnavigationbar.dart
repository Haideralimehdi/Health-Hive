// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customnavcontroller.dart';
import '../utils/appconstant.dart';

class CustomNavigationBar extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController()); // Inject Controller

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: Get.height * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.calendar_month, "Appointments", 1),
              _buildNavItem(Icons.person, "All Doctors", 2),
              _buildNavItem(Icons.bloodtype, "Blood Bank", 3),
              _buildNavItem(Icons.person, "Profile", 4),
            ],
          ),
        ));
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => navController.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: navController.selectedIndex.value == index
                ? AppConstant.Appsecondarycolor
                : Colors.black,
          ),
          // const SizedBox(height: 2), // Space between icon & text
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: navController.selectedIndex.value == index
                  ? AppConstant.Appsecondarycolor
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
