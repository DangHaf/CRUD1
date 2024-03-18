import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/provider/provider_model.dart';

class CommentResponse {
  final List<CommentModel> result;
  final int totalResults;
  final int totalPages;

  CommentResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
    );
  }
}

class CommentModel {
  final String? id;
  final int? totalLikes;
  final List<String> userLikes;
  final String? shopReply;
  final int? point;
  final List<String> video;
  final List<String> image;
  final String? content;
  final String? idPurchase;
  final ProviderModel? idStore;
  final UserModel? idUser;
  final ProductModel? idProduct;
  final List<OptionProductModel> idOptionProducts;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? commentModelId;

  CommentModel({
    this.id,
    this.totalLikes,
    this.userLikes = const [],
    this.shopReply,
    this.point,
    this.video = const [],
    this.image = const [],
    this.idOptionProducts = const [],
    this.content,
    this.idPurchase,
    this.idStore,
    this.idUser,
    this.idProduct,
    this.createdAt,
    this.updatedAt,
    this.commentModelId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'] as String?,
      totalLikes: json['totalLikes'] as int? ?? 0,
      content: json['content'] as String? ?? '',
      shopReply: json['summary'] as String? ?? '',
      point: json['point'] as int?,
      image: json['image'] != null
          ? List<String>.from(json['image'] as List<dynamic>)
          : [],
      video: json['video'] != null
          ? List<String>.from(json['video'] as List<dynamic>)
          : [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      idPurchase: json['idPurchase'] as String?,
      idStore: json['idStore'] != null
          ? json['idStore'].toString().length == 24
              ? ProviderModel(id: json['idStore'] as String?)
              : ProviderModel.fromJson(json['idStore'] as Map<String, dynamic>)
          : null,
      idUser: json['idUser'] != null
          ? json['idUser'].toString().length == 24
              ? UserModel(id: json['idUser'] as String?)
              : UserModel.fromJson(json['idUser'] as Map<String, dynamic>)
          : null,
      idProduct: json['idProduct'] != null
          ? json['idProduct'].toString().length == 24
              ? ProductModel(id: json['idProduct'] as String?)
              : ProductModel.fromJson(json['idProduct'] as Map<String, dynamic>)
          : null,
      idOptionProducts: (json['idOptionProducts'] as List<dynamic>?)
          ?.map((dynamic e) =>
          OptionProductModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const [],
      userLikes: json['userLikes'] != null
          ? List<String>.from(json['userLikes'] as List<dynamic>)
          : [],
      commentModelId: json['_id'] as String?,
    );
  }

  bool get isLike => userLikes.contains(sl<SharedPreferenceHelper>().getIdUser);

  String get timeComment => DateFormat('MM/dd/yyyy HH:mm').format(createdAt!.toLocal());

  String get option {
    String data = '${'cart_016'.tr}: ';
    for (int i = 0; i < idOptionProducts.length; i++) {
      data = '$data${idOptionProducts[i].title}, ';
    }
    return data.substring(0, data.length - 2);
  }
}
