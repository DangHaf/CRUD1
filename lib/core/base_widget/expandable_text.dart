import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:template/core/export/core_export.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    this.trimLines = 2,
    this.colorShowMore,
    this.styleReadMore,
    this.styleContent,
  }) : super(key: key);

  final String text;
  final int trimLines;
  final Color? colorShowMore;
  final TextStyle? styleReadMore;
  final TextStyle? styleContent;
  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;

  ///
  /// On change read more.
  ///
  void _onChangeReadMore() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final TextSpan link = TextSpan(
        text: _readMore ? "... Xem thêm" : " Ẩn",
        style: widget.styleReadMore ?? Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: widget.colorShowMore ?? ColorResources.WHITE,
            ),
        recognizer: TapGestureRecognizer()..onTap = _onChangeReadMore);
    final Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        final TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - (linkSize.width * 1.5),
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset <= 0 ? 1 : pos.offset)!;
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style:  widget.styleContent ?? Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: widget.colorShowMore ?? ColorResources.WHITE,
                ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style: widget.styleContent,
          );
        }
        return RichText(
          text: textSpan,
        );
      },
    );
    return GestureDetector(
      onTap: () {
        _onChangeReadMore();
      },
      child: result,
    );
  }
}
