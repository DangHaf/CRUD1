import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';

class WidgetHeader extends StatelessWidget {
  const WidgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 121,
      child: Row(
        children: [
          Image.asset(ImagesPath.imageStudent, width: 76.r, height: 121.r),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Student",
                  style: TextStyle(
                    color: ColorResources.COLOR_EDAC02,
                    fontSize: IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Management",
                  style: TextStyle(
                    color: ColorResources.COLOR_002184,
                    fontSize: IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
