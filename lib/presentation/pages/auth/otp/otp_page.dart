import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/auth/otp/otp_controller.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class OTPPage extends GetView<OTPController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(
        () => IgnorePointer(
          ignoring: controller.ignoring.value,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: BaseAppBar(
              backgroundColor: Colors.transparent,
              leading: Container(
                margin: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.COLOR_F6F6F7,
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18.sp,
                      color: ColorResources.COLOR_181313.withOpacity(0.37),
                    ),
                  ),
                ),
              ),
            ),
            body: _buildBody(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: IZISizeUtil.PADDING_HORIZONTAL),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: IZIImage(ImagesPath.imageOtp, width: Get.width * 0.7),
                ),
                const SizedBox(height: 30),
                Text(
                  'auth_034'.tr,
                  style: AppText.text30.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: IZISizeUtil.SPACE_3X),
                Text(
                  'auth_035'.trParams({'phone': controller.phoneNumberNational}),
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_464647,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: IZISizeUtil.SPACE_2X * 4),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorResources.COLOR_F6F6F7,
                  ),
                  padding: const EdgeInsets.only(
                    top: IZISizeUtil.SPACE_3X,
                    bottom: IZISizeUtil.SPACE_4X,
                    left: IZISizeUtil.SPACE_2X * 1.2,
                    right: IZISizeUtil.SPACE_2X * 1.2,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'auth_036'.tr,
                        style: AppText.text16.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: IZISizeUtil.SPACE_4X),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: controller.otpController,
                        onChanged: (value) {},
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 50.r,
                          fieldWidth: (Get.width - 40.w - 44) / 6,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.white,
                          activeColor: Colors.white,
                          selectedFillColor: Colors.white,
                          selectedColor: ColorResources.COLOR_259329,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        textStyle: AppText.text22.copyWith(
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => !controller.ignoringSendOTP.value
                      ? InkWell(
                          onTap: () {
                            controller.onClickOtpSendAgain();
                          },
                          child: Text(
                            'auth_043'.tr,
                            style: AppText.text14.copyWith(
                              color: ColorResources.COLOR_3B71CA,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'auth_037'.tr,
                              style: AppText.text14.copyWith(
                                color: ColorResources.COLOR_464647,
                              ),
                            ),
                            TextSpan(
                              text: ' 00:${controller.count.value}s',
                              style: AppText.text14.copyWith(
                                color: ColorResources.COLOR_464647,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ),
                ),
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
            label: 'auth_038'.tr,
            callBack: () {
              controller.onConfirm();
            },
            backgroundColor: ColorResources.COLOR_3B71CA,
          ),
        ),
      ],
    );
  }
}
