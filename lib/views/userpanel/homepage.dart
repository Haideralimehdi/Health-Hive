// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customnavcontroller.dart';
import '../../controllers/notificationbadgecontroller.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';
import '../../widgets/homepagewidgets/bannerwidgets.dart';
import '../../widgets/customnavigationbar.dart';
// import '../../widgets/homepagewidgets/bannerwidget.dart';
// import '../../widgets/homepagewidgets/headingwidget.dart';
// import '../../widgets/homepagewidgets/homepageheaderwidget.dart';
import '../../widgets/homepagewidgets/customdrawerwidget.dart';
import '../../widgets/homepagewidgets/doctorwidget.dart';
import '../../widgets/homepagewidgets/headingswidget.dart';
import '../../widgets/homepagewidgets/homepageheaderwidget.dart';
import '../../widgets/homepagewidgets/specialitieswidget.dart';
import 'alldoctorscreen.dart';
import 'notificationscreen.dart';
import 'specialitiesscreen.dart';
import 'package:badges/badges.dart' as badges;


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavigationController navController =
      Get.put(NavigationController()); // Inject Controller
  final NotificationController notificationController =
      Get.put(NotificationController());

  TextEditingController hometextfield = TextEditingController();

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
      child: GestureDetector(
        onTap: () {
          KeyboardUtil.hideKeyboard(context);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Home Page',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            actions: [
              Obx(() => badges.Badge(
                    showBadge:
                        notificationController.notificationCount.value > 0,
                    badgeContent: Text(
                      '${notificationController.notificationCount.value}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    position: badges.BadgePosition.topEnd(top: 2, end: 2),
                    child: IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DoctorNotificationScreen(),
                          ),
                        );
                        // refresh count after returning from notifications
                        notificationController.fetchNotificationCount();
                      },
                    ),
                  )),
            ],
            backgroundColor: AppConstant.Appsecondarycolor,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          backgroundColor: AppConstant.Appmaincolor,
          drawer: DrawerWidget(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.025, vertical: Get.height * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Homepageheaderwidget(),
                  // SizedBox(height: Get.height * 0.015),
                  // Search Bar
                  // TextFormField(
                  //   controller: hometextfield,
                  //   keyboardType: TextInputType.text,
                  //   decoration: InputDecoration(
                  //     hintText: "Eg: 'MIMS'",
                  //     prefixIcon: Icon(Icons.search, color: Colors.grey),
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(30),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: Get.height * 0.02),

                  BannerWidget(),

                  SizedBox(height: Get.height * 0.015),
                  // Top Specialties Section
                  HeadingWidget(
                    headingTitle: 'Top Specialities',
                    onTap: () {
                      Get.to(() => SpecialtiesScreen());
                    },
                    buttonText: 'View All',
                    headingSubTitle: 'According to your requirments',
                  ),

                  SizedBox(height: Get.height * 0.01),
                  // Hometopspecialitieslist(
                  //   Text: 'speciality',
                  // ),
                  specialitieswidget(),
                  // Top Doctors Section
                  SizedBox(height: Get.height * 0.015),
                  // Top Specialties Section
                  HeadingWidget(
                    headingTitle: 'Top Doctors',
                    onTap: () {
                      navController.changeIndex(2);
                      Get.to(() => AllDoctorsScreen());
                    },
                    buttonText: 'View All',
                    headingSubTitle: 'According to your requirments',
                  ),
                  doctorswidget(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomNavigationBar(),
        ),
      ),
    );
  }
}
