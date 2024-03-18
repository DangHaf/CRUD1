import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/cart/transaction/payment_method/payment_method_controller.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class PaymentMethodPage extends GetView<PaymentMethodController> {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'transaction_011'.tr,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Obx(
                    () => Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'transaction_038'.tr,
                            style: AppText.text16.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorResources.COLOR_535354,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' ${controller.cartModel.value.idStore?.name} - \$${controller.cartModel.value.totalMoney}',
                            style: AppText.text16.copyWith(
                              fontWeight: FontWeight.w700,
                              color: ColorResources.COLOR_1255B9,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  _buildTitle(title: 'transaction_011'.tr),
                  _buildVisa(),
                  SizedBox(height: 10.h),
                  _buildPaypal(),
                  SizedBox(height: 10.h),
                  _buildTitle(title: 'transaction_006'.tr),
                  _buildWithCard(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: IZISizeUtil.SPACE_3X,
              left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              top: 12.h,
            ),
            child: Obx(
              () => IgnorePointer(
                ignoring: controller.isIgnore.value,
                child: CustomButton(
                  label: 'transaction_010'.tr,
                  callBack: () {
                    controller.onConfirm();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisa() {
    return InkWell(
      onTap: () {
        controller.gotoVisa();
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: controller.paymentWithVisa.value
                ? ColorResources.COLOR_1255B9.withOpacity(0.1)
                : Colors.white,
          ),
          width: Get.width,
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: [
              SizedBox(
                width: 34.r,
                height: 24.r,
                child: IZIImage(ImagesPath.icVisa),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: Text(
                  "Visa/MasterCard/JCB",
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_464647,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaypal() {
    return InkWell(
      onTap: () {
        controller.onPaymentWithPaypal();
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: controller.paymentWithPaypal.value
                ? ColorResources.COLOR_1255B9.withOpacity(0.1)
                : Colors.white,
          ),
          width: Get.width,
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: [
              SizedBox(
                width: 34.r,
                height: 30.r,
                child: Center(
                  child: IZIImage(
                    ImagesPath.icPaypal,
                    width: 30.r,
                  ),
                ),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: Text(
                  "Paypal",
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_464647,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWithCard() {
    return InkWell(
      onTap: () {
        controller.chooseOtherPayment();
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: controller.bankAccount.value.id.isNotEmpty &&
                    !controller.paymentWithVisa.value &&
                    !controller.paymentWithPaypal.value
                ? ColorResources.COLOR_1255B9.withOpacity(0.1)
                : Colors.white,
          ),
          width: Get.width,
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: [
              SizedBox(
                width: 34.r,
                height: 30.r,
                child: Center(
                  child: IZIImage(
                    ImagesPath.icCreditCard,
                    width: 30.r,
                  ),
                ),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: Text(
                  controller.bankAccount.value.bankName,
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_464647,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: ColorResources.COLOR_464647,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle({required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: AppText.text16.copyWith(
          color: ColorResources.COLOR_464647,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
