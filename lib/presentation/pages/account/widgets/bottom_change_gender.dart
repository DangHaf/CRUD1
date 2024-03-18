import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class BottomChangeGender extends StatefulWidget {
  final Function(String value) callBack;
  final String? gender;

  const BottomChangeGender({
    super.key,
    required this.callBack,
    required this.gender,
  });

  @override
  State<BottomChangeGender> createState() => _BottomChangeGenderState();
}

class _BottomChangeGenderState extends State<BottomChangeGender> {
  String? gender;

  @override
  void initState() {
    gender = widget.gender;
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
                        'account_041'.tr,
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
                  setState(() {
                    gender = FEMALE;
                  });
                  widget.callBack(FEMALE);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'account_043'.tr,
                            style: AppText.text14,
                          ),
                        ),
                      ),
                      if (gender == FEMALE)
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
                    gender = MALE;
                  });
                  widget.callBack(MALE);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'account_042'.tr,
                            style: AppText.text14,
                          ),
                        ),
                      ),
                      if (gender == MALE)
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
                    gender = OTHER;
                  });
                  widget.callBack(OTHER);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'account_044'.tr,
                            style: AppText.text14,
                          ),
                        ),
                      ),
                      if (gender == OTHER)
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
