import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/data/model/order/order_param.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/domain/end_points/end_point.dart';

class OrderRepository {
  final _dio = sl.get<DioClient>();

  Future<void> createOrder(
      {required OrderRequest orderRequest,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.post(
        EndPoint.PURCHASES,
        data: orderRequest.toJson(),
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getListOrder(
      {required OrderParam orderParam,
      required String status,
      required Function(OrderResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PURCHASES_PAGINATE}?status=$status&idUser=${sl<SharedPreferenceHelper>().getIdUser}',
        queryParameters: orderParam.toJson(),
      );
      onSuccess(OrderResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getDetailOrder(
      {required String idOrder,
      required Function(OrderDetailModel data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PURCHASES}/$idOrder?populate=purchaseDetails.idOptionProduct,purchaseDetails.idOptionProduct.idProduct,idAddress,idStore,idTransaction,idAddress.idState,idAddress.idCity',
      );
      onSuccess(
          OrderDetailModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> cancelOrder(
      {required String id,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put('${EndPoint.PURCHASES}/$id/status',
          data: {'status': CUSTOMER_CANCELED});
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> receivedOrder(
      {required String id,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio
          .put('${EndPoint.PURCHASES}/$id/status', data: {'status': RECEIVED});
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> returnOrder(
      {required String id,
      required OrderReturnRequest returnRequest,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put(
        '${EndPoint.PURCHASES}/$id/status',
        data: returnRequest.toJson(),
      );
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getCountOrder(
      {required Function(CountOrderModel data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.PURCHASES_COUNT_STATUS}?idUser=${sl<SharedPreferenceHelper>().getIdUser}',
      );
      onSuccess(
          CountOrderModel.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
