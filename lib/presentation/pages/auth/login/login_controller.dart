import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/data_source/dio/dio_client.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/repositories/account_repository.dart';
import 'package:template/data/repositories/auth_repository.dart';
import 'package:template/presentation/pages/auth/login/auth_apple_service.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final AccountRepository _accountRepository = GetIt.I.get<AccountRepository>();
  final DioClient _dioClient = GetIt.I.get<DioClient>();

  GoogleSignIn googleSignIn = GoogleSignIn();

  FacebookAuth facebookAuth = FacebookAuth.instance;

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  RxBool ignoring = false.obs;

  final Rx<Country> _country = LookUpData.country.obs;

  Country get country => _country.value;
  TextEditingController searchDialCode = TextEditingController();
  RxBool availableApple = false.obs;

  PhoneCountry? phoneCountry;

  final RxBool _isRemember = false.obs;

  bool get isRemember => _isRemember.value;
  String? route;

  /// 0 -> Customer tap, 1 -> Supplier
  final RxInt _currentTab = 0.obs;

  int get currentTab => _currentTab.value;

  @override
  void onInit() {
    super.onInit();
    _getDataRemember();
    if (Get.arguments != null && Get.arguments['route'] != null) {
      route = Get.arguments['route'] as String;
    }
    if (Get.arguments != null && Get.arguments['country'] != null) {
      _country.value = Get.arguments['country'] as Country;
    }
    if (Get.arguments != null && Get.arguments['password'] != null) {
      password.text = Get.arguments['password'] as String;
    }
    if (Get.arguments != null && Get.arguments['phoneNumber'] != null) {
      phoneNumber.text = Get.arguments['phoneNumber'] as String;
    }

    if (Platform.isIOS) {
      checkAvailableAppleLogin();
    }
  }

  @override
  void onReady() {
    try {
      if (Get.arguments != null && Get.arguments['country'] != null) {
        _country.value = Get.arguments['country'] as Country;
      }
      if (Get.arguments != null && Get.arguments['password'] != null) {
        password.text = Get.arguments['password'] as String;
      }
      if (Get.arguments != null && Get.arguments['phoneNumber'] != null) {
        phoneNumber.text = Get.arguments['phoneNumber'] as String;
      }
    } catch (_) {}

    super.onInit();
  }

  ///
  /// Check Available Apple Login.
  ///
  Future<void> checkAvailableAppleLogin() async {
    availableApple.value = await TheAppleSignIn.isAvailable();
    if (availableApple.value == true) {
      TheAppleSignIn.onCredentialRevoked!.listen((data) {});
    }
  }

  Future<void> onLoginWithGoogle() async {
    if (currentTab == 1) {
      IZIAlert().error(message: 'auth_070'.tr);
      return;
    }
    ignoring.value = true;
    try {
      EasyLoading.show(status: 'auth_044'.tr);
      final GoogleSignInAccount? _googleUser = await googleSignIn.signIn();
      if (_googleUser != null) {
        final GoogleSignInAuthentication _googleAuth =
            await _googleUser.authentication;

        //
        // Obtain the auth request.
        final AuthCredential _credential = GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken,
          idToken: _googleAuth.idToken,
        );

        // Create a new Auth instance.
        final UserCredential _user =
            await FirebaseAuth.instance.signInWithCredential(_credential);

        // Create daa to push server to sign in.
        final SocialRequest _authRequest = SocialRequest(
          fullName: _user.user?.displayName,
          deviceID: sl<SharedPreferenceHelper>().getTokenDevice,
          lang: sl<SharedPreferenceHelper>().getLocale,
          tokenLogin: _user.user?.uid,
          typeTokenLogin: GOOGLE,
          avatar: _user.user?.photoURL,
        );

        await _authRepository.signInSocial(
          data: _authRequest,
          onSuccess: (data) async {
            await sl<SharedPreferenceHelper>()
                .setIdUser(idUser: data.user!.id!);
            await sl<SharedPreferenceHelper>().setIsLogged(isLogged: true);
            await sl<SharedPreferenceHelper>()
                .setRefreshToken(data.refreshToken.toString());
            await sl<SharedPreferenceHelper>()
                .setJwtToken(data.accessToken.toString());
            await _dioClient.refreshToken();
            _accountRepository.updateLanguageUser(
              lang: sl<SharedPreferenceHelper>().getLocale,
              onSuccess: () {},
              onError: (_) {},
            );
            EasyLoading.dismiss();

          },
          onError: (e) {
            EasyLoading.dismiss();
            IZIAlert().error(message: e.toString());
            googleSignIn.signOut();
            facebookAuth.logOut();
          },
        );
      } else {
        EasyLoading.dismiss();
        IZIAlert().error(message: 'auth_045'.tr);
      }
    } catch (e) {
      EasyLoading.dismiss();
      googleSignIn.signOut();
      IZIAlert().error(message: e.toString());
    }
    ignoring.value = false;
  }

  Future<void> onLoginWithFacebook() async {
    if (currentTab == 1) {
      IZIAlert().error(message: 'auth_070'.tr);
      return;
    }
    ignoring.value = true;
    try {
      final userFacebook = await facebookAuth.getUserData();

      EasyLoading.show(status: 'auth_044'.tr);

      final SocialRequest _authRequest = SocialRequest(
        fullName: userFacebook['name'],
        deviceID: sl<SharedPreferenceHelper>().getTokenDevice,
        lang: sl<SharedPreferenceHelper>().getLocale,
        tokenLogin: userFacebook['id'],
        typeTokenLogin: FACEBOOK,
        avatar:
            'https://graph.facebook.com/${userFacebook['id']}/picture?type=large&redirect=true&width=500&height=500',
      );

      await _authRepository.signInSocial(
        data: _authRequest,
        onSuccess: (data) async {
          await sl<SharedPreferenceHelper>().setIdUser(idUser: data.user!.id!);
          await sl<SharedPreferenceHelper>().setIsLogged(isLogged: true);
          await sl<SharedPreferenceHelper>()
              .setRefreshToken(data.refreshToken.toString());
          await sl<SharedPreferenceHelper>()
              .setJwtToken(data.accessToken.toString());
          await _dioClient.refreshToken();
          _accountRepository.updateLanguageUser(
            lang: sl<SharedPreferenceHelper>().getLocale,
            onSuccess: () {},
            onError: (_) {},
          );
          EasyLoading.dismiss();

        },
        onError: (e) {
          EasyLoading.dismiss();
          IZIAlert().error(message: e.toString());
          facebookAuth.logOut();
        },
      );
    } catch (e) {
      IZIAlert().error(message: e.toString());
    }
    ignoring.value = false;
  }

  Future<void> onLoginWithApple() async {
    if (currentTab == 1) {
      IZIAlert().error(message: 'auth_070'.tr);
      return;
    }
    if (availableApple.value) {
      ignoring.value = true;
      try {
        EasyLoading.show(status: 'auth_044'.tr);
        final authService = AuthAppleService();
        final _userIOS = await authService
            .signInWithApple(scopes: [Scope.email, Scope.fullName]);

        final SocialRequest _authRequest = SocialRequest(
          fullName: _userIOS.displayName,
          deviceID: sl<SharedPreferenceHelper>().getTokenDevice,
          lang: sl<SharedPreferenceHelper>().getLocale,
          tokenLogin: _userIOS.uid,
          typeTokenLogin: APPLE,
          avatar: _userIOS.photoURL,
        );

        await _authRepository.signInSocial(
          data: _authRequest,
          onSuccess: (data) async {
            await sl<SharedPreferenceHelper>()
                .setIdUser(idUser: data.user!.id!);
            await sl<SharedPreferenceHelper>().setIsLogged(isLogged: true);
            await sl<SharedPreferenceHelper>()
                .setRefreshToken(data.refreshToken.toString());
            await sl<SharedPreferenceHelper>()
                .setJwtToken(data.accessToken.toString());
            await _dioClient.refreshToken();
            _accountRepository.updateLanguageUser(
              lang: sl<SharedPreferenceHelper>().getLocale,
              onSuccess: () {},
              onError: (_) {},
            );
            EasyLoading.dismiss();

          },
          onError: (e) {
            EasyLoading.dismiss();
            IZIAlert().error(message: e.toString());
            facebookAuth.logOut();
          },
        );
      } catch (e) {
        EasyLoading.dismiss();
        IZIAlert().error(message: e.toString());
      }
      ignoring.value = false;
    } else {
      IZIAlert().error(message: 'auth_046'.tr);
    }
  }

  Future<void> onLoginWithPhone() async {
    if (currentTab == 1) {
      IZIAlert().error(message: 'auth_070'.tr);
      return;
    }
    if (isValidLogin) {
      ignoring.value = true;
      await _checkPhone();
      if (phoneCountry != null) {
        if (!phoneCountry!.isValid) {
          IZIAlert().error(message: 'auth_047'.tr);
        } else {
          EasyLoading.show(status: 'auth_044'.tr);
          final LoginRequest authRequest = LoginRequest(
            phone: phoneCountry!.phoneNumber!,
            password: password.text.trim(),
            deviceID: sl<SharedPreferenceHelper>().getTokenDevice,
            lang: sl<SharedPreferenceHelper>().getLocale,
            storeUserType: CUSTOMER,
          );
          await _authRepository.signInPhone(
            data: authRequest,
            onSuccess: (data) async {
              await sl<SharedPreferenceHelper>()
                  .setIdUser(idUser: data.user!.id!);
              await sl<SharedPreferenceHelper>().setIsLogged(isLogged: true);
              await sl<SharedPreferenceHelper>()
                  .setRefreshToken(data.refreshToken.toString());
              await sl<SharedPreferenceHelper>()
                  .setJwtToken(data.accessToken.toString());
              await _dioClient.refreshToken();
              _accountRepository.updateLanguageUser(
                lang: sl<SharedPreferenceHelper>().getLocale,
                onSuccess: () {},
                onError: (_) {},
              );

              _saveDataRemember();
              EasyLoading.dismiss();
            },
            onError: (error) {
              EasyLoading.dismiss();
              IZIAlert().error(message: error.toString());
            },
          );
        }
      }
      ignoring.value = false;
    }
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

  set country(Country country) {
    _country.value = country;
  }

  bool get isValidLogin {
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
    return true;
  }

  set isRemember(bool value) {
    _isRemember.value = value;
  }

  void _saveDataRemember() {
    sl<SharedPreferenceHelper>().setIsRemember(value: isRemember);
    if (isRemember) {
      sl<SharedPreferenceHelper>().setPhoneNumber(phoneNumber.text.trim());
      sl<SharedPreferenceHelper>().setCountry(country.dialCode!);
      sl<SharedPreferenceHelper>().setAlpha2Code(country.alpha2Code!);
      sl<SharedPreferenceHelper>().setPassword(password.text.trim());
    } else {
      sl<SharedPreferenceHelper>().removeCountry();
      sl<SharedPreferenceHelper>().removePassword();
      sl<SharedPreferenceHelper>().removePhoneNumber();
    }
  }

  void _getDataRemember() {
    final bool dataSave = sl<SharedPreferenceHelper>().getIsRemember;
    if (dataSave) {
      _isRemember.value = dataSave;
      phoneNumber.text = sl<SharedPreferenceHelper>().getPhoneNumber ?? '';
      password.text = sl<SharedPreferenceHelper>().getPassword ?? '';
      final countryCode = sl<SharedPreferenceHelper>().getCountry;
      final alpha2Code = sl<SharedPreferenceHelper>().getAlpha2Code;
      if (countryCode != null) {
        for (int i = 0; i < LookUpData.countryList.length; i++) {
          if (LookUpData.countryList[i].dialCode == countryCode &&
              LookUpData.countryList[i].alpha2Code == alpha2Code) {
            country = LookUpData.countryList[i];
            update();
            break;
          }
        }
      }
    }
  }

  void onChangeTab(int index) {
    if (index == currentTab) {
      return;
    }
    _currentTab.value = index;
  }
}
