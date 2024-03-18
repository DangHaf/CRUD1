// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/core/export/core_export.dart';

class LatestReceiptInfoModel {
  int? quantity;
  String? productId;
  String? transactionId;
  DateTime? purchaseDateMs;
  DateTime? originalPurchaseDateMs;
  DateTime? expiresDateMs;
  LatestReceiptInfoModel({
    this.quantity,
    this.productId,
    this.transactionId,
    this.purchaseDateMs,
    this.originalPurchaseDateMs,
    this.expiresDateMs,
  });

  LatestReceiptInfoModel copyWith({
    int? quantity,
    String? productId,
    String? transactionId,
    DateTime? purchaseDateMs,
    DateTime? originalPurchaseDateMs,
    DateTime? expiresDateMs,
  }) {
    return LatestReceiptInfoModel(
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      transactionId: transactionId ?? this.transactionId,
      purchaseDateMs: purchaseDateMs ?? this.purchaseDateMs,
      originalPurchaseDateMs: originalPurchaseDateMs ?? this.originalPurchaseDateMs,
      expiresDateMs: expiresDateMs ?? this.expiresDateMs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'product_id': productId,
      'transaction_id': transactionId,
      'purchase_date_ms': purchaseDateMs?.millisecondsSinceEpoch,
      'original_purchase_date_ms': originalPurchaseDateMs?.millisecondsSinceEpoch,
      'expires_date_ms': expiresDateMs?.millisecondsSinceEpoch,
    };
  }

  factory LatestReceiptInfoModel.fromMap(Map<String, dynamic> map) {
    return LatestReceiptInfoModel(
      quantity: map['quantity'] != null ? IZINumber.parseInt(map['quantity']) : null,
      productId: map['product_id'] != null ? map['product_id'] as String : null,
      transactionId: map['transaction_id'] != null ? map['transaction_id'] as String : null,
      purchaseDateMs: map['purchase_date_ms'] != null
          ? DateTime.fromMillisecondsSinceEpoch(IZINumber.parseInt(map['purchase_date_ms']))
          : null,
      originalPurchaseDateMs: map['original_purchase_date_ms'] != null
          ? DateTime.fromMillisecondsSinceEpoch(IZINumber.parseInt(map['original_purchase_date_ms']))
          : null,
      expiresDateMs: map['expires_date_ms'] != null
          ? DateTime.fromMillisecondsSinceEpoch(IZINumber.parseInt(map['expires_date_ms']))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LatestReceiptInfoModel.fromJson(String source) =>
      LatestReceiptInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant LatestReceiptInfoModel other) {
    if (identical(this, other)) return true;

    return other.quantity == quantity &&
        other.productId == productId &&
        other.transactionId == transactionId &&
        other.purchaseDateMs == purchaseDateMs &&
        other.originalPurchaseDateMs == originalPurchaseDateMs &&
        other.expiresDateMs == expiresDateMs;
  }

  @override
  int get hashCode {
    return quantity.hashCode ^
        productId.hashCode ^
        transactionId.hashCode ^
        purchaseDateMs.hashCode ^
        originalPurchaseDateMs.hashCode ^
        expiresDateMs.hashCode;
  }

  @override
  String toString() {
    return 'LatestReceiptInfoModel(quantity: $quantity, productId: $productId, transactionId: $transactionId, purchaseDateMs: $purchaseDateMs, originalPurchaseDateMs: $originalPurchaseDateMs, expiresDateMs: $expiresDateMs)';
  }
}
