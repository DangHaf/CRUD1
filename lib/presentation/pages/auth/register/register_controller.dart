import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/repositories/auth_repository.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeConfirmPassword = FocusNode();
  FocusNode focusNodeName = FocusNode();

  final Rx<Country> _country = LookUpData.country.obs;

  Country get country => _country.value;
  TextEditingController searchDialCode = TextEditingController();

  RxBool ignoring = false.obs;
  PhoneCountry? phoneCountry;
  bool isRegisterBefore = true;

  Future<void> onRegister() async {
    if (isValidRegister) {
      ignoring.value = true;
      await _checkPhone();
      if (phoneCountry != null) {
        if (!phoneCountry!.isValid) {
          IZIAlert().error(message: 'auth_047'.tr);
        } else {
          await _checkPhoneWithRegister();
          if (!isRegisterBefore) {
            IZIAlert().error(message: 'auth_071'.tr);
          } else {
            final RegisterRequest authRequest = RegisterRequest(
              fullName: name.text.trim(),
              phone: phoneCountry!.phoneNumber!,
              countryCode: country.alpha2Code!,
              password: password.text.trim(),
              storeUserType: CUSTOMER,
            );

            if (LookUpData.setting.isOTPRegister) {
              Get.toNamed(AuthRouters.OTP, arguments: {
                'phoneNumberNational': phoneCountry!.phoneNumber,
                'phoneNumber': phoneNumber.text.trim(),
                'isFromRegister': true,
                'registerRequest': authRequest,
                'country': country,
              });
            } else {
              EasyLoading.show(status: 'auth_052'.tr);
              await _authRepository.signupPhone(
                data: authRequest,
                onSuccess: () async {
                  EasyLoading.dismiss();
                  Get.offNamedUntil(AuthRouters.LOGIN, (route) => true,
                      arguments: {
                        'country': country,
                        'password': password.text.trim(),
                        'phoneNumber': phoneNumber.text.trim(),
                      });
                },
                onError: (error) {
                  EasyLoading.dismiss();
                  IZIAlert().error(message: error.toString());
                },
              );
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

  bool get isValidRegister {
    if (name.text.trim().isEmpty) {
      IZIAlert().error(message: 'auth_053'.tr);
      return false;
    }
    if (phoneNumber.text.isEmpty) {
      IZIAlert().error(message: 'auth_049'.tr);
      return false;
    }
    if (password.text.isEmpty) {
      IZIAlert().error(message: 'auth_050'.tr);
      return false;
    }
    if (password.text.trim().length < 6) {
      IZIAlert().error(message: 'auth_051'.tr);
      return false;
    }
    if (confirmPassword.text.isEmpty) {
      IZIAlert().error(message: 'auth_054'.tr);
      return false;
    }
    if (confirmPassword.text.trim() != password.text.trim()) {
      IZIAlert().error(message: 'auth_055'.tr);
      return false;
    }
    return true;
  }
}
