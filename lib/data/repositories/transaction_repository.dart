import 'package:template/core/di_container.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/transaction/transaction_request.dart';
import 'package:template/domain/end_points/end_point.dart';

class TransactionRepository {
  final _dio = sl.get<DioClient>();

  Future<void> create({
    required TransactionRequest transactionRequest,
    required Function(String) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final res = await _dio.post(
        EndPoint.TRANSACTION,
        data: transactionRequest.toJson(),
      );
      onSuccess(res.data['_id'] as String);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> success({
    required String id,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _dio.put(
        '${EndPoint.TRANSACTION}/$id',
        data: {'status': 'SUCCESS'},
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
