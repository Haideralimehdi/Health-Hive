// ignore_for_file: file_names

class SpecialitiesModel {
  final String specialityId;
  final String specialityImg;
  final String specialityName;
 

  SpecialitiesModel({
    required this.specialityId,
    required this.specialityImg,
    required this.specialityName,
   
  });

  // Serialize the SpecialitiesModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'specialityId': specialityId,
      'specialityImg': specialityImg,
      'specialityName': specialityName
    };
  }

  // Create a SpecialitiesModel instance from a JSON map
  factory SpecialitiesModel.fromMap(Map<String, dynamic> json) {
    return SpecialitiesModel(
      specialityId: json['specialityId'],
      specialityImg: json['specialityImg'],
      specialityName: json['specialityName']
    );
  }
}
