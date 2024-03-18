import 'dart:convert';

import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/cart/cart_param.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/domain/end_points/end_point.dart';

class CartRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getCart(
      {required CartParam cartParam,
      required Function(CartResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.CART_PAGINATE}?idUser=${sl<SharedPreferenceHelper>().getIdUser}&sort=-updatedAt',
        queryParameters: cartParam.toJson(),
      );
      onSuccess(CartResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> addCart(
      {required CartRequest cartRequest,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.post(
        EndPoint.ADD_CART,
        data: cartRequest.toJson(),
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> addCartWithMany(
      {required List<CartRequest> cartRequest,
      required Function(String id) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.post(
        EndPoint.ADD_CART_MANY,
        data: jsonEncode(cartRequest.map((v) => v.toJson()).toList()),
      );

      final data = (response.data as List<dynamic>)
          .map(
              (dynamic e) => CartIdResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      onSuccess(data.first.id);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> updateCart(
      {required List<ProductPaymentRequest> products,
      required String idCart,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put(
        '${EndPoint.CART}/$idCart',
        data: {'products': products.map((v) => v.toJson()).toList()},
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> deleteCart(
      {required String idCart,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.delete(
        '${EndPoint.CART}/$idCart',
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getCartPayment(
      {required List<CartPaymentRequest> cartRequest,
      required Function(List<CartPaymentResponse> data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.post(EndPoint.CART_PAYMENT,
          data: jsonEncode(cartRequest.map((v) => v.toJson()).toList()));

      (response.data as List<dynamic>)
          .map((dynamic e) =>
              ProductCartModel.fromJson(e as Map<String, dynamic>))
          .toList();

      onSuccess((response.data as List<dynamic>)
          .map((dynamic e) =>
              CartPaymentResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getCountCart(
      {required Function(int data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        EndPoint.COUNT_CART,
      );
      onSuccess(int.parse(response.data as String));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
