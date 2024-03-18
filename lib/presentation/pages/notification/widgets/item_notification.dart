import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/notification/notification_model.dart';

class ItemNotification extends StatelessWidget {
  final NotificationModel notification;
  final Function() readNotification;

  const ItemNotification({
    super.key,
    required this.notification,
    required this.readNotification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        readNotification();
        if (notification.entityType == VOUCHER) {
          Get.toNamed(
            AppRoute.VOUCHER_DETAIL,
            arguments: notification.idEntity,
          );
        } else {
          Get.toNamed(AppRoute.DETAIL_ORDER, arguments: notification.idEntity);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 14.h,
        ),
        color: !notification.isRead
            ? ColorResources.COLOR_CFEEFF.withOpacity(0.4)
            : Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.entityType == VOUCHER)
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 0.25,
                    color: ColorResources.COLOR_B1B1B1,
                  ),
                ),
                alignment: Alignment.center,
                child: IZIImage(
                  notification.getThumbnail,
                  width: 22.r,
                  height: 22.r,
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: IZIImage(
                  notification.getThumbnail,
                  width: 38.r,
                  height: 38.r,
                ),
              ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppText.text16.copyWith(
                        color: ColorResources.COLOR_181313,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                  SizedBox(height: 5.h),
                  if (notification.entityType == VOUCHER)
                    Text(
                      notification.content,
                      style: AppText.text14.copyWith(
                        color: ColorResources.COLOR_A4A2A2,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  else
                    Html(
                      data: notification.content,
                      style: {
                        "body": Style(
                          margin: Margins.all(0),
                          fontSize: FontSize(14.sp),
                          fontFamily: 'Nunito',
                          color: ColorResources.COLOR_A4A2A2,
                        ),
                        "div": Style(
                          margin: Margins.all(0),
                          fontSize: FontSize(14.sp),
                          fontFamily: 'Nunito',
                          color: ColorResources.COLOR_A4A2A2,
                        ),
                        "span": Style(
                          margin: Margins.all(0),
                          fontSize: FontSize(14.sp),
                          fontFamily: 'Nunito',
                          color: ColorResources.COLOR_0095E9,
                        )
                      },
                    ),
                  SizedBox(height: 10.h),
                  Text(
                    IZIDate.timeAgoCustom(notification.createdAt!),
                    style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_A4A2A2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
