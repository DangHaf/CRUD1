import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/presentation/pages/cart/widgets/item_product_cart.dart';

class ItemCard extends StatelessWidget {
  final CartModel cart;
  final Function(bool) callBackCheckCart;
  final Function(int) onIncrease;
  final Function(int) onReduce;
  final Function(int) onSelect;
  final Function(int) onRemove;
  final Function(OptionProductModel, int, int) onChangeType;
  final Function() callBackVoucher;

  const ItemCard({
    super.key,
    required this.cart,
    required this.callBackCheckCart,
    required this.onIncrease,
    required this.onReduce,
    required this.onSelect,
    required this.onRemove,
    required this.onChangeType,
    required this.callBackVoucher,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoute.DETAIL_PROVIDER, arguments: cart.idStore?.id);
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
              vertical: 12.h,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: cart.isChecked,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(color: ColorResources.COLOR_A4A2A2),
                  onChanged: (value) {
                    callBackCheckCart(value!);
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
                  padding: EdgeInsets.only(left: 15.w, right: 5.w),
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
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: ColorResources.COLOR_A4A2A2,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          color: Colors.white,
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 7.h),
            itemCount: cart.products.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemProductCart(
                product: cart.products[index].idProduct!,
                idStore: cart.idStore!.id!,
                onIncrease: () => onIncrease(index),
                onReduce: () => onReduce(index),
                onRemove: () => onRemove(index),
                onSelect: () => onSelect(index),
                productCart: cart.products[index],
                onChangeType: (type, quantity) =>
                    onChangeType(type, quantity, index),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 4.h);
            },
          ),
        ),
        Divider(
          height: 0,
          color: ColorResources.COLOR_8A92A6,
          thickness: 0.3.h,
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
                if (cart.voucher != null)
                  Image.asset(
                    ImagesPath.icVoucherSelected,
                    width: 24.r,
                    height: 20.r,
                  )
                else
                  Image.asset(
                    ImagesPath.icVoucherCart,
                    width: 20.r,
                    height: 20.r,
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: cart.voucher != null ? 6.w : 8.w),
                    child: cart.voucher != null
                        ? Text(
                            'Voucher ${'voucher_009'.tr.toLowerCase()} ${cart.voucher?.disCount}',
                            style: AppText.text14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorResources.COLOR_0095E9,
                            ),
                          )
                        : Text(
                            'cart_002'.tr,
                            style: AppText.text14.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorResources.COLOR_464647,
                            ),
                          ),
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
      ],
    );
  }
}
