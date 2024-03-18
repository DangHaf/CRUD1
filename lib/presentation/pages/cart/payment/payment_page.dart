import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/presentation/pages/cart/payment/payment_controller.dart';
import 'package:template/presentation/pages/cart/payment/widget/item_cart_payment.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'cart_014'.tr,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  _buildAddress(),
                  SizedBox(height: 5.h),
                  _buildProviderWithProduct(),
                  SizedBox(height: 5.h),
                  _buildInfoPayment(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: IZISizeUtil.SPACE_6X,
              left: IZISizeUtil.PADDING_HORIZONTAL,
              right: IZISizeUtil.PADDING_HORIZONTAL,
              top: 12,
            ),
            child: CustomButton(
              label: 'cart_013'.tr,
              callBack: () {
                Get.toNamed(
                  AppRoute.PAYMENT_METHOD,
                  arguments: {
                    'listCart': controller.listCartTransaction,
                    'address': controller.address.value,
                  },
                );
              },
              backgroundColor: ColorResources.COLOR_3B71CA,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPayment() {
    return Obx(
      () => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  ImagesPath.icDetailPayment,
                  width: 20.r,
                  height: 20.r,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'cart_007'.tr,
                      style: AppText.text14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorResources.COLOR_464647,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildItemTitleValueMoney(
                title: 'cart_008'.tr,
                value: '\$${controller.totalProductMoney.price}'),
            _buildItemTitleValueMoney(
                title: 'cart_009'.tr,
                value: '\$${controller.totalTaxMoney.price}'),
            _buildItemTitleValueMoney(
                title: 'cart_010'.tr,
                value: '\$${controller.totalShipMoney.price}'),
            _buildItemTitleValueMoney(
                title: 'cart_011'.tr,
                value: '\$${controller.totalReduceMoney.price}'),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'cart_012'.tr,
                    style: AppText.text16.copyWith(
                      color: ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '\$${controller.totalMoney.price}',
                    style: AppText.text15.copyWith(
                      color: ColorResources.COLOR_EB0F0F,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTitleValueMoney(
      {required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
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

  Widget _buildProviderWithProduct() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemCount: controller.listCart.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          if (!controller.listCart[index].hasProduct) {
            return const SizedBox();
          }
          return ItemCartPayment(
            cart: controller.listCart[index],
            callBackVoucher: () {
              controller.getVoucherCart(index);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (!controller.listCart[index].hasProduct) {
            return const SizedBox();
          }
          return SizedBox(height: 5.h);
        },
      ),
    );
  }

  Widget _buildAddress() {
    return InkWell(
      onTap: () {
        controller.onChangeAddress();
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 12.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              ImagesPath.icLocationBlue,
              width: 20.r,
              height: 20.r,
              color: ColorResources.COLOR_0095E9,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'address_001'.tr,
                    style: AppText.text14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorResources.COLOR_464647,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => controller.address.value.id.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          controller.address.value.fullName,
                                          style: AppText.text12.copyWith(
                                            color: ColorResources.COLOR_464647,
                                          ),
                                        ),
                                        Container(
                                          height: 12,
                                          width: 1,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          color: ColorResources.COLOR_464647,
                                        ),
                                        Text(
                                          controller.address.value.phone,
                                          style: AppText.text12.copyWith(
                                            color: ColorResources.COLOR_464647,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      controller.address.value.fullAddress,
                                      style: AppText.text12.copyWith(
                                        color: ColorResources.COLOR_464647,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'cart_023'.tr,
                                  style: AppText.text12.copyWith(
                                    color: ColorResources.COLOR_464647,
                                  ),
                                ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorResources.COLOR_464647,
                        size: 16.sp,
                      )
                    ],
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
