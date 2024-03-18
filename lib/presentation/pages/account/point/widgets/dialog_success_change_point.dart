import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/widgets/custom_button.dart';
import 'package:avatar_glow/avatar_glow.dart';

class DialogSuccessChangePoint extends StatelessWidget {
  final String content;

  const DialogSuccessChangePoint({
    super.key,
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
              glowColor: ColorResources.COLOR_1ECF0F,
              duration: const Duration(milliseconds: 1500),
              endRadius: 50.r,
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.COLOR_1ECF0F,
                ),
                child: Icon(
                  Icons.check,
                  size: 40.r,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'change_point_010'.tr,
              style: AppText.text18.copyWith(
                color: ColorResources.COLOR_3B71CA,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              content,
              style: AppText.text14.copyWith(
                color: ColorResources.COLOR_677275,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            SizedBox(
              width: 205.w,
              child: CustomButton(
                  label: 'change_point_011'.tr,
                  borderRadius: 8.r,
                  callBack: () {
                    Get.back();
                  }),
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }
}
