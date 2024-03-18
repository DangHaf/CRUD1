import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/config/routes/route_path/auth_routers.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/presentation/pages/comment/widgets/comment_product_item.dart';
import 'package:template/presentation/pages/dash_board/dash_board_controller.dart';
import 'package:template/presentation/pages/home/widgets/dialog_login.dart';
import 'package:template/presentation/pages/home/widgets/item_product.dart';
import 'package:template/presentation/pages/home/widgets/voucher_custom.dart';
import 'package:template/presentation/pages/product/product_detail_controller.dart';
import 'package:template/presentation/pages/product/widgets/bottom_type_product_detail.dart';
import 'package:template/presentation/pages/product/widgets/carousel_cover_image.dart';
import 'package:template/presentation/pages/product/widgets/description_html.dart';
import 'package:template/presentation/pages/product/widgets/evaluation_widget.dart';
import 'package:template/presentation/pages/product/widgets/item_little_product.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.ignoring.value,
        child: WillPopScope(
          onWillPop: () async {
            Get.back(result: controller.product.isLike);
            return true;
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: ColorResources.BACK_GROUND_2,
            appBar: _buildAppBar(),
            body: _buildBody(),
            bottomNavigationBar: _buildNavigationBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () => controller.initData(isRefresh: true),
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              _buildImage(),
              _buildOverviewProduct(),
              SizedBox(height: 5.h),
              _buildVoucher(),
              _buildProvider(),
              SizedBox(height: 10.h),
              DescriptionHtml(
                title: 'product_detail_004'.tr,
                description: controller.product.description,
                isLoading: controller.isLoading,
              ),
              SizedBox(height: 10.h),
              if (!controller.isLoadingRate && controller.comments.isNotEmpty)
                _buildListReview(),
              _buildSuggestProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListReview() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              await Get.toNamed(AppRoute.COMMENT_PRODUCT,
                  arguments: controller.productId);
              controller.getReview(isRefresh: true);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'product_detail_007'.tr,
                        style: AppText.text16.copyWith(
                          color: ColorResources.COLOR_464647,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'product_detail_008'.tr,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_3B71CA,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      EvaluationWidget(
                          rate: controller.product.averagePoint.toDouble()),
                      SizedBox(width: 10.w),
                      Text(
                        controller.product.averagePoint.averagePoint,
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_3B71CA,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 0.5,
                        height: 15,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        color: ColorResources.COLOR_A4A2A2,
                      ),
                      Text(
                        '${controller.product.totalRate} ${'product_detail_009'.tr}',
                        style: AppText.text12.copyWith(
                          color: ColorResources.COLOR_464647,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0.3,
            height: 0,
            color: ColorResources.COLOR_A4A2A2.withOpacity(0.5),
          ),
          ListView.separated(
            itemCount: controller.itemReview,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              if (controller.isLoadingRate) {
                return const CommentProductItemLoading();
              }
              return CommentProductItem(
                comment: controller.comments[index],
                onTapLike: () {
                  controller.onTapLike(comment: controller.comments[index]);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 0.3,
                height: 0,
                color: ColorResources.COLOR_A4A2A2.withOpacity(0.5),
              );
            },
          ),
          Divider(
            thickness: 0.3,
            height: 0,
            color: ColorResources.COLOR_A4A2A2.withOpacity(0.5),
          ),
          SizedBox(height: 6.h),
          InkWell(
            onTap: () async {
              await Get.toNamed(AppRoute.COMMENT_PRODUCT,
                  arguments: controller.productId);
              controller.getReview(isRefresh: true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'product_detail_008'.tr,
                  style: AppText.text12.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorResources.COLOR_0095E9,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorResources.COLOR_0095E9,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewProduct() {
    if (controller.isLoading) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
        ),
        child: Shimmer.fromColors(
          baseColor: ColorResources.NEUTRALS_6,
          highlightColor: Colors.grey.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                ),
                child: Container(
                  width: Get.width * 0.4,
                  height: 15.sp,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 13.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListProductCode(),
                  SizedBox(height: 15.h),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
                child: Container(
                  width: Get.width * 0.4,
                  height: 20.sp,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
                child: Container(
                  width: Get.width * 0.4,
                  height: 12.sp,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME - 4,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_sharp,
                      color: ColorResources.COLOR_FFD600,
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: Get.width * 0.4,
                      height: 12.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Text(
              controller.title,
              style: AppText.text15.copyWith(
                fontWeight: FontWeight.w400,
                color: ColorResources.TEXT_BOLD,
              ),
            ),
          ),
          SizedBox(height: 13.h),
          if (controller.product.idOptionProducts.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildListProductCode(),
                SizedBox(height: 15.h),
              ],
            ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
            child: Text(
              controller.product.title,
              style: AppText.text20.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.COLOR_464647),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
            child: _buildPrice(),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME - 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star_sharp,
                      color: ColorResources.COLOR_FFD600,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      controller.product.averagePoint.averagePoint,
                      style: AppText.text12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorResources.COLOR_464647,
                      ),
                    ),
                    Container(
                      width: 0.5,
                      height: 15,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      color: ColorResources.COLOR_A4A2A2,
                    ),
                    Text(
                      controller.product.titleSold,
                      style: AppText.text12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorResources.COLOR_464647,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.onChangeIsLikedProduct();
                    },
                    child: controller.product.isLike
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
          )
        ],
      ),
    );
  }

  Widget _buildPrice() {
    if (controller.product.idOptionProducts.isNotEmpty &&
        controller.optionProduct != null) {
      return Row(
        children: [
          if (controller.optionProduct!.isShowBothPrice)
            Row(
              children: [
                Text(
                  '\$ ${controller.optionProduct!.originPrice.price}',
                  style: AppText.text12.copyWith(
                    color: ColorResources.COLOR_B1B1B1,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 4.w),
              ],
            ),
          if (controller.optionProduct!.isShowBothPrice)
            Text(
              '\$ ${controller.optionProduct!.price!.price}',
              style: AppText.text16.copyWith(
                color: ColorResources.COLOR_EB0F0F,
              ),
            )
          else
            Text(
              '\$ ${controller.optionProduct!.originPrice.price}',
              style: AppText.text16.copyWith(
                color: ColorResources.COLOR_EB0F0F,
              ),
            ),
        ],
      );
    }
    return Row(
      children: [
        if (controller.product.isShowBothPrice)
          Row(
            children: [
              Text(
                '\$ ${controller.product.originPrice.price}',
                style: AppText.text12.copyWith(
                  color: ColorResources.COLOR_B1B1B1,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 4.w),
            ],
          ),
        if (controller.product.isShowBothPrice)
          Text(
            '\$ ${controller.product.price!.price}',
            style: AppText.text16.copyWith(
              color: ColorResources.COLOR_EB0F0F,
            ),
          )
        else
          Text(
            '\$ ${controller.product.originPrice.price}',
            style: AppText.text16.copyWith(
              color: ColorResources.COLOR_EB0F0F,
            ),
          ),
      ],
    );
  }

  Widget _buildImage() {
    if (controller.isLoading) {
      return IZIImage(
        '',
        width: Get.width,
        height: Get.width * 0.7,
      );
    }
    return controller.product.idOptionProducts.isNotEmpty
        ? CarouselCoverImage(
            callBackIndex: (index) {
              controller.onChangeIndex(index);
            },
            productModel: controller.product,
            currentIndex: controller.currentIndex,
            controller: controller.carouselController,
          )
        : IZIImage(
            controller.product.thumbnail ?? '',
            width: Get.width,
            height: Get.width * 0.7,
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
                    Get.back(result: controller.product.isLike);
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
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Get.back();
                Get.find<DashBoardController>().onChangeDashboardPage(index: 1);
              },
              child: Center(
                child: Stack(
                  children: [
                    SizedBox(
                      width: 40.r,
                      height: 40.r,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.popUntil(
                            Get.context!,
                            (route) =>
                                route.settings.name == AuthRouters.DASH_BOARD,
                          );
                          Get.find<DashBoardController>()
                              .onChangeDashboardPage(index: 1);
                        },
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          ImagesPath.icCart,
                          color: ColorResources.COLOR_1255B9,
                          fit: BoxFit.scaleDown,
                          height: 28.r,
                          width: 28.r,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4.r,
                      right: 0,
                      child: Obx(
                        () => controller.countCart.value == 0
                            ? const SizedBox()
                            : Container(
                                decoration: BoxDecoration(
                                  color: ColorResources.RED,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                child: Text(
                                  controller.countCart.value > 9
                                      ? '9+'
                                      : controller.countCart.value.toString(),
                                  style: AppText.text9.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.WHITE,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
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

  Widget _buildListProductCode() {
    if (controller.isLoading) {
      return SizedBox(
        height: 80.w,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: IZIImage(
                '',
                height: 80.w,
                width: 80.w,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(width: 8.w),
        ),
      );
    }
    if (controller.product.idOptionProducts.isNotEmpty) {
      return SizedBox(
        height: 80.w,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
          itemCount: controller.product.idOptionProducts.length,
          itemBuilder: (BuildContext context, int index) => ItemLittleProduct(
            isSelected: index == controller.currentIndexOption,
            image: controller.product.idOptionProducts[index].images.isEmpty
                ? ''
                : controller.product.idOptionProducts[index].images.first,
            onTap: () {
              controller
                  .onChangeIndex(controller.product.images.length + index);
            },
          ),
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(width: 8.w),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildVoucher() {
    if (controller.isLoading) {
      Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          vertical: 15.h,
        ),
        child: Text(
          'product_detail_003'.tr,
          style: AppText.text16.copyWith(
            color: ColorResources.COLOR_464647,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    if (controller.vouchers.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => controller.navigateVoucher(),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                vertical: 15.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'product_detail_003'.tr,
                    style: AppText.text16.copyWith(
                      color: ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          controller.vouchers.length >
                                  controller.maximumVouchersShowed
                              ? controller.maximumVouchersShowed
                              : controller.vouchers.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: CustomPaint(
                              painter: VoucherCustom(
                                color: ColorResources.COLOR_CE1818,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 3.w),
                                child: Text(
                                  '${'voucher_009'.tr}: ${controller.vouchers[index].disCount}',
                                  style: AppText.text8.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: ColorResources.COLOR_A4A2A2,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildProvider() {
    if (controller.isLoading) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 8.h,
          bottom: 10.h,
          left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Shimmer.fromColors(
          baseColor: ColorResources.NEUTRALS_6,
          highlightColor: Colors.grey.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: IZIImage(
                      '',
                      width: 36.w,
                      height: 36.w,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width * 0.4,
                          height: 14.sp,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          width: Get.width * 0.4,
                          height: 12.sp,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  SizedBox(
                    width: 9.w,
                    height: 9.w,
                    child: Image.asset(ImagesPath.icLocationBlue),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Container(
                      width: Get.width * 0.6,
                      height: 10.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  SizedBox(
                    width: 9.w,
                    height: 9.w,
                    child: Image.asset(ImagesPath.icPhoneContact),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Container(
                      width: Get.width * 0.3,
                      height: 10.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
    return InkWell(
      onTap: () {
        Get.back();
        Get.toNamed(AppRoute.DETAIL_PROVIDER, arguments: controller.providerId);
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 8.h,
          bottom: 10.h,
          left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: IZIImage(
                      controller.provider.thumbnail ?? '',
                      width: 36.w,
                      height: 36.w,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.provider.name ?? '',
                          style: AppText.text14.copyWith(
                            color: ColorResources.COLOR_181313,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          controller.provider.contact,
                          style: AppText.text12.copyWith(
                            color: ColorResources.COLOR_464647,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  SizedBox(
                    width: 9.w,
                    height: 9.w,
                    child: Image.asset(ImagesPath.icLocationBlue),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      controller.provider.addressWithCityState,
                      style: AppText.text10
                          .copyWith(color: ColorResources.COLOR_535354),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  SizedBox(
                    width: 9.w,
                    height: 9.w,
                    child: Image.asset(ImagesPath.icPhoneContact),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      controller.provider.businessPhone ?? '',
                      style: AppText.text10
                          .copyWith(color: ColorResources.COLOR_30BB1A),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestProducts() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: IZISizeUtil.SPACE_3X,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.SPACE_3X),
                child: Text(
                  'product_detail_012'.tr,
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
                    return ItemProduct(
                      product: controller.listProduct[index],
                      navigate: () {
                        controller.onRefreshWithNewData(
                            controller.listProduct[index].id!,
                            controller.listProduct[index].idStore!.id!);
                      },
                    );
                  },
                ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: ColorResources.COLOR_B1B1B1.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, -1)),
      ]),
      height: 55.h,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
                  Get.dialog(
                    DialogLogin(onLogin: () {
                      Get.toNamed(
                        AuthRouters.LOGIN,
                        arguments: {'route': AppRoute.DETAIL_PRODUCT},
                      );
                    }),
                  );
                  return;
                }
                Get.bottomSheet(
                  BottomTypeProductDetail(
                    product: controller.product,
                    type: TypeBottomProduct.CART,
                    callBackAddCart: (cartRequest) {
                      controller.addCart(cartRequest);
                    },
                    callBackBuyNow: (listCart) {},
                    optionProduct: controller.optionProduct,
                  ),
                  isScrollControlled: true,
                );
              },
              child: Container(
                color: ColorResources.WHITE,
                child: Center(
                  child: Image.asset(
                    ImagesPath.icCart,
                    color: ColorResources.COLOR_3B71CA,
                    fit: BoxFit.scaleDown,
                    height: 28.w,
                    width: 28.w,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (sl<SharedPreferenceHelper>().getIdUser.isEmpty) {
                  Get.dialog(
                    DialogLogin(onLogin: () {
                      Get.toNamed(
                        AuthRouters.LOGIN,
                        arguments: {'route': AppRoute.DETAIL_PRODUCT},
                      );
                    }),
                  );
                  return;
                }
                Get.bottomSheet(
                  BottomTypeProductDetail(
                    product: controller.product,
                    type: TypeBottomProduct.BUY_NOW,
                    callBackAddCart: (cartRequest) {},
                    optionProduct: controller.optionProduct,
                    callBackBuyNow: (listCart) {
                      controller.checkPayment(listCart);
                    },
                  ),
                  isScrollControlled: true,
                );
              },
              child: Container(
                color: ColorResources.COLOR_3B71CA,
                child: Center(
                  child: Text(
                    'product_detail_011'.tr,
                    style: AppText.text14.copyWith(
                      color: ColorResources.WHITE,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
