import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/addpatientcontroller.dart';
import '../model/doctormodel.dart';
import '../model/patientmodel.dart';
import '../utils/appconstant.dart';
import '../views/userpanel/addpatientformscreen.dart';

class ExistingPatientsBottomSheet extends StatelessWidget {
  final List<QueryDocumentSnapshot> patientDocs;
  final DoctorModel doctorModel;
  final String selectedTime;
  final DateTime? selectedDate;

  const ExistingPatientsBottomSheet({
    required this.patientDocs,
    required this.doctorModel,
    required this.selectedTime,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: Get.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Existing Patient",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: patientDocs.length,
              itemBuilder: (context, index) {
                final data = patientDocs[index].data() as Map<String, dynamic>;
                final patient = PatientModel.fromMap(data);

                return Card(
                  child: ListTile(
                    title: Text("${patient.firstName} ${patient.lastName}"),
                    subtitle: Text("Relation: ${patient.relation}"),
                    onTap: () {
                      Get.find<AddPatientController>()
                          .setSelectedPatient(patient);
                      Navigator.pop(context); // close bottom sheet
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstant.Appsecondarycolor),
              onPressed: () {
                Navigator.pop(context); // close bottom sheet
                Get.to(() => AddPatientFormScreen(
                      doctorModel: doctorModel,
                      selectedTime: selectedTime,
                      selectedDate: selectedDate,
                    ));
              },
              icon: Icon(Icons.add,
                  color: AppConstant.iconTextColor,
                  size: Get.width * 0.06),
              label: Text(
                "Add New Patient",
                style: TextStyle(
                    fontSize: Get.width * 0.045,
                    color: AppConstant.iconTextColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
