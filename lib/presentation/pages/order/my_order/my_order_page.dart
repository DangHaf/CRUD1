import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/order/my_order/my_order_controller.dart';
import 'package:template/presentation/pages/order/my_order/widgets/bottom_add_cart.dart';
import 'package:template/presentation/pages/order/my_order/widgets/item_order.dart';
import 'package:template/presentation/pages/order/my_order/widgets/tap_my_order.dart';

class MyOrderPage extends GetView<MyOrderController> {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.ignoring.value,
        child: Scaffold(
          backgroundColor: ColorResources.BACK_GROUND_2,
          appBar: BaseAppBar(
            title: 'order_011'.tr,
          ),
          body: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Obx(
      () => SmartRefresher(
        controller: controller.refreshController,
        header: Platform.isAndroid
            ? const MaterialClassicHeader(color: ColorResources.COLOR_3B71CA)
            : null,
        onLoading: () => controller.getListOrder(isLoadMore: true),
        enablePullUp: controller.isLoadMore,
        onRefresh: () => controller.initData(isRefresh: true),
        child: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.listOrder.isEmpty
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
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: controller.listOrder.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemOrder(
                          order: controller.listOrder[index],
                          cancel: () => controller.onCancelOrder(index),
                          received: () =>
                              controller.onChangeStatusReceived(index),
                          review: () => controller.navigateReview(index),
                          repurchase: () {
                            Get.bottomSheet(
                              BottomAddCart(
                                order: controller.listOrder[index],
                                onAddCart: () {
                                  Get.back();
                                  controller.addCart(index);
                                },
                              ),
                            );
                          },
                          onRefresh: () {
                            controller.initData(isRefresh: true);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10.h);
                      },
                    ),
                  ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 74.h,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: controller.autoScrollController,
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Obx(
          () => Row(
            children: [
              TapMyOrder(
                title: 'order_002'.tr,
                icon: ImagesPath.icWaitingConfirm,
                callBack: () {
                  controller.onChangeTap(OrderTap.WAIT_FOR_CONFIRMATION, 0);
                },
                isSelected:
                    controller.orderTap == OrderTap.WAIT_FOR_CONFIRMATION,
                colorSelected: ColorResources.COLOR_FFD600,
                scrollController: controller.autoScrollController,
                index: 0,
              ),
              SizedBox(width: 25.w),
              TapMyOrder(
                title: 'order_005'.tr,
                icon: ImagesPath.icConfirmed,
                callBack: () {
                  controller.onChangeTap(OrderTap.CONFIRMED, 1);
                },
                isSelected: controller.orderTap == OrderTap.CONFIRMED,
                colorSelected: ColorResources.COLOR_130FAB,
                scrollController: controller.autoScrollController,
                index: 1,
              ),
              SizedBox(width: 25.w),
              TapMyOrder(
                title: 'order_004'.tr,
                icon: ImagesPath.icPacking,
                callBack: () {
                  controller.onChangeTap(OrderTap.PACKING, 2);
                },
                isSelected: controller.orderTap == OrderTap.PACKING,
                colorSelected: ColorResources.COLOR_00BCB0,
                scrollController: controller.autoScrollController,
                index: 2,
              ),
              SizedBox(width: 25.w),
              TapMyOrder(
                title: 'order_048'.tr,
                icon: ImagesPath.icDelivering,
                callBack: () {
                  controller.onChangeTap(OrderTap.DELIVERING, 3);
                },
                isSelected: controller.orderTap == OrderTap.DELIVERING,
                colorSelected: ColorResources.COLOR_CD09A2,
                scrollController: controller.autoScrollController,
                index: 3,
              ),
              SizedBox(width: 25.w),
              TapMyOrder(
                title: 'order_006'.tr,
                icon: ImagesPath.icDelivered,
                callBack: () {
                  controller.onChangeTap(OrderTap.DELIVERED, 4);
                },
                isSelected: controller.orderTap == OrderTap.DELIVERED,
                colorSelected: ColorResources.COLOR_0B8A4D,
                scrollController: controller.autoScrollController,
                index: 4,
              ),
              SizedBox(width: 25.w),
              TapMyOrder(
                title: 'order_007'.tr,
                icon: ImagesPath.icReceivedGood,
                callBack: () {
                  controller.onChangeTap(OrderTap.RECEIVED, 5);
                },
                isSelected: controller.orderTap == OrderTap.RECEIVED,
                colorSelected: ColorResources.COLOR_5A0B8A,
                scrollController: controller.autoScrollController,
                index: 5,
              ),
              SizedBox(width: 25.w),
              TapMyOrder(
                title: 'order_008'.tr,
                icon: ImagesPath.icCancel,
                iconSelected: ImagesPath.icCancelRed,
                callBack: () {
                  controller.onChangeTap(OrderTap.CANCELED, 6);
                },
                isSelected: controller.orderTap == OrderTap.CANCELED,
                colorSelected: ColorResources.COLOR_E9330B,
                scrollController: controller.autoScrollController,
                index: 6,
              ),
              SizedBox(width: 25.w),
              TapMyOrder(
                title: 'order_009'.tr,
                icon: ImagesPath.icReturnOrder,
                callBack: () {
                  controller.onChangeTap(OrderTap.RETURN, 7);
                },
                isSelected: controller.orderTap == OrderTap.RETURN,
                colorSelected: ColorResources.COLOR_FA6900,
                scrollController: controller.autoScrollController,
                index: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
