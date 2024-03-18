import 'package:template/core/di_container.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/setting/setting_model.dart';
import 'package:template/domain/end_points/end_point.dart';

class SettingRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getSetting(
      {required Function(List<SettingModel> settings) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(EndPoint.SETTING);

      final results = response.data as List<dynamic>;
      onSuccess(results
          .map((e) => SettingModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
