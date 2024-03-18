import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';

class DescriptionHtml extends StatefulWidget {
  final String title;
  final String description;
  final bool isLoading;
  final TextStyle? styleTitle;

  const DescriptionHtml({
    super.key,
    required this.title,
    required this.description,
    required this.isLoading,
    this.styleTitle,
  });

  @override
  State<DescriptionHtml> createState() => _DescriptionHtmlState();
}

class _DescriptionHtmlState extends State<DescriptionHtml> {
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container(
        color: Colors.white,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  vertical: IZISizeUtil.SPACE_2X),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: IZISizeUtil.SPACE_2X),
                    child: Text(
                      widget.title,
                      style: widget.styleTitle ??
                          AppText.text16.copyWith(
                            color: ColorResources.COLOR_464647,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: ColorResources.NEUTRALS_6,
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      width: Get.width,
                      height: 50.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                vertical: IZISizeUtil.SPACE_2X),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: IZISizeUtil.SPACE_2X),
                  child: Text(
                    widget.title,
                    style: widget.styleTitle ??
                        AppText.text16.copyWith(
                          color: ColorResources.COLOR_464647,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (widget.description.length > getMax)
                  Html(
                    data: !isReadMore
                        ? widget.description.substring(0, getMax)
                        : widget.description,
                    style: {
                      'h1': Style(
                        fontWeight: FontWeight.w700,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(18.sp),
                      ),
                      'h2': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'h3': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'h4': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'p': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'pre': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'li': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      "body": Style(
                        margin: Margins.all(0),
                        fontSize: FontSize(13.5.sp),
                      ),
                    },

                  )
                else
                  Html(
                    data: widget.description,
                    style: {
                      'h1': Style(
                        fontWeight: FontWeight.w700,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(18.sp),
                      ),
                      'h2': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'h3': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'h4': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'p': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.COLOR_677275,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'pre': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.COLOR_677275,
                        fontSize: FontSize(13.5.sp),
                      ),
                      'li': Style(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                        fontSize: FontSize(13.5.sp),
                      ),
                      "body": Style(
                        margin: Margins.all(0),
                        fontSize: FontSize(13.5.sp),
                      ),
                    },
                  )
              ],
            ),
          ),
          if (widget.description.length > getMax)
            Container(
              height: 35.h,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: .3.h,
                    color: ColorResources.COLOR_A4A2A2,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isReadMore = !isReadMore;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isReadMore
                          ? 'product_detail_006'.tr
                          : 'product_detail_005'.tr,
                      style: AppText.text12.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.COLOR_0095E9,
                      ),
                    ),
                    if (isReadMore)
                      const Icon(
                        Icons.keyboard_arrow_up,
                        color: ColorResources.COLOR_0095E9,
                      )
                    else
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorResources.COLOR_0095E9,
                      )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  int get getMax {
    if (widget.description.length < 800) {
      return widget.description.length;
    }
    final str = widget.description.substring(0, 800);
    if (str[799] == '/' && str[798] == '<') {
      return 798;
    }
    if (str[799] == '<') {
      return 799;
    }
    return 800;
  }
}
