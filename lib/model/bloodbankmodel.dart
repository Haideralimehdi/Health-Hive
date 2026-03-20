// ignore_for_file: file_names

class BloodDonorModel {
  final String donorId;
  final String userId;
  final String name;
  final String gender;
  final String phone;
  final String bloodGroup;
  final String donorImage;
  final String location;
  final String city;
  final bool isActive;

  BloodDonorModel({
    required this.donorId,
    required this.userId,
    required this.name,
    required this.gender,
    required this.phone,
    required this.bloodGroup,
    required this.donorImage,
    required this.location,
    required this.city,
    required this.isActive,
  });

  // Convert object to JSON map
  Map<String, dynamic> toMap() {
    return {
      'donorId': donorId,
      'userId': userId,
      'name': name,
      'gender': gender,
      'phone': phone,
      'bloodGroup': bloodGroup,
      'donorImage': donorImage,
      'location': location,
      'city': city,
      'isActive': isActive,
    };
  }

  // Convert JSON map to object
  factory BloodDonorModel.fromMap(Map<String, dynamic> json) {
    return BloodDonorModel(
      donorId: json['donorId'],
      userId: json['userId'],
      name: json['name'],
      gender: json['gender'],
      phone: json['phone'],
      bloodGroup: json['bloodGroup'],
      donorImage: json['donorImage'],
      location: json['location'],
      city: json['city'],
      isActive: json['isActive'],
    );
  }
}
