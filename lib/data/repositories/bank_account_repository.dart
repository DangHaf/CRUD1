import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/bank_account/bank_account_model.dart';
import 'package:template/data/model/bank_account/bank_account_request.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/domain/end_points/end_point.dart';

class BankAccountRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getAll({
    required String idStore,
    required String type,
    required Function(List<BankAccountModel> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final String uri =
          '${EndPoint.BANK_ACCOUNT}/paginate?type=$type&idStore=$idStore';
      final response = await _dio.get(uri);
      final results = response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BankAccountModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> paginate({
    required int page,
    required int limit,
    required String type,
    required Function(List<BankAccountResponse> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final String uri =
          '${EndPoint.BANK_ACCOUNT}/paginate?page=$page&limit=$limit&owner=${sl<SharedPreferenceHelper>().getIdUser}&type=$type';
      final response = await _dio.get(uri);
      final results = response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BankAccountResponse.fromMap(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> paginateTypeBank({
    required int page,
    required int limit,
    required String type,
    required Function(List<BankAccountResponse> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final String uri =
          '${EndPoint.BANK_ACCOUNT}/paginate?page=$page&limit=$limit&owner=${sl<SharedPreferenceHelper>().getIdUser}&type=$type';
      final response = await _dio.get(uri);
      final results = response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => BankAccountResponse.fromMap(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  ///
  /// Insert bank account to database
  ///
  Future<void> add({
    required BankAccountResponse data,
    required Function(BankAccountResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response =
          await _dio.post(EndPoint.BANK_ACCOUNT, data: data.toJson());
      final results = response.data as dynamic;
      onSuccess(BankAccountResponse.fromMap(results as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  ///
  /// Update bank account to database
  ///
  Future<void> update({
    required String id,
    required BankAccountResponse data,
    required Function(BankAccountResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response =
          await _dio.put('${EndPoint.BANK_ACCOUNT}/$id', data: data.toJson());
      final results = response.data as dynamic;
      onSuccess(BankAccountResponse.fromMap(results as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  /// Update bank account information
  Future<void> updateBankAccount({
    required String id,
    required BankAccountRequest data,
    required Function(BankAccountResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response =
          await _dio.put('${EndPoint.BANK_ACCOUNT}/$id', data: data.toJson());
      final results = response.data as dynamic;
      onSuccess(BankAccountResponse.fromMap(results as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  /// Add new bank account information
  Future<void> addBankAccount({
    required BankAccountRequest data,
    required Function(BankAccountResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response =
          await _dio.post(EndPoint.BANK_ACCOUNT, data: data.toJson());
      final results = response.data as dynamic;
      onSuccess(BankAccountResponse.fromMap(results as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
