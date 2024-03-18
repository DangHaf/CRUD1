import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formatExpiryVoucher {
    return DateFormat('HH:mm MM.dd.yyyy').format(this);
  }

  String get formatExpiryVoucherStandard {
    return DateFormat('MM/dd/yyyy HH:mm ').format(this);
  }

  String get formatTimeOrder {
    return DateFormat('HH:mm MM/dd/yyyy').format(this);
  }

  DateTime get getDate {
    return DateTime(year, month, day);
  }
}
