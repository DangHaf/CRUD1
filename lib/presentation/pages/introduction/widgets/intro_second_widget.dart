import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/introduction/widgets/circle_painter_top.dart';
import 'package:template/presentation/pages/introduction/widgets/content_intro_widget.dart';

class IntroSecondWidget extends StatelessWidget {
  const IntroSecondWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              size: Size(Get.width, Get.width),
              painter: CirclePainterTop(color: Colors.transparent),
              child: IZIImage(
                ImagesPath.imageIntro2,
                width: Get.width,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: IZISizeUtil.SPACE_5X,
              right: IZISizeUtil.SPACE_5X,
              bottom: 150.h,
            ),
            child: ContentIntroWidget(
              title: 'intro_003'.tr,
              description: 'intro_004'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
