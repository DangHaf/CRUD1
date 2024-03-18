import 'package:template/core/utils/extensions/date_time_extension.dart';
import 'package:template/data/model/product/product_model.dart';

class VoucherModel {
  final String id;
  final String title;
  final String type;
  final num priceDiscount;
  final num percentDiscount;
  final num minPriceToUse;
  final String unitTypeDiscount;
  final int endDateTime;
  final int startDateTime;
  final int? quantityRemaining;
  final int? originalQuantity;
  final String? description;
  final String? code;
  final String? idStore;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? position;
  final String? image;
  final String? thumbnail;
  final num maxDiscount;
  final List<OptionProductModel> idOptionProducts;

  VoucherModel({
    this.id = '',
    this.title = '',
    this.type = '',
    this.priceDiscount = 0,
    this.percentDiscount = 0,
    this.minPriceToUse = 0,
    this.unitTypeDiscount = '',
    this.position,
    this.image,
    this.thumbnail,
    this.endDateTime = 0,
    this.startDateTime = 0,
    this.quantityRemaining,
    this.originalQuantity,
    this.description,
    this.code,
    this.idStore,
    this.createdAt,
    this.updatedAt,
    this.maxDiscount = 0,
    this.idOptionProducts = const [],
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? '',
      unitTypeDiscount: json['unitTypeDiscount'] as String? ?? '',
      priceDiscount: json['priceDiscount'] as num? ?? 0,
      percentDiscount: json['percentDiscount'] as num? ?? 0,
      minPriceToUse: json['minPriceToUse'] as num? ?? 0,
      maxDiscount: json['maxDiscount'] as num? ?? 0,
      position: json['position'] as int?,
      image: json['image'] as String?,
      thumbnail: json['thumbnail'] as String?,
      endDateTime: json['endDateTime'] as int? ?? 0,
      startDateTime: json['startDateTime'] as int? ?? 0,
      quantityRemaining: json['quantityRemaining'] as int?,
      originalQuantity: json['originalQuantity'] as int?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      idStore: json['idStore'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
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
    );
  }

  String get disCount =>
      unitTypeDiscount == "MONEY" ? "\$$priceDiscount" : "$percentDiscount%";

  String get getMaxDiscount =>
      unitTypeDiscount == "MONEY" ? "\$$priceDiscount" : "\$$maxDiscount";

  String get expiry {
    return '${DateTime.fromMillisecondsSinceEpoch(startDateTime).formatExpiryVoucherStandard} - ${DateTime.fromMillisecondsSinceEpoch(endDateTime).formatExpiryVoucherStandard}';
  }

  List<String> get applyTo {
    try {
      final List<String> apply = [];
      for (int i = 0; i < idOptionProducts.length; i++) {
        bool hasItem = false;
        for (int j = 0; j < apply.length; j++) {
          if (apply[j].contains(idOptionProducts[i].product!.title)) {
            apply[j] = '${apply[j].substring(0, apply[j].length - 1)}, ${idOptionProducts[i].title})';
            hasItem = true;
            break;
          }
        }
        if (!hasItem) {
          apply.add(
              '${idOptionProducts[i].product?.title} (${idOptionProducts[i].title})');
        }
      }
      return apply;
    } catch (_) {
      return [];
    }
  }
}
