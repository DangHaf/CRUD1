import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class DialogLogin extends StatelessWidget {
  final Function() onLogin;

  const DialogLogin({
    super.key,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 22.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'auth_007'.tr,
              style: AppText.text20.copyWith(
                color: ColorResources.COLOR_464647,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              'auth_061'.tr,
              style: AppText.text20.copyWith(
                color: ColorResources.COLOR_464647,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 120.w,
                    height: 32.h,
                    child: CustomButton(
                        paddingVertical: 0,
                        label: 'auth_062'.tr,
                        borderRadius: 100,
                        backgroundColor: Colors.white,
                        colorBorder: ColorResources.COLOR_3B71CA,
                        style: AppText.text15.copyWith(
                          color: ColorResources.COLOR_3B71CA,
                          fontWeight: FontWeight.w600,
                        ),
                        callBack: () {
                          Get.back();
                        }),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: SizedBox(
                    width: 120.w,
                    height: 32.h,
                    child: CustomButton(
                        paddingVertical: 0,
                        label: 'auth_063'.tr,
                        borderRadius: 100,
                        backgroundColor: ColorResources.COLOR_3B71CA,
                        style: AppText.text15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        callBack: () {
                          Get.back();
                          onLogin();
                        }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
