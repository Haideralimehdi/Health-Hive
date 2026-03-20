
// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'controllers/networkcontroller.dart';
import 'controllers/usercontroller.dart';
import 'firebase_options.dart';
import 'utils/appconstant.dart';
import 'views/authui/signupscreen.dart';
import 'views/authui/splashscreen.dart';
import 'views/authui/welcomescreen.dart';
import 'views/userpanel/alldoctorscreen.dart';
import 'views/userpanel/appointmentscreen.dart';
import 'views/userpanel/bloodbankscreen.dart';
import 'views/userpanel/homepage.dart';
import 'views/userpanel/profilescreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  Get.put(UserController());
User? user = FirebaseAuth.instance.currentUser;
if(FirebaseAuth.instance.currentUser != null) {
       final UserController userController = Get.find<UserController>();
userController.loadUserData(user!.uid);
  }

// Inject the NetworkController
  Get.put(NetworkController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar color
      statusBarIconBrightness: Brightness.light, // Status bar icons color
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/doctors', page: () => AllDoctorsScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/appointments', page: () => AppointmentsScreen()),
        GetPage(name: '/Bloodbankscreen', page: () => BloodBankScreen()),
        // Add more pages if needed
      ],
     theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppConstant.Appsecondarycolor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstant.Appsecondarycolor,
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstant.Appsecondarycolor,
            foregroundColor: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstant.Appsecondarycolor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppConstant.Appsecondarycolor),
          ),
        ),
      ),
      // home: HomePage(),
      home:Splashscreen(),
      builder: EasyLoading.init(),
    );
  }
}
