import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IZISmartRefresher extends StatelessWidget {
  const IZISmartRefresher({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.refreshController,
    required this.enablePullDown,
    required this.onLoading,
    this.primary,
    this.enablePullUp,
    this.scrollDirection,
    this.header,
    this.footer,
  }) : super(key: key);

  final Function() onRefresh;
  final Function() onLoading;
  final bool enablePullDown;
  final Widget child;
  final bool? primary;
  final RefreshController? refreshController;
  final bool? enablePullUp;
  final Axis? scrollDirection;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const ClampingScrollPhysics(),
      primary: primary ?? false,
      onRefresh: onRefresh,
      onLoading: onLoading,
      controller: refreshController!,
      enablePullUp: enablePullUp ?? false,
      enablePullDown: enablePullDown,
      scrollDirection: scrollDirection,
      header: ClassicHeader(
        idleText: 'home_105'.tr,
        releaseText: 'home_106'.tr,
        completeText: 'home_107'.tr,
        refreshingText: 'home_031'.tr,
        failedText: 'home_108'.tr,
        canTwoLevelText: 'home_105'.tr,
      ),
      footer: ClassicFooter(
        loadingText: 'home_033'.tr,
        canLoadingText: 'home_109'.tr,
        failedText: 'home_110'.tr,
        idleText: 'home_109'.tr,
      ),
      child: child,
    );
  }
}
