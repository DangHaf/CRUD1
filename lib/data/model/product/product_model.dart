import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/voucher/voucher_model.dart';

class ProductResponse {
  final List<ProductModel> result;
  final int totalResults;
  final int totalPages;
  final ProviderModel? store;

  ProductResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
    this.store,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
      store: json['store'] != null
          ? ProviderModel.fromJson(json['store'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ProductModel {
  final String? id;
  final String? groupType;
  final String? unit;
  final String? type;
  final int? lastTimeUpdated;
  final bool isHasVoucher;
  final int endDateTimeVoucher;
  final int startDateTimeVoucher;
  final int voucherQuantityRemaining;
  final num voucherValue;
  final List<String> images;
  final int quantity;
  final num totalSold;
  final num totalPoint;
  final int totalRate;
  final bool isShow;
  final int position;
  final num originPrice;
  final num? price;
  final String description;
  final String title;
  final List<String> viewers;
  final List<String> likes;
  final ProviderModel? idStore;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OptionProductModel> idOptionProducts;
  final num averagePoint;
  final VoucherModel? idVoucher;

  /// Only UI
  int quantityProduct;

  ProductModel({
    this.id,
    this.groupType,
    this.unit,
    this.type,
    this.lastTimeUpdated = 0,
    this.isHasVoucher = false,
    this.endDateTimeVoucher = 0,
    this.startDateTimeVoucher = 0,
    this.voucherQuantityRemaining = 0,
    this.voucherValue = 0,
    this.images = const [],
    this.quantity = 0,
    this.totalSold = 0,
    this.totalPoint = 0,
    this.totalRate = 0,
    this.isShow = false,
    this.position = 0,
    this.originPrice = 0,
    this.price,
    this.title = '',
    this.description = '',
    this.idStore,
    this.viewers = const [],
    this.likes = const [],
    this.createdAt,
    this.updatedAt,
    this.quantityProduct = 0,
    this.idOptionProducts = const [],
    this.averagePoint = 0,
    this.idVoucher,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] as String?,
      groupType: json['groupType'] as String?,
      unit: json['unit'] as String?,
      type: json['type'] as String?,
      lastTimeUpdated: json['lastTimeUpdated'] as int? ?? 0,
      isHasVoucher: json['isHasVoucher'] as bool? ?? false,
      endDateTimeVoucher: json['endDateTimeVoucher'] as int? ?? 0,
      startDateTimeVoucher: json['startDateTimeVoucher'] as int? ?? 0,
      voucherQuantityRemaining: json['voucherQuantityRemaining'] as int? ?? 0,
      voucherValue: json['voucherValue'] as num? ?? 0,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : [],
      quantity: json['quantity'] as int? ?? 0,
      totalSold: json['totalSold'] as num? ?? 0,
      totalPoint: json['totalPoint'] as num? ?? 0,
      totalRate: json['totalRate'] as int? ?? 0,
      isShow: json['isShow'] as bool? ?? false,
      position: json['position'] as int? ?? 0,
      originPrice: json['originPrice'] as num? ?? 0,
      price: json['price'] as num?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      viewers: json['viewers'] != null
          ? List<String>.from(json['viewers'] as List<dynamic>)
          : [],
      likes: json['likes'] != null
          ? List<String>.from(json['likes'] as List<dynamic>)
          : [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      idStore: json['idStore'] != null
          ? json['idStore'].toString().length != 24
              ? ProviderModel.fromJson(json['idStore'] as Map<String, dynamic>)
              : ProviderModel(id: json['idStore'] as String)
          : null,
      idOptionProducts: json['idOptionProducts'] != null
          ? (json['idOptionProducts'] as List<dynamic>?)?.map((dynamic e) {
                if (e.toString().length != 24) {
                  return OptionProductModel.fromJson(e as Map<String, dynamic>);
                }
                return OptionProductModel(id: e as String?);
              }).toList() ??
              const []
          : const [],
      averagePoint: json['averagePoint'] as num? ?? 0,
      idVoucher:
          json['idVoucher'] != null && json['idVoucher'].toString().length != 24
              ? VoucherModel.fromJson(json['idVoucher'] as Map<String, dynamic>)
              : null,
    );
  }

  String? get thumbnail => images.isNotEmpty ? images.first : null;

  bool get isLike => likes.contains(sl<SharedPreferenceHelper>().getIdUser);

  String get titleSold {
    if (totalSold < 1000) {
      return '${'home_021'.tr}: $totalSold';
    }
    if (totalSold < 1000000) {
      return '${'home_021'.tr}: ${NumberFormat("###.#", "en_US").format(totalSold / 1000)}k';
    }

    return '${'home_021'.tr}: ${NumberFormat("###.#", "en_US").format(totalSold / 1000000)}m';
  }

  bool get isShowBothPrice {
    if (price != originPrice && price != null) {
      return true;
    }
    return false;
  }

  String? get discount {
    if (idVoucher != null) {
      if (idVoucher?.unitTypeDiscount == "MONEY") {
        return '${'home_020'.tr} \$${NumberFormat("###.#", "en_US").format(idVoucher?.priceDiscount)}';
      }
      return '${'home_020'.tr} ${NumberFormat("###.#", "en_US").format(idVoucher?.percentDiscount)}%';
    }
    return null;
  }

  num get realPrice {
    if (price != null) {
      return price!;
    }
    return originPrice;
  }
}

class OptionProductModel {
  final String? id;
  final int? minQuantity;
  final List<String> images;
  final String? video;
  final int quantity;
  final String title;
  final String? idProduct;
  final ProductModel? product;
  final num? price;
  final num originPrice;

  OptionProductModel({
    this.id,
    this.minQuantity,
    this.images = const [],
    this.video,
    this.quantity = 0,
    this.title = '',
    this.idProduct,
    this.price,
    this.originPrice = 0,
    this.product,
  });

  factory OptionProductModel.fromJson(Map<String, dynamic> json) {
    return OptionProductModel(
      id: json['_id'] as String? ?? '',
        minQuantity: json['minQuantity'] as int?,
      quantity: json['quantity'] as int? ?? 0,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : [],
      video: json['video'] as String? ?? '',
      title: json['title'] as String? ?? '',
      idProduct:
          json['idProduct'] != null && json['idProduct'].toString().length == 24
              ? json['idProduct'] as String
              : null,
      product:
          json['idProduct'] != null && json['idProduct'].toString().length != 24
              ? ProductModel.fromJson(json['idProduct'] as Map<String, dynamic>)
              : null,
      price: json['price'] as num? ?? 0,
      originPrice: json['originPrice'] as num? ?? 0,
    );
  }

  num get priceUse {
    if (price != null) {
      return price!;
    }
    return originPrice;
  }

  bool get isShowBothPrice {
    if (price != originPrice && price != null) {
      return true;
    }
    return false;
  }

  bool get stocking {
    if (quantity > 0) {
      if (minQuantity != null) {
        if (quantity >= minQuantity!) {
          return true;
        }
        return false;
      }
      return true;
    }
    return false;
  }

  int get minQuantityBuy {
    if (minQuantity != null && minQuantity! > 0) {
      return minQuantity!;
    }
    return 1;
  }

  String? get thumbnail => images.isNotEmpty ? images.first : null;
}
