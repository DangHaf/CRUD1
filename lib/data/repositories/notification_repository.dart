import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/notification/notification_model.dart';
import 'package:template/data/model/notification/notification_param.dart';
import 'package:template/domain/end_points/end_point.dart';

class NotificationRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getCountNotification({
    required Function(int data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(
        '${EndPoint.NOTIFICATION}/${sl<SharedPreferenceHelper>().getIdUser}/count',
      );

      onSuccess(onSuccess(int.parse(response.data)));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getListNotification({
    required NotificationParam notificationParam,
    required Function(NotificationAppResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(
        '${EndPoint.NOTIFICATION}/paginate',
        queryParameters: notificationParam.toJson(),
      );
      onSuccess(
        NotificationAppResponse.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> readNotification({
    required String idNotification,
    required Function() onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      await _dio
          .put('${EndPoint.NOTIFICATION}/$idNotification/mask-as-read', data: {
        'idUser': sl<SharedPreferenceHelper>().getIdUser,
      });
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getDetailNotification({
    required String id,
    required Function(NotificationModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get('${EndPoint.NOTIFICATION}/$id');
      onSuccess(
        NotificationModel.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
