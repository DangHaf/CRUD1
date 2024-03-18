// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';

class PackageModel {
  String? id;
  String? title;
  int? money;
  int? discountPercent;
  String? unit;
  int? days;
  PackageModel({
    this.id,
    this.title,
    this.money,
    this.discountPercent,
    this.unit,
    this.days,
  });

  PackageModel copyWith({
    String? id,
    String? title,
    int? money,
    int? discountPercent,
    String? unit,
    int? days,
  }) {
    return PackageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      money: money ?? this.money,
      discountPercent: discountPercent ?? this.discountPercent,
      unit: unit ?? this.unit,
      days: days ?? this.days,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'money': money,
      'discountPercent': discountPercent,
      'unit': unit,
      'days': days,
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      title: map['title'] != null
          ? !IZIValidate.nullOrEmpty((map['title'] as Map<String, dynamic>)[sl<SharedPreferenceHelper>().getLocale])
              ? (map['title'] as Map<String, dynamic>)[sl<SharedPreferenceHelper>().getLocale].toString()
              : (map['title'] as Map<String, dynamic>)['en'].toString()
          : null,
      money: map['money'] != null ? (map['money'] as num).toInt() : null,
      discountPercent: map['discountPercent'] != null ? (map['discountPercent'] as num).toInt() : null,
      unit: map['unit'] != null ? map['unit'] as String : null,
      days: map['days'] != null ? (map['days'] as num).toInt() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageModel.fromJson(String source) => PackageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PackageModel(id: $id, title: $title, money: $money, discountPercent: $discountPercent, unit: $unit, days: $days)';
  }

  @override
  bool operator ==(covariant PackageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.money == money &&
        other.discountPercent == discountPercent &&
        other.unit == unit &&
        other.days == days;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ money.hashCode ^ discountPercent.hashCode ^ unit.hashCode ^ days.hashCode;
  }
}
