import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/notification/notification_controller.dart';
import 'package:template/presentation/pages/notification/widgets/item_notification.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(title: 'notification_001'.tr),
      body: Obx(
        () => controller.isLoading
            ? Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              )
            : controller.listNotification.isEmpty
                ? Center(
                    child: Text(
                      'empty_data'.tr,
                      style: AppText.text14.copyWith(
                        color: ColorResources.COLOR_677275,
                      ),
                    ),
                  )
                : SmartRefresher(
                    controller: controller.refreshController,
                    header: Platform.isAndroid
                        ? const MaterialClassicHeader(
                            color: ColorResources.COLOR_3B71CA)
                        : null,
                    onLoading: () =>
                        controller.getListNotification(isLoadMore: true),
                    enablePullUp: controller.isLoadMore,
                    onRefresh: () => controller.initData(isRefresh: true),
                    child: ListView.separated(
                      itemCount: controller.listNotification.length,
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemNotification(
                          notification: controller.listNotification[index],
                          readNotification: () {
                            controller.readNotification(index);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          thickness: 0.3,
                          color: ColorResources.COLOR_A4A2A2.withOpacity(0.75),
                          height: 0,
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
