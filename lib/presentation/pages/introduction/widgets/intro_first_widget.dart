import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/introduction/widgets/circle_painter.dart';
import 'package:template/presentation/pages/introduction/widgets/content_intro_widget.dart';

class IntroFirstWidget extends StatelessWidget {
  const IntroFirstWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: ColorResources.COLOR_EEF4FB,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.only(
                left: IZISizeUtil.SPACE_3X,
                right: IZISizeUtil.SPACE_3X,
              ),
              child: IZIImage(
                ImagesPath.imageIntro1,
                width: Get.width * 0.7,
              ),
            ),
          ),
          CustomPaint(
            size: Size(Get.width, Get.width),
            painter: CirclePainter(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                left: IZISizeUtil.SPACE_5X,
                right: IZISizeUtil.SPACE_5X,
                bottom: 150.h,
              ),
              child:  ContentIntroWidget(
                title: 'intro_001'.tr,
                description:
                    'intro_002'.tr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
