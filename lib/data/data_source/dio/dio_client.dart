import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/domain/export/domain_export.dart';

class DioClient {
  GetIt sl = GetIt.instance;
  Dio? dio;
  String? token;
  LoggingInterceptor? loggingInterceptor;

  DioClient() {
    _init();
  }

  ///
  /// Init dio.
  ///
  Future<void> _init() async {
    final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;

    dio = Dio();
    dio!
      ..options.baseUrl = EndPoint.BASE_URL
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $jwtToken'};
    dio!.interceptors.add(sl.get<LoggingInterceptor>());
  }

  ///
  /// Refresh token.
  ///
  Future<void> refreshToken() async {
    final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;
    dio!.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $jwtToken'};
  }

  ///
  /// Calling the function again when the token expires cannot be called.
  ///
  Future<Response<dynamic>> reTry(RequestOptions requestOption) async {
    try {
      return await dio!.request(
        requestOption.path,
        data: requestOption.data,
        options: Options(
          method: requestOption.method,
          headers: requestOption.headers,
        ),
      );
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  ///
  /// Làm mới token khi hết hạn.
  ///
  Future<void> refreshTokenExpiration() async {
    // final refreshTokenSaved = sl<SharedPreferenceHelper>().refreshToken;
    // dio!.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    // final response = await dio!.post(
    //   '/auth/refresh-token',
    //   data: AuthResponse(refreshToken: refreshTokenSaved).toMap(),
    // );
    // final results = response.data as dynamic;
    // final data = AuthResponse.fromMap(results as Map<String, dynamic>);
    // sl<SharedPreferenceHelper>().setJwtToken(data.accessToken.toString());
    // sl<SharedPreferenceHelper>().setRefreshToken(data.refreshToken.toString());
    await refreshToken();
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio!.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> downloadFile({
    required String uri,
    required String path,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio!.download(uri, path, cancelToken: cancelToken);
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      print("Download file error");
      rethrow;
    }
  }

  Future<Response> uploadImages(
    String uri, {
    required List<File> files,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final arrayFiles = [];
      for (var i = 0; i < files.length; i++) {
        arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
      }

      final FormData formData = FormData.fromMap({'files': arrayFiles});
      final response = await dio!.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      print("Upload image");
      rethrow;
    }
  }

  Future<Response> uploadFiles(
    String uri, {
    required List<PlatformFile> files,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final arrayFiles = [];
      for (var i = 0; i < files.length; i++) {
        arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
      }

      final FormData formData = FormData.fromMap({'files': arrayFiles});

      final response = await dio!.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> convertFile(
    String uri, {
    required List<File> files,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final arrayFiles = [];
      for (var i = 0; i < files.length; i++) {
        arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
      }

      final FormData formData = FormData.fromMap({'file': arrayFiles});
      final response = await dio!.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      print("Upload image");
      rethrow;
    }
  }
}
