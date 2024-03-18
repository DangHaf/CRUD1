import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class TapMyOrder extends StatelessWidget {
  final String title;
  final String icon;
  final String? iconSelected;
  final Function() callBack;
  final bool isSelected;
  final Color colorSelected;
  final AutoScrollController scrollController;
  final int index;

  const TapMyOrder({
    super.key,
    required this.title,
    required this.icon,
    required this.callBack,
    required this.isSelected,
    required this.colorSelected,
    this.iconSelected,
    required this.scrollController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      controller: scrollController,
      key: ValueKey(index),
      index: index,
      child: InkWell(
        onTap: callBack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconSelected != null)
              Image.asset(
                isSelected ?  iconSelected! : icon,
                width: 22.r,
                height: 22.r,
              )
            else
              Image.asset(
                icon,
                width: 22.r,
                height: 22.r,
                color: isSelected ? colorSelected : ColorResources.COLOR_677275,
              ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: AppText.text10.copyWith(
                color: isSelected ? colorSelected : ColorResources.COLOR_677275,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
