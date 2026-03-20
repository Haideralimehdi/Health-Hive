// ignore_for_file: non_constant_identifier_names, unnecessary_overrides, empty_catches, unused_local_variable, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../utils/appconstant.dart';

// import '../utils/app-constant.dart';

class GetDeviceTokenController extends GetxController {
  String? DeviceToken;

  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        DeviceToken = token;
        print("token: $DeviceToken");
        update();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.Appsecondarycolor,
        colorText: AppConstant.iconTextColor,
      );
    }
  }
}
