import 'package:get/get.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/voucher/voucher_model.dart';

class CartResponse {
  final List<CartModel> result;
  final int totalResults;
  final int totalPages;

  CartResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map(
                  (dynamic e) => CartModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
    );
  }

  num get totalPrice {
    num total = 0;
    for (int i = 0; i < result.length; i++) {
      total += result[i].totalMoney;
    }
    return total;
  }
}

class CartModel {
  String id;
  ProviderModel? idStore;
  List<ProductCartModel> products;
  String idUser;
  String? idVoucher;
  VoucherModel? voucher;
  num totalMoney;
  num totalProductMoney;

  CartModel({
    this.id = '',
    this.idStore,
    this.products = const [],
    this.idUser = '',
    this.idVoucher,
    this.voucher,
    this.totalMoney = 0,
    this.totalProductMoney = 0,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'] as String? ?? '',
      idUser: json['idUser'] as String? ?? '',
      idStore: json['idStore'] != null
          ? ProviderModel.fromJson(json['idStore'] as Map<String, dynamic>)
          : null,
      products: (json['products'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  ProductCartModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  bool get isChecked {
    for (int i = 0; i < products.length; i++) {
      if (!products[i].checked) {
        return false;
      }
    }
    return true;
  }

  num get totalPriceUI {
    num total = 0;
    for (int i = 0; i < products.length; i++) {
      total += products[i].totalPriceUI;
    }
    return total;
  }

  int get totalQuantity {
    int total = 0;
    for (int i = 0; i < products.length; i++) {
      total += products[i].totalQuantity;
    }
    return total;
  }

  bool get hasProduct {
    for (int i = 0; i < products.length; i++) {
      if (products[i].checked) {
        return true;
      }
    }
    return false;
  }

  String get stringQuantity {
    int quantity = 0;
    for (int i = 0; i < products.length; i++) {
      if (products[i].checked) {
        quantity += products[i].quantity;
      }
    }
    if (quantity == 1) {
      return 'cart_017'.trParams({'quantity': quantity.toString()});
    }
    return 'cart_018'.trParams({'quantity': quantity.toString()});
  }
}

class ProductCartModel {
  String? id;
  int quantity;
  OptionProductModel? idOptionProduct;
  ProductModel? idProduct;
  bool checked;

  ProductCartModel({
    this.id,
    this.quantity = 0,
    this.idOptionProduct,
    this.idProduct,
    this.checked = false,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    return ProductCartModel(
      id: json['_id'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      idOptionProduct: json['idOptionProduct'] != null
          ? OptionProductModel.fromJson(
              json['idOptionProduct'] as Map<String, dynamic>)
          : null,
      idProduct: json['idProduct'] != null
          ? ProductModel.fromJson(json['idProduct'] as Map<String, dynamic>)
          : null,
    );
  }

  num get totalPriceUI {
    if (idOptionProduct == null) {
      return 0;
    }
    if (checked) {
      return quantity * idOptionProduct!.priceUse;
    }
    return 0;
  }

  int get totalQuantity {
    if (idOptionProduct == null) {
      return 0;
    }
    if (checked) {
      return quantity;
    }
    return 0;
  }
}

class CartPaymentResponse {
  final num totalProductMoney;
  final num totalTaxMoney;
  final num totalShipMoney;
  final num totalReduceMoney;
  final num totalMoney;
  final String idStore;

  CartPaymentResponse({
    this.totalProductMoney = 0,
    this.totalTaxMoney = 0,
    this.totalShipMoney = 0,
    this.totalReduceMoney = 0,
    this.totalMoney = 0,
    this.idStore = '',
  });

  factory CartPaymentResponse.fromJson(Map<String, dynamic> json) {
    return CartPaymentResponse(
      totalProductMoney: json['totalProductMoney'] as num? ?? 0,
      totalTaxMoney: json['totalTaxMoney'] as num? ?? 0,
      totalShipMoney: json['totalShipMoney'] as num? ?? 0,
      totalReduceMoney: json['totalReduceMoney'] as num? ?? 0,
      totalMoney: json['totalMoney'] as num? ?? 0,
      idStore: json['idStore'] as String? ?? '',
    );
  }
}

class CartIdResponse {
  String id;

  CartIdResponse({
    this.id = '',
  });

  factory CartIdResponse.fromJson(Map<String, dynamic> json) {
    return CartIdResponse(
      id: json['_id'] as String? ?? '',
    );
  }
}
