import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';

class IntroductionController extends GetxController {
  PageController pageController = PageController();

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  ///
  /// Skip introduction.
  ///
  void skipIntroduction() {
    pageController.jumpToPage(2);
  }

  ///
  /// On next page.
  ///
  void onNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  ///
  /// On change index of page view.
  ///
  set currentIndex(int index) {
    _currentIndex.value = index;
  }

  void goToLogin() {
    Get.toNamed(AuthRouters.DASH_BOARD);
    sl<SharedPreferenceHelper>().setIsIntroduce(isIntroduce: true);
  }
}
