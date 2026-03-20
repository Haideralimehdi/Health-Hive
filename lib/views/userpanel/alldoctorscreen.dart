// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customnavcontroller.dart';
import '../../model/doctormodel.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';
import '../../widgets/customnavigationbar.dart';
import '../../widgets/fliterbottomsheet.dart';
import 'doctordetailscreen.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final NavigationController navController = Get.put(NavigationController());
  String selectedSpecialty = "";
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();

  List<String> specialties = [
    "Dentist",
    "Cardiology",
    "General",
    "Surgeon",
    "Neurologist",
    "Gynecologist"
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back navigation
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
        return true;
      },
      child: GestureDetector(
        onTap: () {
          KeyboardUtil.hideKeyboard(context);
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppConstant.iconTextColor,
            ),
            backgroundColor: AppConstant.Appsecondarycolor,
            title: Text(
              'All Doctors',
              style: TextStyle(color: AppConstant.iconTextColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // 🔍 Search and Filter Row
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          cursorColor: AppConstant.Appsecondarycolor,
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value.trim().toLowerCase();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Search doctor by name",
                            prefixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppConstant.Appsecondarycolor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppConstant.Appsecondarycolor),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppConstant.Appsecondarycolor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.filter_list,
                              color: Colors.white, size: Get.width * 0.065),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              isScrollControlled: true,
                              builder: (context) {
                                return FilterBottomSheet(
                                  specialties: specialties,
                                  selectedSpecialty: selectedSpecialty,
                                  onSelect: (String value) {
                                    setState(() {
                                      selectedSpecialty = value;
                                    });
                                  },
                                  onApply: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),

                  // 👨‍⚕️ Doctor List
                  FutureBuilder(
                    future: selectedSpecialty.isEmpty
                        ? FirebaseFirestore.instance.collection('doctors').get()
                        : FirebaseFirestore.instance
                            .collection('doctors')
                            .where('specialty', isEqualTo: selectedSpecialty)
                            .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Something went wrong"));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: Get.height / 5,
                          child: Center(child: CupertinoActivityIndicator()),
                        );
                      }

                      // Filtering by name
                      final filteredDocs = snapshot.data!.docs.where((doc) {
                        final name = doc['name'].toString().toLowerCase();
                        return name.contains(searchQuery);
                      }).toList();

                      if (filteredDocs.isEmpty) {
                        return Center(child: Text("No doctors found"));
                      }

                      return ListView.builder(
                        itemCount: filteredDocs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final doc = filteredDocs[index];

                          DoctorModel doctorModel = DoctorModel(
                            doctorId: doc['doctorId'],
                            name: doc['name'],
                            phone: doc['phone'],
                            qualification: doc['qualification'],
                            specialty: doc['specialty'],
                            experience: doc['experience'],
                            hospital: doc['hospital'],
                            imageUrl: doc['imageUrl'],
                            rating: (doc['rating'] is int)
                                ? (doc['rating'] as int).toDouble()
                                : doc['rating'],
                            fee: doc['fee'],
                            availableslots: doc['availableslots'],
                            userId: doc['userId'],
                          );

                          final currentUserId =
                              FirebaseAuth.instance.currentUser!.uid;

                          return GestureDetector(
                            onTap: () {
                              Get.to(() =>
                                  DoctorDetailScreen(doctormodel: doctorModel));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 🖼 Doctor Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        doctorModel.imageUrl,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey[300],
                                          child: Icon(Icons.broken_image),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // 📝 Doctor Info + Delete
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  doctorModel.name,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              // ✅ Only show delete icon if current user is the owner
                                              if (doctorModel.userId ==
                                                  currentUserId)
                                                IconButton(
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () async {
                                                    // 🔐 Confirm delete
                                                    bool confirm =
                                                        await showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            "Delete Doctor"),
                                                        content: Text(
                                                            "Are you sure you want to delete this doctor?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    false),
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    true),
                                                            child: Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red)),
                                                          ),
                                                        ],
                                                      ),
                                                    );

                                                    if (confirm) {
                                                      // Step 1: Delete doctor
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('doctors')
                                                          .doc(doctorModel
                                                              .doctorId)
                                                          .delete();

                                                      // Step 2: Check if any doctors left for this user
                                                      final remainingDoctors =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'doctors')
                                                              .where('userId',
                                                                  isEqualTo:
                                                                      currentUserId)
                                                              .get();

                                                      // Step 3: If no doctors left, update user's isDoctor to false
                                                      if (remainingDoctors
                                                          .docs.isEmpty) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(currentUserId)
                                                            .update({
                                                          'isDoctor': false
                                                        });
                                                      }

                                                      // Step 4: Refresh screen
                                                      setState(() {});
                                                      Get.snackbar("Success",
                                                          "Doctor deleted");
                                                    }
                                                  },
                                                ),
                                            ],
                                          ),
                                          Text(
                                            doctorModel.qualification,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            doctorModel.specialty,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            "${doctorModel.experience} Experience",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  size: 16, color: Colors.grey),
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  doctorModel.hospital,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black54),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Consulting Fee:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                "Rs ${doctorModel.fee}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ⭐ Rating
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber, size: 18),
                                            SizedBox(width: 4),
                                            Text(
                                              doctorModel.rating.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
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
