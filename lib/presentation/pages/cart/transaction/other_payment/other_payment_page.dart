import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/cart/transaction/other_payment/other_payment_controller.dart';

class OtherPaymentPage extends GetView<OtherPaymentController> {
  const OtherPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACK_GROUND_2,
      appBar: BaseAppBar(
        title: 'transaction_006'.tr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
        ),
        child: Obx(
          () => controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(title: 'transaction_007'.tr),
                    Expanded(
                      child: _buildListData(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  ListView _buildListData() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final item = controller.listBankAccount[index];
        return InkWell(
          onTap: () {
            Get.back(result: item);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.bankName,
                  style: AppText.text15.copyWith(
                    color: ColorResources.COLOR_464647,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${'transaction_008'.tr}: ${item.accountName}',
                  style: AppText.text10.copyWith(
                    color: ColorResources.COLOR_464647,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${'transaction_009'.tr}: ${item.accountNumber}',
                  style: AppText.text10.copyWith(
                    color: ColorResources.COLOR_464647,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10.h);
      },
      itemCount: controller.listBankAccount.length,
    );
  }

  Widget _buildTitle({required String title}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: IZISizeUtil.PADDING_HORIZONTAL_HOME),
      child: Text(
        title,
        style: AppText.text16.copyWith(
          color: ColorResources.COLOR_464647,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
