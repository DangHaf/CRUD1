import 'package:flutter/material.dart';
import 'package:template/core/export/core_export.dart';

class LoadingApp extends StatelessWidget {
  const LoadingApp({
    Key? key,
    this.titleLoading,
    this.titleStyle,
    this.useLoadingLogo = true,
    this.titleColor,
    this.size,
    this.sizeLogo,
  }) : super(key: key);

  final String? titleLoading;
  final TextStyle? titleStyle;
  final bool? useLoadingLogo;
  final Color? titleColor;
  final double? size;
  final double? sizeLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (useLoadingLogo!)
          SizedBox(
            width: size ?? IZISizeUtil.setSize(percent: .14),
            height: size ?? IZISizeUtil.setSize(percent: .14),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: IZIImage(
                    ImagesPath.loadingLogo,
                    width: sizeLogo ?? IZISizeUtil.setSize(percent: .1),
                  ),
                ),
                SizedBox(
                  width: size ?? IZISizeUtil.setSize(percent: .14),
                  height: size ?? IZISizeUtil.setSize(percent: .14),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorResources.WHITE),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        if (!IZIValidate.nullOrEmpty(titleLoading))
          Padding(
            padding: IZISizeUtil.setEdgeInsetsOnly(top: 10),
            child: Text(
              titleLoading!,
              style: titleStyle ??
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: titleColor ?? ColorResources.WHITE,
                      ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
