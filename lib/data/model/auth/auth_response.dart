
import 'dart:io';

class PhoneCountry {
  final String? phoneNumber;
  final bool isValid;
  final String? countryCode;
  final String? phoneNational;
  final String? countryIso3;
  final String? countryIso2;

  PhoneCountry({
    this.isValid = false,
    this.phoneNumber,
    this.countryCode,
    this.phoneNational,
    this.countryIso3,
    this.countryIso2,
  });

  factory PhoneCountry.fromJson(Map<String, dynamic> json) {
    return PhoneCountry(
      phoneNumber: json['phoneNumber'] as String?,
      countryCode: json['countryCode'] as String?,
      phoneNational: json['phoneNational'] as String?,
      countryIso3: json['countryIso3'] as String?,
      countryIso2: json['countryIso2'] as String?,
      isValid: json['isValid'] as bool? ?? false,
    );
  }
}

class AuthResponse {
  final String? accessToken;
  final String? refreshToken;
  final UserModel? user;

  AuthResponse({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserModel {
  final String? id;
  String? avatar;
  String? gender;
  String? nickName;
  String? fullName;
  String? phone;
  String? countryCode;
  String? address;
  String? email;
  DateTime? dateOfBirth;
  final List<OtherAddress> otherAddress;
  String? idState;
  String? idCity;

  /// Only UI
  File? avatarFile;

  UserModel({
    this.id,
    this.avatar,
    this.gender,
    this.nickName,
    this.fullName,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.countryCode,
    this.email,
    this.otherAddress = const [],
    this.avatarFile,
    this.idState,
    this.idCity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar,
      'gender': gender,
      'nickName': nickName,
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'countryCode': countryCode,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      if (email != null && email!.isNotEmpty) 'email': email,
      'otherAddress': otherAddress.map((e) => e.toJson()).toList(),
      'idState': idState,
      'idCity': idCity,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as String?,
      nickName: json['nickName'] as String?,
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['countryCode'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['dateOfBirth'] as int)
          : null,
      otherAddress: (json['otherAddress'] as List<dynamic>?)
          ?.map((dynamic e) =>
          OtherAddress.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const [],
      idState: json['idState'] as String?,
      idCity: json['idCity'] as String?,
    );
  }
}

class OtherAddress {
  final String? id;
  final String? address;
  final String? title;

  OtherAddress({
    this.id,
    this.address,
    this.title,
  });

  factory OtherAddress.fromJson(Map<String, dynamic> json) {
    return OtherAddress(
      id: json['_id'] as String?,
      address: json['address'] as String?,
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'address': address,
      'title': title,
    };
  }
}
