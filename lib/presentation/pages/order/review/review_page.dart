import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/presentation/pages/order/review/review_controller.dart';
import 'package:template/presentation/pages/order/review/widgets/review_item.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class ReviewPage extends GetView<ReviewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: controller.ignoring.value,
        child: Scaffold(
          appBar: BaseAppBar(
            title: 'rate_001'.tr,
          ),
          backgroundColor: ColorResources.BACK_GROUND_2,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                  ),
                  child: Center(
                    child: Text(
                      'rate_002'.tr,
                      style: AppText.text10.copyWith(
                        fontWeight: FontWeight.w300,
                        color: ColorResources.COLOR_E9330B,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    controller.reviews.length,
                    (index) => ReviewItem(
                      data: controller.reviews[index],
                      indexProduct: index + 1,
                      callBackContent: (value) {
                        controller.onChangeContent(index, value);
                      },
                      callBackRate: (value) {
                        controller.onChangeRate(index, value);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              bottom: IZISizeUtil.SPACE_6X,
              left: IZISizeUtil.PADDING_HORIZONTAL,
              right: IZISizeUtil.PADDING_HORIZONTAL,
              top: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  label: 'rate_003'.tr,
                  callBack: () {
                    controller.rateOrder();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
