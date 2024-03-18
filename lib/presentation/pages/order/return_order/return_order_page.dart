import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/auth/widgets/auth_input.dart';
import 'package:template/presentation/pages/order/return_order/return_order_controller.dart';
import 'package:template/presentation/pages/order/return_order/widgets/bottom_evident.dart';
import 'package:template/presentation/pages/order/return_order/widgets/bottom_return_product_reason.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class ReturnOrderPage extends GetView<ReturnOrderController> {
  const ReturnOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'return_001'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            _buildProduct(),
            SizedBox(height: 10.h),
            _buildReason(),
            SizedBox(height: 10.h),
            _buildRefund(),
            SizedBox(height: 10.h),
            _buildDescription(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
              label: 'return_010'.tr,
              callBack: () {
                controller.returnOrder();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
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
            'return_006'.tr,
            style: AppText.text14.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorResources.COLOR_181313,
            ),
          ),
          SizedBox(height: 10.h),
          AuthInput(
            controller: controller.descriptionController,
            fillColor: ColorResources.COLOR_F6F6F7,
            hintText: 'return_008'.tr,
            maxLength: 300,
            maxLine: 3,
            isShowCounter: true,
          ),
          SizedBox(height: 10.h),
          Obx(
            () => Wrap(
              spacing: 8.r,
              runSpacing: 8.r,
              children: [
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      BottomEvident(
                        callBackCamera: () {
                          controller.takeAPhoto();
                        },
                        callBackGallery: () {
                          controller.pickImage();
                        },
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(5.r),
                  child: DottedBorder(
                    dashPattern: const [8, 4],
                    strokeWidth: 0.5,
                    color: ColorResources.COLOR_8A92A6,
                    radius: Radius.circular(10.r),
                    borderType: BorderType.RRect,
                    child: Container(
                      width: (Get.width -
                              IZISizeUtil.PADDING_HORIZONTAL_HOME * 2 -
                              8.r * 2 -
                              10) /
                          3,
                      height: (Get.width -
                              IZISizeUtil.PADDING_HORIZONTAL_HOME * 2 -
                              8.r * 2 -
                              10) /
                          3,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            ImagesPath.icPlus,
                            width: 30.r,
                            height: 30.r,
                            color: ColorResources.COLOR_464647,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'return_009'.trParams(
                              {'count': '${controller.files.length}/5'},
                            ),
                            style: AppText.text10.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  controller.files.length,
                  (index) => Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                            width: 0.5,
                            color: ColorResources.COLOR_3B71CA,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: IZIImage.file(
                            File(controller.files[index].path),
                            width: (Get.width -
                                    IZISizeUtil.PADDING_HORIZONTAL_HOME * 2 -
                                    8.r * 2 -
                                    4) /
                                3,
                            height: (Get.width -
                                    IZISizeUtil.PADDING_HORIZONTAL_HOME * 2 -
                                    8.r * 2 -
                                    4) /
                                3,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            controller.onRemoveFile(index);
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.white),
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(4),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefund() {
    return Container(
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
            'return_005'.tr,
            style: AppText.text14.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorResources.COLOR_181313,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            '\$${controller.order.totalMoney}',
            style: AppText.text20.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorResources.COLOR_181313,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReason() {
    return Obx(
      () => InkWell(
        onTap: () {
          Get.bottomSheet(
            BottomReturnProductReason(
              callBack: (reason) => controller.onChangeReason(reason),
              initData: controller.reasonReturn.value,
            ),
            isScrollControlled: true,
          );
        },
        child: Container(
          width: Get.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            vertical: 14.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'return_003'.tr,
                      style: AppText.text14.copyWith(
                        color: ColorResources.COLOR_181313,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' *',
                      style: AppText.text12.copyWith(
                        color: ColorResources.COLOR_DE0000,
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    controller.reasonReturn.value.name,
                    style: AppText.text14.copyWith(
                      color: ColorResources.COLOR_A4A2A2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ColorResources.COLOR_464647,
                    size: 14.sp,
                  ),
                ],
              )
            ],
          ),
        ),
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
            child: Text(
              '${'return_002'.tr} (${controller.order.purchaseDetails.length})',
              style: AppText.text14.copyWith(
                color: ColorResources.COLOR_181313,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: controller.order.purchaseDetails.length,
            itemBuilder: (BuildContext context, int index) {
              final item = controller.order.purchaseDetails[index];
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  vertical: 6.h,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              );
            },
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
