mixin IZINumber {
  ///
  /// Parse to double
  ///
  static double parseDouble(dynamic number, {double fault = 0.0}) {
    if (number != null) {
      // Double
      if (number is double) {
        return number;
      } else if (number is int) {
        return number * 1.0;
      } else if (number is String) {
        // String double
        if (number.contains('.')) {
          return double.parse(number);
        } else {
          // May be string int
          return int.parse(number) * 1.0;
        }
      }
    }
    return fault;
  }

  ///
  /// Parse to int
  ///
  static int parseInt(dynamic number, {int fault = 0}) {
    if (number != null) {
      // Double
      if (number is double) {
        return number.round();
      } else if (number is int) {
        return number;
      } else if (number is String) {
        // String double
        if (number.contains('.')) {
          return double.parse(number).round();
        } else {
          // May be string int
          return int.parse(number);
        }
      }
    }
    return fault;
  }

  static double parserNumberOfInput(String value) {
    final number = double.parse(
      value.replaceAll('.', ''),
    );
    return number;
  }

  static String convertDoubleToString(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }
}
