import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class ItemProductGroup extends StatelessWidget {
  final String title;
  final String icon;
  final Function() callBack;

  const ItemProductGroup({
    super.key,
    required this.title,
    required this.icon,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Column(
        children: [
          Container(
            width: 50.r,
            height: 50.r,
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorResources.COLOR_8A92A6, width: 0.5),
            ),
            alignment: Alignment.center,
            child: IZIImage(
              icon,
              width: 26.r,
              height: 26.r,
            ),
          ),
          Text(
            title,
            style: AppText.text12.copyWith(
              color: ColorResources.COLOR_464647,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
