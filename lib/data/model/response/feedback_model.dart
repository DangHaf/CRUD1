// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/core/export/core_export.dart';

class FeedbackModel {
  String? id;
  String? deviceID;
  String? customerName;
  String? customerEmail;
  String? feedbackText;
  String? feedbackReply;
  List<String>? feedbackImage;
  List<String>? feedbackFile;
  int? rating;

  FeedbackModel({
    this.id,
    this.deviceID,
    this.customerName,
    this.customerEmail,
    this.feedbackText,
    this.feedbackReply,
    this.feedbackImage,
    this.feedbackFile,
    this.rating,
  });

  FeedbackModel copyWith({
    String? id,
    String? deviceID,
    String? customerName,
    String? customerEmail,
    String? feedbackText,
    String? feedbackReply,
    List<String>? feedbackImage,
    List<String>? feedbackFile,
    int? rating,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      deviceID: deviceID ?? this.deviceID,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      feedbackText: feedbackText ?? this.feedbackText,
      feedbackReply: feedbackReply ?? this.feedbackReply,
      feedbackImage: feedbackImage ?? this.feedbackImage,
      feedbackFile: feedbackFile ?? this.feedbackFile,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) '_id': id,
      if (!IZIValidate.nullOrEmpty(deviceID)) 'deviceID': deviceID,
      if (!IZIValidate.nullOrEmpty(customerName)) 'customerName': customerName,
      if (!IZIValidate.nullOrEmpty(customerEmail)) 'customerEmail': customerEmail,
      if (!IZIValidate.nullOrEmpty(feedbackText)) 'feedbackText': feedbackText,
      if (!IZIValidate.nullOrEmpty(feedbackReply)) 'feedbackReply': feedbackReply,
      if (!IZIValidate.nullOrEmpty(feedbackImage)) 'feedbackImages': feedbackImage,
      if (!IZIValidate.nullOrEmpty(feedbackFile)) 'feedbackFiles': feedbackFile,
      if (!IZIValidate.nullOrEmpty(rating)) 'rating': rating,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'FeedbackModel(id: $id, deviceID: $deviceID, customerName: $customerName, customerEmail: $customerEmail, feedbackText: $feedbackText, feedbackReply: $feedbackReply, feedbackImage: $feedbackImage, feedbackFile: $feedbackFile, rating: $rating)';
  }

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.deviceID == deviceID &&
        other.customerName == customerName &&
        other.customerEmail == customerEmail &&
        other.feedbackText == feedbackText &&
        other.feedbackReply == feedbackReply &&
        other.feedbackImage == feedbackImage &&
        other.feedbackFile == feedbackFile &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deviceID.hashCode ^
        customerName.hashCode ^
        customerEmail.hashCode ^
        feedbackText.hashCode ^
        feedbackReply.hashCode ^
        feedbackImage.hashCode ^
        feedbackFile.hashCode ^
        rating.hashCode;
  }
}
