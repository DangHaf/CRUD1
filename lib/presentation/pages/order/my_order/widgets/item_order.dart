import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class ItemOrder extends StatelessWidget {
  final OrderModel order;
  final Function() cancel;
  final Function() received;
  final Function() review;
  final Function() repurchase;
  final Function() onRefresh;

  const ItemOrder({
    super.key,
    required this.order,
    required this.cancel,
    required this.received,
    required this.review,
    required this.repurchase,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.toNamed(AppRoute.DETAIL_ORDER, arguments: order.id);
        onRefresh();
      },
      child: Container(
        width: Get.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 14.h,
        ),
        child: Column(
          children: [
            ItemProductOrder(
              colorStatus: order.colorStatus,
              status: order.stringStatus,
              optionProduct: order.purchaseDetails[0].idOptionProduct!,
              quantity: order.purchaseDetails[0].quantity,
              colorSubStatus: order.colorSubStatus,
              subStatus: order.stringSubStatus,
              amount: order.purchaseDetails[0].quantity *
                  order.purchaseDetails[0].idOptionProduct!.priceUse,
            ),
            if (order.purchaseDetails.length > 1)
              Align(
                child: Padding(
                  padding: EdgeInsets.only(bottom: hasButton ? 5.h : 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'order_032'.tr,
                        style: AppText.text10.copyWith(
                          color: ColorResources.COLOR_8A92A6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (order.purchaseDetails.length <= 1) SizedBox(height: 14.h),
            const Divider(
              height: 0,
              thickness: 0.3,
              color: ColorResources.COLOR_A4A2A2,
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.stringQuantity,
                  style: AppText.text12.copyWith(
                    color: ColorResources.COLOR_535354,
                  ),
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'order_034'.tr,
                      style: AppText.text12.copyWith(
                        color: ColorResources.COLOR_535354,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 8.w),
                    ),
                    TextSpan(
                      text: '\$${order.totalMoney.price}',
                      style: AppText.text12.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorResources.COLOR_E9330B,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            if (hasButton)
              Column(
                children: [
                  SizedBox(height: 14.h),
                  const Divider(
                    height: 0,
                    thickness: 0.3,
                    color: ColorResources.COLOR_A4A2A2,
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildButton(),
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    if (order.status == WAIT_FOR_CONFIRMATION) {
      return CustomButton(
        label: 'order_008'.tr,
        paddingHorizontal: 26.w,
        paddingVertical: 4.h,
        colorBorder: ColorResources.COLOR_3B71CA,
        backgroundColor: Colors.white,
        callBack: cancel,
        style: AppText.text12.copyWith(
          color: ColorResources.COLOR_3B71CA,
        ),
      );
    }
    if (order.status == CONFIRMED ||
        order.status == DELIVERING ||
        order.status == PACKING) {
      return CustomButton(
        label: 'order_010'.tr,
        paddingHorizontal: 16.w,
        paddingVertical: 3.h,
        backgroundColor: ColorResources.COLOR_B1B1B1,
        callBack: () {},
        style: AppText.text12.copyWith(
          color: Colors.white,
        ),
      );
    }
    if (order.status == DELIVERED) {
      return CustomButton(
        label: 'order_010'.tr,
        paddingHorizontal: 16.w,
        paddingVertical: 3.h,
        callBack: received,
        style: AppText.text12.copyWith(
          color: Colors.white,
        ),
      );
    }
    if (order.status == RECEIVED && !order.isEvaluated) {
      return CustomButton(
        label: 'order_001'.tr,
        paddingHorizontal: 16.w,
        paddingVertical: 3.h,
        callBack: review,
        style: AppText.text12.copyWith(
          color: Colors.white,
        ),
      );
    }
    if (order.status == RECEIVED && order.isEvaluated) {
      return CustomButton(
        label: 'order_039'.tr,
        paddingHorizontal: 16.w,
        paddingVertical: 3.h,
        callBack: repurchase,
        style: AppText.text12.copyWith(
          color: Colors.white,
        ),
      );
    }
    return const SizedBox();
  }

  bool get hasButton {
    if (order.status == WAIT_FOR_CONFIRMATION) {
      return true;
    }
    if (order.status == CONFIRMED ||
        order.status == DELIVERING ||
        order.status == PACKING) {
      return true;
    }
    if (order.status == DELIVERED) {
      return true;
    }
    if (order.status == RECEIVED) {
      return true;
    }
    return false;
  }
}

class ItemProductOrder extends StatelessWidget {
  final String status;
  final Color colorStatus;
  final OptionProductModel optionProduct;
  final int quantity;
  final String? subStatus;
  final Color? colorSubStatus;
  final num amount;

  const ItemProductOrder({
    super.key,
    required this.status,
    required this.colorStatus,
    required this.optionProduct,
    required this.quantity,
    this.subStatus,
    this.colorSubStatus,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5.r),
          child: IZIImage(
            optionProduct.images.isNotEmpty ? optionProduct.images.first : '',
            width: 70.sp,
            height: 70.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
            height: 70.sp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        optionProduct.product?.title ?? '',
                        style: AppText.text14.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorResources.COLOR_464647,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'x$quantity',
                      style: AppText.text14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorResources.COLOR_535354,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: status,
                      style: AppText.text12.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorStatus,
                      ),
                    ),
                    TextSpan(
                      text: subStatus,
                      style: AppText.text10.copyWith(
                        color: colorSubStatus,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
