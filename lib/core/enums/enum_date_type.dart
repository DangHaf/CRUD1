import 'package:get/get.dart';
import 'package:template/core/utils/extensions/date_time_extension.dart';

enum DateType {
  TODAY,
  YESTERDAY,
  LAST_WEEK,
  LAST_MONTH,
  PERIOD,
  OTHER,
}

extension DateTypeExtension on DateType {
  String get stringValue {
    switch (this) {
      case DateType.TODAY:
        return 'change_point_012'.tr;
      case DateType.YESTERDAY:
        return 'change_point_013'.tr;
      case DateType.LAST_WEEK:
        return 'change_point_014'.tr;
      case DateType.LAST_MONTH:
        return 'change_point_015'.tr;
      case DateType.PERIOD:
        return 'change_point_016'.tr;
      default:
        return 'change_point_017'.tr;
    }
  }

  String? get stringFilter {
    switch (this) {
      case DateType.TODAY:
        final int _startTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ).millisecondsSinceEpoch;

        final int _endTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          23,
          59,
        ).millisecondsSinceEpoch;

        return 'historyDate>$_startTime&historyDate<$_endTime';
      case DateType.YESTERDAY:
        final int _startTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 1,
        ).millisecondsSinceEpoch;

        final int _endTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 1,
          23,
          59,
        ).millisecondsSinceEpoch;

        return 'historyDate>$_startTime&historyDate<$_endTime';
      case DateType.LAST_WEEK:
        final date = DateTime.now();
        final startOfWeek =
            date.subtract(Duration(days: date.weekday + 6)).getDate;
        final endOfWeek = date
            .add(Duration(days: DateTime.daysPerWeek - date.weekday - 7))
            .getDate;
        final int _startTime = DateTime(
          startOfWeek.year,
          startOfWeek.month,
          startOfWeek.day,
        ).millisecondsSinceEpoch;

        final int _endTime = DateTime(
          endOfWeek.year,
          endOfWeek.month,
          endOfWeek.day,
          23,
          59,
        ).millisecondsSinceEpoch;
        return 'historyDate>$_startTime&historyDate<$_endTime';
      case DateType.LAST_MONTH:
        final DateTime now = DateTime.now();
        final DateTime lastMonth = DateTime(now.year, now.month - 1);
        final DateTime firstDayOfLastMonth =
        DateTime(lastMonth.year, lastMonth.month);
        final DateTime lastDayOfLastMonth =
        DateTime(lastMonth.year, lastMonth.month + 1, 0);

        final int _startTime = DateTime(
          firstDayOfLastMonth.year,
          firstDayOfLastMonth.month,
          firstDayOfLastMonth.day,
        ).millisecondsSinceEpoch;

        final int _endTime = DateTime(
          lastDayOfLastMonth.year,
          lastDayOfLastMonth.month,
          lastDayOfLastMonth.day,
          23,
          59,
        ).millisecondsSinceEpoch;
        return 'historyDate>$_startTime&historyDate<$_endTime';
      default:
        return null;
    }
  }

  List<DateTime> get dateTimeRange {
    switch (this) {
      case DateType.TODAY:
        final _startTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );

        final _endTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          23,
          59,
        );

        return [_startTime, _endTime];
      case DateType.YESTERDAY:
        final _startTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 1,
        );

        final _endTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 1,
          23,
          59,
        );

        return [_startTime, _endTime];
      case DateType.LAST_WEEK:
        final date = DateTime.now();
        final startOfWeek =
            date.subtract(Duration(days: date.weekday + 6)).getDate;
        final endOfWeek = date
            .add(Duration(days: DateTime.daysPerWeek - date.weekday - 7))
            .getDate;
        final _startTime = DateTime(
          startOfWeek.year,
          startOfWeek.month,
          startOfWeek.day,
        );

        final _endTime = DateTime(
          endOfWeek.year,
          endOfWeek.month,
          endOfWeek.day,
          23,
          59,
        );
        return [_startTime, _endTime];
      case DateType.LAST_MONTH:
        final DateTime now = DateTime.now();
        final DateTime lastMonth = DateTime(now.year, now.month - 1);
        final DateTime firstDayOfLastMonth =
        DateTime(lastMonth.year, lastMonth.month);
        final DateTime lastDayOfLastMonth =
        DateTime(lastMonth.year, lastMonth.month + 1, 0);

        final _startTime = DateTime(
          firstDayOfLastMonth.year,
          firstDayOfLastMonth.month,
          firstDayOfLastMonth.day,
        );

        final _endTime = DateTime(
          lastDayOfLastMonth.year,
          lastDayOfLastMonth.month,
          lastDayOfLastMonth.day,
          23,
          59,
        );
        return [_startTime, _endTime];
      default:
        return [];
    }
  }
}