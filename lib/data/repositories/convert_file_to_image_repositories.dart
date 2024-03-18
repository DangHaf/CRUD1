import 'dart:io';

import 'package:dio/dio.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/domain/export/domain_export.dart';

class ConvertFileToTextRepository {
  final _dio = sl.get<DioClient>();

  ConvertFileToTextRepository();

  ///
  /// Convert File to image
  ///
  Future<void> convertFileToImage({
    required File data,
    required bool isImage,
    required Function(String text, String urlImage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    Response<dynamic>? response;
    try {
      response = await _dio.convertFile(isImage ? EndPoint.convertImage : EndPoint.convertFile, files: [data]);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final _results = response.data as dynamic;

      onSuccess(
        _results['text'].toString(),
        _results['fileUrl'].toString(),
      );
    }
  }
}
