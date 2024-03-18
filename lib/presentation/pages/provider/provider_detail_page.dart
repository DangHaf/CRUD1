import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/presentation/pages/home/widgets/item_out_standing.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';
import 'package:template/presentation/pages/product/widgets/description_html.dart';
import 'package:template/presentation/pages/provider/provider_detail_controller.dart';

class ProviderDetailPage extends GetView<ProviderDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(
      () => SmartRefresher(
        controller: controller.refreshControllerProduct,
        onLoading: () {
          controller.getProducts(isLoadMore: true);
        },
        enablePullUp: controller.isLoadMoreProduct,
        onRefresh: () {
          controller.initData(isRefresh: true);
        },
        header: Platform.isAndroid
            ? const MaterialClassicHeader(color: ColorResources.COLOR_3B71CA)
            : null,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProvider(),
              SizedBox(height: 5.h),
              if (controller.listOutStanding.isNotEmpty || controller.isLoading)
                _buildOutstandingProduct(),
              _buildSuggestProducts()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProvider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            if (controller.isLoading)
              IZIImage(
                '',
                height: Get.width * 0.82,
                width: Get.width,
              )
            else
              IZIImage(
                controller.provider.value.banner ?? '',
                height: Get.width * 0.82,
                width: Get.width,
              ),
            Positioned(
              bottom: -1.h,
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: ColorResources.WHITE,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.h),
                    if (controller.isLoading)
                      Shimmer.fromColors(
                        baseColor: ColorResources.NEUTRALS_6,
                        highlightColor: Colors.grey.withOpacity(0.2),
                        child: Container(
                          width: Get.width * 0.4,
                          height: 18.sp,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              controller.provider.value.name ?? '',
                              style: AppText.text18.copyWith(
                                fontWeight: FontWeight.w700,
                                color: ColorResources.BLACK,
                                height: 1.2,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                ImagesPath.icChat,
                                color: ColorResources.COLOR_0B8A4D,
                                height: 20.w,
                                width: 20.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'provider_detail_001'.tr,
                                style: AppText.text12.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: ColorResources.COLOR_677275,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: ColorResources.NEUTRALS_6,
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: 14.sp,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: Get.width,
                          height: 14.sp,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: Get.width,
                          height: 14.sp,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                _buildInformation(),
              SizedBox(height: 8.h),
              const Divider(
                thickness: 0.3,
                height: 0,
                color: ColorResources.COLOR_A4A2A2,
              ),
            ],
          ),
        ),
        DescriptionHtml(
          title: 'provider_detail_005'.tr,
          description: controller.provider.value.introduce,
          isLoading: controller.isLoading,
          styleTitle: AppText.text14.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 0,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: SizedBox(
                width: 40.r,
                height: 40.r,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.back(result: controller.provider.value.isLike);
                  },
                  backgroundColor: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorResources.COLOR_677275,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 40.r,
                height: 40.r,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRoute.SEARCH_PRODUCT_PROVIDER,
                      arguments: controller.providerId,
                    );
                  },
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    ImagesPath.icSearchInput,
                    width: 16.r,
                    height: 16.r,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      elevation: 0,
    );
  }

  Widget _buildInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: Image.asset(ImagesPath.icPhoneContact),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      controller.provider.value.businessPhone ?? '',
                      style: AppText.text14.copyWith(
                        color: ColorResources.COLOR_30BB1A,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: Image.asset(ImagesPath.icLocationBlue),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      controller.provider.value.addressWithCityState,
                      style: AppText.text14.copyWith(
                        color: ColorResources.COLOR_677275,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (controller.provider.value.totalRateSupplier != 0) {
                        Get.toNamed(AppRoute.COMMENT_PROVIDER,
                            arguments: controller.provider.value.id);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: ColorResources.COLOR_FBD408,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'provider_detail_002'.tr,
                          style: AppText.text14.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorResources.BLACK,
                          ),
                        ),
                        Container(
                          width: 0.5,
                          height: 15,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          color: ColorResources.COLOR_A4A2A2,
                        ),
                        Text(
                          '${controller.provider.value.averagePointSupplier.averagePoint}/5',
                          style: AppText.text14.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorResources.COLOR_FBD408,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text(
                            '(${controller.provider.value.totalRateSupplier} ${'review_001'.tr})',
                            style: AppText.text12.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorResources.COLOR_677275,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ColorResources.COLOR_677275,
                          size: 10.w,
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.onChangeIsLike();
                      },
                      child: controller.provider.value.isLike
                          ? const Icon(
                              Icons.favorite,
                              color: ColorResources.RED,
                            )
                          : const Icon(
                              Icons.favorite_outline_outlined,
                              color: ColorResources.RED,
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOutstandingProduct() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 10.h,
              left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'home_011'.tr,
                        style: AppText.text16.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorResources.COLOR_464647,
                        ),
                      ),
                      TextSpan(
                        text: 'home_012'.tr,
                        style: AppText.text16.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorResources.COLOR_1255B9,
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Image.asset(
                            ImagesPath.icOutstandingProduct,
                            width: 22.w,
                            height: 22.w,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoute.PRODUCT_HOT,
                        arguments: controller.providerId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      'home_006'.tr,
                      style: AppText.text12.copyWith(
                        color: ColorResources.COLOR_3B71CA,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.width * 0.4 * 1.45,
            child: Obx(
              () => controller.isLoadingOutStanding
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                      ),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return const ItemOutStandingLoading();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                    )
                  : controller.listOutStanding.isNotEmpty
                      ? SmartRefresher(
                          controller: controller.refreshControllerOutStanding,
                          onLoading: () {
                            controller.getOutStanding(isLoadMore: true);
                          },
                          enablePullUp: controller.isLoadMoreOutStanding,
                          enablePullDown: false,
                          footer: CustomFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                            builder: (context, mode) {
                              return CupertinoActivityIndicator(
                                animating: mode == LoadStatus.loading,
                              );
                            },
                          ),
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                            ),
                            itemCount: controller.listOutStanding.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemOutStanding(
                                product: controller.listOutStanding[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 10.w,
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            'empty_data'.tr,
                            style: AppText.text12.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorResources.COLOR_677275,
                            ),
                          ),
                        ),
            ),
          ),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }

  Widget _buildSuggestProducts() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1.h,
                width: 70.w,
                color: ColorResources.COLOR_8A92A6,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  'provider_detail_007'.tr,
                  style: AppText.text16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.COLOR_464647,
                  ),
                ),
              ),
              Container(
                height: 1.h,
                width: 70.w,
                color: ColorResources.COLOR_8A92A6,
              ),
            ],
          ),
        ),
        Obx(
          () => controller.isLoadingProduct
              ? GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r),
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return const ItemProductLoading();
                  },
                )
              : GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.listProduct.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10.r,
                      mainAxisSpacing: 10.r),
                  padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ItemProduct(product: controller.listProduct[index]);
                  },
                ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}
