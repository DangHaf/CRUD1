import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/presentation/pages/home/widgets/voucher_custom.dart';

class ItemProduct extends StatelessWidget {
  final ProductModel product;
  final Function()? onRemoveItem;
  final Function()? navigate;

  const ItemProduct({
    super.key,
    required this.product,
    this.onRemoveItem,
    this.navigate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if(navigate != null){
          navigate!();
          return;
        }
        final res = await Get.toNamed(AppRoute.DETAIL_PRODUCT, arguments: {
          "productId": product.id,
          "providerId": product.idStore?.id
        });
        if (res != null && onRemoveItem != null) {
          final data = res as bool;
          if (!data) {
            onRemoveItem!();
          }
          try {} catch (_) {}
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.white,
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
                  width: Get.width,
                  height: Get.height,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9.w, horizontal: 7.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            maxLines: product.discount != null ? 1 : 2,
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                product.titleSold,
                                style: AppText.text10
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.w)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemProductLoading extends StatelessWidget {
  const ItemProductLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Colors.white,
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
                width: Get.width,
                height: Get.height,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 9.w, horizontal: 7.w),
                    child: Shimmer.fromColors(
                      baseColor: ColorResources.NEUTRALS_6,
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width,
                            height: 12.sp,
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
                SizedBox(height: 5.w)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
