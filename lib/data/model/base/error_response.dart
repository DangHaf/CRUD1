// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../core/helper/izi_validate.dart';

/// errors : [{"code":"l_name","message":"The last name field is required."},{"code":"password","message":"The password field is required."}]

class ErrorResponse {
  late List<Errors> _errors;

  List<Errors> get errors => _errors;

  ErrorResponse({required List<Errors> errors}) {
    _errors = errors;
  }

  ErrorResponse.fromJson(dynamic json) {
    if (!IZIValidate.nullOrEmpty(json['errors'])) {
      _errors = [];
      json['errors'].forEach((v) {
        _errors.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errors'] = _errors.map((v) => v.toJson()).toList();
    return map;
  }

  @override
  String toString() => 'ErrorResponse(_errors: $_errors)';
}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  late String _code;
  late String _message;
  late String _title;
  late String _detail;

  String get code => _code;
  String get message => _message;
  String get title => _title;
  String get detail => _detail;

  Errors({required String code, required String message, required String title, required String detail}) {
    _code = code;
    _message = message;
    _title = title;
    _detail = detail;
  }

  Errors.fromJson(dynamic json) {
    _code = json['code'].toString();
    _message = json['message'].toString();
    _title = json['title'].toString();
    _detail = json['detail'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['title'] = _title;
    map['detail'] = _detail;
    return map;
  }
}
