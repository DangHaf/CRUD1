import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class ItemLittleProduct extends StatelessWidget {
  final String image;
  final bool isSelected;
  final Function() onTap;

  const ItemLittleProduct({
    super.key,
    required this.image,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.w,
            color:
                isSelected ? ColorResources.COLOR_1255B9 : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.r),
          child: IZIImage(
            IZIValidate.nullOrEmpty(image) ? '' : image,
            height: 80.w,
            width: 80.w,
          ),
        ),
      ),
    );
  }
}

class ItemNameProduct extends StatelessWidget {
  final bool isSelected;
  final String content;
  final bool isEnable;

  const ItemNameProduct({
    super.key,
    required this.isSelected,
    required this.content,
    required this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: isSelected
            ? ColorResources.COLOR_0095E9
            : ColorResources.COLOR_EBEBEB,
      ),
      child: Text(
        content,
        style: AppText.text12.copyWith(
          fontWeight: FontWeight.w400,
          color: isSelected
              ? ColorResources.WHITE
              : isEnable
                  ? ColorResources.COLOR_464647
                  : ColorResources.COLOR_A4A2A2,
        ),
      ),
    );
  }
}
