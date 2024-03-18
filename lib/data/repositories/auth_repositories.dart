import 'package:dio/dio.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/export/data_export.dart';
import 'package:template/domain/export/domain_export.dart';

class AuthRepositories {
  final _dio = sl.get<DioClient>();

  AuthRepositories();

  ///
  /// Sign in or sign up.
  ///
  Future<void> signInSocial({
    required AuthModel data,
    required Function(AuthModel data) onSuccess,
    required Function(dynamic error) onError,
    // required Function() onCallBackError,
  }) async {
    Response<dynamic>? response;
    try {
      response = await _dio.post(EndPoint.signInAccount, data: data.toJson());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final _results = response.data as dynamic;

      // Call back data.
      final user = AuthModel.fromMap(_results['user'] as Map<String, dynamic>);

      user.accessToken = _results['accessToken'].toString();
      user.refreshToken = _results['refreshToken'].toString();

      onSuccess(user);
    }
  }

  ///
  /// Update
  ///
  Future<void> update({
    required String id,
    required AuthModel data,
    required Function(UserModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response = await _dio.put('${EndPoint.users}/$id', data: data.toMap());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(UserModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Find.
  ///
  Future<void> checkDeviceHavePurchase({
    String? filter,
    required Function(AuthModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String _uri =
        '${EndPoint.users}?deviceID=${sl<SharedPreferenceHelper>().getTokenDevice}&fields=-groupAPIDenines,-groupAPIAccesses,-groupDetails,-groups,-dateOfBirth,-gender,-role,-email,-coverPhotos,-avatar,-fullName,-isDeleted,-fcmTokens,-socialType,-isEnableFCM';
    late Response response;

    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri += filter.toString();
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }

    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as List<dynamic>;
      if (results.isNotEmpty) {
        onSuccess(AuthModel.fromMap(results.first as Map<String, dynamic>));
      }
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Find bang-bang-cap by id
  ///
  Future<void> find(
    String id, {
    String? filter,
    required Function(AuthModel event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String _uri = '${EndPoint.users}/$id';
    late Response response;

    if (!IZIValidate.nullOrEmpty(filter)) {
      _uri += filter.toString();
    }

    try {
      response = await _dio.get(_uri);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }

    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(AuthModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  ///
  /// Update
  ///
  Future<void> increaseFreeMessage({
    required int amount,
    required Function(UserModel data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    final String _uri = '${EndPoint.users}/${sl<SharedPreferenceHelper>().getIdUser}/increase-aicount-free-messages';

    final Map<String, dynamic> _data = {"amount": amount};
    try {
      response = await _dio.put(_uri, data: _data);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) && response.statusCode! >= 200 && response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(UserModel.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
