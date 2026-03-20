// ignore_for_file: use_super_parameters, sort_child_properties_last, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/bloodbankmodel.dart';

class BloodBankWidget extends StatelessWidget {
  final BloodDonorModel donor;

  const BloodBankWidget({Key? key, required this.donor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
 margin: EdgeInsets.symmetric(
        vertical: Get.width * 0.02,
        horizontal: Get.width * 0.02,
      ),      child: Padding(
        padding: EdgeInsets.all(Get.width * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           CircleAvatar(
              child: Icon(Icons.person, size: Get.width * 0.08),
              radius: Get.width * 0.099, // responsive avatar size
            ),
            SizedBox(width: Get.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donor.name,
                    style: TextStyle(
                      fontSize: Get.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Location: ${donor.location}",
                    style: TextStyle(
                      fontSize: Get.width * 0.040,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  donor.bloodGroup,
                  style: TextStyle(
                    fontSize: Get.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 6),
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.green),
                  iconSize: Get.width * 0.06,
                  onPressed: () {
                    sendMessageOnWhatsApp(
                        donor: donor,
                                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

 Future<void> sendMessageOnWhatsApp({
   required BloodDonorModel donor,
  }) async {
    final number = "${donor.phone}";
    final message = "Hello, I need blood of type ${donor.bloodGroup}.\n"
        "Please let me know if you can help me.";

  final Uri url = Uri.parse('https://wa.me/$number?text=${Uri.encodeComponent(message)}');

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication); // ✅ required for Android
  } else {
    //  throw 'Could not launch $url';
    Get.snackbar("Error", "Could not launch WhatsApp",
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}