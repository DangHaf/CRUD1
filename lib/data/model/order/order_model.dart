import 'dart:ui';

import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/utils/extensions/date_time_extension.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/transaction/transaction_model.dart';

class OrderResponse {
  final List<OrderModel> result;
  final int totalResults;
  final int totalPages;

  OrderResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map(
                  (dynamic e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
    );
  }
}

class OrderModel {
  final String id;
  final String status;
  final String idStore;
  final num totalMoney;
  List<PurchaseDetailModel> purchaseDetails;

  OrderModel({
    this.id = '',
    this.status = '',
    this.idStore = '',
    this.totalMoney = 0,
    this.purchaseDetails = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      idStore: json['idStore'] as String? ?? '',
      totalMoney: json['totalMoney'] as num? ?? 0,
      purchaseDetails: (json['purchaseDetails'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  PurchaseDetailModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  bool get isEvaluated {
    for (int i = 0; i < purchaseDetails.length; i++) {
      if (purchaseDetails[i].isEvaluated) {
        return true;
      }
    }
    return false;
  }

  Color get colorStatus {
    if (status == WAIT_FOR_CONFIRMATION) {
      return ColorResources.COLOR_FFD600;
    }
    if (status == CONFIRMED) {
      return ColorResources.COLOR_130FAB;
    }
    if (status == PACKING) {
      return ColorResources.COLOR_00BCB0;
    }
    if (status == DELIVERING) {
      return ColorResources.COLOR_CD09A2;
    }
    if (status == DELIVERED) {
      return ColorResources.COLOR_0B8A4D;
    }
    if (status == RECEIVED) {
      return ColorResources.COLOR_5A0B8A;
    }
    if (status == CUSTOMER_CANCELED || status == STORE_CANCELED) {
      return ColorResources.COLOR_E9330B;
    }
    if (status == RETURN ||
        status == ACCEPT_RETURN ||
        status == REFUSE_RETURN) {
      return ColorResources.COLOR_FA6900;
    }
    return ColorResources.COLOR_677275;
  }

  String get stringStatus {
    if (status == WAIT_FOR_CONFIRMATION) {
      return 'order_002'.tr;
    }
    if (status == CONFIRMED) {
      return 'order_005'.tr;
    }
    if (status == PACKING) {
      return 'order_004'.tr;
    }
    if (status == DELIVERING) {
      return 'order_048'.tr;
    }
    if (status == DELIVERED) {
      return 'order_006'.tr;
    }
    if (status == RECEIVED) {
      return 'order_007'.tr;
    }
    if (status == CUSTOMER_CANCELED || status == STORE_CANCELED) {
      return 'order_029'.tr;
    }
    if (status == RETURN ||
        status == ACCEPT_RETURN ||
        status == REFUSE_RETURN) {
      return 'order_009'.tr;
    }
    return '';
  }

  String? get stringSubStatus {
    if (status == RETURN) {
      return ' - ${'order_030'.tr}';
    }
    if (status == REFUSE_RETURN) {
      return ' - ${'order_031'.tr}';
    }
    return null;
  }

  Color? get colorSubStatus {
    if (status == RETURN) {
      return ColorResources.COLOR_677275;
    }

    if (status == REFUSE_RETURN) {
      return ColorResources.COLOR_EB0F0F;
    }
    return null;
  }

  String get stringQuantity {
    int quantity = 0;
    for (int i = 0; i < purchaseDetails.length; i++) {
      quantity += purchaseDetails[i].quantity;
    }
    if (quantity == 1) {
      return 'order_045'.trParams({'quantity': quantity.toString()});
    }
    return 'order_045'.trParams({'quantity': quantity.toString()});
  }
}

class PurchaseModel {
  final String id;
  final String? idProduct;
  final OptionProductModel? idOptionProduct;
  final int quantity;
  final num price;
  final bool isEvaluated;

  PurchaseModel({
    this.id = '',
    this.idOptionProduct,
    this.idProduct,
    this.quantity = 0,
    this.price = 0,
    this.isEvaluated = false,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['_id'] as String? ?? '',
      idProduct: json['idProduct'] as String? ?? '',
      idOptionProduct: json['idOptionProduct'] != null
          ? OptionProductModel.fromJson(
              json['idOptionProduct'] as Map<String, dynamic>)
          : null,
      quantity: json['quantity'] as int? ?? 0,
      price: json['price'] as num? ?? 0,
      isEvaluated: json['isEvaluated'] as bool? ?? false,
    );
  }
}

class OrderDetailModel {
  final String id;
  final String status;
  final num totalReduceMoney;
  final num totalShipMoney;
  final num totalTaxMoney;
  final num totalProductMoney;
  final num totalMoney;
  final String cancelationReason;
  final String descriptionReason;
  final String code;
  final TransactionModel? idTransaction;
  final AddressModel? idAddress;
  final ProviderModel? idStore;
  List<PurchaseDetailModel> purchaseDetails;
  List<String> images;
  final DateTime? createdAt;

  OrderDetailModel({
    this.id = '',
    this.status = '',
    this.totalReduceMoney = 0,
    this.totalShipMoney = 0,
    this.totalTaxMoney = 0,
    this.totalProductMoney = 0,
    this.totalMoney = 0,
    this.cancelationReason = '',
    this.descriptionReason = '',
    this.code = '',
    this.idTransaction,
    this.idStore,
    this.idAddress,
    this.createdAt,
    this.purchaseDetails = const [],
    this.images = const [],
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['_id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      totalReduceMoney: json['totalReduceMoney'] as num? ?? 0,
      totalShipMoney: json['totalShipMoney'] as num? ?? 0,
      totalTaxMoney: json['totalTaxMoney'] as num? ?? 0,
      totalProductMoney: json['totalProductMoney'] as num? ?? 0,
      totalMoney: json['totalMoney'] as num? ?? 0,
      cancelationReason: json['cancelationReason'] as String? ?? '',
      descriptionReason: json['descriptionReason'] as String? ?? '',
      code: json['code'] as String? ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : [],
      idTransaction: json['idTransaction'] != null
          ? TransactionModel.fromJson(
              json['idTransaction'] as Map<String, dynamic>)
          : null,
      idStore: json['idStore'] != null
          ? ProviderModel.fromJson(json['idStore'] as Map<String, dynamic>)
          : null,
      idAddress: json['idAddress'] != null
          ? AddressModel.fromJson(json['idAddress'] as Map<String, dynamic>)
          : null,
      purchaseDetails: (json['purchaseDetails'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  PurchaseDetailModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  String get timeOrder {
    if (createdAt != null) {
      return createdAt!.formatTimeOrder;
    }
    return '';
  }

  bool get isEvaluated {
    for (int i = 0; i < purchaseDetails.length; i++) {
      if (!purchaseDetails[i].isEvaluated) {
        return false;
      }
    }
    return true;
  }

  bool get isReturn {
    if (status == RETURN ||
        status == ACCEPT_RETURN ||
        status == REFUSE_RETURN) {
      return true;
    }
    return false;
  }

  bool get isShowSubStatus {
    if (status == RETURN || status == REFUSE_RETURN) {
      return true;
    }
    return false;
  }

  Color get colorStatus {
    if (status == WAIT_FOR_CONFIRMATION) {
      return ColorResources.COLOR_FFD600;
    }
    if (status == CONFIRMED) {
      return ColorResources.COLOR_130FAB;
    }
    if (status == DELIVERING) {
      return ColorResources.COLOR_00BCB0;
    }
    if (status == DELIVERED) {
      return ColorResources.COLOR_0B8A4D;
    }
    if (status == RECEIVED) {
      return ColorResources.COLOR_5A0B8A;
    }
    if (status == CUSTOMER_CANCELED || status == STORE_CANCELED) {
      return ColorResources.COLOR_E9330B;
    }
    if (status == RETURN ||
        status == ACCEPT_RETURN ||
        status == REFUSE_RETURN) {
      return ColorResources.COLOR_FA6900;
    }
    return ColorResources.COLOR_677275;
  }

  String get stringStatus {
    if (status == WAIT_FOR_CONFIRMATION) {
      return 'order_002'.tr;
    }
    if (status == CONFIRMED) {
      return 'order_005'.tr;
    }
    if (status == DELIVERING) {
      return 'order_004'.tr;
    }
    if (status == DELIVERED) {
      return 'order_006'.tr;
    }
    if (status == RECEIVED) {
      return 'order_007'.tr;
    }
    if (status == CUSTOMER_CANCELED || status == STORE_CANCELED) {
      return 'order_029'.tr;
    }
    if (status == RETURN ||
        status == ACCEPT_RETURN ||
        status == REFUSE_RETURN) {
      return 'order_009'.tr;
    }
    return '';
  }

  String? get stringSubStatus {
    if (status == RETURN) {
      return 'order_030'.tr;
    }
    if (status == REFUSE_RETURN) {
      return 'order_031'.tr;
    }
    return null;
  }

  Color? get colorSubStatus {
    if (status == RETURN) {
      return ColorResources.COLOR_677275;
    }

    if (status == REFUSE_RETURN) {
      return ColorResources.COLOR_EB0F0F;
    }
    return null;
  }

  bool get isTimeLineCanceled {
    if (status == CUSTOMER_CANCELED || status == STORE_CANCELED) {
      return true;
    }
    return false;
  }

  bool get isTimeLineConfirmed {
    if (status == WAIT_FOR_CONFIRMATION) {
      return false;
    }
    return true;
  }

  bool get isTimeLinePackaged {
    if (status == WAIT_FOR_CONFIRMATION || status == CONFIRMED) {
      return false;
    }
    return true;
  }

  bool get isTimeLineDelivering {
    if (status == WAIT_FOR_CONFIRMATION ||
        status == CONFIRMED ||
        status == PACKING) {
      return false;
    }
    return true;
  }

  bool get isTimeLineReturn {
    if (status == RETURN ||
        status == ACCEPT_RETURN ||
        status == REFUSE_RETURN) {
      return true;
    }
    return false;
  }

  bool get isTimeLineReceivedOrDelivered {
    if (status == RECEIVED || status == DELIVERED) {
      return true;
    }
    return false;
  }
}

class PurchaseDetailModel {
  final String id;
  final OptionProductModel? idOptionProduct;
  final int quantity;
  final num price;
  final bool isEvaluated;

  /// to use rating
  int rating;
  String contentComment;

  PurchaseDetailModel({
    this.id = '',
    this.idOptionProduct,
    this.quantity = 0,
    this.price = 0,
    this.isEvaluated = false,
    this.rating = 5,
    this.contentComment = '',
  });

  factory PurchaseDetailModel.fromJson(Map<String, dynamic> json) {
    return PurchaseDetailModel(
      id: json['_id'] as String? ?? '',
      idOptionProduct: json['idOptionProduct'] != null
          ? OptionProductModel.fromJson(
              json['idOptionProduct'] as Map<String, dynamic>)
          : null,
      quantity: json['quantity'] as int? ?? 0,
      price: json['price'] as num? ?? 0,
      isEvaluated: json['isEvaluated'] as bool? ?? false,
    );
  }
}

class ItemReviewModel {
  final String idOrder;
  final ProductModel product;
  final List<OptionProductModel> idOptionProduct;

  /// to use rating
  int rating;
  String contentComment;

  ItemReviewModel({
    this.idOrder = '',
    required this.product,
    required this.idOptionProduct,
    this.rating = 5,
    this.contentComment = '',
  });

  List<String> get idOptionProducts {
    final List<String> data = [];
    for (int i = 0; i < idOptionProduct.length; i++) {
      data.add(idOptionProduct[i].id!);
    }
    return data;
  }

  String get option {
    String data = '${'cart_016'.tr}: ';
    for (int i = 0; i < idOptionProduct.length; i++) {
      data = '$data${idOptionProduct[i].title}, ';
    }
    return data.substring(0, data.length - 2);
  }
}

class CountOrderModel {
  final int countWaitForConfirmation;
  final int countConfirmed;
  final int countDelivering;
  final int countPacking;

  CountOrderModel({
    this.countWaitForConfirmation = 0,
    this.countConfirmed = 0,
    this.countDelivering = 0,
    this.countPacking = 0,
  });

  factory CountOrderModel.fromJson(Map<String, dynamic> json) {
    return CountOrderModel(
      countWaitForConfirmation: json['countWaitForConfirmation'] as int? ?? 0,
      countConfirmed: json['countConfirmed'] as int? ?? 0,
      countDelivering: json['countDelivering'] as int? ?? 0,
      countPacking: json['countPacking'] as int? ?? 0,
    );
  }
}
