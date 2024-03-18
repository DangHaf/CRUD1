// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SettingsModel {
  String? id;
  String? linkShareIos;
  String? linkShareAndroid;
  String? termsAndService;
  String? privacyPolicy;
  List<String>? aiImages;
  List<int>? appShowRate;

  SettingsModel({
    this.id,
    this.linkShareIos,
    this.linkShareAndroid,
    this.termsAndService,
    this.privacyPolicy,
    this.aiImages,
    this.appShowRate,
  });

  SettingsModel copyWith({
    String? id,
    String? linkShareIos,
    String? linkShareAndroid,
    String? termsAndService,
    String? privacyPolicy,
    List<String>? aiImages,
    List<int>? appShowRate,
  }) {
    return SettingsModel(
      id: id ?? this.id,
      linkShareIos: linkShareIos ?? this.linkShareIos,
      linkShareAndroid: linkShareAndroid ?? this.linkShareAndroid,
      termsAndService: termsAndService ?? this.termsAndService,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      aiImages: aiImages ?? this.aiImages,
      appShowRate: appShowRate ?? this.appShowRate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'linkShareIos': linkShareIos,
      'linkShareAndroid': linkShareAndroid,
      'termsAndService': termsAndService,
      'privacyPolicy': privacyPolicy,
      'aiImages': aiImages,
      'appShowRate': appShowRate,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      id: map['id'] != null ? map['id'] as String : null,
      linkShareIos: map['linkShareIos'] != null ? map['linkShareIos'] as String : null,
      linkShareAndroid: map['linkShareAndroid'] != null ? map['linkShareAndroid'] as String : null,
      aiImages: map['aiImages'] != null ? List<String>.from(map['aiImages'] as List<dynamic>) : null,
      appShowRate: map['appShowRate'] != null ? List<int>.from(map['appShowRate'] as List<dynamic>) : [],
      termsAndService: map['termsAndService'] != null ? map['termsAndService'] as String : null,
      privacyPolicy: map['privacyPolicy'] != null ? map['privacyPolicy'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) => SettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SettingsModel(id: $id, linkShareIos: $linkShareIos, linkShareAndroid: $linkShareAndroid, termsAndService: $termsAndService, privacyPolicy: $privacyPolicy, aiImages: $aiImages, appShowRate: $appShowRate)';
  }

  @override
  bool operator ==(covariant SettingsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.linkShareIos == linkShareIos &&
        other.linkShareAndroid == linkShareAndroid &&
        other.termsAndService == termsAndService &&
        other.privacyPolicy == privacyPolicy &&
        listEquals(other.aiImages, aiImages) &&
        listEquals(other.appShowRate, appShowRate);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        linkShareIos.hashCode ^
        linkShareAndroid.hashCode ^
        termsAndService.hashCode ^
        privacyPolicy.hashCode ^
        aiImages.hashCode ^
        appShowRate.hashCode;
  }
}
