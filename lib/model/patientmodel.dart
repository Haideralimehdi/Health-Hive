// ignore_for_file: file_names

class PatientModel {
  final String patientId;
  final String userId;
  final String firstName;
  final String lastName;
  final String dob;
  final String gender;
  final String relation;
  final DateTime? createdAt;

  PatientModel({
    required this.userId,
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.relation,
    this.createdAt,
  });

  // Convert object to JSON map
  Map<String, dynamic> toMap() {
    return {
      'userId':userId,
      'patient_id': patientId,
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'gender': gender,
      'relation': relation,
      'created_at': createdAt?.toIso8601String(), // nullable handled
    };
  }

  // Convert JSON map to object
  factory PatientModel.fromMap(Map<String, dynamic> json) {
    return PatientModel(
      userId: json['userId'],
      patientId: json['patient_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dob: json['dob'],
      gender: json['gender'],
      relation: json['relation'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}
