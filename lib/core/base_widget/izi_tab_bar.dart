import 'package:flutter/material.dart';
import 'package:template/core/export/core_export.dart';

class IZITabBar<T> extends StatelessWidget {
  const IZITabBar(
      {Key? key,
      required this.items,
      required this.onTapChangedTabBar,
      this.currentIndex = 0,
      this.onTap,
      this.heightTabView,
      this.widthTabBar,
      this.heightTabBar,
      this.colorTabBar,
      this.disibleColorTabBar,
      this.radiusTabBar,
      this.isUnderLine = true,
      this.colorText,
      this.disableColorText,
      this.colorUnderLine,
      this.colorBackground})
      : super(key: key);

  final List<T> items;
  final int? currentIndex;
  final Function? onTap;
  final Function(int index) onTapChangedTabBar;
  final double? heightTabView;
  final double? widthTabBar;
  final Color? colorTabBar;
  final Color? disibleColorTabBar;
  final double? radiusTabBar;
  final bool isUnderLine;
  final double? heightTabBar;
  final Color? colorText;
  final Color? disableColorText;
  final Color? colorUnderLine;
  final Color? colorBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: heightTabBar ?? IZISizeUtil.setSize(percent: .15),
      decoration: BoxDecoration(
        color: colorBackground ?? ColorResources.BACK_GROUND,
        borderRadius: BorderRadius.circular(
          radiusTabBar ?? 0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () {
                onTapChangedTabBar(index);
              },
              child: Container(
                padding: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN),
                height: double.infinity,
                width: widthTabBar != null
                    ? (widthTabBar!.roundToDouble() / (items.length + .5))
                    : IZISizeUtil.setSize(percent: .5).roundToDouble() / (items.length + .5),
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? colorTabBar ?? ColorResources.BACK_GROUND
                      : disibleColorTabBar ?? ColorResources.BACK_GROUND,
                  borderRadius: !isUnderLine
                      ? IZISizeUtil.setBorderRadiusAll(radius: radiusTabBar ?? IZISizeUtil.RADIUS_MEDIUM)
                      : null,
                  border: isUnderLine
                      ? Border(
                          bottom: currentIndex == index
                              ? BorderSide(
                                  width: 2,
                                  color: colorUnderLine ?? ColorResources.PRIMARY_3,
                                )
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    items[index].toString(),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: currentIndex == index
                              ? colorText ?? ColorResources.PRIMARY_3
                              : disableColorText ?? ColorResources.NEUTRALS_3,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IZITabBarScroll<T> extends StatelessWidget {
  const IZITabBarScroll({
    Key? key,
    required this.items,
    required this.onTapChangedTabBar,
    this.currentIndex = 0,
    this.onTap,
    this.heightTabView,
    this.widthTabBar,
    this.heightTabBar,
    this.colorTabBar,
    this.disableColorTabBar,
    this.radiusTabBar,
    this.isUnderLine = true,
    this.colorText,
    this.disableColorText,
    this.colorUnderLine,
    this.colorBackground,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.fullTabBorder,
  }) : super(key: key);

  final List<T> items;
  final int? currentIndex;
  final Function? onTap;
  final Function(int index) onTapChangedTabBar;
  final double? heightTabView;
  final double? widthTabBar;
  final Color? colorTabBar;
  final Color? disableColorTabBar;
  final double? radiusTabBar;
  final bool isUnderLine;
  final double? heightTabBar;
  final Color? colorText;
  final Color? disableColorText;
  final Color? colorUnderLine;
  final Color? colorBackground;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Border? fullTabBorder;

  TextStyle _getTextStyle(BuildContext context, int index) {
    if (selectedTextStyle == null) {
      return Theme.of(context).textTheme.labelMedium!.copyWith(
            color:
                currentIndex == index ? colorText ?? ColorResources.PRIMARY_3 : disableColorText ?? ColorResources.GREY,
            fontWeight: currentIndex == index ? FontWeight.w600 : FontWeight.normal,
          );
    }

    return index == currentIndex ? selectedTextStyle! : unselectedTextStyle!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: heightTabBar ?? IZISizeUtil.setSize(percent: .2),
      decoration: BoxDecoration(
        color: colorBackground ?? ColorResources.BACK_GROUND,
        border: fullTabBorder ??
            const Border(
              bottom: BorderSide(color: ColorResources.NICKEL, width: 0.25),
            ),
      ),
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTapChangedTabBar(index);
            },
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? colorTabBar ?? ColorResources.WHITE
                    : disableColorTabBar ?? ColorResources.WHITE,
                borderRadius: !isUnderLine
                    ? IZISizeUtil.setBorderRadiusAll(
                        radius: radiusTabBar ?? IZISizeUtil.RADIUS_MEDIUM,
                      )
                    : null,
                border: isUnderLine
                    ? Border(
                        bottom: currentIndex == index
                            ? BorderSide(
                                width: 2,
                                color: colorUnderLine ?? ColorResources.PRIMARY_3,
                              )
                            : const BorderSide(
                                width: 2,
                                color: Colors.transparent,
                              ),
                      )
                    : null,
              ),
              padding: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: 15),
              child: Center(
                child: Text(
                  items[index].toString(),
                  style: _getTextStyle(context, index),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
