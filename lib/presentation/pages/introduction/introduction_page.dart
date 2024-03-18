import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/introduction/introduction_controller.dart';
import 'package:template/presentation/pages/introduction/widgets/circle_button.dart';
import 'package:template/presentation/pages/introduction/widgets/intro_first_widget.dart';
import 'package:template/presentation/pages/introduction/widgets/intro_second_widget.dart';
import 'package:template/presentation/pages/introduction/widgets/intro_third_widget.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class IntroductionPage extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller.pageController,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) => controller.currentIndex = index,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (index == 0)
                    const IntroFirstWidget()
                  else
                    index == 1
                        ? const IntroSecondWidget()
                        : const IntroThirdWidget(),
                ],
              );
            },
          ),
          Positioned(
            bottom: 100.h,
            child: Obx(
              () => Center(
                child: DotsIndicator(
                  dotsCount: 3,
                  position: controller.currentIndex,
                  decorator: DotsDecorator(
                    color: ColorResources.COLOR_3B71CA.withOpacity(0.3),
                    activeColor: ColorResources.COLOR_3B71CA,
                    size: Size.square(5.r),
                    activeSize: Size(10.r, 10.r),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: IZISizeUtil.SPACE_6X,
            child: SizedBox(
              width: Get.width,
              child: Obx(() => _buildBottom(controller.currentIndex)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom(int index) {
    if (index == 0 || index == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: IZISizeUtil.SPACE_5X),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => controller.skipIntroduction(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: IZISizeUtil.SPACE_2X * 0.6),
                child: Text(
                  'intro_007'.tr,
                  style: AppText.text16.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorResources.COLOR_3B71CA,
                  ),
                ),
              ),
            ),
            CircleButton(
              callBack: () => controller.onNextPage(),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: IZISizeUtil.PADDING_HORIZONTAL),
      child: CustomButton(
        label: 'intro_008'.tr,
        callBack: () {
          controller.goToLogin();
        },
        backgroundColor: ColorResources.COLOR_3B71CA,
      ),
    );
  }
}
