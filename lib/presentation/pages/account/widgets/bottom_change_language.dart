import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class BottomChangeLanguage extends StatefulWidget {
  final Function(String, String) callBack;
  final String language;

  const BottomChangeLanguage({
    super.key,
    required this.callBack,
    required this.language,
  });

  @override
  State<BottomChangeLanguage> createState() => _BottomChangeLanguageState();
}

class _BottomChangeLanguageState extends State<BottomChangeLanguage> {
  late String language;

  @override
  void initState() {
    language = widget.language;
    super.initState();
  }

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
                        'account_011'.tr,
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
              Padding(
                padding: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                child: Text(
                  'account_012'.tr,
                  style: AppText.text12,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    language = 'vi';
                  });
                  widget.callBack('account_009'.tr, 'vi');
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Image.asset(
                        ImagesPath.icVi,
                        width: 36.r,
                        height: 19.r,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'account_009'.tr,
                            style: AppText.text14,
                          ),
                        ),
                      ),
                      if (language == 'vi')
                        Container(
                          width: 22.r,
                          height: 22.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorResources.COLOR_30BB1A,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18.r,
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
                  setState(() {
                    language = 'en';
                  });
                  widget.callBack('account_010'.tr, 'en');
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Image.asset(
                        ImagesPath.icEn,
                        width: 36.r,
                        height: 19.r,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'account_010'.tr,
                            style: AppText.text14,
                          ),
                        ),
                      ),
                      if (language == 'en')
                        Container(
                          width: 22.r,
                          height: 22.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorResources.COLOR_30BB1A,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18.r,
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
