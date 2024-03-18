// ignore_for_file: use_setters_to_change_properties

import 'package:get/get.dart';

class AdsLoadingController extends GetxController {
  RxString titleLoadingAds = 'ads_002'.tr.obs;
  RxBool isLoadingAd = true.obs;

  @override
  void onClose() {
    titleLoadingAds.close();
    isLoadingAd.close();
    super.onClose();
  }

  ///
  /// Set title loading ads.
  ///
  void setTitleLoadingAds({required String title}) {
    isLoadingAd.value = false;
    titleLoadingAds.value = title;
  }
}
