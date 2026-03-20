class AppointmentModel {
  String appointmentId;
  String doctorId;
  String patientId;
  String doctorName;
  String  doctorImage;
  String patientName;
  DateTime appointmentDate;
  String appointmentTime;
  double consultationFee;
  double hospitalCharge;
  double bookingCharge;
  double totalAmount;
  String status; // e.g., pending, confirmed, cancelled

  AppointmentModel({

    required this.appointmentId,
    required this.doctorId,
    required this.patientId,
    required this.doctorName,
    required this.doctorImage,
    required this.patientName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.consultationFee,
    required this.hospitalCharge,
    required this.bookingCharge,
    required this.totalAmount,
    required this.status,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'doctorId': doctorId,
      'patientId': patientId,
      'doctorName': doctorName,
      'doctorImage': doctorImage,
      'patientName': patientName,
      'appointmentDate': appointmentDate.toIso8601String(),
      'appointmentTime': appointmentTime,
      'consultationFee': consultationFee,
      'hospitalCharge': hospitalCharge,
      'bookingCharge': bookingCharge,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  // Create from JSON
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointmentId'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      doctorName: json['doctorName'],
      doctorImage: json['doctorImage'],
      patientName: json['patientName'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      appointmentTime: json['appointmentTime'],
      consultationFee: (json['consultationFee'] as num).toDouble(),
      hospitalCharge: (json['hospitalCharge'] as num).toDouble(),
      bookingCharge: (json['bookingCharge'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'],
    );
  }
}
