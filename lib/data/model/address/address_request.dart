import 'package:template/core/utils/app_constants.dart';

class AddressRequest {
  String idUser;
  String idState;
  String idCity;
  String addressDetail;
  String fullName;
  String phone;
  bool isDefault;
  String appType;

  AddressRequest({
    required this.idCity,
    required this.idUser,
    required this.idState,
    required this.addressDetail,
    required this.phone,
    required this.fullName,
    this.isDefault = false,
    this.appType = NAIL_SUPPLY,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idUser': idUser,
      'idCity': idCity,
      'idState': idState,
      'addressDetail': addressDetail,
      'phone': phone,
      'fullName': fullName,
      'isDefault': isDefault,
      'appType': appType,
    };
  }
}
