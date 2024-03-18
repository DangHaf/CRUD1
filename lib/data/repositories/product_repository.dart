import 'dart:io';

import 'package:dio/dio.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/product/product_param.dart';
import 'package:template/domain/end_points/end_point.dart';

class ProductRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getProductOutStanding(
      {required ProductParam productParam,
      required Function(ProductResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        EndPoint.PRODUCT_OUTSTANDING,
        queryParameters: productParam.toJson(),
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProductOutStandingOfProvider(
      {required String idStore,
      required ProductParam productParam,
      required Function(ProductResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PRODUCT_OUTSTANDING}?idStore=$idStore',
        queryParameters: productParam.toJson(),
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProductHighlightSaving(
      {required ProductParam productParam,
      required Function(ProductResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        EndPoint.PRODUCT_HIGHLIGHT,
        queryParameters: productParam.toJson(),
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProductNewPoint(
      {required ProductParam productParam,
      required Function(ProductResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final now = DateTime.now();
      final response = await _dio.get(
        '${EndPoint.PRODUCT_PAGINATE}?createdAt>=${DateTime(now.year, now.month, now.day).millisecondsSinceEpoch}&createdAt<=${DateTime(now.year, now.month, now.day, 23, 59).millisecondsSinceEpoch}',
        queryParameters: productParam.toJson(),
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProductForYou(
      {required ProductParam productParam,
      required Function(ProductResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PRODUCT_PAGINATE}?viewers=${sl<SharedPreferenceHelper>().getIdUser}',
        queryParameters: productParam.toJson(),
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProducts(
      {required ProductParam productParam,
      required Function(ProductResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        EndPoint.PRODUCT_PAGINATE,
        queryParameters: productParam.toJson(),
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getFavoriteProducts(
    int page,
    int limit, {
    required Function(ProductResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PRODUCT_PAGINATE}?page=$page&limit=$limit&likes=${sl<SharedPreferenceHelper>().getIdUser}',
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> updateProduct(
      {required String id,
      required dynamic data,
      required Function(ProductModel data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.put(
        EndPoint.PRODUCT_PAGINATE,
        data: data,
      );
      onSuccess(ProductModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProductById(
      {required String id,
      required Function(ProductModel data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
          '${EndPoint.PRODUCT}/$id?populate=idOptionProducts,idStore,idStore.idOwner');
      onSuccess(ProductModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> setLike(
      {required String idProduct,
      required Function(bool data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put(
        '${EndPoint.PRODUCT}/$idProduct/like/${sl<SharedPreferenceHelper>().getIdUser}',
      );
      onSuccess(true);
    } catch (e) {
      onSuccess(false);
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> setUnLike(
      {required String idProduct,
      required Function(bool data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put(
        '${EndPoint.PRODUCT}/$idProduct/unlike/${sl<SharedPreferenceHelper>().getIdUser}',
      );
      onSuccess(true);
    } catch (e) {
      onSuccess(false);
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProductPropose(
      {required ProductParam productParam,
      required Function(ProductResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        EndPoint.PRODUCT_PROPOSE,
        queryParameters: productParam.toJson(),
      );
      onSuccess(
          ProductResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProductSearchImage({
    required File image,
    required Function(List<ProductModel> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final String fileName = image.path.split('/').last;
    final FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    try {
      final response = await _dio.post(
        EndPoint.PRODUCT_SEARCH,
        data: formData,
      );
      onSuccess(
        (response.data as List<dynamic>)
            .map(
                (dynamic e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> seenProduct(
      {required String id,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final idUser = sl<SharedPreferenceHelper>().getIdUser;
      await _dio.put('${EndPoint.PRODUCT}/$id/seen/$idUser');
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
