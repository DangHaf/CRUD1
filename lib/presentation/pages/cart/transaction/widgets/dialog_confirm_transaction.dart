import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/widgets/custom_button.dart';
import 'package:avatar_glow/avatar_glow.dart';

class DialogConfirmTransaction extends StatelessWidget {
  final Function() onConfirm;
  final String content;

  const DialogConfirmTransaction({
    super.key,
    required this.onConfirm,
    required this.content,
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
        margin: EdgeInsets.only(top: 30.r),
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            AvatarGlow(
              glowColor: ColorResources.COLOR_DIALOG,
              duration: const Duration(milliseconds: 1500),
              endRadius: 50.r,
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.COLOR_DIALOG.withOpacity(.15),
                ),
                child: Icon(
                  Icons.check,
                  size: 40.r,
                  color: ColorResources.GREEN,
                ),
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              content,
              style: AppText.text14.copyWith(
                color: ColorResources.COLOR_677275,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 120.w,
                    height: 48.h,
                    child: CustomButton(
                        paddingVertical: 0,
                        label: 'come_back'.tr,
                        borderRadius: 8.r,
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
                    height: 48.h,
                    child: CustomButton(
                        paddingVertical: 0,
                        label: 'agree'.tr,
                        borderRadius: 8.r,
                        backgroundColor: ColorResources.COLOR_3B71CA,
                        style: AppText.text15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        callBack: () {
                          Get.back();
                          onConfirm();
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
          ],
        ),
      ),
    );
  }
}
