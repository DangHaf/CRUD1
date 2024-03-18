import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/introduction/widgets/circle_painter.dart';
import 'package:template/presentation/pages/introduction/widgets/content_intro_widget.dart';

class IntroThirdWidget extends StatelessWidget {
  const IntroThirdWidget({
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
            child: IZIImage(
              ImagesPath.imageIntro3,
              width: Get.width,
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
              child: ContentIntroWidget(
                title: 'intro_005'.tr,
                description: 'intro_006'.tr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
