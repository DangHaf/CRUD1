class UpdateStudentRequest {
  // final String? id;
  final ContactInfoRequest? contactInfo;
  final List<String>? registeredCourses;
  final double? averageScore;
  final int? dateOfBirth;
  // final String? classInfo;
  final String? fullName;

  UpdateStudentRequest({
    // this.id,
    this.contactInfo,
    this.registeredCourses,
    this.averageScore,
    this.dateOfBirth,
    // this.classInfo,
    this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'contactInfo': contactInfo?.toJson(),
      'registeredCourses': registeredCourses,
      'averageScore': averageScore,
      'dateOfBirth': dateOfBirth,
      // 'classInfo': classInfo,
      'fullName': fullName,
    };
  }
}

class ContactInfoRequest {
  final String? id;
  final String? address;
  final String? email;
  final String? phoneNumber;

  ContactInfoRequest({
    this.id,
    this.address,
    this.email,
    this.phoneNumber,
  });

  factory ContactInfoRequest.fromJson(Map<String, dynamic> json) {
    return ContactInfoRequest(
      id: json['_id'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}

class AddStudentRequest {
  final ContactAddInfoRequest contactInfo;
  final List<String> registeredCourses;
  final double averageScore;
  final int? dateOfBirth;
  final String classInfo;
  final String fullName;

  AddStudentRequest({
    required this.contactInfo,
    required this.registeredCourses,
    required this.averageScore,
    required this.dateOfBirth,
    required this.classInfo,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'contactInfo': contactInfo.toJson(),
      'registeredCourses': registeredCourses,
      'averageScore': averageScore,
      'dateOfBirth': dateOfBirth,
      'class': classInfo,
      'fullName': fullName,
    };
  }
}

class ContactAddInfoRequest {
  final String address;
  final String email;
  final String phoneNumber;

  ContactAddInfoRequest({
    required this.address,
    required this.email,
    required this.phoneNumber,
  });

  factory ContactAddInfoRequest.fromJson(Map<String, dynamic> json) {
    return ContactAddInfoRequest(
      address: json['address'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
