import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class WidgetLoading extends StatefulWidget {
  const WidgetLoading({super.key});

  @override
  State<WidgetLoading> createState() => _WidgetLoadingState();
}

class _WidgetLoadingState extends State<WidgetLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.black.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: ColorResources.COLOR_EDAC02,
          ),
          const SizedBox(width: 20),
          Text(
            'Deleting...',
            style: TextStyle(
              color: ColorResources.COLOR_EDAC02,
              fontSize: IZISizeUtil.LABEL_LARGE_FONT_SIZE,
              fontWeight: FontWeight.w700,
            ),
          ), // Văn bản
        ],
      ),
    );
  }
}
