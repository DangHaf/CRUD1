import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/domain/export/domain_export.dart';

class SettingOldRepository {
  SettingOldRepository();
  final _dio = GetIt.I.get<DioClient>();

  ///
  /// Get setting.
  ///
  Future<void> getSetting({
    String? filter,
    required Function(SettingsModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    String _uri = EndPoint.settings;

    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri = '${EndPoint.category}?$filter';
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final returnData = SettingsModel.fromMap(response.data as Map<String, dynamic>);
      onSuccess(returnData);
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
