import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class ItemHomeAction extends StatelessWidget {
  final String title;
  final String icon;
  final Function() callBack;
  final bool isSelected;

  const ItemHomeAction({
    super.key,
    required this.title,
    required this.icon,
    required this.callBack,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Column(
        children: [
          Container(
            width: 60.r,
            height: 60.r,
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                gradient: LinearGradient(colors: [
                  if (isSelected)
                    ColorResources.COLOR_5CB6F7.withOpacity(0.84)
                  else
                    ColorResources.COLOR_EBEBEB,
                  if (isSelected)
                    ColorResources.COLOR_6590FF.withOpacity(0.82)
                  else
                    ColorResources.COLOR_EBEBEB,
                ])),
            alignment: Alignment.center,
            child: Image.asset(
              icon,
              width: 35.r,
              height: 35.r,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          Text(
            title,
            style: AppText.text12.copyWith(
              color: isSelected
                  ? ColorResources.COLOR_3D4143
                  : ColorResources.COLOR_677275,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
