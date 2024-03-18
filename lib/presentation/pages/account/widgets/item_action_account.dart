import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class ItemActionAccount extends StatelessWidget {
  final String title;
  final String icon;
  final Function() callBack;
  final bool isBorder;
  final Widget? subWidget;

  const ItemActionAccount({
    super.key,
    required this.title,
    required this.icon,
    required this.callBack,
    this.isBorder = true,
    this.subWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      borderRadius: isBorder ? BorderRadius.circular(5.r) : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 15.h,
        ),
        decoration: BoxDecoration(
          borderRadius: isBorder ? BorderRadius.circular(5.r) : null,
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 16.r,
              height: 16.r,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style:
                    AppText.text14.copyWith(color: ColorResources.COLOR_181313),
              ),
            ),
            if (subWidget != null) subWidget!,
          ],
        ),
      ),
    );
  }
}
