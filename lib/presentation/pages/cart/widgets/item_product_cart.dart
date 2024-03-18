import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/presentation/pages/cart/widgets/bottom_type_product.dart';

class ItemProductCart extends StatelessWidget {
  final ProductModel product;
  final String idStore;
  final ProductCartModel productCart;
  final Function() onIncrease;
  final Function() onReduce;
  final Function() onSelect;
  final Function() onRemove;
  final Function(OptionProductModel, int) onChangeType;

  const ItemProductCart({
    super.key,
    required this.product,
    required this.onIncrease,
    required this.onReduce,
    required this.onSelect,
    required this.onRemove,
    required this.productCart,
    required this.onChangeType,
    required this.idStore,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRoute.DETAIL_PRODUCT, arguments: {
          "productId": product.id,
          "providerId": idStore,
        });
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: productCart.checked,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(color: ColorResources.COLOR_A4A2A2),
                  onChanged: (value) {
                    onSelect();
                  },
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return ColorResources.COLOR_0095E9;
                    }
                    return Colors.white;
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: IZIImage(
                      productCart.idOptionProduct?.thumbnail ?? '',
                      width: 75.w,
                      height: 75.w,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 75.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16.sp),
                              child: Text(
                                product.title,
                                style: AppText.text14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.COLOR_464647,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(5.r),
                              onTap: () {
                                Get.bottomSheet(
                                  BottomTypeProduct(
                                    product: product,
                                    callBackType: (type, quantity) {
                                      onChangeType(type, quantity);
                                    },
                                    initOptionProduct: productCart.idOptionProduct!,
                                    initQuantity: productCart.quantity,
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: Get.width * 0.35,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: ColorResources.COLOR_EDEDED,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${'cart_016'.tr}: ${productCart.idOptionProduct?.title}',
                                        style: AppText.text10
                                            .copyWith(color: ColorResources.COLOR_8A92A6),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 18.sp,
                                      color: ColorResources.COLOR_8A92A6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                if (productCart.idOptionProduct!.isShowBothPrice)
                                  Row(
                                    children: [
                                      Text(
                                        '\$ ${productCart.idOptionProduct?.originPrice}',
                                        style: AppText.text12.copyWith(
                                          color: ColorResources.COLOR_B1B1B1,
                                          decoration: TextDecoration.lineThrough,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                    ],
                                  ),
                                if (productCart.idOptionProduct!.isShowBothPrice)
                                  Text(
                                    '\$ ${productCart.idOptionProduct?.price}',
                                    style: AppText.text16.copyWith(
                                      color: ColorResources.COLOR_EB0F0F,
                                      height: 1,
                                    ),
                                  )
                                else
                                  Text(
                                    '\$ ${productCart.idOptionProduct?.originPrice}',
                                    style: AppText.text16.copyWith(
                                      color: ColorResources.COLOR_EB0F0F,
                                      height: 1,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        height: 25.r,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (productCart.quantity > 0) {
                                  onReduce();
                                }
                              },
                              child: Container(
                                height: 25.r,
                                width: 25.r,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      width: 0.6,
                                      color: ColorResources.COLOR_CFCECE
                                          .withOpacity(0.7),
                                    ),
                                    left: BorderSide(
                                      width: 0.6,
                                      color: ColorResources.COLOR_CFCECE
                                          .withOpacity(0.7),
                                    ),
                                    bottom: BorderSide(
                                      width: 0.6,
                                      color: ColorResources.COLOR_CFCECE
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: ColorResources.COLOR_0095E9,
                                ),
                              ),
                            ),
                            Container(
                              height: 25.r,
                              padding: EdgeInsets.symmetric(horizontal: 12.r),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.6,
                                  color: ColorResources.COLOR_CFCECE.withOpacity(0.7),
                                ),
                              ),
                              child: Text(
                                productCart.quantity.toString(),
                                style: AppText.text10.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: ColorResources.COLOR_3B71CA,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (productCart.idOptionProduct != null &&
                                    (productCart.idOptionProduct!.quantity >
                                        productCart.quantity)) {
                                  onIncrease();
                                }
                              },
                              child: Container(
                                height: 25.r,
                                width: 25.r,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      width: 0.6,
                                      color: ColorResources.COLOR_CFCECE
                                          .withOpacity(0.7),
                                    ),
                                    right: BorderSide(
                                      width: 0.6,
                                      color: ColorResources.COLOR_CFCECE
                                          .withOpacity(0.7),
                                    ),
                                    bottom: BorderSide(
                                      width: 0.6,
                                      color: ColorResources.COLOR_CFCECE
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: ColorResources.COLOR_0095E9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8.h - 6,
            right: 14.w - 4,
            child: IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () {
                onRemove();
              },
              icon: Icon(
                Icons.clear,
                color: ColorResources.COLOR_A4A2A2,
                size: 18.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
