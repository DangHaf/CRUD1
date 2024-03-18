import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';

class TransactionModel {
  final String id;
  final String method;

  TransactionModel({
    this.id = '',
    this.method = '',
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['_id'] as String? ?? '',
      method: json['method'] as String? ?? '',
    );
  }

  String get getStringMethod {
    if(method == PAYPAL){
      return 'Paypal';
    }
    if(method == VISA){
      return 'Visa';
    }
    if(method == TRANSFER){
      return 'transaction_018'.tr;
    }
    return '';
  }
}
