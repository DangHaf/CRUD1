// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    final String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      final int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        // print( responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      // print('Data ${response.data}');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print('ERROR [${err.response?.statusCode}] Message[${err.response?.data}] => PATH: ${err.requestOptions.path}');
    String tokenInvalid = '';
    if (!IZIValidate.nullOrEmpty(err.response?.data['errors'])) {
      if ((err.response?.data['errors'][0] as Map<String, dynamic>).containsKey('detail')) {
        tokenInvalid = err.response?.data['errors'][0]['detail'].toString() ?? '';
      }
    }
    if (err.response != null) {
      if (err.response!.statusCode != null) {
        if (err.response!.statusCode! >= 400 && err.response!.statusCode! <= 500 && tokenInvalid == 'jwt expired') {
          final dio = GetIt.I.get<DioClient>();
          await dio.refreshTokenExpiration();
          return handler.resolve(await dio.reTry(err.requestOptions));
        }
      }
    }
    return handler.next(err);
  }
}
