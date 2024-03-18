import 'package:template/data/model/countries/country_list.dart';
import 'package:template/data/model/countries/country_model.dart';

const String PropertyName = 'alpha_2_code';

class CountryRepository {
  CountryRepository._();

  static List<Country> getCountriesData({required List<String>? countries}) {
    final List jsonList = Countries.countryList;

    if (countries == null || countries.isEmpty) {
      return jsonList
          .map((country) => Country.fromJson(country as Map<String, dynamic>))
          .toList();
    }
    final List filteredList = jsonList.where((country) {
      return countries.contains(country[PropertyName]);
    }).toList();

    return filteredList
        .map((country) => Country.fromJson(country as Map<String, dynamic>))
        .toList();
  }
}
