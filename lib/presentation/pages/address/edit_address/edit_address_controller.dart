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
import 'package:template/data/repositories/address_repository.dart';
import 'package:template/data/repositories/auth_repository.dart';

class EditAddressController extends GetxController {
  final AuthRepository _authRepository = GetIt.I.get<AuthRepository>();
  final AddressRepository _addressRepository = GetIt.I.get<AddressRepository>();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  StateModel? state;
  CityModel? city;
  List<CityModel> listCity = [];

  final Rx<Country> _country = LookUpData.country.obs;

  Country get country => _country.value;
  TextEditingController searchDialCode = TextEditingController();

  PhoneCountry? phoneCountry;

  late AddressModel address;
  RxBool ignoring = false.obs;
  final idUser = sl<SharedPreferenceHelper>().getIdUser;

  @override
  void onInit() {
    address = Get.arguments as AddressModel;
    _initData();
    super.onInit();
  }

  void _initData() {
    name.text = address.fullName;
    phoneNumber.text = address.phone;
    addressController.text = address.addressDetail;
    state = address.idState;
    city = address.idCity;
    stateController.text = address.idState?.name ?? '';
    cityController.text = address.idCity?.name ?? '';
    listCity.clear();
    for (final element in LookUpData.listCity) {
      if (element.idState == state?.id) {
        listCity.add(element);
      }
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

  Future<void> updateAddress() async {
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
    EasyLoading.show(status: 'address_015'.tr);
    final AddressRequest address = AddressRequest(
      idCity: city!.id,
      idUser: idUser,
      idState: state!.id,
      addressDetail: addressController.text.trim(),
      phone: phone,
      fullName: name.text.trim(),
    );
    await _addressRepository.update(
      id: this.address.id,
      addressRequest: address,
      onSuccess: () {
        IZIAlert().success(message: 'address_016'.tr);
        Get.back();
      },
      onError: (error) {
        IZIAlert().error(message: error.toString());
      },
    );
    ignoring.value = false;
    EasyLoading.dismiss();
  }

  Future<void> deleteAddress() async {
    EasyLoading.show();
    await _addressRepository.deleteAddress(
      id: address.id,
      onSuccess: () {},
      onError: (error) {},
    );
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
