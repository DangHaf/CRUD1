import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:template/data/model/address/address_model.dart';
import 'package:template/data/model/countries/country_model.dart';
import 'package:template/data/model/setting/setting_model.dart';
import 'package:template/data/model/type_product.dart';

class LookUpData {
  LookUpData();

  static SettingModel setting = SettingModel();
  static List<Country> countryList = <Country>[];
  static Country country = Country(
    name: 'United States',
    alpha2Code: 'US',
    alpha3Code: 'USA',
    dialCode: '+1',
    flagUri: 'assets/flags/${'US'.toLowerCase()}.png',
  );

  static List<StateModel> listState = <StateModel>[];
  static List<CityModel> listCity = <CityModel>[];
  static RxList<TypeProductModel> typeProduct = <TypeProductModel>[].obs;
  static String linkShareNailSupply = '';
}
