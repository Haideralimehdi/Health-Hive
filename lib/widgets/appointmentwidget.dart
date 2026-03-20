// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/appconstant.dart';

class AppointmentCard extends StatelessWidget {
  final Map<String, String> appointment;
  final bool isActive;

  AppointmentCard({required this.appointment, required this.isActive});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    double scale = Get.textScaleFactor;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isActive)
              Text(
                appointment["daysAgo"] ?? "",
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppConstant.Appsecondarycolor,
                ),
              ),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                if (appointment.containsKey("image"))
                  CircleAvatar(
                    backgroundImage: NetworkImage(appointment["image"]!),
                    radius: width * 0.08,
                  ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${appointment["name"]} (${appointment["specialty"]})",
                        style: TextStyle(fontSize: 16 * scale, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.005),
                      Text("Date: ${appointment["date"]}"),
                      Text("Time/Token: ${appointment["time"]}"),
                      Text("Place: ${appointment["place"]}"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isActive ? Colors.green : AppConstant.Appsecondarycolor,
                    ),
                    child: Text(
                      isActive ? "Reschedule" : "Add A Review",
                      style: TextStyle(color: Colors.white, fontSize: 14 * scale),
                    ),
                  ),
                ),
                if (isActive) SizedBox(width: width * 0.03),
                if (isActive)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 14 * scale),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
