import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/presentation/pages/order/detail_order/detail_order_controller.dart';
import 'package:template/presentation/pages/order/detail_order/widgets/bottom_add_cart_detail.dart';
import 'package:template/presentation/pages/order/detail_order/widgets/dot_line.dart';
import 'package:template/presentation/widgets/custom_button.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailOrderPage extends GetView<DetailOrderController> {
  const DetailOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'order_012'.tr,
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTimeLine(),
                    SizedBox(height: 5.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoute.DETAIL_PROVIDER,
                            arguments: controller.order.idStore?.id);
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: Image.asset(
                                ImagesPath.icProvider,
                                width: 20.r,
                                height: 20.r,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                controller.order.idStore?.name ?? '',
                                style: AppText.text14.copyWith(
                                  color: ColorResources.COLOR_464647,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.sp,
                              color: ColorResources.COLOR_A4A2A2,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    _buildProduct(),
                    SizedBox(height: 10.h),
                    _buildInfoPayment(),
                    SizedBox(height: 10.h),
                    _buildDetailOrder(),
                    if (controller.order.isReturn) _buildReturnOrder(),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(() => _buildBottom()),
    );
  }

  Widget _buildReturnOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            vertical: 14.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'order_026'.tr,
                style: AppText.text14.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.COLOR_181313,
                ),
              ),
              Text(
                controller.order.cancelationReason,
                style: AppText.text14.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.COLOR_464647,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: Get.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            vertical: 14.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'order_028'.tr,
                style: AppText.text14.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.COLOR_181313,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                controller.order.descriptionReason,
                style: AppText.text10.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.COLOR_464647,
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.w,
                children:
                    List.generate(controller.order.images.length, (index) {
                  return InkWell(
                    onTap: () {
                      Get.dialog(Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: SafeArea(
                          child: Stack(
                            children: [
                              SizedBox(
                                width: Get.width,
                                height: Get.height,
                                child: CachedNetworkImage(
                                  imageUrl: controller.order.images[index],
                                  fadeOutDuration: Duration.zero,
                                  fadeInDuration: Duration.zero,
                                  width: Get.width,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(ImagesPath.placeHolder),
                                ),
                              ),
                              Positioned(
                                left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                                top: 14.h,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 18.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    child: IZIImage(
                      controller.order.images[index],
                      width: (Get.width - 28.w - 16.w) / 3,
                      height: (Get.width - 28.w - 16.w) / 3,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottom() {
    if (controller.order.status == WAIT_FOR_CONFIRMATION) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          bottom: IZISizeUtil.SPACE_6X,
          left: IZISizeUtil.PADDING_HORIZONTAL,
          right: IZISizeUtil.PADDING_HORIZONTAL,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: 'order_023'.tr,
              callBack: () => controller.onCancelOrder(),
              backgroundColor: Colors.white,
              colorBorder: ColorResources.COLOR_3B71CA,
              style: AppText.text16.copyWith(
                color: ColorResources.COLOR_3B71CA,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    if (controller.order.status == DELIVERED) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  label: 'order_024'.tr,
                  callBack: () => controller.navigateReturnOrder(),
                  backgroundColor: Colors.white,
                  style: AppText.text16.copyWith(
                    color: ColorResources.COLOR_3B71CA,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: CustomButton(
                  label: 'order_025'.tr,
                  callBack: () => controller.onChangeStatusReceived(),
                  borderRadius: 0,
                ),
              ),
            ],
          ),
        ],
      );
    }

    if (controller.order.status == RECEIVED && !controller.order.isEvaluated) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          bottom: IZISizeUtil.SPACE_6X,
          left: IZISizeUtil.PADDING_HORIZONTAL,
          right: IZISizeUtil.PADDING_HORIZONTAL,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: 'order_001'.tr,
              callBack: () => controller.navigateReview(),
              style: AppText.text12.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (controller.order.status == RECEIVED && controller.order.isEvaluated) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          bottom: IZISizeUtil.SPACE_6X,
          left: IZISizeUtil.PADDING_HORIZONTAL,
          right: IZISizeUtil.PADDING_HORIZONTAL,
          top: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: 'order_039'.tr,
              callBack: () {
                Get.bottomSheet(
                  BottomAddCartDetail(
                    order: controller.order,
                    onAddCart: () {
                      Get.back();
                      controller.addCart();
                    },
                  ),
                );
              },
              style: AppText.text12.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildDetailOrder() {
    return Container(
      color: Colors.white,
      width: Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        vertical: 14.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'order_012'.tr,
            style: AppText.text14.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _buildItemTitleValueMoney(
            title: 'order_017'.tr,
            value: controller.order.code,
          ),
          _buildItemTitleValueMoney(
            title: 'order_018'.tr,
            value: '\$${controller.order.totalProductMoney.price}',
          ),
          _buildItemTitleValueMoney(
            title: 'order_019'.tr,
            value: '\$${controller.order.totalTaxMoney.price}',
          ),
          _buildItemTitleValueMoney(
            title: 'order_020'.tr,
            value: '\$${controller.order.totalShipMoney.price}',
          ),
          _buildItemTitleValueMoney(
            title: 'order_021'.tr,
            value: '\$${controller.order.totalReduceMoney.price}',
          ),
          const DotLine(color: ColorResources.COLOR_B1B1B1, height: 0.5),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'order_022'.tr,
                style: AppText.text14.copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${controller.order.totalMoney.price}',
                style: AppText.text14.copyWith(
                  color: ColorResources.COLOR_E9330B,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPayment() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        vertical: 14.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                ImagesPath.icTimeOrderCustomer,
                width: 21.r,
                height: 21.r,
              ),
              SizedBox(width: 4.w),
              Text(
                'order_047'.tr,
                style: AppText.text14.copyWith(
                  color: ColorResources.COLOR_181313,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            controller.order.timeOrder,
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_677275,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          const Divider(
            height: 0,
            thickness: 0.3,
            color: ColorResources.COLOR_A4A2A2,
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Image.asset(
                ImagesPath.icLocationGreen,
                width: 21.r,
                height: 21.r,
              ),
              SizedBox(width: 4.w),
              Text(
                'order_014'.tr,
                style: AppText.text14.copyWith(
                  color: ColorResources.COLOR_181313,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            controller.order.idAddress?.fullName ?? '',
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_677275,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            controller.order.idAddress?.fullAddress ?? '',
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_677275,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          const Divider(
            height: 0,
            thickness: 0.3,
            color: ColorResources.COLOR_A4A2A2,
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Image.asset(
                ImagesPath.icWallet,
                width: 21.r,
                height: 21.r,
              ),
              SizedBox(width: 4.w),
              Text(
                'order_015'.tr,
                style: AppText.text14.copyWith(
                  color: ColorResources.COLOR_181313,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            controller.order.idTransaction?.getStringMethod ?? '',
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_677275,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProduct() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'order_013'.tr} (${controller.order.purchaseDetails.length})',
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_181313,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (controller.order.isShowSubStatus)
                  Container(
                    padding: EdgeInsets.only(
                      top: 2.h,
                      bottom: 2.h,
                      left: 8.w,
                      right: 14.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: controller.order.colorSubStatus!.withOpacity(0.15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 5.r,
                          height: 5.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: controller.order.colorSubStatus,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          controller.order.stringSubStatus!,
                          style: AppText.text12.copyWith(
                            fontWeight: FontWeight.w600,
                            color: controller.order.colorSubStatus,
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: controller.order.purchaseDetails.length,
            itemBuilder: (BuildContext context, int index) {
              final item = controller.order.purchaseDetails[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.DETAIL_PRODUCT, arguments: {
                    "productId": item.idOptionProduct?.product?.id,
                    "providerId": item.idOptionProduct?.product?.idStore?.id
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    vertical: 14.h,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: IZIImage(
                          item.idOptionProduct != null &&
                                  item.idOptionProduct!.images.isNotEmpty
                              ? item.idOptionProduct!.images.first
                              : '',
                          width: 70.sp,
                          height: 70.sp,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: SizedBox(
                          height: 70.sp,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.idOptionProduct?.product?.title ?? '',
                                style: AppText.text14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.COLOR_464647,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.idOptionProduct?.title ?? '',
                                style: AppText.text14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.COLOR_A4A2A2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${item.idOptionProduct?.priceUse.price}',
                                    style: AppText.text14.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorResources.COLOR_E9330B,
                                    ),
                                  ),
                                  Text(
                                    'x${item.quantity}',
                                    style: AppText.text12.copyWith(
                                      color: ColorResources.COLOR_677275,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 28.h,
                thickness: 0.3,
                endIndent: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                indent: IZISizeUtil.PADDING_HORIZONTAL_HOME + 60.sp,
                color: ColorResources.COLOR_A4A2A2,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildTimeLine() {
    return Container(
      height: 84.h,
      width: Get.width,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        controller: controller.scrollController,
        child: Row(
          children: [
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              afterLineStyle: const LineStyle(
                color: ColorResources.COLOR_6BBB59,
                thickness: 1,
              ),
              beforeLineStyle: const LineStyle(
                color: ColorResources.COLOR_6BBB59,
                thickness: 1,
              ),
              lineXY: 0.3,
              isFirst: true,
              endChild: Center(
                child: Text(
                  'order_002'.tr,
                  style: AppText.text12.copyWith(
                    color: ColorResources.COLOR_464647,
                  ),
                ),
              ),
              indicatorStyle: IndicatorStyle(
                width: 30.r,
                height: 30.r,
                color: ColorResources.COLOR_6BBB59,
                iconStyle: IconStyle(
                  iconData: Icons.check,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
            if (controller.order.isTimeLineCanceled)
              Row(
                children: [
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    afterLineStyle: const LineStyle(
                      color: ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    beforeLineStyle: const LineStyle(
                      color: ColorResources.COLOR_6BBB59,
                      thickness: 1,
                    ),
                    lineXY: 0.3,
                    endChild: Center(
                      child: Text(
                        'order_029'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30.r,
                      height: 30.r,
                      color: ColorResources.COLOR_6BBB59,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    afterLineStyle: const LineStyle(
                      color: ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    beforeLineStyle: const LineStyle(
                      color: ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    lineXY: 0.3,
                    endChild: Center(
                      child: Text(
                        'order_004'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30.r,
                      height: 30.r,
                      color: ColorResources.COLOR_D3F2CE,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    afterLineStyle: const LineStyle(
                      color: ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    beforeLineStyle: const LineStyle(
                      color: ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    lineXY: 0.3,
                    endChild: Center(
                      child: Text(
                        'order_048'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30.r,
                      height: 30.r,
                      color: ColorResources.COLOR_D3F2CE,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    afterLineStyle: const LineStyle(
                      color: ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    beforeLineStyle: const LineStyle(
                      color: ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    lineXY: 0.3,
                    isLast: true,
                    endChild: Center(
                      child: Text(
                        'order_006'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30.r,
                      height: 30.r,
                      color: ColorResources.COLOR_D3F2CE,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            if (!controller.order.isTimeLineCanceled)
              Row(
                children: [
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    afterLineStyle: LineStyle(
                      color: controller.order.isTimeLineConfirmed
                          ? ColorResources.COLOR_6BBB59
                          : ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    beforeLineStyle: const LineStyle(
                      color: ColorResources.COLOR_6BBB59,
                      thickness: 1,
                    ),
                    lineXY: 0.3,
                    endChild: Center(
                      child: Text(
                        'order_005'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30.r,
                      height: 30.r,
                      color: controller.order.isTimeLineConfirmed
                          ? ColorResources.COLOR_6BBB59
                          : ColorResources.COLOR_D3F2CE,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    afterLineStyle: LineStyle(
                      color: controller.order.isTimeLinePackaged
                          ? ColorResources.COLOR_6BBB59
                          : ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    beforeLineStyle: LineStyle(
                      color: !controller.order.isTimeLineConfirmed
                          ? ColorResources.COLOR_EBFEE8
                          : ColorResources.COLOR_6BBB59,
                      thickness: 1,
                    ),
                    lineXY: 0.3,
                    endChild: Center(
                      child: Text(
                        'order_004'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30.r,
                      height: 30.r,
                      color: controller.order.isTimeLinePackaged
                          ? ColorResources.COLOR_6BBB59
                          : ColorResources.COLOR_D3F2CE,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.manual,
                    afterLineStyle: LineStyle(
                      color: controller.order.isTimeLineDelivering
                          ? ColorResources.COLOR_6BBB59
                          : ColorResources.COLOR_EBFEE8,
                      thickness: 1,
                    ),
                    beforeLineStyle: LineStyle(
                      color: !controller.order.isTimeLinePackaged
                          ? ColorResources.COLOR_EBFEE8
                          : ColorResources.COLOR_6BBB59,
                      thickness: 1,
                    ),
                    lineXY: 0.3,
                    endChild: Center(
                      child: Text(
                        'order_048'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30.r,
                      height: 30.r,
                      color: controller.order.isTimeLineDelivering
                          ? ColorResources.COLOR_6BBB59
                          : ColorResources.COLOR_D3F2CE,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  if (controller.order.isTimeLineReturn)
                    TimelineTile(
                      axis: TimelineAxis.horizontal,
                      alignment: TimelineAlign.manual,
                      afterLineStyle: const LineStyle(
                        color: ColorResources.COLOR_6BBB59,
                        thickness: 1,
                      ),
                      beforeLineStyle: const LineStyle(
                        color: ColorResources.COLOR_6BBB59,
                        thickness: 1,
                      ),
                      lineXY: 0.3,
                      isLast: true,
                      endChild: Center(
                        child: Text(
                          'order_009'.tr,
                          style: AppText.text12.copyWith(
                            color: ColorResources.COLOR_464647,
                          ),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 30.r,
                        height: 30.r,
                        color: ColorResources.COLOR_6BBB59,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  if (!controller.order.isTimeLineReturn)
                    TimelineTile(
                      axis: TimelineAxis.horizontal,
                      alignment: TimelineAlign.manual,
                      beforeLineStyle: LineStyle(
                        color: !controller.order.isTimeLineDelivering
                            ? ColorResources.COLOR_EBFEE8
                            : ColorResources.COLOR_6BBB59,
                        thickness: 1,
                      ),
                      lineXY: 0.3,
                      isLast: true,
                      endChild: Center(
                        child: Text(
                          'order_006'.tr,
                          style: AppText.text12.copyWith(
                            color: ColorResources.COLOR_464647,
                          ),
                        ),
                      ),
                      indicatorStyle: IndicatorStyle(
                        width: 30.r,
                        height: 30.r,
                        color: controller.order.isTimeLineReceivedOrDelivered
                            ? ColorResources.COLOR_6BBB59
                            : ColorResources.COLOR_D3F2CE,
                        iconStyle: IconStyle(
                          iconData: Icons.check,
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildItemTitleValueMoney(
      {required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_8A92A6,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_8A92A6,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
