import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/data/model/order/order_model.dart';
import 'package:template/presentation/widgets/custom_button.dart';

class BottomAddCart extends StatelessWidget {
  final OrderModel order;
  final Function() onAddCart;

  const BottomAddCart({
    super.key,
    required this.order,
    required this.onAddCart,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.clear,
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'order_041'.tr,
                        style: AppText.text18.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 0.5,
                color: ColorResources.COLOR_A4A2A2,
              ),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: order.purchaseDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = order.purchaseDetails[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 7.r,
                              height: 7.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorResources.COLOR_464647,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Text(
                                item.idOptionProduct?.product?.title ?? '',
                                style: AppText.text14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            SizedBox(
                              width: 7.r,
                              height: 7.r,
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.idOptionProduct?.title ?? '',
                                    style: AppText.text14.copyWith(
                                      color: ColorResources.COLOR_8A92A6,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    'x${item.quantity}',
                                    style: AppText.text14.copyWith(
                                      color: ColorResources.COLOR_8A92A6,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 0.3,
                    indent: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    endIndent: IZISizeUtil.PADDING_HORIZONTAL_HOME,
                    height: 0,
                    color: ColorResources.COLOR_B1B1B1,
                  );
                },
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  bottom: IZISizeUtil.SPACE_6X,
                  left: IZISizeUtil.PADDING_HORIZONTAL,
                  right: IZISizeUtil.PADDING_HORIZONTAL,
                  top: 12,
                ),
                child: CustomButton(
                  label: 'order_042'.tr,
                  callBack: onAddCart,
                  backgroundColor: ColorResources.COLOR_3B71CA,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
