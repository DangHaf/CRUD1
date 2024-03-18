import 'package:dio/dio.dart';

class ApiResponse {
  final Response response;
  final dynamic error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue)
      : response = Response(requestOptions: RequestOptions()),
        // ignore: prefer_initializing_formals
        error = errorValue;

  ApiResponse.withSuccess(Response responseValue)
      // ignore: prefer_initializing_formals
      : response = responseValue,
        error = null;
}
