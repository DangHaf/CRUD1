import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/data/model/provider/provider_model.dart';
import 'package:template/presentation/pages/home/widgets/voucher_custom.dart';

class ItemProvider extends StatelessWidget {
  final ProviderModel provider;

  const ItemProvider({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoute.DETAIL_PROVIDER, arguments: provider.id);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 10.h,
              left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: IZIImage(
                        provider.thumbnail ?? '',
                        width: 36.w,
                        height: 36.w,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  provider.name ?? '',
                                  style: AppText.text14.copyWith(
                                    color: ColorResources.COLOR_181313,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  'home_018'.tr,
                                  style: AppText.text12.copyWith(
                                    color: ColorResources.COLOR_3B71CA,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            provider.contact,
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
                      width: 12.w,
                      height: 12.w,
                      child: Image.asset(ImagesPath.icLocationBlue),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        provider.addressWithCityState,
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
                      width: 12.w,
                      height: 12.w,
                      child: Image.asset(ImagesPath.icPhoneContact),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        provider.businessPhone ?? '',
                        style: AppText.text10
                            .copyWith(color: ColorResources.COLOR_30BB1A),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (provider.products!.isNotEmpty)
            SizedBox(
              height: Get.width * 0.4 * 1.45,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                ),
                itemCount: provider.products!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return ItemProductProvider(
                    product: provider.products![index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
              ),
            ),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }
}

class ItemProductProvider extends StatelessWidget {
  final ProductModel product;

  const ItemProductProvider({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoute.DETAIL_PRODUCT, arguments: {
          "productId": product.id,
          "providerId": product.idStore?.id
        });
      },
      child: Container(
        height: Get.width * 0.4 * 1.45,
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: ColorResources.COLOR_AEACAC.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  topRight: Radius.circular(5.r),
                ),
                child: IZIImage(
                  product.thumbnail ?? '',
                  width: Get.width * 0.4,
                  height: Get.width * 0.4 * 1.26 * 3 / 5,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 7.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      maxLines: product.discount != null ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: product.title,
                          style: AppText.text12.copyWith(
                            color: ColorResources.COLOR_464647,
                          ),
                        ),
                        TextSpan(
                          text: ' \n',
                          style: AppText.text12.copyWith(
                            color: Colors.transparent,
                          ),
                        ),
                      ]),
                    ),
                    if (product.discount != null)
                      CustomPaint(
                        painter: VoucherCustom(
                          color: ColorResources.COLOR_CE1818,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.w),
                          child: Text(
                            product.discount!,
                            style: AppText.text8.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              if (product.isShowBothPrice)
                                Text(
                                  '\$ ${product.price}',
                                  style: AppText.text15.copyWith(
                                    color: ColorResources.COLOR_EB0F0F,
                                  ),
                                )
                              else
                                Text(
                                  '\$ ${product.originPrice}',
                                  style: AppText.text15.copyWith(
                                    color: ColorResources.COLOR_EB0F0F,
                                  ),
                                ),
                              SizedBox(width: 4.w),
                              if (product.isShowBothPrice)
                                Text(
                                  '\$ ${product.originPrice}',
                                  style: AppText.text10.copyWith(
                                    color: ColorResources.COLOR_B1B1B1,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          product.titleSold,
                          style: AppText.text10.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemProviderLoading extends StatelessWidget {
  const ItemProviderLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 8.h,
            bottom: 10.h,
            left: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            right: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Shimmer.fromColors(
                                baseColor: ColorResources.NEUTRALS_6,
                                highlightColor: Colors.grey.withOpacity(0.2),
                                child: Container(
                                  width: Get.width * 0.5,
                                  height: 14.sp,
                                  decoration: BoxDecoration(
                                    color: ColorResources.WHITE,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'home_018'.tr,
                                style: AppText.text12.copyWith(
                                  color: ColorResources.COLOR_3B71CA,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Shimmer.fromColors(
                          baseColor: ColorResources.NEUTRALS_6,
                          highlightColor: Colors.grey.withOpacity(0.2),
                          child: Container(
                            width: Get.width * 0.7,
                            height: 10.sp,
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius: BorderRadius.circular(8),
                            ),
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
                  Flexible(
                    child: Shimmer.fromColors(
                      baseColor: ColorResources.NEUTRALS_6,
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        width: Get.width * 0.3,
                        height: 8.sp,
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                  Flexible(
                    child: Shimmer.fromColors(
                      baseColor: ColorResources.NEUTRALS_6,
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        width: Get.width * 0.3,
                        height: 8.sp,
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: Get.width * 0.4 * 1.45,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return const ItemProductProviderLoading();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 10.w,
              );
            },
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }
}

class ItemProductProviderLoading extends StatelessWidget {
  const ItemProductProviderLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.4 * 1.45,
      width: Get.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: ColorResources.COLOR_AEACAC.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.r),
                topRight: Radius.circular(5.r),
              ),
              child: IZIImage(
                '',
                width: Get.width * 0.4,
                height: Get.width * 0.4 * 1.26 * 3 / 5,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 7.w),
              child: Shimmer.fromColors(
                baseColor: ColorResources.NEUTRALS_6,
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 26.sp,
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    CustomPaint(
                      painter: VoucherCustom(
                        color: ColorResources.COLOR_CE1818,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.w),
                        child: Text(
                          'Giảm 20%',
                          style: AppText.text8.copyWith(
                            color: Colors.transparent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: Get.width,
                            height: 14.sp,
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: Get.width * 0.15,
                          height: 10.sp,
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
