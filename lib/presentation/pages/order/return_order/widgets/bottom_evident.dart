import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class BottomEvident extends StatelessWidget {
  final Function() callBackCamera;
  final Function() callBackGallery;

  const BottomEvident({
    super.key,
    required this.callBackCamera,
    required this.callBackGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.clear,
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'return_020'.tr,
                        style: AppText.text18.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: ColorResources.COLOR_A4A2A2,
              ),
              InkWell(
                onTap: () {
                  callBackGallery();
                  Get.back();
                },
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                  child: Row(
                    children: [
                      Image.asset(
                        ImagesPath.icGalleryAction,
                        width: 23.r,
                        height: 23.r,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'account_039'.tr,
                            style: AppText.text14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: ColorResources.COLOR_A4A2A2,
                endIndent: 14.w,
                indent: 14.w,
              ),
              InkWell(
                onTap: () {
                  callBackCamera();
                  Get.back();
                },
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                  child: Row(
                    children: [
                      Image.asset(
                        ImagesPath.icCameraAction,
                        width: 23.r,
                        height: 23.r,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'account_040'.tr,
                            style: AppText.text14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ],
    );
  }
}
