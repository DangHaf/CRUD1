import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    this.title,
    this.onBack,
    this.actions,
    this.backgroundColor,
    this.titleStyle,
    this.leading,
    this.bottom,
    this.height = kToolbarHeight,
    this.elevation = 0,
    this.isFlexibleSpace = true,
    this.titleWidget,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.leadingBg,
  });

  final String? title;
  final Widget? leading;
  final Function? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final PreferredSizeWidget? bottom;
  final double height;
  final double elevation;
  final bool? isFlexibleSpace;
  final Widget? titleWidget;
  final double? leadingWidth;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Color? leadingBg;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        children: [
          Container(
            height: 8,
            width: Get.width,
            color: backgroundColor ?? ColorResources.COLOR_3B71CA,
          ),
          AppBar(
            bottom: bottom,
            elevation: elevation,
            backgroundColor: backgroundColor ?? ColorResources.COLOR_3B71CA,
            actions: actions,
            foregroundColor: ColorResources.WHITE,
            surfaceTintColor: Colors.transparent,
            leadingWidth: leadingWidth,
            automaticallyImplyLeading: automaticallyImplyLeading,
            titleSpacing: 0,
            leading: Center(
              child: leading ??
                  (automaticallyImplyLeading
                      ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: leadingBg ?? Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (onBack != null) {
                          onBack!();
                          return;
                        }
                        Get.back();
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: ColorResources.COLOR_677275,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                      : null),
            ),
            title: titleWidget ??
                (title != null
                    ? Text(
                        title!,
                        style: titleStyle ??
                            AppText.text18.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                      )
                    : null),
            flexibleSpace: isFlexibleSpace!
                ? Container(
                    decoration: BoxDecoration(
                      color: backgroundColor ?? ColorResources.COLOR_3B71CA,
                    ),
                  )
                : null,
            centerTitle: centerTitle,
          ),
        ],
      ),
    );
  }
}
