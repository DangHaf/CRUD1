// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/core/helper/izi_validate.dart';

class UserModel {
  String? id;
  String? email;
  String? fullName;
  String? password;
  String? language;
  bool? isPremium;
  String? deviceID;
  String? avatar;
  DateTime? premiumStartDate;
  DateTime? premiumEndDate;
  UserModel({
    this.id,
    this.email,
    this.fullName,
    this.password,
    this.language,
    this.isPremium,
    this.deviceID,
    this.avatar,
    this.premiumStartDate,
    this.premiumEndDate,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? password,
    String? language,
    bool? isPremium,
    String? deviceID,
    String? avatar,
    DateTime? premiumStartDate,
    DateTime? premiumEndDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      language: language ?? this.language,
      isPremium: isPremium ?? this.isPremium,
      deviceID: deviceID ?? this.deviceID,
      avatar: avatar ?? this.avatar,
      premiumStartDate: premiumStartDate ?? this.premiumStartDate,
      premiumEndDate: premiumEndDate ?? this.premiumEndDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) '_id': id,
      if (!IZIValidate.nullOrEmpty(email)) 'email': email,
      if (!IZIValidate.nullOrEmpty(fullName)) 'fullName': fullName,
      if (!IZIValidate.nullOrEmpty(password)) 'password': password,
      if (!IZIValidate.nullOrEmpty(language)) 'language': language,
      if (!IZIValidate.nullOrEmpty(isPremium)) 'isPremium': isPremium,
      if (!IZIValidate.nullOrEmpty(deviceID)) 'deviceID': deviceID,
      if (!IZIValidate.nullOrEmpty(avatar)) 'avatar': avatar,
      if (!IZIValidate.nullOrEmpty(premiumStartDate)) 'premiumStartDate': premiumStartDate?.millisecondsSinceEpoch,
      if (!IZIValidate.nullOrEmpty(premiumEndDate)) 'premiumEndDate': premiumEndDate?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      isPremium: map['isPremium'] != null ? map['isPremium'] as bool : null,
      deviceID: map['deviceID'] != null ? map['deviceID'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      premiumStartDate:
          map['premiumStartDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['premiumStartDate'] as int) : null,
      premiumEndDate:
          map['premiumEndDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['premiumEndDate'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, fullName: $fullName, password: $password, language: $language, isPremium: $isPremium, deviceID: $deviceID, avatar: $avatar, premiumStartDate: $premiumStartDate, premiumEndDate: $premiumEndDate)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.fullName == fullName &&
        other.password == password &&
        other.language == language &&
        other.isPremium == isPremium &&
        other.deviceID == deviceID &&
        other.avatar == avatar &&
        other.premiumStartDate == premiumStartDate &&
        other.premiumEndDate == premiumEndDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        fullName.hashCode ^
        password.hashCode ^
        language.hashCode ^
        isPremium.hashCode ^
        deviceID.hashCode ^
        avatar.hashCode ^
        premiumStartDate.hashCode ^
        premiumEndDate.hashCode;
  }
}
