import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/repositories/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  TextEditingController phoneNumber = TextEditingController();

  RxBool ignoring = false.obs;

  final Rx<Country> _country = LookUpData.country.obs;

  Country get country => _country.value;
  TextEditingController searchDialCode = TextEditingController();

  PhoneCountry? phoneCountry;
  String otpCode = '';

  bool isRegisterBefore = false;

  @override
  void onInit() {
    _country.value = Get.arguments['country'] as Country;
    phoneNumber.text = Get.arguments['phoneNumber'] as String;
    super.onInit();
  }

  Future<void> onContinue() async {
    if (isValidPhone) {
      ignoring.value = true;
      await _checkPhone();
      if (phoneCountry != null) {
        if (!phoneCountry!.isValid) {
          IZIAlert().error(message: 'auth_047'.tr);
        } else {
          await _checkPhoneWithRegister();
          if (isRegisterBefore) {
            IZIAlert().error(message: 'auth_072'.tr);
          } else {
            if (LookUpData.setting.isOTPForget) {
              Get.toNamed(AuthRouters.OTP, arguments: {
                'phoneNumberNational': phoneCountry!.phoneNumber,
                'phoneNumber': phoneNumber.text.trim(),
                'isFromForgotPassword': true,
                'country': country,
              });
            } else {
              await _sendOTP();
              Get.toNamed(AuthRouters.RESET_PASSWORD, arguments: {
                'phoneNumberNational': phoneCountry!.phoneNumber,
                'phoneNumber': phoneNumber.text.trim(),
                'country': country,
                'otpCode': otpCode,
              });
            }
          }
        }
      }
      ignoring.value = false;
    }
  }

  set country(Country country) {
    _country.value = country;
  }

  bool get isValidPhone {
    if (phoneNumber.text.isEmpty) {
      IZIAlert().error(message: 'auth_049'.tr);
      return false;
    }
    return true;
  }

  Future<void> _checkPhone() async {
    EasyLoading.show(status: 'auth_048'.tr);
    await _authRepository.checkPhone(
      phoneNumber: phoneNumber.text.trim(),
      country: country.alpha2Code!,
      onSuccess: (data) {
        phoneCountry = data;
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    EasyLoading.dismiss();
  }

  Future<void> _checkPhoneWithRegister() async {
    EasyLoading.show(status: 'auth_048'.tr);
    await _authRepository.checkAccountWithPhone(
      phoneNumber: phoneCountry!.phoneNumber!,
      onSuccess: (data) {
        isRegisterBefore = data;
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    EasyLoading.dismiss();
  }

  Future<void> _sendOTP() async {
    EasyLoading.show(status: 'auth_057'.tr);
    final OTPRequest otp = OTPRequest(phone: phoneCountry!.phoneNumber!);
    await _authRepository.sendOTP(
      data: otp,
      onSuccess: (registerToken) {
        otpCode = registerToken;
      },
      onError: (error) {
        _sendOTP();
      },
    );
    EasyLoading.dismiss();
  }
}
