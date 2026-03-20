// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../model/doctormodel.dart';
import '../../utils/appconstant.dart';
import 'booknow.dart';
// import '../utils/appconstant.dart'; // Apna constant file add karo

class DoctorDetailScreen extends StatefulWidget {
  DoctorModel doctormodel;
  DoctorDetailScreen({super.key, required this.doctormodel});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    double scale = Get.textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctormodel.name,
            style: TextStyle(fontSize: 18 * scale, color: Colors.white)),
        leading: BackButton(color: Colors.white),
        backgroundColor: AppConstant.Appsecondarycolor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.doctormodel.imageUrl,
                    width: width * 0.25,
                    height: width * 0.25,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: width * 0.25,
                        height: width * 0.25,
                        color: Colors.grey[200],
                        child: Icon(Icons.broken_image,
                            size: 30, color: Colors.grey),
                      );
                    },
                  ),
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.doctormodel.name,
                          style: TextStyle(
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.bold)),
                      Text(widget.doctormodel.qualification,
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 14 * scale)),
                      Text(widget.doctormodel.specialty,
                          style: TextStyle(
                              color: AppConstant.Appsecondarycolor,
                              fontSize: 14 * scale)),
                      SizedBox(height: 4),
                      Text(widget.doctormodel.experience,
                          style: TextStyle(fontSize: 13 * scale)),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Expanded(
                              child: Text(widget.doctormodel.hospital,
                                  style: TextStyle(fontSize: 13 * scale))),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text("${widget.doctormodel.rating}",
                        style: TextStyle(fontSize: 14 * scale)),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.03),

            // Clinic Visit Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Clinic Visit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Text("Consulting Fee: \$${widget.doctormodel.fee}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Clinic Address :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      "Serum Clinic, Rose Dam,\nNear Police Station, West Ham"),
                  SizedBox(height: 4),
                  Text(
                    "• Free Consult Follow-Up 7 Days Post Consultation",
                    style: TextStyle(
                        color: Colors.grey[700], fontSize: 12 * scale),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => BookNowScreen(
                            doctorModel: widget.doctormodel,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.Appsecondarycolor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text("Book Now",
                        style: TextStyle(
                            color: Colors.white, fontSize: 14 * scale)),
                  ),
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      sendMessageOnWhatsApp(
                        doctorModel: widget.doctormodel,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.Appsecondarycolor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: Icon(Icons.message, color: Colors.white),
                    label: Text("What'sApp",
                        style: TextStyle(
                            color: Colors.white, fontSize: 14 * scale)),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),

            // About Doctor
            Text("About Doctor",
                style: TextStyle(
                    fontSize: 16 * scale, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(
              "A Career As A Doctor Is A Clinical Professional That Involves Providing Services In Healthcare Facilities. "
              "Individuals In The Doctor’s Career Path Are Responsible For Diagnosing, Examining, And Identifying Diseases, "
              "Disorders, And Illnesses Of Patients.",
              style: TextStyle(fontSize: 13.5 * scale, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> sendMessageOnWhatsApp({
  required DoctorModel doctorModel,
}) async {
  String phone = doctorModel.phone.replaceFirst(RegExp(r'^0'), '92');

  final message =
      "Hello ${doctorModel.name}, I would like to book an appointment.";

  final Uri url = Uri.parse(
      "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}");

  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    Get.snackbar(
      "Error",
      "WhatsApp not installed",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
