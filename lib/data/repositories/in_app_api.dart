
import 'package:dio/dio.dart';
import 'package:template/data/model/response/latest_receipt_info_model.dart';

import '../../core/export/core_export.dart';
import '../../domain/export/domain_export.dart';
import '../export/data_export.dart';

class InAppAPI {
  final _dio = sl.get<DioClient>();

  InAppAPI();

  bool _isAllowCallAPI = true;

  ///
  /// Verify Receipt purchase.
  ///
  Future<void> verifyReceiptApple({
    required String idProduct,
    required String receipt,
    required Function(LatestReceiptInfoModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    const String _uri = EndPoint.receiptAppleSanBox;

    final Map<String, dynamic> _data = {
      "receipt-data": receipt,
      "password": PasswordAppStore,
      "exclude-old-transactions": true,
    };
    if (_isAllowCallAPI) {
      _isAllowCallAPI = false;
      try {
        response = await _dio.post(_uri, data: _data);
      } catch (e) {
        _isAllowCallAPI = true;
        onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
        return;
      }
    } else {
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final _results = response.data as dynamic;

      final _latestReceipt = (_results['latest_receipt_info'] as List<dynamic>)
          .map((e) => LatestReceiptInfoModel.fromMap(e as Map<String, dynamic>));
      for (final e in _latestReceipt) {
        if (e.productId == idProduct) {
          onSuccess(e);

          break;
        }
      }
      _isAllowCallAPI = true;
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
      _isAllowCallAPI = true;
    }
  }
}
