class StudentModel {
  final String id;
  final ContactInfo contactInfo;
  final List<String> registeredCourses;
  final double averageScore;
  final int? dateOfBirth;
  final String classInfo;
  final String fullName;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentModel({
    required this.id,
    required this.contactInfo,
    required this.registeredCourses,
    required this.averageScore,
    required this.dateOfBirth,
    required this.classInfo,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'] as String,
      contactInfo:
          ContactInfo.fromJson(json['contactInfo'] as Map<String, dynamic>),
      registeredCourses:
          List<String>.from(json['registeredCourses'] as List<dynamic>),
      averageScore: (json['averageScore'] as num).toDouble(),
      dateOfBirth: json['dateOfBirth'] as int?,
      classInfo: json['class'] as String,
      fullName: json['fullName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class ContactInfo {
  final String address;
  final String email;
  final String phoneNumber;
  final String id;

  ContactInfo({
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.id,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      address: json['address'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      id: json['_id'] as String,
    );
  }
}
