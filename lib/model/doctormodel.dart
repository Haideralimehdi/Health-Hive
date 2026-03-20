class DoctorModel {
  final String doctorId;
  final String userId; // ✅ New field
  final String name;
  final String phone;
  final String qualification;
  final String specialty;
  final String experience;
  final String hospital;
  final String imageUrl;
  final double rating;
  final String fee;
  final List<dynamic> availableslots;

  DoctorModel({
    required this.doctorId,
    required this.userId, // ✅ Add to constructor
    required this.name,
    required this.phone,
    required this.qualification,
    required this.specialty,
    required this.experience,
    required this.hospital,
    required this.imageUrl,
    required this.rating,
    required this.fee,
    required this.availableslots,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'userId': userId, // ✅ Add to map
      'name': name,
      'phone': phone,
      'qualification': qualification,
      'specialty': specialty,
      'experience': experience,
      'hospital': hospital,
      'imageUrl': imageUrl,
      'rating': rating,
      'fee': fee,
      'availableslots': availableslots,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctorId'],
      userId: json['userId'], // ✅ Parse userId
      name: json['name'],
      phone: json['phone'],
      qualification: json['qualification'],
      specialty: json['specialty'],
      experience: json['experience'],
      hospital: json['hospital'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : json['rating'],
      fee: json['fee'],
      availableslots: (json['availableslots'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
