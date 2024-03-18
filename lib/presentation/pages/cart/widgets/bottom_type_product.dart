import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/data/model/product/product_model.dart';
import 'package:template/presentation/pages/product/widgets/item_little_product.dart';

class BottomTypeProduct extends StatefulWidget {
  final Function(OptionProductModel, int) callBackType;
  final ProductModel product;
  final int initQuantity;
  final OptionProductModel initOptionProduct;

  const BottomTypeProduct({
    required this.product,
    required this.callBackType,
    required this.initQuantity,
    required this.initOptionProduct,
  });

  @override
  State<BottomTypeProduct> createState() => _BottomTypeProductState();
}

class _BottomTypeProductState extends State<BottomTypeProduct> {
  int quantity = 0;
  late OptionProductModel optionProduct;

  @override
  void initState() {
    quantity = widget.initQuantity;
    optionProduct = widget.initOptionProduct;
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
                          IZIValidate.nullOrEmpty(optionProduct.images)
                              ? ''
                              : optionProduct.images.first,
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
                              child: Row(
                                children: [
                                  if (optionProduct.isShowBothPrice)
                                    Row(
                                      children: [
                                        Text(
                                          '\$ ${optionProduct.originPrice.price}',
                                          style: AppText.text10.copyWith(
                                            color: ColorResources.COLOR_B1B1B1,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                      ],
                                    ),
                                  if (optionProduct.isShowBothPrice)
                                    Text(
                                      '\$ ${optionProduct.price!.price}',
                                      style: AppText.text14.copyWith(
                                        color: ColorResources.COLOR_EB0F0F,
                                      ),
                                    )
                                  else
                                    Text(
                                      '\$ ${optionProduct.originPrice.price}',
                                      style: AppText.text14.copyWith(
                                        color: ColorResources.COLOR_EB0F0F,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Text(
                              '${'product_detail_013'.tr}: ${optionProduct.quantity.quantity}',
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
                                    optionProduct.id,
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
                              color: optionProduct.quantity == 0 ||
                                      optionProduct.quantity <
                                          optionProduct.minQuantityBuy
                                  ? ColorResources.COLOR_CFCECE
                                  : ColorResources.COLOR_3B71CA,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (quantity < optionProduct.quantity) {
                              setState(() {
                                quantity++;
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
                              color: optionProduct.quantity == 0 ||
                                      optionProduct.quantity <
                                          optionProduct.minQuantityBuy
                                  ? ColorResources.COLOR_CFCECE
                                  : ColorResources.COLOR_0095E9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (optionProduct.minQuantity != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),
                          Text(
                            '${'product_detail_015'.tr}: ${optionProduct.minQuantity}',
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
                  label: 'apply'.tr,
                  colorBG: ColorResources.COLOR_3B71CA,
                  borderRadius: 5.r,
                  fontSizedLabel: 14.sp,
                  onTap: () {
                    Get.back();
                    widget.callBackType(optionProduct, quantity);
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  bool get canDegree {
    if (quantity > 1) {
      if (optionProduct.minQuantity == null) {
        return true;
      }
      if (quantity > optionProduct.minQuantity!) {
        return true;
      }
    }
    return false;
  }
}
