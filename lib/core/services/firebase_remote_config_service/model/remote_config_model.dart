// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_bool_literals_in_conditional_expressions
import 'dart:convert';

class RemoveConfigModel {
  bool? enableAds;
  RemoveConfigModel({
    this.enableAds = true,
  });

  RemoveConfigModel copyWith({
    bool? enableAds,
  }) {
    return RemoveConfigModel(
      enableAds: enableAds ?? this.enableAds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enable_ads': enableAds,
    };
  }

  factory RemoveConfigModel.fromMap(Map<String, dynamic> map) {
    return RemoveConfigModel(
      enableAds: map['enable_ads'] != null ? map['enable_ads'] as bool : true,
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoveConfigModel.fromJson(String source) =>
      RemoveConfigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RemoveConfigModel(enable_ads: $enableAds)';

  @override
  bool operator ==(covariant RemoveConfigModel other) {
    if (identical(this, other)) return true;

    return other.enableAds == enableAds;
  }

  @override
  int get hashCode => enableAds.hashCode;
}
