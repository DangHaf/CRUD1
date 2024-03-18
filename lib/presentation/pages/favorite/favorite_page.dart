import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/favorite/favorite_controller.dart';
import 'package:template/presentation/pages/favorite/widgets/favorite_provider_item.dart';
import 'package:template/presentation/pages/favorite/widgets/item_tab_favorite.dart';
import 'package:template/presentation/pages/favorite/widgets/loading_favorite_provider_item.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';

class FavoritePage extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'dash_board_002'.tr,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 5.h),
          _buildFavoriteTab(),
          SizedBox(
            height: 5.h,
            width: Get.width,
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.currentIndexTab,
                children: [
                  _buildFavoriteProduct(context),
                  _buildFavoriteProvider(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteTab() {
    return Container(
      color: ColorResources.WHITE,
      padding: EdgeInsets.only(bottom: 2.h),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: ItemTabFavorite(
                callback: () => controller.onChangeFavoriteTab(index: 0),
                isSelected: controller.currentIndexTab == 0,
                title: 'favorite_001'.tr,
              ),
            ),
            Expanded(
              child: ItemTabFavorite(
                callback: () => controller.onChangeFavoriteTab(index: 1),
                isSelected: controller.currentIndexTab == 1,
                title: 'favorite_002'.tr,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteProduct(BuildContext context) {
    return Obx(
      () => controller.isLoadingFavoriteProduct
          ? GridView.builder(
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10.r,
                  mainAxisSpacing: 10.r),
              padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                vertical: IZISizeUtil.SPACE_2X,
              ),
              itemBuilder: (BuildContext context, int index) {
                return const ItemProductLoading();
              },
            )
          : controller.listFavoriteProduct.isEmpty
              ? Center(
                  child: Text(
                    'empty_data'.tr,
                    style: AppText.text14.copyWith(
                      color: ColorResources.COLOR_677275,
                    ),
                  ),
                )
              : SmartRefresher(
                  controller: controller.refreshControllerProduct,
                  header: Platform.isAndroid
                      ? const MaterialClassicHeader(
                          color: ColorResources.COLOR_3B71CA)
                      : null,
                  onLoading: () =>
                      controller.getFavoriteProduct(isLoadMore: true),
                  enablePullUp: controller.isLoadMoreFavoriteProduct,
                  onRefresh: () => controller.initDataProducts(isRefresh: true),
                  child: GridView.builder(
                    itemCount: controller.listFavoriteProduct.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10.r,
                        mainAxisSpacing: 10.r),
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                      vertical: IZISizeUtil.SPACE_2X,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ItemProduct(
                        product: controller.listFavoriteProduct[index],
                        onRemoveItem: (){
                          controller.listFavoriteProduct.removeAt(index);
                          controller.listFavoriteProduct.refresh();
                        },
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildFavoriteProvider(BuildContext context) {
    return Obx(
      () => controller.isLoadingFavoriteProvider
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const ItemFavoriteLoadingProvider();
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 6.h);
              },
            )
          : controller.listFavoriteProvider.isEmpty
              ? Center(
                  child: Text(
                    'empty_data'.tr,
                    style: AppText.text14.copyWith(
                      color: ColorResources.COLOR_677275,
                    ),
                  ),
                )
              : SmartRefresher(
                  controller: controller.refreshControllerProvider,
                  header: Platform.isAndroid
                      ? const MaterialClassicHeader(
                          color: ColorResources.COLOR_3B71CA)
                      : null,
                  onLoading: () =>
                      controller.getFavoriteProvider(isLoadMore: true),
                  enablePullUp: controller.isLoadMoreFavoriteProvider,
                  onRefresh: () =>
                      controller.initDataProviders(isRefresh: true),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.listFavoriteProvider.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemFavoriteProvider(
                        provider: controller.listFavoriteProvider[index],
                        onTap: () => controller.onHeartClicked(
                            controller.listFavoriteProvider[index]),
                        removeItem: () {
                          controller.listFavoriteProvider.removeAt(index);
                          controller.listFavoriteProvider.refresh();
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 6.h);
                    },
                  ),
                ),
    );
  }
}
