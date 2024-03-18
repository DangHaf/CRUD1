import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class ItemTabFavorite extends StatefulWidget {
  final String title;
  final bool isSelected;
  final Function() callback;

  const ItemTabFavorite({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.callback,
  }) : super(key: key);

  @override
  State<ItemTabFavorite> createState() => _ItemTabFavorite();
}

class _ItemTabFavorite extends State<ItemTabFavorite> {
  double textWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTextWidth();
    });
  }

  void getTextWidth() {
    final textSpan = TextSpan(
      text: widget.title,
      style: AppText.text14.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    setState(() {
      textWidth = textPainter.width;
      textWidth += 12.w;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: widget.isSelected
                          ? ColorResources.COLOR_3B71CA
                          : ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Container(
              height: 2.h,
              width: textWidth,
              color: widget.isSelected
                  ? ColorResources.COLOR_3B71CA
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
