import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/core/utils/app_constants.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/repositories/auth_repository.dart';
import 'package:template/presentation/pages/auth/otp/otp_controller.dart';

class ResetPasswordController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeConfirmPassword = FocusNode();

  RxBool ignoring = false.obs;

  late String phoneNumberNational;
  late String phoneNumber;
  Country? country;
  String? otpCode;

  @override
  void onInit() {
    phoneNumberNational = Get.arguments['phoneNumberNational'] as String;
    phoneNumber = Get.arguments['phoneNumber'] as String;
    if (Get.arguments['country'] != null) {
      country = Get.arguments['country'] as Country;
    }

    if (Get.arguments['otpCode'] != null) {
      otpCode = Get.arguments['otpCode'] as String;
    }
    super.onInit();
  }

  Future<void> onResetPassword() async {
    if (!isValidReset) {
      return;
    }
    ignoring.value = true;
    EasyLoading.show(status: 'auth_059'.tr);
    final ResetPassWordRequest request = ResetPassWordRequest(
      phone: phoneNumberNational,
      password: newPassword.text.trim(),
      storeUserType: CUSTOMER,
      otpCode: otpCode,
    );
    await _authRepository.resetPassword(
      data: request,
      onSuccess: () async {
        try{
          Get.find<OTPController>().otpController.clear();
        }catch(_){}
        EasyLoading.dismiss();
        IZIAlert().success(message: 'auth_060'.tr);
        Get.offNamedUntil(AuthRouters.LOGIN, (route) => true, arguments: {
          'country': country,
          'password': newPassword.text.trim(),
          'phoneNumber': phoneNumber,
        });
      },
      onError: (error) {
        EasyLoading.dismiss();
        IZIAlert().error(message: error.toString());
      },
    );
    ignoring.value = false;
  }

  bool get isValidReset {
    if (newPassword.text.isEmpty) {
      IZIAlert().error(message: 'auth_050'.tr);
      return false;
    }
    if (newPassword.text.trim().length < 6) {
      IZIAlert().error(message: 'auth_051'.tr);
      return false;
    }
    if (confirmNewPassword.text.isEmpty) {
      IZIAlert().error(message: 'auth_054'.tr);
      return false;
    }
    if (confirmNewPassword.text.trim() != newPassword.text.trim()) {
      IZIAlert().error(message: 'auth_055'.tr);
      return false;
    }
    return true;
  }
}
