import 'package:flutter/material.dart';
import 'package:template/core/export/core_export.dart';

class IZIButton extends StatelessWidget {
  const IZIButton({
    Key? key,
    required this.onTap,
    this.label,
    this.height,
    this.maxLine,
    this.type = IZIButtonType.DEFAULT,
    this.isEnabled = true,
    this.padding,
    this.margin,
    this.borderRadius,
    this.icon,
    this.iconRight,
    this.imageUrlIconRight,
    this.color = ColorResources.WHITE,
    this.colorBGDisabled = ColorResources.GREY,
    this.colorDisable = ColorResources.OUTER_SPACE,
    this.colorBG = ColorResources.PRIMARY_1,
    this.colorIcon,
    this.colorText,
    this.imageUrlIcon,
    this.withBorder,
    this.width,
    this.fontSizedLabel,
    this.space,
    this.fontWeight,
    this.colorBorder,
    this.fillColor,
    this.sizeIcon,
    this.isGradient = false,
    this.gradientColorList,
  }) : super(key: key);

  final String? label;
  final Color? color;
  final Color? colorDisable;
  final Color? colorBGDisabled;
  final Color? colorBG;
  final Function onTap;
  final double? height;
  final int? maxLine;
  final IZIButtonType? type;
  final Color? colorIcon;
  final Color? colorText;
  final Color? colorBorder;
  final Color? fillColor;

  final bool? isEnabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final IconData? icon, iconRight;
  final String? imageUrlIcon, imageUrlIconRight;
  final double? withBorder;
  final double? width;
  final double? fontSizedLabel;
  final double? space;
  final double? sizeIcon;
  final FontWeight? fontWeight;
  final bool? isGradient;
  final List<Color>? gradientColorList;

  Color getColorBG(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return colorBG!;
      }
      return colorBGDisabled!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return fillColor ?? Colors.transparent;
      }
      return ColorResources.WHITE;
    }
    return colorBG!;
  }

  Color getColor(IZIButtonType type) {
    if (type == IZIButtonType.DEFAULT) {
      if (isEnabled!) {
        return color!;
      }
      return colorDisable!;
    } else if (type == IZIButtonType.OUTLINE) {
      if (isEnabled!) {
        return colorBG!;
      }
      return ColorResources.GREY;
    }
    return color!;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: isEnabled!
            ? () {
                onTap();
              }
            : null,
        child: Container(
          width: width ?? IZISizeUtil.getMaxWidth(),
          padding: padding ??
              IZISizeUtil.setEdgeInsetsSymmetric(vertical: IZISizeUtil.SPACE_2X, horizontal: IZISizeUtil.SPACE_2X),
          margin: margin ?? IZISizeUtil.setEdgeInsetsSymmetric(vertical: 5),
          decoration: BoxDecoration(
            gradient: !isGradient!
                ? null
                : LinearGradient(
                    colors: gradientColorList ??
                        [
                          const Color(0xff309FB0).withOpacity(1),
                          const Color(0xff0E2938).withOpacity(0.3),
                          const Color(0xff0E2938).withOpacity(.6),
                          const Color(0xff0E2938).withOpacity(0.3),
                          const Color(0xff309FB0).withOpacity(1),
                        ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [-0.1, 0.6, 0.5, 0.6, 1.4],
                  ),
            color: getColorBG(type!),
            border: type == IZIButtonType.DEFAULT
                ? null
                : Border.all(
                    color: colorBorder ?? ColorResources.PRIMARY_1,
                    width: withBorder ?? 1,
                  ),
            borderRadius: IZISizeUtil.setBorderRadiusAll(radius: borderRadius ?? 100),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!IZIValidate.nullOrEmpty(imageUrlIcon))
                SizedBox(
                  height: sizeIcon ?? IZISizeUtil.setSize(percent: .1),
                  width: sizeIcon ?? IZISizeUtil.setSize(percent: .1),
                  child: IZIImage(
                    imageUrlIcon.toString(),
                  ),
                ),
              if (icon != null)
                Icon(
                  icon,
                  color: colorIcon ?? getColor(type!),
                  size: sizeIcon ?? IZISizeUtil.setSize(percent: .1),
                )
              else
                const SizedBox(),
              SizedBox(
                width: space == null ? 0 : IZISizeUtil.setSize(percent: .1) * space!,
              ),
              if (label != null)
                Flexible(
                  child: Text(
                    " $label",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: fontSizedLabel ?? IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
                          color: colorText ?? getColor(type!),
                          fontWeight: fontWeight ?? FontWeight.w700,
                        ),
                    maxLines: maxLine ?? 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (!IZIValidate.nullOrEmpty(imageUrlIconRight))
                SizedBox(
                  height: IZISizeUtil.setSize(percent: .2),
                  width: IZISizeUtil.setSize(percent: .2),
                  child: IZIImage(
                    imageUrlIconRight.toString(),
                  ),
                ),
              if (iconRight != null)
                Icon(
                  iconRight,
                  color: colorIcon ?? getColor(type!),
                  size: IZISizeUtil.setSize(percent: .125),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
