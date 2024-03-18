import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: IZISizeUtil.setEdgeInsetsOnly(
          left: IZISizeUtil.SPACE_HORIZONTAL_SCREEN,
          top: IZISizeUtil.setSize(percent: .04),
          right: IZISizeUtil.setSizeWithWidth(percent: .2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Big title.
            _bigTitle(context),
          ],
        ),
      ),
    );
  }

  Widget _bigTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_2X),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: ColorResources.WHITE,
                  fontSize: 20.sp,
                ),
          ),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorResources.WHITE,
                fontSize: 14.sp,
              ),
        ),
      ],
    );
  }
}
