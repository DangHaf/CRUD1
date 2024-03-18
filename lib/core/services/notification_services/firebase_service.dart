import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/services/notification_services/local_notification_service.dart';
import 'package:template/data/model/notification/notification_model.dart';

class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initForegroundNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> init() async {
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('Firebase User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('Firebase User granted provisional permission');
    } else {
      log('Firebase User declined or has not accepted permission');
    }

    await _firebaseMessaging.setAutoInitEnabled(true);

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {});

    /// Xử lý message khi nhận thông báo ở forgground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final RemoteNotification? notification = message.notification;
      if (notification != null && Platform.isAndroid) {
        final Map<String, dynamic> data = message.data;
        LocalNotificationAPI().showNotificationWithPayload(
          title: notification.title!.tr,
          body: notification.body!.tr,
          payLoad: jsonEncode(data),
          idNotification: notification.hashCode,
        );
      }
    });

    /// Xử lý message khi nhân vào thông báo.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      debugPrint("onMessageOpenedApp: data ${message.data}");
      debugPrint("onMessageOpenedApp: notification ${message.notification}");
      onOpenNotification(message);
    });
  }

  // Yêu cầu cấp quyền
  Future<void> requestPermission() async {
    final requestPermisson = await _firebaseMessaging.getNotificationSettings();
    if (requestPermisson.authorizationStatus == AuthorizationStatus.denied ||
        requestPermisson.authorizationStatus ==
            AuthorizationStatus.notDetermined ||
        requestPermisson.authorizationStatus ==
            AuthorizationStatus.provisional) {
      await _firebaseMessaging.requestPermission(
        announcement: true,
        carPlay: true,
      );
    }
  }

  /// Top function / static function xử lý khi nhận thông báo backdround
  static Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
    debugPrint("onBackgroundMessage data: ${message.data}");
    debugPrint("onBackgroundMessage notification: ${message.notification}");
    // LocalNotificationService().showNotification(
    //   Random().nextInt(1000),
    //   message.notification?.title ?? '',
    //   message.notification?.body ?? '',
    //   notificationChannelId,
    //   "DPFOOD",
    //   "",
    // );
  }

  /// Open notification
  Future<void> onOpenNotification(RemoteMessage message,
      {bool isAppClosed = false}) async {
    final DataNotification data = DataNotification.fromMap(message.data);

    if (data.entityType == 'VOUCHER') {
      Get.toNamed(AppRoute.VOUCHER_DETAIL, arguments: data.idVoucher);
      return;
    }
    if (data.entityType == 'PURCHASE') {
      Get.toNamed(
        AppRoute.DETAIL_ORDER,
        arguments: data.idPurchase,
      );
      return;
    }
  }

  Future<void> backgroundHandler() async {
    await Firebase.initializeApp();

    /// Goi khi nhận thông báo background
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }

  Future<void> subscribeTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeTopic(String topic) async {
    // ignore: deprecated_member_use
    final bool isReset = await deleteInstanceID();
    if (!isReset) {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    }
  }

  Future<bool> deleteInstanceID() async {
    try {
      await _firebaseMessaging.deleteToken();
      return true;
    } catch (e) {
      return false;
    }
  }
}
