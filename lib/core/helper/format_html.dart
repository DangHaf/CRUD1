import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:template/core/export/core_export.dart';

class Specification extends StatelessWidget {
  final String specification;
  final EdgeInsetsGeometry? padding;
  final bool? isScroll;
  final Style? style;
  final Function(String)? onLinkTap;
  const Specification({
    Key? key,
    required this.specification,
    this.padding,
    this.isScroll = true,
    this.style,
    this.onLinkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: (isScroll == true) ? null : const NeverScrollableScrollPhysics(),
      child: Html(
        data: CommonHelper.htmlUnescape(specification),
        style: {
          "body": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            fontSize: FontSize(
              IZISizeUtil.BODY_LARGE_FONT_SIZE,
            ),
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            color: ColorResources.OUTER_SPACE,
          ),
          "html": style ??
              Style(
                textAlign: TextAlign.justify,
                padding: HtmlPaddings.zero,
                margin: Margins.zero,
                fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
                color: ColorResources.OUTER_SPACE,
              ),
          "table": Style(
            backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            padding: HtmlPaddings.zero,
            margin: Margins.zero,
            lineHeight: LineHeight.em(1),
            fontSize: FontSize(
              IZISizeUtil.BODY_LARGE_FONT_SIZE,
            ),
            color: ColorResources.OUTER_SPACE,
            textAlign: TextAlign.center,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          "tr": Style(
            border: Border(
              bottom: BorderSide(color: ColorResources.BLACK.withOpacity(.4)),
              left: BorderSide(color: ColorResources.BLACK.withOpacity(.4)),
              right: BorderSide(color: ColorResources.BLACK.withOpacity(.4)),
              top: BorderSide(color: ColorResources.BLACK.withOpacity(.4)),
            ),
            color: ColorResources.OUTER_SPACE,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          "th": Style(
            padding: HtmlPaddings.all(6),
            backgroundColor: Colors.grey,
            fontSize: FontSize(
              IZISizeUtil.BODY_LARGE_FONT_SIZE,
            ),
            color: ColorResources.OUTER_SPACE,
            fontWeight: FontWeight.w600,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          "td": Style(
            padding: HtmlPaddings.all(6),
            alignment: Alignment.topLeft,
            color: ColorResources.OUTER_SPACE,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          'h5': Style(
            maxLines: 2,
            color: ColorResources.OUTER_SPACE,
            textOverflow: TextOverflow.ellipsis,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
        },
      ),
    );
  }
}
