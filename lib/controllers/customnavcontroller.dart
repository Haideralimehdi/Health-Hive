// ignore_for_file: pattern_never_matches_value_type, unused_import

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../views/userpanel/homepage.dart';


class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs; // Observable variable

  void changeIndex(int index) {
    selectedIndex.value = index;
    _navigateToScreen(index);
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/home');// Ensure home screen is reset properly
        // Get.offAll(() => HomePage());
        break;
      case 1:
        Get.toNamed('/appointments');
      //  Get.to(() => AppointmentsScreen());
        break;
      case 2:
        Get.toNamed('/doctors');
        // Get.to(()=> DoctorScreen());
        break;
      case 3:
        Get.toNamed('/Bloodbankscreen');
        // Get.to(() => BloodBankScreen());
        break;
      case 4:
        Get.toNamed('/profile');
        //  Get.to(() => ProfileScreen());
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(Get.currentRoute.obs, (route) {
      selectedIndex.value = _getIndexFromRoute(route);
    });
  }

  int _getIndexFromRoute(String route) {
    switch (route) {
      case '/home':
        return 0;
      case '/appointments':
        return 1;
      case '/doctors':
        return 2;
      case  '/Bloodbankscreen':
        return 3;
      case '/profile':
        return 4;
      default:
        return 0;
    }
  }
}
