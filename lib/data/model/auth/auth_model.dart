// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'dart:convert';

import 'package:template/core/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthModel {
  String? id;
  String? deviceID;
  String? accessToken;
  String? refreshToken;
  String? language;
  bool? isPremium;
  String? idPremium;
  int? aiCountFreeMessages;
  String? avatar;
  DateTime? premiumStartDate;
  DateTime? premiumEndDate;
  String? appType;
  AuthModel({
    this.id,
    this.deviceID,
    this.accessToken,
    this.refreshToken,
    this.language,
    this.isPremium,
    this.idPremium,
    this.aiCountFreeMessages,
    this.avatar,
    this.premiumStartDate,
    this.premiumEndDate,
    this.appType,
  });

  AuthModel copyWith({
    String? id,
    String? deviceID,
    String? accessToken,
    String? refreshToken,
    String? language,
    bool? isPremium,
    String? idPremium,
    int? aiCountFreeMessages,
    String? avatar,
    DateTime? premiumStartDate,
    DateTime? premiumEndDate,
    String? appType,
  }) {
    return AuthModel(
      id: id ?? this.id,
      deviceID: deviceID ?? this.deviceID,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      language: language ?? this.language,
      isPremium: isPremium ?? this.isPremium,
      idPremium: idPremium ?? this.idPremium,
      aiCountFreeMessages: aiCountFreeMessages ?? this.aiCountFreeMessages,
      avatar: avatar ?? this.avatar,
      premiumStartDate: premiumStartDate ?? this.premiumStartDate,
      premiumEndDate: premiumEndDate ?? this.premiumEndDate,
      appType: appType ?? this.appType,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(id: $id, deviceID: $deviceID, accessToken: $accessToken, refreshToken: $refreshToken, language: $language, isPremium: $isPremium, idPremium: $idPremium, aiCountFreeMessages: $aiCountFreeMessages, avatar: $avatar, premiumStartDate: $premiumStartDate, premiumEndDate: $premiumEndDate)';
  }

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.deviceID == deviceID &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.language == language &&
        other.isPremium == isPremium &&
        other.idPremium == idPremium &&
        other.aiCountFreeMessages == aiCountFreeMessages &&
        other.avatar == avatar &&
        other.premiumStartDate == premiumStartDate &&
        other.appType == appType &&
        other.premiumEndDate == premiumEndDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deviceID.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        language.hashCode ^
        isPremium.hashCode ^
        idPremium.hashCode ^
        aiCountFreeMessages.hashCode ^
        avatar.hashCode ^
        premiumStartDate.hashCode ^
        appType.hashCode ^
        premiumEndDate.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) '_id': id,
      if (!IZIValidate.nullOrEmpty(avatar)) 'avatar': avatar,
      if (!IZIValidate.nullOrEmpty(deviceID)) 'deviceID': deviceID,
      if (!IZIValidate.nullOrEmpty(accessToken)) 'accessToken': accessToken,
      if (!IZIValidate.nullOrEmpty(refreshToken)) 'refreshToken': refreshToken,
      if (!IZIValidate.nullOrEmpty(language)) 'language': language,
      if (!IZIValidate.nullOrEmpty(isPremium)) 'isPremium': isPremium,
      if (!IZIValidate.nullOrEmpty(idPremium)) 'idPremium': idPremium,
      if (!IZIValidate.nullOrEmpty(appType)) 'appType': appType,
      if (!IZIValidate.nullOrEmpty(premiumStartDate)) 'premiumStartDate': premiumStartDate?.millisecondsSinceEpoch,
      if (!IZIValidate.nullOrEmpty(premiumEndDate)) 'premiumEndDate': premiumEndDate?.millisecondsSinceEpoch,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      deviceID: map['deviceID'] != null ? map['deviceID'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      appType: map['appType'] != null ? map['appType'] as String : null,
      accessToken: map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken: map['refreshToken'] != null ? map['refreshToken'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      isPremium: map['isPremium'] != null ? map['isPremium'] as bool : false,
      idPremium: map['idPremium'] != null ? map['idPremium'] as String : null,
      aiCountFreeMessages: map['aiCountFreeMessages'] != null ? (map['aiCountFreeMessages'] as num).toInt() : 0,
      premiumStartDate:
          map['premiumStartDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['premiumStartDate'] as int) : null,
      premiumEndDate:
          map['premiumEndDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['premiumEndDate'] as int) : null,
    );
  }
}
