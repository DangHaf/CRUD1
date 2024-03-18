import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/enums/enum_date_type.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/account/point/point_controller.dart';
import 'package:template/presentation/pages/account/point/widgets/bottom_select_date.dart';
import 'package:template/presentation/pages/account/point/widgets/item_point_history.dart';
import 'package:template/presentation/pages/account/point/widgets/paint_background.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class PointPage extends GetView<PointController> {
  const PointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(Get.width, Get.width * 0.6),
            painter: PaintBackground(color: ColorResources.COLOR_3B71CA),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: BaseAppBar(
              title: 'change_point_001'.tr,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: Get.width * 0.6 - 64 - 20.r - MediaQuery.of(context).padding.top,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => Text(
                            controller.totalPoint.value.toString(),
                            style: AppText.text40.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'change_point_003'.tr,
                          style: AppText.text20.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  ImagesPath.icPoint,
                  width: 80.r,
                  height: 80.r,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    vertical: 12.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'change_point_004'.tr,
                        style: AppText.text17.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              BottomSelectDate(
                                callBack: (dateType) async {
                                  if (dateType == DateType.PERIOD) {
                                    final results =
                                        await showCalendarDatePicker2Dialog(
                                      context: context,
                                      config:
                                          CalendarDatePicker2WithActionButtonsConfig(
                                        calendarType:
                                            CalendarDatePicker2Type.range,
                                      ),
                                      dialogSize:
                                          Size(Get.width * 0.8, Get.width * 0.8),
                                      value: [],
                                      borderRadius: BorderRadius.circular(15),
                                    );
                                    if (results != null && results.isNotEmpty) {
                                      controller.onChangeDate(dateType);
                                      controller.onChangeRangeDate(results);
                                    }
                                  } else {
                                    controller.onChangeDate(dateType);
                                  }
                                },
                                dateType: controller.dateType,
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                width: 0.45,
                                color: ColorResources.COLOR_3B71CA,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImagesPath.icCalendar,
                                  width: 14.r,
                                  height: 14.r,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  controller.displayFilter.value,
                                  style: AppText.text12.copyWith(
                                      color: ColorResources.COLOR_3B71CA),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => SmartRefresher(
                      controller: controller.refreshController,
                      header: Platform.isAndroid
                          ? const MaterialClassicHeader(
                              color: ColorResources.COLOR_3B71CA)
                          : null,
                      onLoading: () =>
                          controller.getListPointHistory(isLoadMore: true),
                      enablePullUp: controller.isLoadMore,
                      onRefresh: () => controller.initDataPoint(isRefresh: true),
                      child: controller.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.listPointHistory.isEmpty
                              ? Center(
                                  child: Text(
                                    'empty_data'.tr,
                                    style: AppText.text14.copyWith(
                                      color: ColorResources.COLOR_677275,
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          IZISizeUtil.PADDING_HORIZONTAL_HOME,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: controller.listPointHistory.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ItemPointHistory(
                                        pointHistory:
                                            controller.listPointHistory[index],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(height: 8.h);
                                    },
                                  ),
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
