import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_alert.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/address/address_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/repositories/account_repository.dart';
import 'package:template/data/repositories/address_repository.dart';
import 'package:template/data/repositories/auth_repository.dart';

class AddAddressController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final AccountRepository _accountRepository = GetIt.I.get<AccountRepository>();
  final AddressRepository _addressRepository = GetIt.I.get<AddressRepository>();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final idUser = sl<SharedPreferenceHelper>().getIdUser;
  UserModel _user = UserModel();
  StateModel? state;
  CityModel? city;
  List<CityModel> listCity = [];

  final Rx<Country> _country = LookUpData.country.obs;

  Country get country => _country.value;
  TextEditingController searchDialCode = TextEditingController();

  PhoneCountry? phoneCountry;

  RxBool ignoring = false.obs;

  bool setDefault = false;

  @override
  void onInit() {
    if(Get.arguments != null){
      setDefault = Get.arguments as bool;
    }
    super.onInit();
    _getUser();
  }

  Future<void> _getUser() async {
    await _accountRepository.getUser(
      onSuccess: (data) async {
        _user = data;
        name.text = _user.fullName ?? '';
        await getPhone();
      },
      onError: (error) {},
    );
  }

  Future<void> getPhone() async {
    if (_user.countryCode != null) {
      try {
        for (int i = 0; i < LookUpData.countryList.length; i++) {
          if (LookUpData.countryList[i].alpha2Code == _user.countryCode) {
            _country.value = LookUpData.countryList[i];
            break;
          }
        }
        await _authRepository.checkPhone(
          phoneNumber: _user.phone!,
          country: _user.countryCode!,
          onSuccess: (data) async {
            if (data.isValid && data.phoneNational != null) {
              phoneNumber.text = data.phoneNational ?? '';
            }
          },
          onError: (_) {},
        );
      } catch (_) {}
    }
  }

  void onChangeState(StateModel stateModel) {
    if (state?.id != stateModel.id) {
      state = stateModel;
      city = null;
      stateController.text = stateModel.name;
      cityController.clear();
      listCity.clear();
      for (final element in LookUpData.listCity) {
        if (element.idState == stateModel.id) {
          listCity.add(element);
        }
      }
    }
  }

  void onChangeCity(CityModel cityModel) {
    if (city?.id != cityModel.id) {
      city = cityModel;
      cityController.text = cityModel.name;
    }
  }

  // ignore: use_setters_to_change_properties
  void onChangeCountry(Country country) {
    _country.value = country;
  }

  bool get isValid {
    if (name.text.trim().isEmpty) {
      IZIAlert().error(message: 'address_013'.tr);
      return false;
    }
    if (phoneNumber.text.isEmpty) {
      IZIAlert().error(message: 'address_012'.tr);
      return false;
    }
    if (state == null) {
      IZIAlert().error(message: 'address_009'.tr);
      return false;
    }
    if (city == null) {
      IZIAlert().error(message: 'address_010'.tr);
      return false;
    }
    if (addressController.text.isEmpty) {
      IZIAlert().error(message: 'address_011'.tr);
      return false;
    }
    return true;
  }

  Future<void> createAddress() async {
    if (!isValid) {
      return;
    }
    await _checkPhone();
    String phone = '';
    if (phoneCountry != null && phoneCountry!.isValid) {
      phone = phoneCountry!.phoneNumber!;
      for (int i = 0; i < LookUpData.countryList.length; i++) {
        if (LookUpData.countryList[i].alpha2Code == phoneCountry?.countryIso2 ||
            LookUpData.countryList[i].alpha3Code == phoneCountry?.countryIso3) {
          _country.value = LookUpData.countryList[i];
          break;
        }
      }
    } else {
      IZIAlert().error(message: 'auth_047'.tr);
      return;
    }
    ignoring.value = true;
    EasyLoading.show(status: 'address_008'.tr);
    final AddressRequest address = AddressRequest(
      idCity: city!.id,
      idUser: idUser,
      idState: state!.id,
      addressDetail: addressController.text.trim(),
      phone: phone,
      fullName: name.text.trim(),
      isDefault: setDefault,
    );
    await _addressRepository.create(
      addressRequest: address,
      onSuccess: () {
        IZIAlert().success(message: 'address_014'.tr);
        Get.back(result: true);
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    ignoring.value = false;
    EasyLoading.dismiss();
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
}
