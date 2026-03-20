// ignore_for_file: sort_child_properties_last

// import 'package:doctor_app/controllers/usercontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getuserdatacontroller.dart';
import '../../controllers/usercontroller.dart';
import '../../utils/appconstant.dart';

class Homepageheaderwidget extends StatefulWidget {
  const Homepageheaderwidget({super.key});

  @override
  State<Homepageheaderwidget> createState() => _HomepageheaderwidgetState();
}

class _HomepageheaderwidgetState extends State<Homepageheaderwidget> {
    final UserController userController =
          Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.012,
        vertical: Get.height * 0.012,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Image & Greeting
          Row(
            children: [
              CircleAvatar(
                radius: 22,
               child: Icon(Icons.person, size: 25, color: Colors.white),
                backgroundColor: AppConstant.Appsecondarycolor,
              ),
              SizedBox(width: Get.width * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ${userController.userModel.value?.username ?? 'User'}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstant.Appsecondarycolor),
                  ),
                  Text(
                    "Good Morning",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          // Location & Notification Icons
          Row(
            children: [
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Text(
              //       "Your Location",
              //       style: TextStyle(fontSize: 12, color: Colors.grey),
              //     ),
              //     Row(
              //       children: [
              //         // DropdownButton<String>(
              //         //   value: "Jhelum",
              //         //   icon: Icon(Icons.keyboard_arrow_down, size: 18),
              //         //   underline: SizedBox(),
              //         //   items: ["Jhelum", "Lahore", "Karachi"]
              //         //       .map((String value) {
              //         //     return DropdownMenuItem<String>(
              //         //       value: value,
              //         //       child: Text(value),
              //         //     );
              //         //   }).toList(),
              //         //   onChanged: (newValue) {},
              //         // ),
              //         Icon(Icons.location_on,
              //             color: Colors.blue, size: 18),
              //       ],
              //     ),
              //   ],
              // ),
              // SizedBox(width: 10),
              Icon(Icons.notifications,
                  color: AppConstant.Appsecondarycolor, size: 28),
            ],
          ),
        ],
      ),
    );
  }
}
