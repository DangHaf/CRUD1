class SocialRequest {
  String? tokenLogin;
  String lang;
  String typeTokenLogin;
  String? fullName;
  String deviceID;
  String? avatar;
  String appType;

  SocialRequest({
    this.fullName,
    required this.typeTokenLogin,
    required this.deviceID,
    required this.lang,
    this.tokenLogin,
    this.avatar,
    this.appType = 'NAIL_SUPPLY',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': fullName,
      'typeTokenLogin': typeTokenLogin,
      'deviceID': deviceID,
      'lang': lang,
      'tokenLogin': tokenLogin,
      'avatar': avatar,
      'appType': appType,
    };
  }
}

class LoginRequest {
  String storeUserType;
  String lang;
  String password;
  String phone;
  String deviceID;
  String appType;

  LoginRequest({
    required this.phone,
    required this.password,
    required this.deviceID,
    required this.lang,
    required this.storeUserType,
    this.appType = 'NAIL_SUPPLY',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
      'deviceID': deviceID,
      'lang': lang,
      'storeUserType': storeUserType,
      'appType': appType,
    };
  }
}

class RegisterRequest {
  String fullName;
  String? nickName;
  String phone;
  String countryCode;
  String? email;
  String? address;
  String password;
  String storeUserType;
  String? otpCode;
  String appType;

  RegisterRequest({
    required this.fullName,
    this.nickName,
    required this.phone,
    required this.countryCode,
    this.email,
    this.address,
    required this.password,
    required this.storeUserType,
    this.otpCode,
    this.appType = 'NAIL_SUPPLY',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullName': fullName,
      'nickName': nickName,
      'phone': phone,
      'countryCode': countryCode,
      'email': email,
      'address': address,
      'password': password,
      'storeUserType': storeUserType,
      if (otpCode != null) 'otpCode': otpCode,
      'appType': appType,
    };
  }
}

class OTPRequest {
  String phone;

  OTPRequest({
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
    };
  }
}

class ResetPassWordRequest {
  String storeUserType;
  String password;
  String phone;
  String? otpCode;

  ResetPassWordRequest({
    required this.phone,
    required this.password,
    required this.storeUserType,
    this.otpCode,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
      'storeUserType': storeUserType,
      if (otpCode != null) 'otpCode': otpCode,
    };
  }
}
