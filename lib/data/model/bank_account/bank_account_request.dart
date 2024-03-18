import 'package:template/core/export/core_export.dart';

class BankAccountRequest {
  String bankName;
  String accountNumber;
  String accountName;
  String owner;
  String type;
  String countryCode;

  BankAccountRequest({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.type,
    required this.countryCode,
    this.owner = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "bankName": bankName,
      "accountNumber": accountNumber,
      "accountName": accountName,
      "owner": sl<SharedPreferenceHelper>().getIdUser,
      'countryCode': countryCode,
      "type": type
    };
  }
}
