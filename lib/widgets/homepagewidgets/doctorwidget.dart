// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../model/doctormodel.dart';
import '../../views/userpanel/doctordetailscreen.dart';

class doctorswidget extends StatefulWidget {
  const doctorswidget({super.key});

  @override
  State<doctorswidget> createState() => _doctorswidgetState();
}

class _doctorswidgetState extends State<doctorswidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("doctors").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 3,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No doctors found:"));
        }
        if (snapshot.data != null) {
          return Container(
            height: Get.height / 6, // adjust height to fit 2 rows
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DoctorModel doctorModel = DoctorModel(
                  doctorId: snapshot.data!.docs[index]['doctorId'],
                  name: snapshot.data!.docs[index]['name'],
                  phone: snapshot.data!.docs[index]['phone'],
                  qualification: snapshot.data!.docs[index]['qualification'],
                  specialty: snapshot.data!.docs[index]['specialty'],
                  experience: snapshot.data!.docs[index]['experience'],
                  hospital: snapshot.data!.docs[index]['hospital'],
                  imageUrl: snapshot.data!.docs[index]['imageUrl'],
                  rating: (snapshot.data!.docs[index]['rating'] is int)
                      ? (snapshot.data!.docs[index]['rating'] as int).toDouble()
                      : snapshot.data!.docs[index]['rating'],
                  fee: snapshot.data!.docs[index]['fee'],
                  availableslots: snapshot.data!.docs[index]['availableslots'],
                  userId: snapshot.data!.docs[index]['userId'],
                );

                return GestureDetector(
                  onTap: () {
                    Get.to(() => DoctorDetailScreen(doctormodel: doctorModel));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      width: Get.width / 3.5,
                      height: Get.height / 6, // 👈 Container height fixed
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4)
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Image Section
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            child: CachedNetworkImage(
                              imageUrl: doctorModel.imageUrl,
                              width: Get.width / 3.5,
                              height: Get.height /
                                  12, // 👈 Match with half or more of container
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) => Container(
                                width: Get.width / 3.5,
                                height: Get.height / 12,
                                color: Colors.grey[300],
                                child: Icon(Icons.broken_image,
                                    size: 40, color: Colors.grey),
                              ),
                            ),
                          ),

                          // Spacer for better layout
                          SizedBox(height: 5),

                          // Doctor Name
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  doctorModel.name,
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
