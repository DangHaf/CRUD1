import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/pages/voucher/voucher_controller.dart';
import 'package:template/presentation/pages/voucher/widget/voucher_item.dart';

class VoucherPage extends GetView<VoucherController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'voucher_001'.tr,
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: controller.listVoucher.length,
                itemBuilder: (context, index) {
                  final voucher = controller.listVoucher[index];
                  return ItemVoucher(
                    voucher: voucher,
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
    );
  }
}
