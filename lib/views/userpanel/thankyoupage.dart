// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last

// import 'package:doctor_app/views/userpanel/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/appointmentmodel.dart';
import '../../utils/appconstant.dart';
import 'homepage.dart';

class ThankYouScreen extends StatefulWidget {
   final AppointmentModel appointment;

  const ThankYouScreen({super.key, required this.appointment});
  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;

    return Scaffold(
    
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: Column(
          children: [
            SizedBox(height: height * 0.06),

            Text("Thank You", style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold)),
            SizedBox(height: height * 0.025),

            Icon(Icons.verified, color: Colors.green, size: width * 0.22),
            SizedBox(height: height * 0.02),

            Text("Your Booking Is Successfully Completed",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.04, color: Colors.grey[800])),
            SizedBox(height: height * 0.02),

            Text("Booking Id", style: TextStyle(fontSize: width * 0.04, color: Colors.black54)),
            Text("100068", style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold)),
            SizedBox(height: height * 0.03),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.download),
                  label: Text("Download Invoice", style: TextStyle(fontSize: width * 0.035)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                  label: Text("Share Invoice", style: TextStyle(fontSize: width * 0.035)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.035),

            Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.appointment.doctorName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.045)),
                  SizedBox(height: 4),
                  Text("Cardiologist", style: TextStyle(fontSize: width * 0.035)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: width * 0.035, color: Colors.grey),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Serum Clinic, Rose Dam, Near Police Station, West Ham",
                          style: TextStyle(fontSize: width * 0.032),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text("View Map",
                            style: TextStyle(color: Colors.blue, fontSize: width * 0.035)),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),

            ElevatedButton(
              onPressed: () {
                Get.offAll(()=> HomePage()); // change route as needed
              },
              child: Text("Back To Home Page", style: TextStyle(fontSize: width * 0.045, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstant.Appsecondarycolor,
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                minimumSize: Size(double.infinity, height * 0.07),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
