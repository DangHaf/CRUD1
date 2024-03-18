import 'package:template/core/export/core_export.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/point_history_model.dart';
import 'package:template/domain/end_points/end_point.dart';

class PointRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getPointHistory({
    String? filter,
    required int pageNo,
    required int pageSize,
    required Function(PointHistoryResponse data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      String url =
          '${EndPoint.POINT_HISTORY_PAGINATE}?appType=NAIL_SUPPLY&page=$pageNo&limit=$pageSize&populate=idPostPackage&idUser=${sl<SharedPreferenceHelper>().getIdUser}';
      if (filter != null) {
        url = '$url&$filter';
      }
      final response = await _dio.get(url);
      onSuccess(
        PointHistoryResponse.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getTotalPoint({
    required String idUser,
    required Function(int data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    try {
      final response = await _dio.get(
        '${EndPoint.USER_POINT}?idUser=$idUser&appType=NAIL_SUPPLY',
      );
      onSuccess(response.data[0]['totalPoint'] as int);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
