// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customnavcontroller.dart';
import '../../model/bloodbankmodel.dart';
import '../../utils/appconstant.dart';
import '../../utils/managekeyboard.dart';
import '../../widgets/bloodbankwidget.dart';
import '../../widgets/customnavigationbar.dart';
import '../../widgets/fliterbottomsheet.dart';
import 'donatebloodscreen.dart';

class BloodBankScreen extends StatefulWidget {
  @override
  State<BloodBankScreen> createState() => _BloodBankScreenState();
}

class _BloodBankScreenState extends State<BloodBankScreen> {
  final NavigationController navController = Get.put(NavigationController());
  final TextEditingController searchController = TextEditingController();

  List<String> specialties = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
  ];

  String selectedSpecialty = "";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.trim();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navController.changeIndex(0);
        return true;
      },
      child: GestureDetector(
        onTap: () {
          KeyboardUtil.hideKeyboard(context);
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Blood Bank",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppConstant.Appsecondarycolor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.02,
                vertical: Get.height * 0.01,
              ),
              child: Column(
                children: [
                  /// 🔍 Search + Filter
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: AppConstant.Appsecondarycolor,
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Get.height * 0.015),
                            hintText: "Search Blood Group...",
                            prefixIcon:
                                Icon(Icons.search, size: Get.width * 0.06),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: AppConstant.Appsecondarycolor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: AppConstant.Appsecondarycolor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
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
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    return FilterBottomSheet(
                                      specialties: specialties,
                                      selectedSpecialty: selectedSpecialty,
                                      onSelect: (newValue) {
                                        setState(() {
                                          selectedSpecialty = newValue;
                                        });
                                        setModalState(() {});
                                      },
                                      onApply: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Get.height * 0.02),

                  /// 🩸 Donate Button
                  SizedBox(
                    width: Get.width * 0.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppConstant.Appsecondarycolor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: Get.height * 0.013),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => DonateBloodScreen());
                      },
                      child: Text(
                        "Donate Blood",
                        style: TextStyle(
                          color: AppConstant.iconTextColor,
                          fontSize: Get.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  /// 🔄 Real-Time Data from Firestore
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('BloodBank')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No donors found"));
                      }

                      final donorDocs = snapshot.data!.docs;

                      // Filter by blood group (from search or filter)
                      final filteredDonors = donorDocs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>? ?? {};
                        final bloodGroup =
                            (data['bloodGroup'] ?? '').toString().toLowerCase();

                        final matchesSearch = searchQuery.isEmpty ||
                            bloodGroup.contains(searchQuery.toLowerCase());

                        final matchesFilter = selectedSpecialty.isEmpty ||
                            bloodGroup == selectedSpecialty.toLowerCase();

                        return matchesSearch && matchesFilter;
                      }).toList();

                      if (filteredDonors.isEmpty) {
                        return Center(child: Text("No matching blood donors"));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredDonors.length,
                        itemBuilder: (context, index) {
                          final donorData = filteredDonors[index].data()
                              as Map<String, dynamic>;
                          final donor = BloodDonorModel.fromMap(donorData);

                          return Dismissible(
                            key: Key(donor.donorId),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            confirmDismiss: (direction) async {
                              final currentUserId =
                                  FirebaseAuth.instance.currentUser?.uid;

                              if (currentUserId == donor.userId) {
                                // Show confirmation dialog
                                return await showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text(
                                        'Are you sure you want to delete this donor?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(true),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Show warning
                                Get.snackbar(
                                  "Permission Denied",
                                  "You can only delete donors added by you.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return false;
                              }
                            },
                            onDismissed: (direction) async {
                              await FirebaseFirestore.instance
                                  .collection('BloodBank')
                                  .doc(donor.donorId)
                                  .delete();

                              Get.snackbar(
                                "Deleted",
                                "Donor has been removed.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            },
                            child: BloodBankWidget(donor: donor),
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
