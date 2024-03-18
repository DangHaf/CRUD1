import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/address/address_request.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/domain/end_points/end_point.dart';

class AddressRepository {
  final _dio = sl.get<DioClient>();

  Future<void> create({
    required AddressRequest addressRequest,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _dio.post(
        EndPoint.ADDRESS,
        data: addressRequest.toJson(),
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> update({
    required String id,
    required AddressRequest addressRequest,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _dio.put(
        '${EndPoint.ADDRESS}/$id',
        data: addressRequest.toJson(),
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> setDefaultAddress({
    required String id,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _dio.put(
        '${EndPoint.ADDRESS}/$id',
        data: {
          "idUser": sl<SharedPreferenceHelper>().getIdUser,
          "isDefault": true,
        },
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> deleteAddress({
    required String id,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _dio.delete('${EndPoint.ADDRESS}/$id');
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getAddressDefault({
    required Function(AddressResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final res = await _dio.get(
        '${EndPoint.ADDRESS}/paginate?idUser=${sl<SharedPreferenceHelper>().getIdUser}&isDefault=true&populate=idState,idCity',
      );
      onSuccess(AddressResponse.fromJson(res.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> paginateAddress({
    required Function(AddressResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final res = await _dio.get(
        '${EndPoint.ADDRESS}/paginate?idUser=${sl<SharedPreferenceHelper>().getIdUser}&populate=idState,idCity',
      );
      onSuccess(AddressResponse.fromJson(res.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
