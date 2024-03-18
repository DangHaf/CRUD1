import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/data/model/notification/notification_model.dart';
import 'package:template/presentation/pages/account/account_controller.dart';
import 'package:template/presentation/pages/favorite/favorite_controller.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/pages/student_management/student_management_controller.dart';

class DashBoardController extends GetxController {
  RxInt currentIndex = 1.obs;

  RxBool isLogged = sl<SharedPreferenceHelper>().isLogged.obs;

  @override
  void onInit() {
    initNotificationForeground();
    initNotificationBackground();
    super.onInit();
  }

  @override
  void onReady() {
    if (isLogged.value != sl<SharedPreferenceHelper>().isLogged) {
      isLogged.value = sl<SharedPreferenceHelper>().isLogged;
    }

    Get.find<HomeController>().onReady();
    Get.find<FavoriteController>().onReady();
    Get.find<AccountController>().onReady();
    Get.find<StudentManagementController>().onReady();
    super.onReady();
  }

  Future<void> initNotificationForeground() async {
    final notificationAppLaunchDetails = await sl<LocalNotificationAPI>()
        .flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      final notificationRes =
          notificationAppLaunchDetails!.notificationResponse;
      try {
        if (notificationRes?.payload != null) {
          final DataNotification data = DataNotification.fromMap(
              jsonDecode(notificationRes!.payload!)
                  as Map<String, dynamic>);
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
      } catch (_) {}
    }
  }

  void initNotificationBackground() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
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
    });
  }

  void onChangeDashboardPage({
    required int index,
    bool needRefresh = true,
    String? idCart,
    List<String> idBuyBack = const [],
  }) {
    if (index == currentIndex.value) return;
    currentIndex.value = index;
  }
}
