import 'package:template/core/di_container.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/type_product.dart';
import 'package:template/domain/end_points/end_point.dart';

class LookupRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getState({
    required Function(List<StateModel> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(EndPoint.STATE);
      final result = (response.data as List<dynamic>?)
          ?.map(
              (dynamic e) => StateModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const [];

      onSuccess(result);
    } catch (e) {
      onError(ApiResponse
          .withError(ApiErrorHandler.getMessage(e))
          .error);
    }
  }

  Future<void> getCity({
    required Function(List<CityModel> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(EndPoint.CITY);
      final result = (response.data as List<dynamic>?)
          ?.map(
              (dynamic e) => CityModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const [];

      onSuccess(result);
    } catch (e) {
      onError(ApiResponse
          .withError(ApiErrorHandler.getMessage(e))
          .error);
    }
  }

  Future<void> getTypeProduct({
    required Function(List<TypeProductModel> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get('${EndPoint.TYPE_PRODUCT}?lang=${sl<SharedPreferenceHelper>().getLocale}');
      final result = (response.data as List<dynamic>?)
          ?.map(
              (dynamic e) => TypeProductModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const [];

      onSuccess(result);
    } catch (e) {
      onError(ApiResponse
          .withError(ApiErrorHandler.getMessage(e))
          .error);
    }
  }
}
