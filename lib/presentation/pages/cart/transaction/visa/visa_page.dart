import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/cart/transaction/visa/visa_controller.dart';
import 'package:template/presentation/pages/cart/transaction/visa/widgets/format_card_number.dart';
import 'package:template/presentation/pages/cart/transaction/visa/widgets/format_expiration_date.dart';
import 'package:template/presentation/pages/cart/transaction/visa/widgets/input_visa.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class VisaPage extends GetView<VisaController> {
  const VisaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'transaction_020'.tr,
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                        vertical: 14.h,
                      ),
                      child: Column(
                        children: [
                          InputVisa(
                            controller: controller.cardNumberController,
                            hintText: 'transaction_021'.tr,
                            label: 'transaction_022'.tr,
                            keyboardType: TextInputType.number,
                            maxLength: 19,
                            inputFormatters: [
                              FormatCardNumber(),
                            ],
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 10.w,
                                  ),
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: ColorResources.LIGHT_GREY
                                        .withOpacity(.7),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: IZIImage(
                                    ImagesPath.visaSaveImage,
                                    width: 45.r,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          InputVisa(
                            controller: controller.fullNameController,
                            hintText: 'transaction_023'.tr,
                            label: 'transaction_024'.tr,
                          ),
                          const SizedBox(height: 16),
                          InputVisa(
                            hintText: 'transaction_025'.tr,
                            label: 'transaction_026'.tr,
                            inputFormatters: [
                              FormatExpirationDate(),
                            ],
                            maxLength: 5,
                            controller: controller.expirationDateController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          InputVisa(
                            hintText: 'transaction_027'.tr,
                            label: 'transaction_028'.tr,
                            maxLength: 3,
                            controller: controller.cvcController,
                            keyboardType: TextInputType.number,
                          ),
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
                        ignoring: controller.ignoring.value,
                        child: CustomButton(
                          label: 'transaction_029'.tr,
                          callBack: () {
                            controller.saveVisaAccount();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
