import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/auth/reset_password/reset_password_controller.dart';
import 'package:template/presentation/pages/auth/widgets/auth_input.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
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
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child:
                      IZIImage(ImagesPath.imageReset, width: Get.width * 0.7),
                ),
                const SizedBox(height: 30),
                Text(
                  'auth_039'.tr,
                  style: AppText.text30.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: IZISizeUtil.SPACE_3X),
                Text(
                  'auth_040'.tr,
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_464647,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: IZISizeUtil.SPACE_2X * 4),
                AuthInput(
                  isPassword: true,
                  controller: controller.newPassword,
                  hintText: 'auth_041'.tr,
                  fillColor: ColorResources.COLOR_EAEAEA.withOpacity(0.53),
                  focusNode: controller.focusNodePassword,
                  onNext: (){
                    controller.focusNodeConfirmPassword.requestFocus();
                  },
                ),
                const SizedBox(height: IZISizeUtil.SPACE_2X),
                AuthInput(
                  controller: controller.confirmNewPassword,
                  isPassword: true,
                  hintText: 'auth_042'.tr,
                  fillColor: ColorResources.COLOR_EAEAEA.withOpacity(0.53),
                  focusNode: controller.focusNodeConfirmPassword,
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
              controller.onResetPassword();
            },
            backgroundColor: ColorResources.COLOR_3B71CA,
          ),
        ),
      ],
    );
  }
}
