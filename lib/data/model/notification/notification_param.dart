import 'package:template/core/export/core_export.dart';


class NotificationParam {
  int page;
  int limit;
  String appType;
  String usersReceived;
  String language;

  NotificationParam({
    this.page = 1,
    this.limit = 10,
    this.appType = NAIL_SUPPLY,
    required this.usersReceived,
    this.language = 'en',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      'appType': appType,
      'language': language,
      'usersReceived': usersReceived,
    };
  }
}
