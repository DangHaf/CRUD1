import 'dart:convert';

import 'package:template/core/utils/app_constants.dart';

class BankAccountModel {
  final String id;
  final String type;
  final String ccv;
  final String expirationDate;
  final String phone;
  final String passport;
  final String holder;
  final bool isShow;
  final String thumbnail;
  final String bankName;
  final String accountNumber;
  final String accountName;
  final String clientId;
  final String secretKey;
  final String currency;
  final String description;
  final String note;

  BankAccountModel({
    this.id = '',
    this.type = '',
    this.ccv = '',
    this.expirationDate = '',
    this.phone = '',
    this.passport = '',
    this.holder = '',
    this.isShow = true,
    this.thumbnail = '',
    this.bankName = '',
    this.accountNumber = '',
    this.accountName = '',
    this.secretKey = SECRETKEY,
    this.clientId = CLIENT_ID,
    this.currency = CURRENCY,
    this.description = DESCRIPTION,
    this.note = NOTE_PAYPAL,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['_id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      ccv: json['ccv'] as String? ?? '',
      expirationDate: json['expirationDate'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      passport: json['passport'] as String? ?? '',
      holder: json['holder'] as String? ?? '',
      isShow: json['isShow'] as bool? ?? true,
      thumbnail: json['thumbnail'] as String? ?? '',
      bankName: json['bankName'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      accountName: json['accountName'] as String? ?? '',
      secretKey: json['secretKey'] != null && json['secretKey'] != ''
          ? json['secretKey'] as String
          : SECRETKEY,
      clientId: json['clientId'] != null && json['clientId'] != ''
          ? json['clientId'] as String
          : CLIENT_ID,
      currency: json['currency'] != null && json['currency'] != ''
          ? json['currency'] as String
          : CURRENCY,
      description: json['description'] != null && json['description'] != ''
          ? json['description'] as String
          : DESCRIPTION,
      note: json['note'] != null && json['note'] != ''
          ? json['note'] as String
          : NOTE_PAYPAL,
    );
  }
}

class BankAccountResponse {
  String? id;
  String? ccv;
  String? expirationDate;
  String? phone;
  String? passport;
  String? holder;
  String? thumbnail;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? owner;
  String? idStore;
  bool? isSelect;
  String? type;
  String? countryCode;

  BankAccountResponse({
    this.id,
    this.ccv,
    this.expirationDate,
    this.phone,
    this.passport,
    this.holder,
    this.thumbnail,
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.owner,
    this.idStore,
    this.isSelect = false,
    this.type,
    this.countryCode,
  });

  factory BankAccountResponse.fromMap(Map<String, dynamic> map) {
    return BankAccountResponse(
      id: map['_id'] as String?,
      ccv: map['ccv'] as String?,
      expirationDate: map['expirationDate'] as String?,
      phone: map['phone'] as String?,
      passport: map['passport'] as String?,
      holder: map['holder'] as String?,
      thumbnail: map['thumbnail'] as String?,
      bankName: map['bankName'] as String?,
      accountNumber: map['accountNumber'] as String?,
      accountName: map['accountName'] as String?,
      owner: map['owner'] as String?,
      idStore: map['idStore'] as String?,
      type: map['type'] as String?,
      countryCode: map['countryCode'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) '_id': id,
      if (ccv != null) 'ccv': ccv,
      if (expirationDate != null) 'expirationDate': expirationDate,
      if (phone != null) 'phone': phone,
      if (passport != null) 'passport': passport,
      if (holder != null) 'holder': holder,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (bankName != null) 'bankName': bankName,
      if (accountNumber != null) 'accountNumber': accountNumber,
      if (accountName != null) 'accountName': accountName,
      if (owner != null) 'owner': owner,
      if (idStore != null) 'idStore': idStore,
      if (type != null) 'type': type,
      if (countryCode != null) 'countryCode': countryCode,
    };
  }

  String toJson() => json.encode(toMap());
}
