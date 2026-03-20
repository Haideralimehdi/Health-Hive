// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/doctormodel.dart';
import '../../utils/appconstant.dart';
import 'addpatientscreen.dart';
// import '../utils/appconstant.dart';

class BookNowScreen extends StatefulWidget {
  final DoctorModel doctorModel;
  const BookNowScreen({
    super.key,
    required this.doctorModel,
  });

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  String selectedTime = '';
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    double scale = Get.textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment",
            style: TextStyle(fontSize: 18 * scale, color: Colors.white)),
        backgroundColor: AppConstant.Appsecondarycolor,
        leading: BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Summary
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.08,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: Image.network(
                        widget.doctorModel.imageUrl,
                        fit: BoxFit.cover,
                        width: width * 0.16,
                        height: width * 0.16,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: width * 0.08,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.doctorModel.name,
                            style: TextStyle(
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.bold)),
                        Text(widget.doctorModel.specialty,
                            style: TextStyle(
                                fontSize: 14 * scale, color: Colors.grey[700])),
                        Text(widget.doctorModel.hospital,
                            style: TextStyle(
                                fontSize: 13 * scale, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.03),

            // Date Selection
            Text("Select Date",
                style: TextStyle(
                    fontSize: 16 * scale, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(7, (index) {
                  DateTime date = DateTime.now().add(Duration(days: index));
                  bool isSelected = selectedDate != null &&
                      date.day == selectedDate!.day &&
                      date.month == selectedDate!.month &&
                      date.year == selectedDate!.year;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSelected
                            ? AppConstant.Appsecondarycolor
                            : Colors.grey[200],
                      ),
                      child: Column(
                        children: [
                          Text("${date.day}",
                              style: TextStyle(
                                  fontSize: 16 * scale,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black)),
                          Text(
                            "${[
                              "Sun",
                              "Mon",
                              "Tue",
                              "Wed",
                              "Thu",
                              "Fri",
                              "Sat"
                            ][date.weekday % 7]}",
                            style: TextStyle(
                                fontSize: 13 * scale,
                                color:
                                    isSelected ? Colors.white70 : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: height * 0.03),

            // Time Slot Selection
            Text("Select Time Slot",
                style: TextStyle(
                    fontSize: 16 * scale, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: widget.doctorModel.availableslots.map((time) {
                bool isSelected = time == selectedTime;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? AppConstant.Appsecondarycolor
                          : Colors.grey[200],
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 14 * scale,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Spacer(),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == null) {
                    Get.snackbar("Error", "Please select a date!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white);
                    return;
                  }
                  if (selectedTime.isEmpty) {
                    Get.snackbar("Error", "Please select a time slot!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white);
                    return;
                  }
                  // Get.snackbar("Success", "Appointment Booked!",
                  //     snackPosition: SnackPosition.BOTTOM,
                  //     backgroundColor: AppConstant.Appsecondarycolor,
                  //     colorText: Colors.white);
                  Get.to(() => AddPatientScreen(
                        doctorModel: widget.doctorModel,
                        selectedTime: selectedTime,
                        selectedDate: selectedDate,
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstant.Appsecondarycolor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Confirm Booking",
                    style:
                        TextStyle(fontSize: 16 * scale, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
