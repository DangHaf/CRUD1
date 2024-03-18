import 'package:flutter/material.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? colorBorder;
  final LinearGradient? linearGradient;
  final String label;
  final double paddingHorizontal;
  final double paddingVertical;
  final TextStyle? style;
  final double borderRadius;
  final Function() callBack;
  final double? width;

  const CustomButton({
    Key? key,
    this.backgroundColor,
    this.colorBorder,
    required this.label,
    this.paddingHorizontal = 12,
    this.paddingVertical = 12,
    this.borderRadius = 5,
    this.style,
    this.linearGradient,
    required this.callBack,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor ?? ColorResources.COLOR_3B71CA,
            gradient: linearGradient,
            border:
                colorBorder != null ? Border.all(color: colorBorder!) : null),
        child: Text(
          label,
          style: style ??
              AppText.text16
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
