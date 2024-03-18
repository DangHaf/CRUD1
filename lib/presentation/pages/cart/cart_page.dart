import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/config/routes/route_path/app_route.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/extensions/num_extension.dart';
import 'package:template/presentation/pages/cart/cart_controller.dart';
import 'package:template/presentation/pages/cart/widgets/item_card.dart';

class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'cart_001'.tr,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      header: Platform.isAndroid
                          ? const MaterialClassicHeader(
                              color: ColorResources.COLOR_3B71CA)
                          : null,
                      onLoading: () => controller.getListCart(isLoadMore: true),
                      enablePullUp: controller.isLoadMore,
                      onRefresh: () => controller.initData(isRefresh: true),
                      child: controller.listCart.isEmpty
                          ? Center(
                              child: Text(
                                'empty_data'.tr,
                                style: AppText.text14.copyWith(
                                  color: ColorResources.COLOR_677275,
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              itemCount: controller.listCart.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (controller
                                    .listCart[index].products.isEmpty) {
                                  return const SizedBox();
                                }
                                return ItemCard(
                                  cart: controller.listCart[index],
                                  onSelect: (indexPro) {
                                    controller.onCheckProduct(index, indexPro);
                                  },
                                  onRemove: (indexPro) {
                                    controller.onRemove(index, indexPro);
                                  },
                                  onReduce: (indexPro) {
                                    controller.onReduce(index, indexPro);
                                  },
                                  onIncrease: (indexPro) {
                                    controller.onIncrease(index, indexPro);
                                  },
                                  callBackCheckCart: (value) {
                                    controller.onCheckAll(index, value);
                                  },
                                  onChangeType: (type, quantity, indexPro) {
                                    controller.onChangeType(
                                        index, indexPro, type, quantity);
                                  },
                                  callBackVoucher: () {
                                    controller.getVoucherCart(index);
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                if (controller
                                    .listCart[index].products.isEmpty) {
                                  return const SizedBox();
                                }
                                return SizedBox(height: 10.h);
                              },
                            ),
                    ),
                  ),
                  if (controller.listCart.isNotEmpty)
                    _buildBottom()
                ],
              ),
      ),
    );
  }

  Widget _buildBottom() {
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
            child: Container(
              height: 55.h,
              width: Get.width / 2,
              alignment: Alignment.center,
              child: Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'cart_003'.tr,
                        style: AppText.text14
                            .copyWith(color: ColorResources.COLOR_464647),
                      ),
                      TextSpan(
                        text: '\$${controller.totalPrice.value.price}',
                        style: AppText.text14.copyWith(
                          color: ColorResources.COLOR_EB0F0F,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (controller.totalQuantity.value > 0) {
                  Get.toNamed(AppRoute.PAYMENT, arguments: {
                    'listCart': controller.listCartHasProduct,
                    'address': controller.addressModel,
                  });
                } else {
                  IZIAlert().error(message: 'cart_015'.tr);
                }
              },
              child: Container(
                color: ColorResources.COLOR_3B71CA,
                height: 55.h,
                width: Get.width / 2,
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    '${'cart_004'.tr} (${controller.totalQuantity.value.quantity})',
                    style: AppText.text14.copyWith(
                      color: Colors.white,
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
