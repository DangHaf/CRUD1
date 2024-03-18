import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class DialogConfirm extends StatelessWidget {
  final Function() onConfirm;
  final Function()? onBack;
  final String title;
  final String content;
  final String icon;
  final bool isBackWithConfirm;

  const DialogConfirm({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
    required this.icon,
    this.onBack,
    this.isBackWithConfirm = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(top: 30.r),
            padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              vertical: 22.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30.h),
                Text(
                  title,
                  style: AppText.text18.copyWith(
                    color: ColorResources.COLOR_3B71CA,
                    fontWeight: FontWeight.w700,
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
                              if (onBack != null) {
                                onBack!();
                              }
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
                              if (isBackWithConfirm) {
                                Get.back();
                              }
                              onConfirm();
                            }),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Image.asset(icon, width: 75.r, height: 75.r)
        ],
      ),
    );
  }
}
