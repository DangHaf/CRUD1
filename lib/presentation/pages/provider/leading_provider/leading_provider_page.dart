import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/provider/leading_provider/leading_provider_controller.dart';
import 'package:template/presentation/pages/provider/widgets/leading_provider_item.dart';

class LeadingProviderPage extends GetView<LeadingProviderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'provider_detail_006'.tr,
      ),
      backgroundColor: ColorResources.BACK_GROUND_2,
      body: Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SmartRefresher(
                controller: controller.refreshControllerLeadingProvider,
                header: Platform.isAndroid
                      ? const MaterialClassicHeader(
                          color: ColorResources.COLOR_3B71CA)
                      : null,
                onLoading: () {
                  controller.getLeadingProvider(isLoadMore: true);
                },
                onRefresh: () => controller.initDataLeadingProvider(isRefresh: true),
                enablePullUp: controller.isLoadMoreLeadingProvider,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.listLeadingProvider.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.32,
                    crossAxisSpacing: 5.r,
                    mainAxisSpacing: 5.r,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    vertical: 20.h,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return LeadingProviderItem(
                      provider: controller.listLeadingProvider[index],
                      onTap: () => Get.toNamed(AppRoute.DETAIL_PROVIDER,
                          arguments: controller.listLeadingProvider[index].id),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
