// ignore_for_file: use_key_in_widget_constructors, unused_import, deprecated_member_use

// import 'package:doctor_app/utils/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customnavcontroller.dart';
import '../../utils/appconstant.dart';
import '../../widgets/appointmentwidget.dart';
import '../../widgets/customnavigationbar.dart';
import 'activeappointmentscreen.dart';
import 'previewsappointment.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final NavigationController navController =
      Get.put(NavigationController()); // Inject Controller
  @override
  Widget build(BuildContext context) {
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          // backgroundColor: AppConstant.Appmaincolor,
          appBar: AppBar(
            backgroundColor: AppConstant.Appsecondarycolor,
            automaticallyImplyLeading: false,
            title: Text("My Appointments",
                style: TextStyle(
                  // fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            bottom: TabBar(
              labelColor: Colors.white, // Active tab text color
              unselectedLabelColor: Colors.black54, // Inactive tab text color
              indicatorColor: Colors.white, // Line under active tab
              tabs: [
                Tab(
                  text: "Actives",
                ),
                Tab(text: "Previous"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ActiveAppointments(),
              PreviousAppointments(),
            ],
          ),
          bottomNavigationBar: CustomNavigationBar(),
        ),
      ),
    );
  }
}

// class PreviousAppointments extends StatelessWidget {
//   final List<Map<String, String>> appointments = [
//     {
//       "name": "Dr Denies Martine",
//       "specialty": "Cardiologist",
//       "date": "15/02/2026",
//       "time": "08:30 AM",
//       "place": "Serum Clinic, Rose Dam, Near Police Station, West Ham",
//       "daysAgo": "3 Days Ago"
//     },
//     {
//       "name": "Dr Denies Martine",
//       "specialty": "Cardiologist",
//       "date": "15/02/2026",
//       "time": "08:30 AM",
//       "place": "Serum Clinic, Rose Dam, Near Police Station, West Ham",
//       "daysAgo": "8 Days Ago"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: appointments.length,
//       itemBuilder: (context, index) {
//         final appointment = appointments[index];
//         return AppointmentCard(appointment: appointment, isActive: false);
//       },
//     );
//   }
// }
