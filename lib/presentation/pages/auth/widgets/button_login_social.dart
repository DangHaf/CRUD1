import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class ButtonLoginSocial extends StatelessWidget {
  final String icon;
  final String label;
  final Function() callBack;

  const ButtonLoginSocial({
    super.key,
    required this.icon,
    required this.label,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: IZISizeUtil.SPACE_4X,
          vertical: 12 ,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24.r,
              height: 24.r,
              child: IZIImage(icon),
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: AppText.text12.copyWith(
                    color: ColorResources.COLOR_464647,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 24.r,
              height: 24.r,
            ),
          ],
        ),
      ),
    );
  }
}
