import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/notification/notification_detail/notification_detail_controller.dart';

class NotificationDetailPage extends GetView<NotificationDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(title: 'notification_002'.tr),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.notification.image != null)
                    IZIImage(
                      controller.notification.image!,
                      width: Get.width,
                      height: Get.width * 0.53,
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                          vertical: 20.h),
                      child: Column(
                        children: [
                          Text(
                            controller.notification.title,
                            style: AppText.text20.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorResources.COLOR_464647),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.h),
                          Html(
                            data: controller.notification.content,
                            style: {
                              "body": Style(
                                  fontSize: FontSize(14.sp),
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.COLOR_535354,
                                  fontFamily: 'Nunito')
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
