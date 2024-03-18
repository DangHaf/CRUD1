import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: IZIImage(
                ImagesPath.splashImage,
                width: Get.width * 0.22,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'notification'.tr,
              style: AppText.text14,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 40.w),
              child: CustomButton(
                label: 'login'.tr,
                callBack: () {
                  Get.toNamed(AuthRouters.LOGIN);
                },
                backgroundColor: ColorResources.COLOR_3B71CA,
                paddingVertical: 14.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
