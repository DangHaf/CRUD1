import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/look_up_data.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/pages/home/widgets/dialog_login.dart';
import 'package:template/presentation/pages/home/widgets/item_best_seller.dart';
import 'package:template/presentation/pages/home/widgets/item_for_you.dart';
import 'package:template/presentation/pages/home/widgets/item_home_action.dart';
import 'package:template/presentation/pages/home/widgets/item_leading_provider.dart';
import 'package:template/presentation/pages/home/widgets/item_new_point.dart';
import 'package:template/presentation/pages/home/widgets/item_out_standing.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';
import 'package:template/presentation/pages/home/widgets/item_product_group.dart';
import 'package:template/presentation/pages/home/widgets/item_provider.dart';
import 'package:template/presentation/pages/home/widgets/item_saving_focus.dart';
import 'package:template/presentation/pages/home/widgets/slide/slide_show_custom.dart';
import 'package:template/presentation/pages/search/search_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: controller.currentAction,
                  children: [
                    _buildContentProduct(),
                    _buildContentProvider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => controller.isShowButtonScroll.value
            ? SizedBox(
                width: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    controller.onScrollTop();
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.black,
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _buildContentProduct() {
    return Obx(
      () => SmartRefresher(
        controller: controller.refreshControllerProduct,
        scrollController: controller.scrollController,
        onLoading: () {
          controller.getProducts(isLoadMore: true);
        },
        enablePullUp: controller.isLoadMoreProduct,
        onRefresh: () {
          controller.initProducts();
        },
        header: Platform.isAndroid
            ? const MaterialClassicHeader(color: ColorResources.COLOR_3B71CA)
            : null,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => _buildHomeAction()),
              Container(
                height: 5.h,
                width: Get.width,
                color: ColorResources.BACK_GROUND_2,
              ),
              if (LookUpData.typeProduct.isNotEmpty) _buildProductGroup(),
              if (controller.listOutStanding.isNotEmpty ||
                  controller.isLoadingOutStanding)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                    _buildOutstandingProduct(),
                  ],
                ),
              if (controller.listSavingFocus.isNotEmpty ||
                  controller.isLoadingSavingFocus)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                    _buildSavingsFocus(),
                  ],
                ),
              if (controller.listNewPoint.isNotEmpty ||
                  controller.isLoadingNewPoint)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                    _buildNewPoint(),
                  ],
                ),
              if (controller.listForYou.isNotEmpty ||
                  controller.isLoadingForYou)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                    _buildForYou(),
                  ],
                ),
              if (controller.listProduct.isNotEmpty ||
                  controller.isLoadingProduct)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                    _buildProducts(),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutstandingProduct() {
    return Column(
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
                  Get.toNamed(AppRoute.SEARCH, arguments: {
                    'filterSort': FilterSortModel(
                        id: 4, name: 'search_014'.tr, type: OUTSTANDING),
                  });
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
                : SmartRefresher(
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
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                    ),
                  ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget _buildSavingsFocus() {
    return Column(
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
                child: Text(
                  'home_013'.tr,
                  style: AppText.text16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.COLOR_464647,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.SEARCH, arguments: {
                    'filterSort': FilterSortModel(
                        id: 3, name: 'search_013'.tr, type: SAVING),
                  });
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
        Obx(
          () => controller.isLoadingBanner
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.h,
                    left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  ),
                  child: IZIImage(
                    '',
                    width: Get.width,
                    height: Get.width * 0.25,
                  ),
                )
              : controller.banners.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.h,
                        left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                        right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                      ),
                      child: SlideshowCustom(
                        width: Get.width,
                        height: Get.width * 0.25,
                        indicatorColor: ColorResources.COLOR_3B71CA,
                        indicatorBackgroundColor:
                            ColorResources.COLOR_3B71CA.withOpacity(0.3),
                        autoPlayInterval: 5000,
                        isLoop: true,
                        indicatorBottomPadding: 10.r,
                        children: [
                          ...List.generate(
                            controller.banners.length,
                            (index) => InkWell(
                              onTap: () async {
                                if (controller.banners[index].link == null) {
                                  return;
                                }
                                final Uri _url =
                                    Uri.parse(controller.banners[index].link!);

                                if (await canLaunchUrl(_url)) {
                                  await launchUrl(_url);
                                } else {
                                  IZIAlert()
                                      .error(message: '${'home_110'.tr} $_url');
                                }
                              },
                              child: IZIImage(
                                controller.banners[index].image ?? '',
                                width: Get.width,
                                height: Get.width * 0.22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
        SizedBox(
          height: Get.width * 0.4 * 1.45,
          child: Obx(
            () => controller.isLoadingSavingFocus
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return const ItemSavingFocusLoading();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                  )
                : SmartRefresher(
                    controller: controller.refreshControllerSavingFocus,
                    onLoading: () {
                      controller.getSavingFocus(isLoadMore: true);
                    },
                    enablePullUp: controller.isLoadMoreSavingFocus,
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
                      itemCount: controller.listSavingFocus.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemSavingFocus(
                          product: controller.listSavingFocus[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                    ),
                  ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget _buildNewPoint() {
    return Column(
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
                child: Text(
                  'home_014'.tr,
                  style: AppText.text16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.COLOR_464647,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.SEARCH, arguments: {
                    'filterSort': FilterSortModel(
                        id: 2, name: 'search_012'.tr, type: NEW),
                  });
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
          height: Get.width * 0.4 * 1.4,
          child: Obx(
            () => controller.isLoadingNewPoint
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return const ItemNewPointLoading();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                  )
                : SmartRefresher(
                    controller: controller.refreshControllerNewPoint,
                    onLoading: () {
                      controller.getNewPoint(isLoadMore: true);
                    },
                    enablePullUp: controller.isLoadMoreNewPoint,
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
                      itemCount: controller.listNewPoint.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemNewPoint(
                          product: controller.listNewPoint[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                    ),
                  ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget _buildForYou() {
    return Column(
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
                child: Text(
                  'home_015'.tr,
                  style: AppText.text16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.COLOR_464647,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.SEARCH, arguments: {
                    'filterSort': FilterSortModel(
                        id: 5, name: 'search_015'.tr, type: FOR_YOU),
                  });
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
          height: Get.width * 0.4 * 1.35,
          child: Obx(
            () => controller.isLoadingForYou
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return const ItemForYouLoading();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                  )
                : SmartRefresher(
                    controller: controller.refreshControllerForYou,
                    onLoading: () {
                      controller.getForYou(isLoadMore: true);
                    },
                    enablePullUp: controller.isLoadMoreForYou,
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
                      itemCount: controller.listForYou.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemForYou(
                          product: controller.listForYou[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                    ),
                  ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget _buildProducts() {
    return Container(
      color: ColorResources.BACK_GROUND_2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 10.h,
              left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Text(
              'home_011'.tr,
              style: AppText.text16.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.COLOR_464647,
              ),
            ),
          ),
          Obx(
            () => controller.isLoadingProduct
                ? GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 5,
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
                      return ItemProduct(
                        product: controller.listProduct[index],
                      );
                    },
                  ),
          ),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff5C91F7).withOpacity(0.84),
                const Color(0xff2A65FC).withOpacity(0.83),
              ],
            ),
          ),
          padding: EdgeInsets.only(
            left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            bottom: IZISizeUtil.SPACE_4X.h,
            top:
                IZISizeUtil.SPACE_5X.h + MediaQuery.of(context).viewPadding.top,
          ),
          margin: EdgeInsets.only(bottom: 27.h),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => controller.user.id != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: controller.user.avatar ?? '',
                              fadeOutDuration: Duration.zero,
                              fadeInDuration: Duration.zero,
                              width: 50.r,
                              height: 50.r,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: ColorResources.COLOR_C8C8C8,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 28.sp,
                                  ),
                                );
                              },
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: controller.user.avatar ?? '',
                              fadeOutDuration: Duration.zero,
                              fadeInDuration: Duration.zero,
                              width: 50.r,
                              height: 50.r,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  ImagesPath.logoApp,
                                  fit: BoxFit.cover,
                                  width: 50.r,
                                  height: 50.r,
                                );
                              },
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'hello'.tr,
                            style: AppText.text12.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Obx(
                            () => Text(
                              controller.user.fullName ?? 'Nail Supply',
                              style: AppText.text12.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
                        Get.dialog(
                          DialogLogin(onLogin: () {
                            Get.toNamed(AuthRouters.LOGIN);
                          }),
                        );
                        return;
                      }
                      controller.updateCountNotification();
                      Get.toNamed(AppRoute.NOTIFICATION);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Obx(
                      () => Container(
                        width: 35.r,
                        height: 35.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorResources.COLOR_F2F0F0.withOpacity(0.4),
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Image.asset(
                              ImagesPath.icNotification,
                              width: 18.r,
                              height: 22.r,
                              color: Colors.white,
                            ),
                            if (controller.countNotification != 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 7.r,
                                  height: 7.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: ColorResources.COLOR_FF0000,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
        Positioned(
          bottom: 4,
          left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          child: InkWell(
            onTap: () {
              Get.toNamed(
                AppRoute.SEARCH,
                arguments: {'isFocus': true},
              );
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: Get.width,
              height: 48.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    )
                  ]),
              padding: EdgeInsets.only(left: 6.w),
              child: Row(
                children: [
                  Image.asset(
                    ImagesPath.icSearch,
                    width: 22.r,
                    height: 22.r,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'home_001'.tr,
                        style: AppText.text12
                            .copyWith(color: ColorResources.COLOR_B1B1B1),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoute.SEARCH_IMAGE);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 22.r + 12.w,
                      height: 48.h,
                      child: Image.asset(
                        ImagesPath.icCameraBlue,
                        width: 22.r,
                        height: 22.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductGroup() {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Text(
              'home_009'.tr,
              style: AppText.text16.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.COLOR_464647,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              ),
              child: Row(
                children: [
                  ...List.generate(LookUpData.typeProduct.length, (index) {
                    final item = LookUpData.typeProduct[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          right: index < LookUpData.typeProduct.length - 1
                              ? 40
                              : 0),
                      child: ItemProductGroup(
                        title: item.title,
                        icon: item.icon,
                        callBack: () {
                          Get.toNamed(AppRoute.SEARCH, arguments: {
                            'filterGroupProduct': item,
                          });
                        },
                      ),
                    );
                  }),
                  // ItemProductGroup(
                  //   title: 'home_002'.tr,
                  //   icon: ImagesPath.icPaint,
                  //   callBack: () {
                  //     Get.toNamed(AppRoute.SEARCH, arguments: {
                  //       'filterGroupProduct': FilterGroupProductModel(
                  //           id: 2, name: 'search_019'.tr, type: PAINT),
                  //     });
                  //   },
                  // ),
                  // ItemProductGroup(
                  //   title: 'home_003'.tr,
                  //   icon: ImagesPath.icMachines,
                  //   callBack: () {
                  //     Get.toNamed(AppRoute.SEARCH, arguments: {
                  //       'filterGroupProduct': FilterGroupProductModel(
                  //           id: 3, name: 'search_020'.tr, type: MACHINERY),
                  //     });
                  //   },
                  // ),
                  // ItemProductGroup(
                  //   title: 'home_004'.tr,
                  //   icon: ImagesPath.icDevice,
                  //   callBack: () {
                  //     Get.toNamed(AppRoute.SEARCH, arguments: {
                  //       'filterGroupProduct': FilterGroupProductModel(
                  //           id: 4, name: 'search_021'.tr, type: EQUIPMENT),
                  //     });
                  //   },
                  // ),
                  // ItemProductGroup(
                  //   title: 'home_005'.tr,
                  //   icon: ImagesPath.icOther,
                  //   callBack: () {
                  //     Get.toNamed(AppRoute.SEARCH, arguments: {
                  //       'filterGroupProduct': FilterGroupProductModel(
                  //           id: 5, name: 'search_022'.tr, type: OTHER_TYPE),
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeAction() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        vertical: 12.h,
      ),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          const Spacer(),
          ItemHomeAction(
            title: 'home_007'.tr,
            icon: ImagesPath.icProductHome,
            callBack: () {
              controller.onChangeCurrentAction(0);
            },
            isSelected: controller.currentAction == 0,
          ),
          const Spacer(),
          ItemHomeAction(
            title: 'home_008'.tr,
            icon: ImagesPath.icSupplierHome,
            callBack: () {
              controller.onChangeCurrentAction(1);
            },
            isSelected: controller.currentAction == 1,
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildContentProvider() {
    return Obx(
      () => SmartRefresher(
        controller: controller.refreshControllerProvider,
        scrollController: controller.scrollControllerProvider,
        onLoading: () {
          controller.getProvider(isLoadMore: true);
        },
        enablePullUp: controller.isLoadMoreProvider,
        onRefresh: () {
          controller.initProvider();
        },
        header: Platform.isAndroid
            ? const MaterialClassicHeader(color: ColorResources.COLOR_3B71CA)
            : null,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => _buildHomeAction()),
              Container(
                height: 5.h,
                width: Get.width,
                color: ColorResources.BACK_GROUND_2,
              ),
              if (controller.listBestSeller.isNotEmpty ||
                  controller.isLoadingBestSeller)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBestSellerProduct(),
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                  ],
                ),
              if (controller.listLeadingProvider.isNotEmpty ||
                  controller.isLoadingLeadingProvider)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeadingProvider(),
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                  ],
                ),
              if (controller.listNews.isNotEmpty || controller.isLoadMoreNews)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNews(),
                    Container(
                      height: 5.h,
                      width: Get.width,
                      color: ColorResources.BACK_GROUND_2,
                    ),
                  ],
                ),
              if (controller.listProvider.isNotEmpty ||
                  controller.isLoadingProvider)
                _buildListProvider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBestSellerProduct() {
    return Column(
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
                      text: 'home_019'.tr,
                      style: AppText.text16.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorResources.COLOR_1255B9,
                      ),
                    ),
                    WidgetSpan(
                      child: Image.asset(
                        ImagesPath.icBest,
                        width: 23.w,
                        height: 23.w,
                      ),
                    ),
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.SEARCH, arguments: {
                    'filterSort': FilterSortModel(
                        id: 6, name: 'search_016'.tr, type: HOT_SELL),
                  });
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
            () => controller.isLoadingBestSeller
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return const ItemBestSellerLoading();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                  )
                : SmartRefresher(
                    controller: controller.refreshControllerBestSeller,
                    onLoading: () {
                      controller.getBestSeller(isLoadMore: true);
                    },
                    enablePullUp: controller.isLoadMoreBestSeller,
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
                      itemCount: controller.listBestSeller.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (controller.listBestSeller[index].totalSold == 0) {
                          return const SizedBox();
                        }
                        return ItemBestSeller(
                          product: controller.listBestSeller[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        if (controller.listBestSeller[index].totalSold == 0) {
                          return const SizedBox();
                        }
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                    ),
                  ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget _buildLeadingProvider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 13.h,
            bottom: 15.h,
            left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home_017'.tr,
                style: AppText.text16.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.COLOR_464647,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(AppRoute.LEADING_PROVIDER),
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
          height: Get.width * 0.55 * 0.33,
          child: Obx(
            () => controller.isLoadingLeadingProvider
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return const ItemLeadingProviderLoading();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 10.w);
                    },
                  )
                : SmartRefresher(
                    controller: controller.refreshControllerLeadingProvider,
                    onLoading: () {
                      controller.getLeadingProvider(isLoadMore: true);
                    },
                    enablePullUp: controller.isLoadMoreLeadingProvider,
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
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.listLeadingProvider.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemLeadingProvider(
                            provider: controller.listLeadingProvider[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10.w);
                      },
                    ),
                  ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 13.h,
            bottom: 15.h,
            left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
          child: Text(
            'home_016'.tr,
            style: AppText.text16.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorResources.COLOR_464647,
            ),
          ),
        ),
        SizedBox(
          height: Get.width * 0.65 * 0.468,
          child: Obx(
            () => controller.isLoadingNews
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: IZIImage(
                          '',
                          width: Get.width * 0.65,
                          height: Get.width * 0.65 * 0.468,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 10.w);
                    },
                  )
                : SmartRefresher(
                    controller: controller.refreshControllerNews,
                    onLoading: () {
                      controller.getNews(isLoadMore: true);
                    },
                    enablePullUp: controller.isLoadMoreNews,
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
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.listNews.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: IZIImage(
                            controller.listNews[index].thumbnail ?? '',
                            width: Get.width * 0.65,
                            height: Get.width * 0.65 * 0.468,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10.w);
                      },
                    ),
                  ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildListProvider() {
    return Obx(
      () => controller.isLoadingProvider
          ? ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: 10,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return const ItemProviderLoading();
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 5.h,
                  width: Get.width,
                  color: ColorResources.BACK_GROUND_2,
                );
              },
            )
          : ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.listProvider.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.DETAIL_PROVIDER,
                      arguments: controller.listProvider[index].id),
                  child: ItemProvider(
                    provider: controller.listProvider[index],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 5.h,
                  width: Get.width,
                  color: ColorResources.BACK_GROUND_2,
                );
              },
            ),
    );
  }
}
