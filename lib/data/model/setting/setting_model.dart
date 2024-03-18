class SettingModel {
  final String? id;
  final String? linkAndroid;
  final String? linkIos;
  final bool isOTPRegister;
  final bool isOTPForget;
  final bool isOTPUpdate;
  final String? linkShareNailSupply;

  SettingModel({
    this.id,
    this.linkAndroid,
    this.linkIos,
    this.isOTPRegister = false,
    this.isOTPForget = false,
    this.isOTPUpdate = false,
    this.linkShareNailSupply,
  });

  factory SettingModel.fromJson(Map<String, dynamic> map) {
    return SettingModel(
      id: map['id'] as String?,
      linkAndroid: map['linkAndroid'] as String?,
      linkIos: map['linkIos'] as String?,
      isOTPRegister: map['isOTPRegister'] as bool? ?? false,
      isOTPForget: map['isOTPForget'] as bool? ?? false,
      isOTPUpdate: map['isOTPUpdate'] as bool? ?? false,
      linkShareNailSupply: map['linkShareNailSupply'] as String?,
    );
  }
}
