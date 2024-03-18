import 'package:intl/intl.dart';

mixin IZIPrice {
  static String currencyConverterVND(double value, {String? locale = 'vi-VN', String? from, String? replace}) {
    return NumberFormat.currency(name: "", decimalDigits: 0, locale: locale)
        .format(value)
        .replaceAll(from ?? ',', replace ?? '.');
  }

  static String currencyConverter(double value, {String? locale = 'en-US'}) {
    return NumberFormat.currency(name: "", decimalDigits: 0, locale: locale).format(value);
  }
}
