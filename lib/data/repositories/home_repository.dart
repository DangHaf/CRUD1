import 'package:template/core/di_container.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/home/banner_model.dart';
import 'package:template/data/model/home/news_model.dart';
import 'package:template/domain/end_points/end_point.dart';

class HomeRepository {
  final _dio = sl.get<DioClient>();

  Future<void> getBanners(
      {required Function(List<BannerModel> data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(EndPoint.BANNER);
      try {
        final data = (response.data as List<dynamic>)
            .map((dynamic e) => BannerModel.fromJson(e as Map<String, dynamic>))
            .toList();
        onSuccess(data);
      } catch (_) {
        onSuccess([]);
      }
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> getNews(
      {required int pageNo,
      required int pageSize,
      required Function(NewsResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
        '${EndPoint.NEWS}?page=$pageNo&limit=$pageSize&appType=$NAIL_SUPPLY',
      );
      onSuccess(NewsResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
