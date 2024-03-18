import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/cart/voucher_cart/voucher_cart_controller.dart';
import 'package:template/presentation/pages/cart/voucher_cart/widgets/item_voucher_cart.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class VoucherCartPage extends GetView<VoucherCartController> {
  const VoucherCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(title: 'voucher_001'.tr),
      body: Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      itemCount: controller.listVoucher.length,
                      itemBuilder: (context, index) {
                        final voucher = controller.listVoucher[index];
                        return Obx(
                          () => ItemVoucherCart(
                            voucher: voucher,
                            onSelect: () {
                              if (voucher.minPriceToUse >
                                  controller.totalPrice) {
                                IZIAlert().error(message: 'cart_026'.tr);
                                return;
                              }
                              controller.onChangeSelected(index);
                            },
                            groupId: controller.voucherSelected.value.id,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5.h,
                          width: Get.width,
                        );
                      },
                    ),
                  ),
                  if (controller.listVoucher.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: IZISizeUtil.SPACE_6X,
                        left: IZISizeUtil.PADDING_HORIZONTAL,
                        right: IZISizeUtil.PADDING_HORIZONTAL,
                        top: 12,
                      ),
                      child: CustomButton(
                        label: 'apply'.tr,
                        callBack: () {
                          controller.onApply();
                        },
                        backgroundColor: ColorResources.COLOR_3B71CA,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
