import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/cart/transaction/payment_confirm/payment_confirm_controller.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class PaymentConfirmPage extends GetView<PaymentConfirmController> {
  const PaymentConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'transaction_018'.tr,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  _buildInfo(),
                  SizedBox(height: 20.h),
                  _buildContent(),
                  _buildImage(),
                ],
              ),
            ),
          ),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Text(
            'transaction_015'.tr,
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_464647,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.content,
                style: AppText.text18.copyWith(
                  color: ColorResources.COLOR_464647,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(10.r),
                constraints: const BoxConstraints(),
                onPressed: () {
                  controller.copyData(
                    content: controller.content,
                  );
                },
                icon: IZIImage(
                  ImagesPath.icCopy,
                  width: 30.r,
                  height: 30.r,
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        vertical: 20.h,
      ),
      child: Column(
        children: [
          Text(
            'transaction_001'.tr,
            style: AppText.text18,
          ),
          SizedBox(height: 10.h),
          Obx(
            () => controller.imagePath.isNotEmpty
                ? InkWell(
                    onTap: () {
                      controller.onPickImage();
                    },
                    child: Center(
                      child: IZIImage.file(
                        File(controller.imagePath.value),
                        width: Get.width * 0.7,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      controller.onPickImage();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorResources.COLOR_EBEBEB,
                      ),
                      child: IZIImage(
                        ImagesPath.imageUpload,
                        width: 150.w,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 10.h),
          Center(
            child: Text(
              'transaction_016'.tr,
              style: AppText.text12.copyWith(
                color: ColorResources.COLOR_F41E1E.withOpacity(0.86),
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'transaction_012'.tr,
            style: AppText.text16.copyWith(
              color: ColorResources.COLOR_464647,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'transaction_013'.tr,
                style: AppText.text12.copyWith(
                  color: ColorResources.COLOR_464647,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.all(10.r),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.copyData(
                        content: controller.bankAccount.bankName,
                      );
                    },
                    icon: IZIImage(
                      ImagesPath.icCopy,
                      width: 30.r,
                    ),
                  ),
                  Text(
                    controller.bankAccount.bankName,
                    style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'transaction_009'.tr,
                style: AppText.text12.copyWith(
                  color: ColorResources.COLOR_464647,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.all(10.r),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.copyData(
                        content: controller.bankAccount.accountNumber,
                      );
                    },
                    icon: IZIImage(
                      ImagesPath.icCopy,
                      width: 30.r,
                    ),
                  ),
                  Text(
                    controller.bankAccount.accountNumber,
                    style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'transaction_008'.tr,
                style: AppText.text12.copyWith(
                  color: ColorResources.COLOR_464647,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.all(10.r),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.copyData(
                        content: controller.bankAccount.accountName,
                      );
                    },
                    icon: IZIImage(
                      ImagesPath.icCopy,
                      width: 30.r,
                    ),
                  ),
                  Text(
                    controller.bankAccount.accountName,
                    style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'transaction_014'.tr,
                style: AppText.text12.copyWith(
                  color: ColorResources.COLOR_464647,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.all(10.r),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      controller.copyData(
                        content: controller.totalMoney.toString(),
                      );
                    },
                    icon: IZIImage(
                      ImagesPath.icCopy,
                      width: 30.r,
                    ),
                  ),
                  Text(
                    '\$${controller.totalMoney}',
                    style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: IZISizeUtil.SPACE_3X,
        left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        top: 12.h,
      ),
      child: CustomButton(
        label: 'transaction_019'.tr,
        callBack: () {
          if (controller.imagePath.isEmpty) {
            IZIAlert().error(message: 'transaction_005'.tr);
            return;
          }
          Get.dialog(
            _buildDialog(),
            barrierDismissible: false,
          );
        },
      ),
    );
  }

  Widget _buildDialog() {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(IZISizeUtil.SPACE_5X),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: IZISizeUtil.SPACE_4X),
              child: IZIImage(ImagesPath.imageSuccessPayment,
                  width: Get.width * 0.3),
            ),
            Text(
              'transaction_003'.tr,
              style: AppText.text12.copyWith(
                color: ColorResources.COLOR_5B5B5B,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: IZISizeUtil.SPACE_4X),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: 'transaction_004'.tr,
                  callBack: () {
                    if (!controller.isIgnore) {
                      controller.onCompleted();
                    }
                  },
                  backgroundColor: ColorResources.COLOR_3B71CA,
                  paddingVertical: IZISizeUtil.SPACE_2X,
                  paddingHorizontal: IZISizeUtil.SPACE_5X,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
