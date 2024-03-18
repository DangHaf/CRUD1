import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/data/model/cart/cart_model.dart';

class ItemCartPayment extends StatelessWidget {
  final CartModel cart;
  final Function() callBackVoucher;

  const ItemCartPayment({
    super.key,
    required this.cart,
    required this.callBackVoucher,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            vertical: 12.h,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Image.asset(
                  ImagesPath.icProvider,
                  width: 20.r,
                  height: 20.r,
                ),
              ),
              Flexible(
                child: Text(
                  cart.idStore?.name ?? '',
                  style: AppText.text14.copyWith(
                    color: ColorResources.COLOR_464647,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          color: ColorResources.COLOR_A4A2A2,
          thickness: 0.4.h,
        ),
        Container(
          color: Colors.white,
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 7.h, bottom: 10.h),
            itemCount: cart.products.length,
            itemBuilder: (BuildContext context, int index) {
              if (!cart.products[index].checked) {
                return const SizedBox();
              }
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: IZIImage(
                        cart.products[index].idOptionProduct?.thumbnail ?? '',
                        width: 75.w,
                        height: 65.w,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: SizedBox(
                        height: 65.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cart.products[index].idProduct?.title ?? '',
                              style: AppText.text14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.COLOR_464647),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${'cart_016'.tr}: ${cart.products[index].idOptionProduct?.title}',
                              style: AppText.text14
                                  .copyWith(color: ColorResources.COLOR_A4A2A2),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$ ${cart.products[index].idOptionProduct!.priceUse.price}',
                                  style: AppText.text16.copyWith(
                                    color: ColorResources.COLOR_EB0F0F,
                                  ),
                                ),
                                Text(
                                  'x${cart.products[index].quantity}',
                                  style: AppText.text16.copyWith(
                                    color: ColorResources.COLOR_A4A2A2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              if (!cart.products[index].checked) {
                return const SizedBox();
              }
              return SizedBox(height: 4.h);
            },
          ),
        ),
        Divider(
          height: 0,
          color: ColorResources.COLOR_A4A2A2,
          thickness: 0.4.h,
        ),
        InkWell(
          onTap: callBackVoucher,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
            ),
            child: Row(
              children: [
                Image.asset(
                  ImagesPath.icVoucherCart,
                  width: 20.r,
                  height: 20.r,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'cart_002'.tr,
                      style: AppText.text14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorResources.COLOR_464647,
                      ),
                    ),
                  ),
                ),
                if (cart.idVoucher != null)
                  Text(
                    'cart_022'.tr,
                    style: AppText.text12.copyWith(
                      color: ColorResources.COLOR_1ECF0F,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: ColorResources.COLOR_A4A2A2,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          color: ColorResources.COLOR_A4A2A2,
          thickness: 0.4.h,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
          ),
          child: Row(
            children: [
              Image.asset(
                ImagesPath.icTotalPriceProduct,
                width: 20.r,
                height: 20.r,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    cart.stringQuantity,
                    style: AppText.text14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorResources.COLOR_464647,
                    ),
                  ),
                ),
              ),
              Text(
                '\$${cart.totalProductMoney.price}',
                style: AppText.text14.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorResources.COLOR_CE1818,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
