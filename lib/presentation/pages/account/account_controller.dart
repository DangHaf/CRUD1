import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/core/services/multi_language_service/localization_service.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/data/repositories/account_repository.dart';
import 'package:template/data/repositories/auth_repository.dart';
import 'package:template/data/repositories/lookup_repository.dart';
import 'package:template/data/repositories/order_repository.dart';

class AccountController extends GetxController {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookAuth facebookAuth = FacebookAuth.instance;
  final LookupRepository _lookupRepository = GetIt.I.get<LookupRepository>();
  final AccountRepository _accountRepository = GetIt.I.get<AccountRepository>();
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final OrderRepository _orderRepository = GetIt.I.get<OrderRepository>();
  RxBool ignoring = false.obs;
  final RxString _language = ''.obs;

  String get language => _language.value;

  RxString key = ''.obs;

  /// User
  final Rx<UserModel> _user = UserModel().obs;

  UserModel get user => _user.value;

  String currentUser = sl<SharedPreferenceHelper>().getIdUser;

  final Rx<CountOrderModel> _countOrder = CountOrderModel().obs;

  CountOrderModel get countOrder => _countOrder.value;

  @override
  void onInit() {
    if (sl<SharedPreferenceHelper>().getLocale == 'vi') {
      key.value = 'vi';
      _language.value = 'account_009'.tr;
    } else {
      key.value = 'en';
      _language.value = 'account_010'.tr;
    }
    getUser();
    getCountOrder();
    super.onInit();
  }

  Future<void> getUser() async {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      return;
    }
    await _accountRepository.getUser(
      onSuccess: (data) {
        _user.value = data;
      },
      onError: (error) {},
    );
  }

  Future<void> logout() async {
    ignoring.value = true;
    EasyLoading.show(status: 'account_018'.tr);
    await _authRepository.signOut(
      onSuccess: () {
        sl<SharedPreferenceHelper>().removeIdUser();
        sl<SharedPreferenceHelper>().removeLogged();
        sl<SharedPreferenceHelper>().removeRefreshToken();
        sl<SharedPreferenceHelper>().removeJwtToken();
        Get.offAllNamed(AuthRouters.DASH_BOARD);
        googleSignIn.signOut();
        facebookAuth.logOut();
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    ignoring.value = false;
    EasyLoading.dismiss();
  }

  Future<void> deleteAccount() async {
    ignoring.value = true;
    EasyLoading.show(status: 'account_015'.tr);
    await _accountRepository.deleteUser(onSuccess: () {
      IZIAlert().success(message: 'account_063'.tr);
      sl<SharedPreferenceHelper>().removeIdUser();
      sl<SharedPreferenceHelper>().removeLogged();
      sl<SharedPreferenceHelper>().removeRefreshToken();
      sl<SharedPreferenceHelper>().removeJwtToken();
      Get.offAllNamed(AuthRouters.DASH_BOARD);
      googleSignIn.signOut();
      facebookAuth.logOut();
    }, onError: (error) {
      IZIAlert().error(message: error.toString());
    });
    ignoring.value = false;
    EasyLoading.dismiss();
  }

  Future<void> changeLanguage(String language, String key) async {
    _language.value = language;
    this.key.value = key;
    sl<SharedPreferenceHelper>().setLocale(key);
    LocalizationService.changeLocale(key);
    _accountRepository.updateLanguageUser(
      lang: key,
      onSuccess: () {},
      onError: (_) {},
    );
    _lookupRepository.getTypeProduct(
      onSuccess: (data) {
        LookUpData.typeProduct.clear();
        LookUpData.typeProduct.addAll(data);
      },
      onError: (error) {},
    );
  }

  Future<void> onShare() async {
    ShareResult result;
    result = await Share.shareWithResult(LookUpData.linkShareNailSupply);
    if (result.status == ShareResultStatus.success) {
      _accountRepository.addPointShare(
        onSuccess: () {
          IZIAlert().success(message: 'change_point_021'.tr);
          Get.toNamed(AppRoute.POINT);
        },
        onError: (err) {
          IZIAlert().error(message: err.toString());
        },
      );
    }
  }

  Future<void> getCountOrder() async {
    if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
      return;
    }
    await _orderRepository.getCountOrder(
      onSuccess: (data) {
        _countOrder.value = data;
      },
      onError: (_) {},
    );
  }

  Future<void> refreshData() async {
    getUser();
    getCountOrder();
  }
}
