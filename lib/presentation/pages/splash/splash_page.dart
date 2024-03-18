import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_D43D5E,
      body: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Center(
            child: IZIImage(
              ImagesPath.splashImage,
              width: Get.width * 0.3,
            ),
          );
        },
      ),
    );
  }
}
