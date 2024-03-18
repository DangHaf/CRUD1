import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';
import 'package:template/presentation/pages/provider/product_hot/product_hot_controller.dart';

class ProductHotPage extends GetView<ProductHotController> {
  const ProductHotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(title: 'search_014'.tr),
      body: Obx(
        () => controller.isLoadingOutStanding
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SmartRefresher(
                controller: controller.refreshControllerOutStanding,
                onLoading: () => controller.getOutStanding(isLoadMore: true),
                onRefresh: () =>
                    controller.initDataOutStanding(isRefresh: true),
                header: Platform.isAndroid
                    ? const MaterialClassicHeader(
                        color: ColorResources.COLOR_3B71CA)
                    : null,
                enablePullUp: controller.isLoadMoreOutStanding,
                child: controller.listOutStanding.isEmpty
                    ? Center(
                        child: Text(
                          'empty_data'.tr,
                          style: AppText.text16.copyWith(
                            color: ColorResources.COLOR_464647,
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.listOutStanding.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10.r,
                            mainAxisSpacing: 10.r),
                        padding: EdgeInsets.symmetric(
                          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                          vertical: 10.h,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ItemProduct(
                            product: controller.listOutStanding[index],
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
