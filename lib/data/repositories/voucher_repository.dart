import 'package:dio/dio.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/voucher/voucher_model.dart';
import 'package:template/domain/end_points/end_point.dart';

class VoucherRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getDetailById(
    String id, {
    required Function(VoucherModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      late Response response;

      final String url = '${EndPoint.VOUCHER}/$id?populate=idOptionProducts.idProduct';

      response = await _dio.get(url);

      onSuccess(VoucherModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getVoucherWithProduct(
      {required VoucherWithProductRequest voucherRequest,
      required Function(List<VoucherModel> data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.post(
        EndPoint.CART_VOUCHER,
        data: voucherRequest.toJson(),
      );
      final results = response.data as List<dynamic>;
      onSuccess(results
          .map((e) => VoucherModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
