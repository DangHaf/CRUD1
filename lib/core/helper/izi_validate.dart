mixin IZIValidate {
  ///
  /// check password if return string is has error else null not error.
  ///
  static String? password(String password) {
    if (password.length < 6) return 'Must have at least 6 characters';

    return null;
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool nullOrEmpty(dynamic value) {
    if (value == null ||
        value.toString().trim().isEmpty ||
        value.toString() == 'null' ||
        value.toString() == '{}' ||
        (value is List && value.isEmpty == true)) return true;
    return false;
  }

  ///
  /// Check is number.
  ///
  static bool isNumeric(String s) {
    if (s == 'null') {
      return false;
    }

    return double.tryParse(s) != null || int.tryParse(s) != null;
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool phoneNumber(String? value) {
    final RegExp reg = RegExp(r'^0[0-9]{9}$');
    if (nullOrEmpty(value)) {
      return false;
    }
    if (reg.hasMatch(value!)) {
      // phone validate
      return true;
    }

    return false;
  }

  ///
  /// Validate special characters.
  ///
  static bool hasSpecialCharacters(String input) {
    final pattern = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return pattern.hasMatch(input);
  }
}
