import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/voucher/voucher_detail/voucher_detail_controller.dart';

class VoucherDetailPage extends GetView<VoucherDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'voucher_002'.tr,
      ),
      body: Obx(
        () => controller.isLoadingVoucherDetail
            ? const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.LIGHT_BLUE,
                ),
              )
            : Padding(
                padding:
                    IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_2X),
                child: Column(
                  children: [
                    IZIImage(
                      controller.voucher.value.thumbnail ?? '',
                      height: 200.h,
                      width: Get.width,
                    ),
                    Padding(
                      padding: IZISizeUtil.setEdgeInsetsSymmetric(
                          vertical: IZISizeUtil.SPACE_3X),
                      child: Center(
                        child: Text(
                          controller.voucher.value.title,
                          style: AppText.text16.copyWith(
                            color: ColorResources.COLOR_464647,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    _buildInformation(
                      title: 'voucher_003'.tr,
                      description: controller.voucher.value.expiry,
                      imgUrl: ImagesPath.icCalender,
                    ),
                    _buildInformation(
                      title: 'voucher_004'.tr,
                      description: controller.voucher.value.disCount,
                      imgUrl: ImagesPath.icSale,
                    ),
                    if (controller.voucher.value.unitTypeDiscount != MONEY)
                      _buildInformation(
                        title: 'voucher_005'.tr,
                        description: controller.voucher.value.getMaxDiscount,
                        imgUrl: ImagesPath.icMaxSale,
                      ),
                    _buildInformation(
                      title: 'voucher_006'.tr,
                      description:
                          '${'voucher_010'.tr}: \$${controller.voucher.value.minPriceToUse}',
                      imgUrl: ImagesPath.icCondition,
                    ),
                    _buildInformation(
                      title: 'voucher_007'.tr,
                      description:
                          controller.voucher.value.quantityRemaining.toString(),
                      imgUrl: ImagesPath.icVoucher,
                    ),
                    Padding(
                      padding: IZISizeUtil.setEdgeInsetsSymmetric(
                          horizontal: IZISizeUtil.SPACE_4X,
                          vertical: IZISizeUtil.SPACE_1X),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 23.r,
                            height: 23.r,
                            child: IZIImage(ImagesPath.icApplyTo),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: IZISizeUtil.SPACE_4X),
                                  child: Text(
                                    'voucher_011'.tr,
                                    style: AppText.text15.copyWith(
                                        color: ColorResources.COLOR_464647,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                if (controller.voucher.value.type == 'ALL')
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: IZISizeUtil.SPACE_4X),
                                    child: Text(
                                      'voucher_012'.tr,
                                      style: AppText.text15.copyWith(
                                          color: ColorResources.COLOR_A4A2A2,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                else
                                  ...List.generate(
                                      controller.voucher.value.applyTo.length,
                                      (index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20.sp,
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            controller
                                                .voucher.value.applyTo[index],
                                            style: AppText.text15.copyWith(
                                                color:
                                                    ColorResources.COLOR_A4A2A2,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildInformation(
      {required String title,
      required String description,
      required String imgUrl}) {
    return Padding(
      padding: IZISizeUtil.setEdgeInsetsSymmetric(
          horizontal: IZISizeUtil.SPACE_4X, vertical: IZISizeUtil.SPACE_1X),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 23.r,
            height: 23.r,
            child: IZIImage(imgUrl),
          ),
          Expanded(
            child: Padding(
              padding:
                  IZISizeUtil.setEdgeInsetsOnly(left: IZISizeUtil.SPACE_4X),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.text15.copyWith(
                        color: ColorResources.COLOR_464647,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    description,
                    style: AppText.text15.copyWith(
                        color: ColorResources.COLOR_A4A2A2,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
