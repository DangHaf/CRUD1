import 'package:template/core/export/core_export.dart';

class NotificationAppResponse {
  final List<NotificationModel> result;
  final int totalResults;
  final int totalPages;

  NotificationAppResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory NotificationAppResponse.fromJson(Map<String, dynamic> json) {
    return NotificationAppResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
    );
  }
}

class NotificationModel {
  final String? id;
  final String title;
  final String content;
  final String summary;
  final String? thumbnail;
  final String? idEntity;
  final String? image;
  final String? entityType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> usersOpened;

  NotificationModel({
    this.id,
    this.title = '',
    this.content = '',
    this.summary = '',
    this.thumbnail,
    this.idEntity,
    this.image,
    this.entityType,
    this.createdAt,
    this.updatedAt,
    this.usersOpened = const [],
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] as String?,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      thumbnail: json['thumbnail'] as String?,
      idEntity: json['idEntity'] as String?,
      image: json['image'] as String?,
      entityType: json['entityType'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      usersOpened: json['usersOpened'] != null
          ? List<String>.from(json['usersOpened'] as List<dynamic>)
          : [],
    );
  }

  bool get isRead {
    return usersOpened.contains(sl<SharedPreferenceHelper>().getIdUser);
  }

  String get getThumbnail {
    if (entityType == VOUCHER) {
      return ImagesPath.icVoucherNoti;
    }
    if (thumbnail != null && thumbnail!.isNotEmpty) {
      return thumbnail!;
    }
    return '';
  }
}

class DataNotification {
  String? entityType;
  String? appType;
  String? idVoucher;
  String? idPurchase;

  DataNotification({
    this.appType,
    this.idVoucher,
    this.entityType,
    this.idPurchase,
  });

  factory DataNotification.fromMap(Map<String, dynamic> map) {
    return DataNotification(
      entityType: map['entityType'] as String?,
      appType: map['appType'] as String?,
      idVoucher: map['idVoucher'] as String?,
      idPurchase: map['idPurchase'] as String?,
    );
  }
}
