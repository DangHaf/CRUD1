import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template/core/export/core_export.dart';
import 'package:timeago/timeago.dart' as time_ago;

///
/// Format datetime
///
mixin IZIDate {
  static String formatDate(DateTime dateTime, {String format = "dd/MM/yyyy"}) {
    /// yyyy-MM-dd hh:mm:ss
    /// HH:mm dd-MM-yyyy
    /// dd MMM yyyy
    /// dd-MM-yyyy
    /// dd/MM/yyyy
    /// hh:mm
    /// yyyy-MM-dd
    return DateFormat(format, sl<SharedPreferenceHelper>().getLocale)
        .format(dateTime);
  }

  static DateTime parseDateTime(String dateTime,
      {String format = "dd/MM/yyyy"}) {
    if (!IZIValidate.nullOrEmpty(dateTime)) {
      return DateFormat(format).parse(dateTime);
    }
    return DateTime(1970);
  }

  ///
  /// Customer display time ago.
  ///
  static String customerDisplayTime(DateTime date,
      {String format = 'HH:mm dd-MM-yyyy'}) {
    return time_ago.format(date,
        locale: sl<SharedPreferenceHelper>().getLocale);
  }

  ///
  /// Calculate age.
  ///
  static int calculateAge(DateTime birthDate) {
    final DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  ///
  /// Custom time ago.
  ///
  static String timeAgoCustom(DateTime dateTime) {
    final date2 = DateTime.now();
    final difference = date2.difference(dateTime);

    if (difference.inDays > 7) {
      return DateFormat('HH:mm MM/dd/yyyy').format(dateTime);
    }
    if (difference.inDays == 7) {
      return 'time_ago_001'.trParams({'week': '1'});
    }
    if (difference.inDays > 1) {
      return 'time_ago_002'.trParams({'day': '${difference.inDays}'});
    }

    if (difference.inDays == 1) {
      return 'time_ago_003'.tr;
    }

    if (difference.inHours > 1) {
      return 'time_ago_004'.trParams({'hour': '${difference.inHours}'});
    }

    if (difference.inHours == 1) {
      return 'time_ago_005'.trParams({'hour': '${difference.inHours}'});
    }

    if (difference.inMinutes > 1) {
      return 'time_ago_006'.trParams({'minute': '${difference.inMinutes}'});
    }

    if (difference.inMinutes == 1) {
      return 'time_ago_007'.trParams({'minute': '${difference.inMinutes}'});
    }

    if (difference.inSeconds > 3) {
      return 'time_ago_008'.trParams({'second': '${difference.inSeconds}'});
    }

    return 'time_ago_009'.tr;
  }

  static String? formatDateHaveTodayString({
    required DateTime createAtBefore,
    required DateTime createAtNow,
    required bool isShowOnFirst,
  }) {
    String? _result;

    if (isShowOnFirst) {
      _result = DateFormat('yMd', sl<SharedPreferenceHelper>().getLocale)
          .add_jm()
          .format(createAtNow);

      // If today.
      if (DateTime.now().compareTo(DateTime.now()) == 0) {
        _result = _result.replaceAll(_result.split(' ').first, 'Today');
      }
      return _result;
    }

    if (createAtNow.difference(createAtBefore).inMinutes >= 30) {
      _result = DateFormat('yMd', sl<SharedPreferenceHelper>().getLocale)
          .add_jm()
          .format(createAtNow);

      // If today.
      if (DateTime.now().compareTo(DateTime.now()) == 0) {
        _result = _result.replaceAll(_result.split(' ').first, 'Today');
      }
      return _result;
    }

    return _result;
  }
  //
  static String formatDateFromMilliseconds(int millisecondsSinceEpoch) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  int formatMillisecondsFromDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    return dateTime.millisecondsSinceEpoch;
  }


}
