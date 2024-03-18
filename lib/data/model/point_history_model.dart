import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';

class PointHistoryResponse {
  final List<PointHistoryModel> result;
  final int totalResults;
  final int totalPages;

  PointHistoryResponse({
    this.result = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });

  factory PointHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PointHistoryResponse(
      result: (json['results'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  PointHistoryModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalResults: json['totalResults'] as int? ?? 0,
    );
  }
}

class PointHistoryModel {
  String? id;
  String? type;
  DateTime? historyDate;
  num? point;
  String? idUser;
  String? idStore;
  DateTime? createdAt;
  DateTime? updatedAt;

  PointHistoryModel({
    this.id,
    this.type,
    this.idUser,
    this.historyDate,
    this.point,
    this.idStore,
    this.createdAt,
    this.updatedAt,
  });

  factory PointHistoryModel.fromMap(Map<String, dynamic> map) {
    return PointHistoryModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      historyDate: map['historyDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['historyDate'] as int)
          : null,
      point: map['point'] as int?,
      idUser: map['idUser'] as String?,
      idStore: map['idStore'] as String?,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] == null
          ? null
          : DateTime.parse(map['updatedAt'] as String),
    );
  }

  String get getTitle {
    switch (type) {
      case SHARE_DOWNLOAD:
        return 'change_point_007'.tr;
      default:
        return '';
    }
  }

  Color get colorPoint {
    switch (type) {
      case SHARE_DOWNLOAD:
        return ColorResources.COLOR_28B446;
      default:
        return Colors.black;
    }
  }

  String get getPoint {
    switch (type) {
      case SHARE_DOWNLOAD:
        return '+$point';
      default:
        return '';
    }
  }

  String get getContent {
    switch (type) {
      case SHARE_DOWNLOAD:
        return 'change_point_008'.tr;
      default:
        return '';
    }
  }

  String get getIcon {
    switch (type) {
      case SHARE_DOWNLOAD:
        return ImagesPath.icShare;
      default:
        return '';
    }
  }
}
