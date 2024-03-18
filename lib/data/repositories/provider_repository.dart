import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/data/model/provider/provider_param.dart';
import 'package:template/domain/end_points/end_point.dart';

class ProviderRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getProvider(
      {required ProviderParam providerParam,
      required Function(ProviderResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        EndPoint.PROVIDER,
        queryParameters: providerParam.toJson(),
      );
      onSuccess(
          ProviderResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getLeadingProvider(
      {required ProviderParam providerParam,
        required Function(ProviderResponse data) onSuccess,
        required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        EndPoint.LEADING_PROVIDER,
        queryParameters: providerParam.toJson(),
      );
      onSuccess(
          ProviderResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getProviderById(
      {required String id,
      required Function(ProviderModel data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PROVIDERS}/$id?lang=${sl<SharedPreferenceHelper>().getLocale}',
      );
      onSuccess(ProviderModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> setLike(
      {required String idStore,
      required String idUser,
      required Function(bool data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put(
        '${EndPoint.PROVIDERS}/$idStore/like/$idUser',
      );
      onSuccess(true);
    } catch (e) {
      onSuccess(false);
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> setUnLike(
      {required String idStore,
      required String idUser,
      required Function(bool data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put(
        '${EndPoint.PROVIDERS}/$idStore/unlike/$idUser',
      );
      onSuccess(true);
    } catch (e) {
      onSuccess(false);
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getFavoriteProviders(
    int page,
    int limit, {
    required Function(ProviderResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PROVIDER}?page=$page&limit=$limit&likes=${sl<SharedPreferenceHelper>().getIdUser}&populate=idOwner,idCity,idState&fields=name,businessPhone,idOwner.fullName,thumbnail,address,city,state',
      );
      onSuccess(
          ProviderResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
