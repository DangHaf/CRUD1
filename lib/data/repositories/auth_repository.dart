import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/data_source/exception/api_error_handler.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/domain/end_points/end_point.dart';

class AuthRepository {
  final _dio = sl.get<DioClient>();

  Future<void> signInSocial(
      {required SocialRequest data,
      required Function(AuthResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response =
          await _dio.post(EndPoint.SING_IN_WITH_SOCIAL, data: data.toJson());

      onSuccess(AuthResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> signInPhone(
      {required LoginRequest data,
      required Function(AuthResponse data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response =
          await _dio.post(EndPoint.SING_IN_WITH_LOCAL, data: data.toJson());
      onSuccess(AuthResponse.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> signupPhone(
      {required RegisterRequest data,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.post(EndPoint.SING_UP_WITH_LOCAL, data: data.toJson());
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> sendOTP(
      {required OTPRequest data,
      required Function(String registerToken) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response =
          await _dio.post(EndPoint.SEND_OPT_PHONE, data: data.toJson());
      onSuccess(response.data as String);
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> checkPhone(
      {required String phoneNumber,
      required String country,
      required Function(PhoneCountry data) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
          '${EndPoint.PHONE_COUNTRY}/check-phone?phoneNumber=$phoneNumber&country=$country');
      onSuccess(PhoneCountry.fromJson(response.data as Map<String, dynamic>));
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> checkAccountWithPhone(
      {required String phoneNumber,
      required Function(bool) onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final response = await _dio.get(
          '${EndPoint.USER}/check-phone/$phoneNumber/phone/$CUSTOMER/storeUserType?appType=$NAIL_SUPPLY');
      if ((response.data as String) == 'false') {
        onSuccess(false);
      } else {
        onSuccess(true);
      }
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> signOut(
      {required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      final String uri = EndPoint.SIGN_OUT;
      await _dio.post(uri, data: {
        'deviceID': sl<SharedPreferenceHelper>().getTokenDevice,
      });
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }

  Future<void> resetPassword(
      {required ResetPassWordRequest data,
      required Function() onSuccess,
      required Function(dynamic error) onError}) async {
    try {
      await _dio.put(EndPoint.UPDATE_PASSWORD_PHONE, data: data.toJson());
      onSuccess();
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
    }
  }
}
