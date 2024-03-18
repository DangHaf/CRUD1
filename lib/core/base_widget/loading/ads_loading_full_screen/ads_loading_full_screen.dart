import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/core/base_widget/loading/ads_loading_full_screen/ads_loading_controller.dart';
import 'package:template/core/export/core_export.dart';

mixin ShowAdsLoadingFullScreen {
  static void showAdsLoadingFullScreen() {
    Get.dialog(
      const Dialog.fullscreen(
        child: AdsLoadingWidget(),
      ),
    );
  }
}

class AdsLoadingWidget extends StatelessWidget {
  const AdsLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put<AdsLoadingController>(AdsLoadingController());

    return Material(
      color: ColorResources.BLACK,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            if (!_controller.isLoadingAd.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IZIImage(
                    ImagesPath.loadingLogo,
                    width: IZISizeUtil.setSize(percent: .08),
                  ),
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(top: 10),
                    child: Text(
                      _controller.titleLoadingAds.value,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorResources.WHITE,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
            return LoadingApp(
              titleLoading: _controller.titleLoadingAds.value,
              titleColor: ColorResources.WHITE,
            );
          }),
        ],
      ),
    );
  }
}
