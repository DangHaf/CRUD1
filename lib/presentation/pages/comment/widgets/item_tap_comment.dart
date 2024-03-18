import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class ItemTapComment extends StatelessWidget {
  final Function() onTap;
  final bool isSelected;
  final int quantity;
  final String title;

  const ItemTapComment({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.title,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            width: 1.r,
            color: isSelected
                ? ColorResources.COLOR_3B71CA
                : ColorResources.COLOR_EBF0FF,
          ),
          color:
              isSelected ? ColorResources.COLOR_3B71CA : ColorResources.WHITE,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: IZISizeUtil.SPACE_5X,
          vertical: IZISizeUtil.SPACE_1X,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: AppText.text12.copyWith(
                fontWeight: FontWeight.w400,
                color: isSelected
                    ? ColorResources.WHITE
                    : ColorResources.COLOR_535354,
              ),
            ),
            Text(
              '(${quantity.toString()})',
              style: AppText.text12.copyWith(
                fontWeight: FontWeight.w400,
                color: isSelected
                    ? ColorResources.WHITE
                    : ColorResources.COLOR_535354,
              ),
            )
          ],
        ),
      ),
    );
  }
}
