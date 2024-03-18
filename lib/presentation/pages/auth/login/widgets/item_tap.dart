import 'package:flutter/material.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/color_resources.dart';

class ItemTap extends StatefulWidget {
  final String title;
  final bool isSelected;
  final Function() callback;

  const ItemTap({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.callback,
  }) : super(key: key);

  @override
  State<ItemTap> createState() => _ItemTapState();
}

class _ItemTapState extends State<ItemTap> {
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
      textWidth += 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Text(
              widget.title,
              style: AppText.text14.copyWith(
                color: widget.isSelected
                    ? ColorResources.COLOR_3B71CA
                    : ColorResources.COLOR_464647,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 1.5,
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
