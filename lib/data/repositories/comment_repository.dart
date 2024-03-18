import 'dart:convert';

import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/comment/comment_model.dart';
import 'package:template/data/model/comment/rate_request.dart';
import 'package:template/data/model/comment/comment_quantity_model.dart';
import 'package:template/domain/end_points/end_point.dart';

class CommentRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getCountCommentType({
    required String id,
    required Function(CommentQuantity data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(
        '${EndPoint.COMMENT_STATISTIC}/$id',
      );

      onSuccess(
          CommentQuantity.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getCountCommentTypeProvider({
    required String id,
    required Function(CommentQuantity data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(
        '${EndPoint.COMMENT_STATISTIC_PROVIDER}/$id',
      );

      onSuccess(
          CommentQuantity.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> paginate(
    int page,
    int limit, {
    required String filter,
    required Function(CommentResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      const String fields =
          'idStore.city,idStore.state,idStore.businessPhone,idStore.thumbnail,idStore.name,idStore.address,idUser.avatar,idUser.fullName,idUser.nickName,idProduct.title,idProduct.images,idOptionProducts.images,idOptionProducts.title';
      final response = await _dio.get(
        '${EndPoint.COMMENT_PAGINATE}?page=$page&limit=$limit&populate=idUser,idProduct,idStore,idOptionProducts&$filter&fields=$fields',
      );
      onSuccess(
        CommentResponse.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> paginateType(
    int page,
    int limit, {
    required String id,
    required String type,
    required Function(CommentResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      const String fields =
          'idStore.city,idStore.state,idStore.businessPhone,idStore.thumbnail,idStore.name,idStore.address,idUser.avatar,idUser.fullName,idUser.nickName,idProduct.title,idProduct.thumbnail,idProduct.title,idOptionProducts.title';
      final response = await _dio.get(
        '${EndPoint.COMMENT_PAGINATE_TYPE_RATE}?page=$page&limit=$limit&idProduct=$id&populate=idUser,idProduct,idStore,idOptionProducts&type=$type&fields=$fields',
      );
      onSuccess(
        CommentResponse.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> paginateTypeProvider(
    int page,
    int limit, {
    required String id,
    required String type,
    required Function(CommentResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      const String fields =
          'idStore.city,idStore.state,idStore.businessPhone,idStore.thumbnail,idStore.name,idStore.address,idUser.avatar,idUser.fullName,idUser.nickName,idProduct.title,idProduct.images,idProduct.title,idOptionProducts.title,idOptionProducts.images';
      final response = await _dio.get(
        '${EndPoint.COMMENT_PAGINATE_TYPE_RATE}?page=$page&limit=$limit&idStore=$id&populate=idUser,idProduct,idOptionProducts,idStore&type=$type&fields=$fields',
      );
      onSuccess(
        CommentResponse.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> setLike(
      {required String idComment,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.post(
        '${EndPoint.COMMENT}/like',
        data: {
          "idUser": sl<SharedPreferenceHelper>().getIdUser,
          "idRate": idComment
        },
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> setUnLike(
      {required String idComment,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.post(
        '${EndPoint.COMMENT}/unlike',
        data: {
          "idUser": sl<SharedPreferenceHelper>().getIdUser,
          "idRate": idComment
        },
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> addRateOrder(
      {required List<RateRequest> rateRequest,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.post(
        EndPoint.RATE_MANY,
        data: jsonEncode(rateRequest.map((v) => v.toJson()).toList()),
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
