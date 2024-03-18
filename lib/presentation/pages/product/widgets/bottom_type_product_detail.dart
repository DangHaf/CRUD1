import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/data/model/cart/cart_model.dart';
import 'package:template/data/model/cart/cart_request.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/presentation/pages/product/widgets/item_little_product.dart';

class BottomTypeProductDetail extends StatefulWidget {
  final ProductModel product;
  final OptionProductModel? optionProduct;
  final TypeBottomProduct type;
  final Function(CartRequest) callBackAddCart;
  final Function(List<CartModel>) callBackBuyNow;

  const BottomTypeProductDetail({
    required this.product,
    required this.type,
    required this.callBackAddCart,
    required this.callBackBuyNow,
    this.optionProduct,
  });

  @override
  State<BottomTypeProductDetail> createState() =>
      _BottomTypeProductDetailState();
}

class _BottomTypeProductDetailState extends State<BottomTypeProductDetail> {
  int quantity = 0;
  OptionProductModel? optionProduct;

  @override
  void initState() {
    if (widget.product.groupType == 'ORDER' &&
        widget.product.idOptionProducts.isNotEmpty) {
      if (widget.product.idOptionProducts.first.stocking) {
        optionProduct = widget.product.idOptionProducts.first;
        quantity = widget.product.idOptionProducts.first.minQuantityBuy;
      }
    } else if (widget.product.idOptionProducts.isNotEmpty &&
        widget.optionProduct != null) {
      optionProduct = widget.product.idOptionProducts
          .firstWhere((_) => _.id == widget.optionProduct?.id);
      quantity = optionProduct?.minQuantityBuy ?? 1;
      try {} catch (_) {}
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: IZISizeUtil.PADDING_HORIZONTAL_HOME),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            color: ColorResources.WHITE,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: IZISizeUtil.SPACE_2X),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: IZIImage(
                          image,
                          height: 96.r,
                          width: 110.r,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IZIImage(
                                  ImagesPath.icClear,
                                  height: 20.w,
                                  width: 20.w,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: IZISizeUtil.SPACE_3X),
                              child: _buildPrice(),
                            ),
                            Text(
                              '${'product_detail_013'.tr}: $totalQuantity',
                              style: AppText.text14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorResources.COLOR_8A92A6,
                              ),
                            )
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: IZISizeUtil.SPACE_2X),
                height: 5.h,
                color: ColorResources.BACK_GROUND_2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'product_detail_001'.tr,
                      style: AppText.text14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.COLOR_464647,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                        widget.product.idOptionProducts.length,
                        (index) => InkWell(
                          onTap: () {
                            if (widget
                                .product.idOptionProducts[index].stocking) {
                              setState(() {
                                optionProduct =
                                    widget.product.idOptionProducts[index];
                                quantity = widget.product
                                    .idOptionProducts[index].minQuantityBuy;
                              });
                            }
                          },
                          child: ItemNameProduct(
                            isSelected:
                                widget.product.idOptionProducts[index].id ==
                                    optionProduct?.id,
                            content:
                                widget.product.idOptionProducts[index].title,
                            isEnable: widget
                                    .product.idOptionProducts[index].quantity >
                                0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'product_detail_014'.tr,
                      style: AppText.text14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.COLOR_464647,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (canDegree) {
                              setState(() {
                                quantity--;
                              });
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
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: canDegree
                                  ? ColorResources.COLOR_0095E9
                                  : ColorResources.COLOR_CFCECE,
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
                              color:
                                  ColorResources.COLOR_CFCECE.withOpacity(0.7),
                            ),
                          ),
                          child: Text(
                            quantity.toString(),
                            style: AppText.text10.copyWith(
                              fontWeight: FontWeight.w400,
                              color: optionProduct == null ||
                                      optionProduct!.quantity == 0 ||
                                      optionProduct!.quantity <
                                          optionProduct!.minQuantityBuy
                                  ? ColorResources.COLOR_CFCECE
                                  : ColorResources.COLOR_3B71CA,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (optionProduct != null) {
                              if (quantity < optionProduct!.quantity) {
                                setState(() {
                                  quantity++;
                                });
                              }
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
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: optionProduct == null ||
                                      optionProduct!.quantity == 0 ||
                                      optionProduct!.quantity <
                                          optionProduct!.minQuantityBuy
                                  ? ColorResources.COLOR_CFCECE
                                  : ColorResources.COLOR_0095E9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (optionProduct?.minQuantity != null &&
                        optionProduct!.minQuantity! > 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),
                          Text(
                            '${'product_detail_015'.tr}: ${optionProduct!.minQuantity}',
                            style: AppText.text14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorResources.COLOR_464647,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
              Container(
                color: ColorResources.BACK_GROUND_2,
                child: IZIButton(
                  margin: const EdgeInsets.only(
                    left: IZISizeUtil.SPACE_4X,
                    right: IZISizeUtil.SPACE_4X,
                    top: IZISizeUtil.SPACE_4X,
                  ),
                  label: widget.type == TypeBottomProduct.BUY_NOW
                      ? 'product_detail_023'.tr
                      : 'product_detail_022'.tr,
                  colorBG: ColorResources.COLOR_3B71CA,
                  borderRadius: 5.r,
                  fontSizedLabel: 14.sp,
                  onTap: () {
                    if (optionProduct == null) {
                      IZIAlert().error(message: 'product_detail_024'.tr);
                      return;
                    }
                    Get.back();
                    if (widget.type == TypeBottomProduct.CART) {
                      widget.callBackAddCart(cartRequest);
                    }
                    if (widget.type == TypeBottomProduct.BUY_NOW) {
                      widget.callBackBuyNow(listCart);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    if (optionProduct != null) {
      return Row(
        children: [
          if (optionProduct!.isShowBothPrice)
            Row(
              children: [
                Text(
                  '\$ ${optionProduct!.originPrice.price}',
                  style: AppText.text10.copyWith(
                    color: ColorResources.COLOR_B1B1B1,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 4.w),
              ],
            ),
          if (optionProduct!.isShowBothPrice)
            Text(
              '\$ ${optionProduct!.price!.price}',
              style: AppText.text14.copyWith(
                color: ColorResources.COLOR_EB0F0F,
              ),
            )
          else
            Text(
              '\$ ${optionProduct!.originPrice.price}',
              style: AppText.text14.copyWith(
                color: ColorResources.COLOR_EB0F0F,
              ),
            ),
        ],
      );
    }
    return Row(
      children: [
        if (widget.product.isShowBothPrice)
          Row(
            children: [
              Text(
                '\$ ${widget.product.originPrice.price}',
                style: AppText.text10.copyWith(
                  color: ColorResources.COLOR_B1B1B1,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 4.w),
            ],
          ),
        if (widget.product.isShowBothPrice)
          Text(
            '\$ ${widget.product.price!.price}',
            style: AppText.text14.copyWith(
              color: ColorResources.COLOR_EB0F0F,
            ),
          )
        else
          Text(
            '\$ ${widget.product.originPrice.price}',
            style: AppText.text14.copyWith(
              color: ColorResources.COLOR_EB0F0F,
            ),
          ),
      ],
    );
  }

  int get totalQuantity {
    if (optionProduct != null) {
      return optionProduct!.quantity;
    }
    int quantity = 0;
    for (int i = 0; i < widget.product.idOptionProducts.length; i++) {
      quantity += widget.product.idOptionProducts[i].quantity;
    }
    return quantity;
  }

  String get image {
    try {
      if (optionProduct != null) {
        return optionProduct!.images.first;
      }
      return widget.product.thumbnail ?? '';
    } catch (_) {
      return '';
    }
  }

  bool get canDegree {
    if (quantity > 1) {
      if (optionProduct?.minQuantity == null) {
        return true;
      }
      if (quantity > optionProduct!.minQuantity!) {
        return true;
      }
    }
    return false;
  }

  CartRequest get cartRequest {
    return CartRequest(
      quantity: quantity,
      idProduct: widget.product.id!,
      idStore: widget.product.idStore!.id!,
      idOptionProduct: optionProduct!.id!,
    );
  }

  List<CartModel> get listCart {
    return [
      CartModel(
        idStore: widget.product.idStore,
        idUser: sl<SharedPreferenceHelper>().getIdUser,
        products: [
          ProductCartModel(
            idOptionProduct: optionProduct,
            idProduct: widget.product,
            quantity: quantity,
            checked: true,
          ),
        ],
      ),
    ];
  }
}
